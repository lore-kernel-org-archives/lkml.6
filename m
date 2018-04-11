Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/yaZBEwIs8MwQeFThiaeT1WAptOX3vfssNn7490f27ZOqNj+wvZGiNvz+9zioAPicCVr0b
ARC-Seal: i=1; a=rsa-sha256; t=1523472707; cv=none;
        d=google.com; s=arc-20160816;
        b=agEcYkraLS8/BfJGafb438EPRAqurIPY48F8VwajRu7okryGF+Vv48gpsNLIDvf3ig
         LfhnrCHiEvLA0Lv4Ve2MksjMCo84b5/6x5Iqav9N1PIjEOWCNmdBrhdRV+9M1qlRqPkP
         WtMJQwR1Uz5vDwiln3z2kt37mtkWnVzduy07O//yDBF3YvphR0IiirJ3SJeXyE9d+x8J
         XVU1XR2cyJpWQHFe9t0fdl8z81NsFN8bP0rvcbP36cuQj2ppcvN4OS/MAHBN9m1zXKJS
         danhaTOngpDZIjOGuf8XhizRpxKDEjRIKsDzaHgT8LRPYDapBVwPy9W0wiLB6QSfgONe
         kzow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=F9LoTN6nvcbxWmWt1g5ZfT5sL12i//rMGjzRZiLIdM0=;
        b=a1VHwQEoVvjj9YDaL65hTsecUj1YDrLlMuymoN270X9NpbHpFyyQhGHIXfNfmW8ZxZ
         fSkFr8+tiQKKcjz/eADvmpGDDyq5rHPIKQYcki46xH6L4y+elUlPG2GILyK/aX8fgWrZ
         UuxoDZZvdWFwdKrB36nVErW1TzANSqlHvM3uJgcTepe8lsSJjI4g2jbcnLht0upfMp2Y
         /1bH3Ugq15J2RHnK4lXvJ90RGJoj5t9emo+krYGp0oplrhzPWYWUliOPLxUtusQHFeVn
         4Vm6dgQk26npLYyH+2Kcy1icK1/Lt0YQFy1SH+eP4FKqqxMojCdBaA0eCgCuUr9HeLdg
         Df3w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 181/190] ip_tunnel: better validate user provided tunnel names
Date: Wed, 11 Apr 2018 20:37:07 +0200
Message-Id: <20180411183604.050154585@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476363066014877?=
X-GMAIL-MSGID: =?utf-8?q?1597476918023312201?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit 9cb726a212a82c88c98aa9f0037fd04777cd8fe5 ]

Use dev_valid_name() to make sure user does not provide illegal
device name.

syzbot caught the following bug :

BUG: KASAN: stack-out-of-bounds in strlcpy include/linux/string.h:300 [inline]
BUG: KASAN: stack-out-of-bounds in __ip_tunnel_create+0xca/0x6b0 net/ipv4/ip_tunnel.c:257
Write of size 20 at addr ffff8801ac79f810 by task syzkaller268107/4482

CPU: 0 PID: 4482 Comm: syzkaller268107 Not tainted 4.16.0+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x1b9/0x29f lib/dump_stack.c:53
 print_address_description+0x6c/0x20b mm/kasan/report.c:256
 kasan_report_error mm/kasan/report.c:354 [inline]
 kasan_report.cold.7+0xac/0x2f5 mm/kasan/report.c:412
 check_memory_region_inline mm/kasan/kasan.c:260 [inline]
 check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
 memcpy+0x37/0x50 mm/kasan/kasan.c:303
 strlcpy include/linux/string.h:300 [inline]
 __ip_tunnel_create+0xca/0x6b0 net/ipv4/ip_tunnel.c:257
 ip_tunnel_create net/ipv4/ip_tunnel.c:352 [inline]
 ip_tunnel_ioctl+0x818/0xd40 net/ipv4/ip_tunnel.c:861
 ipip_tunnel_ioctl+0x1c5/0x420 net/ipv4/ipip.c:350
 dev_ifsioc+0x43e/0xb90 net/core/dev_ioctl.c:334
 dev_ioctl+0x69a/0xcc0 net/core/dev_ioctl.c:525
 sock_ioctl+0x47e/0x680 net/socket.c:1015
 vfs_ioctl fs/ioctl.c:46 [inline]
 file_ioctl fs/ioctl.c:500 [inline]
 do_vfs_ioctl+0x1cf/0x1650 fs/ioctl.c:684
 ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
 SYSC_ioctl fs/ioctl.c:708 [inline]
 SyS_ioctl+0x24/0x30 fs/ioctl.c:706
 do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x42/0xb7

Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_tunnel.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -253,13 +253,14 @@ static struct net_device *__ip_tunnel_cr
 	struct net_device *dev;
 	char name[IFNAMSIZ];
 
-	if (parms->name[0])
+	err = -E2BIG;
+	if (parms->name[0]) {
+		if (!dev_valid_name(parms->name))
+			goto failed;
 		strlcpy(name, parms->name, IFNAMSIZ);
-	else {
-		if (strlen(ops->kind) > (IFNAMSIZ - 3)) {
-			err = -E2BIG;
+	} else {
+		if (strlen(ops->kind) > (IFNAMSIZ - 3))
 			goto failed;
-		}
 		strlcpy(name, ops->kind, IFNAMSIZ);
 		strncat(name, "%d", 2);
 	}
