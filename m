Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/vG57eHwQmJ2EByH2qj2HdYmoCpAfNxYAv6fO3oLo2cILL8J+Q0hoOEXNP/npVTENRcCzf
ARC-Seal: i=1; a=rsa-sha256; t=1523399945; cv=none;
        d=google.com; s=arc-20160816;
        b=cB1BBWR04ULcKscnzlQzAoBbNFQlZdDrqWao9qYD8BQPbA2Y1ZbmE2OvStfnkt+rxO
         1pilHBpSn3zpPGFKlDqWUCTEgyhB5TZ5ekM5Xkr2Nby12xFV5tIoHfvOfXfBGxLGObN5
         GClv1PBFqCIqj23xJWMJdS/i3hfxXjDO55TE0v6iGGiIabP5C4e+yK3tm23tBbkM8kfp
         uclZlxLBBCVyBh8uaqbFzX4IYfwEMeLQWl8vX7lwDiwdiceRzTuORsDIi1Ius+S30Iza
         HjLjxQeNW4FRrSAiySRFNCGe4W6zJfFXHrGUPJurMukS28hY+VvgWTOpPVaGIzKo9Q0+
         /CjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mwmMAWASQQSMX0TCUnHvrsceggG8UX85vqeKcgNSwfk=;
        b=SYm7gKDGLv9UV+9/8+8GWbE/wnVYZ+vxQeC+JKjDYFly3LITZCd9kxPLqpOOllE20H
         oftOBeAQBavHfG7oBCkPjmFhdsNa3EXzmBCanC3iV1S9Pn+Epo7P9lPnlwMXfi/BHJqI
         ikbo1TJTfnThhIAgVhqL4sh5AwVvwAA0PyU83K0wFAZLOtLJtlTKPxe26jAJRDzLhYAT
         VXyQWgYxJkrwRwqr1LzgsvN1Unc1lBeOsmkh8GKzmR/s7NbSpK7k/wkyXc0z3Tj44Dmj
         1j1Cq3E0RC7UeG+XaLuqpzuHvBkwHqfJBiR6LQbXZpsG3FyhU4DsqDcwwdRllabMemHa
         srsw==
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
Subject: [PATCH 4.14 120/138] ip6_gre: better validate user provided tunnel names
Date: Wed, 11 Apr 2018 00:25:10 +0200
Message-Id: <20180410212916.161423759@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399727147391550?=
X-GMAIL-MSGID: =?utf-8?q?1597400620966567842?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit 5f42df013b8bc1b6511af7a04bf93b014884ae2a ]

Use dev_valid_name() to make sure user does not provide illegal
device name.

syzbot caught the following bug :

BUG: KASAN: stack-out-of-bounds in strlcpy include/linux/string.h:300 [inline]
BUG: KASAN: stack-out-of-bounds in ip6gre_tunnel_locate+0x334/0x860 net/ipv6/ip6_gre.c:339
Write of size 20 at addr ffff8801afb9f7b8 by task syzkaller851048/4466

CPU: 1 PID: 4466 Comm: syzkaller851048 Not tainted 4.16.0+ #1
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
 ip6gre_tunnel_locate+0x334/0x860 net/ipv6/ip6_gre.c:339
 ip6gre_tunnel_ioctl+0x69d/0x12e0 net/ipv6/ip6_gre.c:1195
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

Fixes: c12b395a4664 ("gre: Support GRE over IPv6")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_gre.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -319,11 +319,13 @@ static struct ip6_tnl *ip6gre_tunnel_loc
 	if (t || !create)
 		return t;
 
-	if (parms->name[0])
+	if (parms->name[0]) {
+		if (!dev_valid_name(parms->name))
+			return NULL;
 		strlcpy(name, parms->name, IFNAMSIZ);
-	else
+	} else {
 		strcpy(name, "ip6gre%d");
-
+	}
 	dev = alloc_netdev(sizeof(*t), name, NET_NAME_UNKNOWN,
 			   ip6gre_tunnel_setup);
 	if (!dev)
