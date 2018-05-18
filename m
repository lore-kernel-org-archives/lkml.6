Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrPNWkic5umx5CpHgxTslfYx1ypMQZvkYUty71tcS+tRMXq9qm3QuI3YiojzMnlBafZAsEE
ARC-Seal: i=1; a=rsa-sha256; t=1526631722; cv=none;
        d=google.com; s=arc-20160816;
        b=EvjHCVxz7DAirpAQC0cm9RkCJG7kosiYtQOFXJJXODO0Al80CXC/x3qBIFjQ7lRedO
         veoY843Wvn4gzXqbbMi5pA2EdvxcnSSSNQ1jDE6qD2XIiDY4a0/d59tIXGfCJ5KQ3RB9
         pUFajA0/6N32jM8AncFIOCWXxuLe8TKs4a7SNlgZ2mf7diZ7Uuee2O9eDN911Ru+TycN
         LN3Di6sif3ccfUHs4/YwZOFF7zT25IKbyiqOKRa3n+GJ3oN2drD5gu+KhoLDrU28Hzh3
         9cqUmN6br8CU3OKcS9eL7rtdqZGmfKQUrujt0p17hQBIdYHvnz4f1XR/89MeB4TPlV7U
         J1iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=aYRqjfixB3cIkWcNr6rdIGqcXFZZYvwgm7JKN+UFL1M=;
        b=n8L2Y7UWhC49UpYBkaj8fqX7ziJ0uAz+65JUMFTb9qgx/J4RdPZMppTb4veCq+rUZR
         /uUGHU9+NpEDzrAeN9GLhALALpEGHuWHZde9vjKWHpeNV3R658/3O4a8/uovsJ0ptbC7
         fW9+5aHeU9R3vBmkC2FsTGvakTY6GE/MVzm9Xlt03adjU+QlG+7C3SwvHb+R9q1TT/bH
         AwcFM7qkXwxR8T2lWUaspHO/WqvOfreRmLkzcvR/M0DstbfBiO7WVSXWHAduwKTmL/nb
         fGTjFHEE7+AwBWrm8IsHN8yy0tlAX0Z0fpkFyiIOHHNEp7Cd8vOpZst2l3MJD6X2NtY+
         DaQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=NbgkdCVF;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=NbgkdCVF;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 05/33] llc: better deal with too small mtu
Date: Fri, 18 May 2018 10:15:44 +0200
Message-Id: <20180518081535.311977319@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081535.096308218@linuxfoundation.org>
References: <20180518081535.096308218@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789077943106120?=
X-GMAIL-MSGID: =?utf-8?q?1600789385529772500?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 2c5d5b13c6eb79f5677e206b8aad59b3a2097f60 ]

syzbot loves to set very small mtu on devices, since it brings joy.
We must make llc_ui_sendmsg() fool proof.

usercopy: Kernel memory overwrite attempt detected to wrapped address (offset 0, size 18446612139802320068)!

kernel BUG at mm/usercopy.c:100!
invalid opcode: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
   (ftrace buffer empty)
Modules linked in:
CPU: 0 PID: 17464 Comm: syz-executor1 Not tainted 4.17.0-rc3+ #36
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:usercopy_abort+0xbb/0xbd mm/usercopy.c:88
RSP: 0018:ffff8801868bf800 EFLAGS: 00010282
RAX: 000000000000006c RBX: ffffffff87d2fb00 RCX: 0000000000000000
RDX: 000000000000006c RSI: ffffffff81610731 RDI: ffffed0030d17ef6
RBP: ffff8801868bf858 R08: ffff88018daa4200 R09: ffffed003b5c4fb0
R10: ffffed003b5c4fb0 R11: ffff8801dae27d87 R12: ffffffff87d2f8e0
R13: ffffffff87d2f7a0 R14: ffffffff87d2f7a0 R15: ffffffff87d2f7a0
FS:  00007f56a14ac700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2bc21000 CR3: 00000001abeb1000 CR4: 00000000001426f0
DR0: 0000000020000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000030602
Call Trace:
 check_bogus_address mm/usercopy.c:153 [inline]
 __check_object_size+0x5d9/0x5d9 mm/usercopy.c:256
 check_object_size include/linux/thread_info.h:108 [inline]
 check_copy_size include/linux/thread_info.h:139 [inline]
 copy_from_iter_full include/linux/uio.h:121 [inline]
 memcpy_from_msg include/linux/skbuff.h:3305 [inline]
 llc_ui_sendmsg+0x4b1/0x1530 net/llc/af_llc.c:941
 sock_sendmsg_nosec net/socket.c:629 [inline]
 sock_sendmsg+0xd5/0x120 net/socket.c:639
 __sys_sendto+0x3d7/0x670 net/socket.c:1789
 __do_sys_sendto net/socket.c:1801 [inline]
 __se_sys_sendto net/socket.c:1797 [inline]
 __x64_sys_sendto+0xe1/0x1a0 net/socket.c:1797
 do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455979
RSP: 002b:00007f56a14abc68 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f56a14ac6d4 RCX: 0000000000455979
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000018
RBP: 000000000072bea0 R08: 00000000200012c0 R09: 0000000000000010
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000548 R14: 00000000006fbf60 R15: 0000000000000000
Code: 55 c0 e8 c0 55 bb ff ff 75 c8 48 8b 55 c0 4d 89 f9 ff 75 d0 4d 89 e8 48 89 d9 4c 89 e6 41 56 48 c7 c7 80 fa d2 87 e8 a0 0b a3 ff <0f> 0b e8 95 55 bb ff e8 c0 a8 f7 ff 8b 95 14 ff ff ff 4d 89 e8
RIP: usercopy_abort+0xbb/0xbd mm/usercopy.c:88 RSP: ffff8801868bf800

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/llc/af_llc.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -926,6 +926,9 @@ static int llc_ui_sendmsg(struct socket
 	if (size > llc->dev->mtu)
 		size = llc->dev->mtu;
 	copied = size - hdrlen;
+	rc = -EINVAL;
+	if (copied < 0)
+		goto release;
 	release_sock(sk);
 	skb = sock_alloc_send_skb(sk, size, noblock, &rc);
 	lock_sock(sk);
