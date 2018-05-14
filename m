Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqM1DHekpMhaUp9gPBrk+zi4MY6xwUlakLurFrZjJ4j9GJ2/EYFVHPE/9RLQZ+wZwIRdUGZ
ARC-Seal: i=1; a=rsa-sha256; t=1526280911; cv=none;
        d=google.com; s=arc-20160816;
        b=jNwACmsSovkhKICcfKxvibY6vkBY21aE1plrtTSyIriL1TxIJ5HWCGiaNJg4ZwHrvM
         f7ZJu/LmpTN9DJldtPLPiSYzTsyefJ2gSzbvCIsmhTmZybUh+FUM6VIWsY3pRb71Qo79
         kw/ETSOdg3QUlqLYE8TqsECvLd+6ch+Y4EThYf/8gD5Ltwil3jf1Ixbo6sHeGUxOTDqq
         oBWq3TQ/oEPap/C1rw3FjaeXTzJsZ3liYU/WWwO1WW8K9Us0ZqlwdcnU2IzGDJhfdwQi
         bng0pHgNwfVQFcLs4Lh4NzBtkFDCYAHkUu30PewxZ4CMoNI7LuA864u4+H8o5E4pdqRO
         RTyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=eDMmOp+7d3XYCqV45Wh+7umUaNr9EmhefX4hO8MnZAk=;
        b=TvYpO+qAKJQUz4c7HvD7KlKOyvtPA+poS6C3uFBYYjK+ARurPv73T6P+d77VqZuv/p
         OFdDSO5vbRUrvwh6uDVlPJ5qA2rr1QtdcEgyEeQHyTk2yd8hqR3zz69IRKFhMankopWn
         M/8G+ddAmR7C2g18fZQO/Lgy6+eNi04T3JAKf9bqg8gWzJ281Gu9/r1dF275JlYWTg76
         BTX74Rsh4q/T5Pbxzt8A48caZd6Xk+4Sp5MLj4TH94Wuzp+e8pUr/sdcrhcTPiHmhLBi
         XvwVtvq6c1gQOp5cyJ0Lf18UCZZ0jRTkokimvvhMHBukYmFm+KrIHAh4wUrNgnS4/vIO
         bddw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=j0yz6sA6;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=j0yz6sA6;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 10/62] ipv4: fix uninit-value in ip_route_output_key_hash_rcu()
Date: Mon, 14 May 2018 08:48:26 +0200
Message-Id: <20180514064817.011416788@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421533096477895?=
X-GMAIL-MSGID: =?utf-8?q?1600421533096477895?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit d0ea2b12500543535be3f54e17920fffc9bb45f6 upstream.

syzbot complained that res.type could be used while not initialized.

Using RTN_UNSPEC as initial value seems better than using garbage.

BUG: KMSAN: uninit-value in __mkroute_output net/ipv4/route.c:2200 [inline]
BUG: KMSAN: uninit-value in ip_route_output_key_hash_rcu+0x31f0/0x3940 net/ipv4/route.c:2493
CPU: 1 PID: 12207 Comm: syz-executor0 Not tainted 4.16.0+ #81
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x185/0x1d0 lib/dump_stack.c:53
 kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
 __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:676
 __mkroute_output net/ipv4/route.c:2200 [inline]
 ip_route_output_key_hash_rcu+0x31f0/0x3940 net/ipv4/route.c:2493
 ip_route_output_key_hash net/ipv4/route.c:2322 [inline]
 __ip_route_output_key include/net/route.h:126 [inline]
 ip_route_output_flow+0x1eb/0x3c0 net/ipv4/route.c:2577
 raw_sendmsg+0x1861/0x3ed0 net/ipv4/raw.c:653
 inet_sendmsg+0x48d/0x740 net/ipv4/af_inet.c:764
 sock_sendmsg_nosec net/socket.c:630 [inline]
 sock_sendmsg net/socket.c:640 [inline]
 SYSC_sendto+0x6c3/0x7e0 net/socket.c:1747
 SyS_sendto+0x8a/0xb0 net/socket.c:1715
 do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x455259
RSP: 002b:00007fdc0625dc68 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007fdc0625e6d4 RCX: 0000000000455259
RDX: 0000000000000000 RSI: 0000000020000040 RDI: 0000000000000013
RBP: 000000000072bea0 R08: 0000000020000080 R09: 0000000000000010
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000004f7 R14: 00000000006fa7c8 R15: 0000000000000000

Local variable description: ----res.i.i@ip_route_output_flow
Variable was created at:
 ip_route_output_flow+0x75/0x3c0 net/ipv4/route.c:2576
 raw_sendmsg+0x1861/0x3ed0 net/ipv4/raw.c:653

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/route.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2288,13 +2288,14 @@ struct rtable *ip_route_output_key_hash(
 					const struct sk_buff *skb)
 {
 	__u8 tos = RT_FL_TOS(fl4);
-	struct fib_result res;
+	struct fib_result res = {
+		.type		= RTN_UNSPEC,
+		.fi		= NULL,
+		.table		= NULL,
+		.tclassid	= 0,
+	};
 	struct rtable *rth;
 
-	res.tclassid	= 0;
-	res.fi		= NULL;
-	res.table	= NULL;
-
 	fl4->flowi4_iif = LOOPBACK_IFINDEX;
 	fl4->flowi4_tos = tos & IPTOS_RT_MASK;
 	fl4->flowi4_scope = ((tos & RTO_ONLINK) ?
