Return-Path: <threeearcat@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525102030; cv=none;
        d=google.com; s=arc-20160816;
        b=1BBwB4UeihXUrkWFaphvOJV0/4TeLM604Q+XBMa+0U9jaYYkMRq1U39EvJsG5qfzLt
         OVe3Zlsz0Aqxh8pD4IlB6nFSmmtDt2EoM1A6oUh1HSOaMA6OE9+16NCuciqEzr99y9i8
         XGZQPl8y9Zb9rb6vCfihpAZHUojUzxSHeF4KcW829okwcYuFBopXfZth3M0/ZBix0jkH
         nc4Nzr/z6kFsBgUdK7IR7dKf1kgNrkBlT8Q9+z0BTeO2BR3dUk4VQSBjvQtm84BgNPqB
         d3E5b2g8yCcOgYct2wYVT/lvlrGc/9ZaKukSNl14LBQHT6FMm33YpqRCHWB8veCzutcA
         pP9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=aeO8nZTyxO0poLfn+r/b7WJWpQL8G3BkEKqV0n7S4MA=;
        b=RZmGxkWpIM9scX4ejNn/FOqV32EVN8BK1JssDus5githLVXIKx/ZhtJo8FXspRhipP
         szXYixuDbURCk0QQpbEYrADURFxfcoRG9QykpRfwTG1SeXlikmq9enlOwg6y70hrxWMi
         +juC+k0BpdKjZJaN+9J8tlxyASbKo1XlKSJW2ayuu3ED3eKZ2evNr+X179LJil0/JykL
         L1tFPBGAFVbcDHvEn0i1+kKWwLkKH5ven79mkKZwaSXfixP27Qg/kWZCDh7H5Enpv6gX
         3umUf5cjsDY0DJWp4T++OQcy4btfphzT4EGrQqwT04PAlHK1Q+Wo9fsUFhosyyI3utsN
         sTUA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=moEOVksB;
       spf=pass (google.com: domain of threeearcat@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=threeearcat@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=moEOVksB;
       spf=pass (google.com: domain of threeearcat@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=threeearcat@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZoqWWRHK2a0zmw+nSM9epQi/25egjO9VfzxvubSqlOqGYOTrNvglyhwdgDNlsu5sRB1AUDYgQ==
Date: Tue, 1 May 2018 00:27:04 +0900
From: DaeRyong Jeong <threeearcat@gmail.com>
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: byoungyoung@purdue.edu, kt0755@gmail.com, bammanag@purdue.edu,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] tty: Fix data race in tty_insert_flip_string_fixed_flag
Message-ID: <20180430152700.GA17514@dragonet.kaist.ac.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599185386348568762?=
X-GMAIL-MSGID: =?utf-8?q?1599185386348568762?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Unlike normal serials, in pty layer, there is no guarantee that multiple
threads don't insert input characters at the same time. If it is happened,
tty_insert_flip_string_fixed_flag can be executed concurrently. This can
lead slab out-of-bounds write in tty_insert_flip_string_fixed_flag.

Call sequences are as follows.
CPU0                                    CPU1
n_tty_ioctl_helper                      n_tty_ioctl_helper
__start_tty                             tty_send_xchar
tty_wakeup                              pty_write
n_hdlc_tty_wakeup                       tty_insert_flip_string
n_hdlc_send_frames                      tty_insert_flip_string_fixed_flag
pty_write
tty_insert_flip_string
tty_insert_flip_string_fixed_flag

To fix the race, acquire port->lock in pty_write() before it inserts input
characters to tty buffer. It prevents multiple threads from inserting
input characters concurrently.

The crash log is as follows:
BUG: KASAN: slab-out-of-bounds in tty_insert_flip_string_fixed_flag+0xb5/
0x130 drivers/tty/tty_buffer.c:316 at addr ffff880114fcc121
Write of size 1792 by task syz-executor0/30017
CPU: 1 PID: 30017 Comm: syz-executor0 Not tainted 4.8.0 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.8.2-0-g33fbe13 by qemu-project.org 04/01/2014
 0000000000000000 ffff88011638f888 ffffffff81694cc3 ffff88007d802140
 ffff880114fcb300 ffff880114fcc300 ffff880114fcb300 ffff88011638f8b0
 ffffffff8130075c ffff88011638f940 ffff88007d802140 ffff880194fcc121
Call Trace:
 __dump_stack lib/dump_stack.c:15 [inline]
 dump_stack+0xb3/0x110 lib/dump_stack.c:51
 kasan_object_err+0x1c/0x70 mm/kasan/report.c:156
 print_address_description mm/kasan/report.c:194 [inline]
 kasan_report_error+0x1f7/0x4e0 mm/kasan/report.c:283
 kasan_report+0x36/0x40 mm/kasan/report.c:303
 check_memory_region_inline mm/kasan/kasan.c:292 [inline]
 check_memory_region+0x13e/0x1a0 mm/kasan/kasan.c:299
 memcpy+0x37/0x50 mm/kasan/kasan.c:335
 tty_insert_flip_string_fixed_flag+0xb5/0x130 drivers/tty/tty_buffer.c:316
 tty_insert_flip_string include/linux/tty_flip.h:35 [inline]
 pty_write+0x7f/0xc0 drivers/tty/pty.c:115
 n_hdlc_send_frames+0x1d4/0x3b0 drivers/tty/n_hdlc.c:419
 n_hdlc_tty_wakeup+0x73/0xa0 drivers/tty/n_hdlc.c:496
 tty_wakeup+0x92/0xb0 drivers/tty/tty_io.c:601
 __start_tty.part.26+0x66/0x70 drivers/tty/tty_io.c:1018
 __start_tty+0x34/0x40 drivers/tty/tty_io.c:1013
 n_tty_ioctl_helper+0x146/0x1e0 drivers/tty/tty_ioctl.c:1138
 n_hdlc_tty_ioctl+0xb3/0x2b0 drivers/tty/n_hdlc.c:794
 tty_ioctl+0xa85/0x16d0 drivers/tty/tty_io.c:2992
 vfs_ioctl fs/ioctl.c:43 [inline]
 do_vfs_ioctl+0x13e/0xba0 fs/ioctl.c:679
 SYSC_ioctl fs/ioctl.c:694 [inline]
 SyS_ioctl+0x8f/0xc0 fs/ioctl.c:685
 entry_SYSCALL_64_fastpath+0x1f/0xbd

Signed-off-by: DaeRyong Jeong <threeearcat@gmail.com>
---
 drivers/tty/pty.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 364c0e9..0c7ec27 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -110,16 +110,19 @@ static void pty_unthrottle(struct tty_struct *tty)
 static int pty_write(struct tty_struct *tty, const unsigned char *buf, int c)
 {
 	struct tty_struct *to = tty->link;
+	unsigned long flags;

 	if (tty->stopped)
 		return 0;

 	if (c > 0) {
+		spin_lock_irqsave(&to->port->lock, flags);
 		/* Stuff the data into the input queue of the other end */
 		c = tty_insert_flip_string(to->port, buf, c);
 		/* And shovel */
 		if (c)
 			tty_flip_buffer_push(to->port);
+		spin_unlock_irqrestore(&to->port->lock, flags);
 	}
 	return c;
 }
--
2.7.4
