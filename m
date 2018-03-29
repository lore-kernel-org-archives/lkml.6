Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/4hyLCrAyrEgmG/y5fDrVcS3YD9uRca9mNHqq1Bn6NWy6Yy/P4fajFJCQ+2jhBtpkAk0VK
ARC-Seal: i=1; a=rsa-sha256; t=1522346752; cv=none;
        d=google.com; s=arc-20160816;
        b=X/9Bm7N+3HHcxPpLe1CkOg+XRdyt4sa9XUnPGapaiT8bButIxJYkIcRHLfuzbIlXrg
         8lO+xteadbMXQzgHtCrZBP0rFm88MxvC+D/06Wpk9UoiXCn/jqgTi8Nt6NOrX6KrlqI1
         1zUXfRYSTzVgN4n29Z6MLBxbD+sO7niFsnlpe6BHQ9bHm7cBlQ6HkcwO3NzaRKXaPqDq
         L6yLP0jhlw7ku40TrP7ZaWfCMGlYGWfaMzq+41qd92pU4E+VEXrf3ijBJ3nDsuDxyj6d
         dTx23UNInubf2naux4Ml9qDaUnG3BSFg1qb6iBpmp/jpztpiab/q6ueyjN3TyYfLTgcq
         dEeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AqZH9N0/gAdPAz7yj56PNwxYie0uKT183UtqxSwjlE8=;
        b=XSbnEB0aYZIfnkoGO1MJbIFvXO5x9V2BlUIbygStYF/ncIK3hvXnSSWXbzEZ1SXGeo
         7slo+geE8Tuz6YtnnkKj/pI0giq+rdZjHrPw/TXOcpGdfkPu8kYUpHgFGj+9nnzBJ+wD
         TaaFQmQl3sdRzv42zbkueeh9vNeY17mBXBF4jd6znguY0y4RA+WXMI2efJx7pZmXDoQN
         SYBnfgs2sDzrXnqtnC+rtOn1Iwqip7tt9cD0+754LQaPkfeL7voGfIt0epOEq5yAhbGx
         3TeZPDQ/1wY7VnvMgxehyW2lEWvmEcpcfAvcPVqOpRJXh3m62Cb6sD0BWVgwTIkLP1rd
         vAHw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Guillaume Nault <g.nault@alphalink.fr>,
	James Chapman <jchapman@katalix.com>,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 24/43] l2tp: do not accept arbitrary sockets
Date: Thu, 29 Mar 2018 20:00:19 +0200
Message-Id: <20180329175732.680051702@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175730.190353692@linuxfoundation.org>
References: <20180329175730.190353692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296098194339740?=
X-GMAIL-MSGID: =?utf-8?q?1596296268241252355?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit 17cfe79a65f98abe535261856c5aef14f306dff7 ]

syzkaller found an issue caused by lack of sufficient checks
in l2tp_tunnel_create()

RAW sockets can not be considered as UDP ones for instance.

In another patch, we shall replace all pr_err() by less intrusive
pr_debug() so that syzkaller can find other bugs faster.
Acked-by: Guillaume Nault <g.nault@alphalink.fr>
Acked-by: James Chapman <jchapman@katalix.com>

==================================================================
BUG: KASAN: slab-out-of-bounds in setup_udp_tunnel_sock+0x3ee/0x5f0 net/ipv4/udp_tunnel.c:69
dst_release: dst:00000000d53d0d0f refcnt:-1
Write of size 1 at addr ffff8801d013b798 by task syz-executor3/6242

CPU: 1 PID: 6242 Comm: syz-executor3 Not tainted 4.16.0-rc2+ #253
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x194/0x24d lib/dump_stack.c:53
 print_address_description+0x73/0x250 mm/kasan/report.c:256
 kasan_report_error mm/kasan/report.c:354 [inline]
 kasan_report+0x23b/0x360 mm/kasan/report.c:412
 __asan_report_store1_noabort+0x17/0x20 mm/kasan/report.c:435
 setup_udp_tunnel_sock+0x3ee/0x5f0 net/ipv4/udp_tunnel.c:69
 l2tp_tunnel_create+0x1354/0x17f0 net/l2tp/l2tp_core.c:1596
 pppol2tp_connect+0x14b1/0x1dd0 net/l2tp/l2tp_ppp.c:707
 SYSC_connect+0x213/0x4a0 net/socket.c:1640
 SyS_connect+0x24/0x30 net/socket.c:1621
 do_syscall_64+0x280/0x940 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x42/0xb7

Fixes: fd558d186df2 ("l2tp: Split pppol2tp patch into separate l2tp and ppp parts")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/l2tp/l2tp_core.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1562,9 +1562,14 @@ int l2tp_tunnel_create(struct net *net,
 		encap = cfg->encap;
 
 	/* Quick sanity checks */
+	err = -EPROTONOSUPPORT;
+	if (sk->sk_type != SOCK_DGRAM) {
+		pr_debug("tunl %hu: fd %d wrong socket type\n",
+			 tunnel_id, fd);
+		goto err;
+	}
 	switch (encap) {
 	case L2TP_ENCAPTYPE_UDP:
-		err = -EPROTONOSUPPORT;
 		if (sk->sk_protocol != IPPROTO_UDP) {
 			pr_err("tunl %hu: fd %d wrong protocol, got %d, expected %d\n",
 			       tunnel_id, fd, sk->sk_protocol, IPPROTO_UDP);
@@ -1572,7 +1577,6 @@ int l2tp_tunnel_create(struct net *net,
 		}
 		break;
 	case L2TP_ENCAPTYPE_IP:
-		err = -EPROTONOSUPPORT;
 		if (sk->sk_protocol != IPPROTO_L2TP) {
 			pr_err("tunl %hu: fd %d wrong protocol, got %d, expected %d\n",
 			       tunnel_id, fd, sk->sk_protocol, IPPROTO_L2TP);
