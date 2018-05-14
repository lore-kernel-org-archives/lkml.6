Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpvnBmuWwr2bTFBRJAFXRGuT6Q7QnEbd/JuQz9iCifJc9ks9w4hXrTm6mspCCRv7liOGhP2
ARC-Seal: i=1; a=rsa-sha256; t=1526281083; cv=none;
        d=google.com; s=arc-20160816;
        b=QJH1r0HduCNnE8UYwJdRB+Qk8GLxbQgMIvGIyKrS3OV4FL3pr9NkhQItIy2TzkjdDu
         lIT7uw/FBRQcxkjGv4na6OIcu55071jKhoBc3TmfqVCWkuwADsM2mh2xgZfNaV/nEhA5
         z+kClEIWvHplMD9J0Pzxy7mB8sK8foL16LWIp8q6eWuERIXU42s+PEbk40Mzq1dZNymP
         fJhKiFYtdFyE73FZ6owLrxoFObov8g4I9CINPTMyU5+JXoy4pdvj8A5tKt2eoxwbRHhv
         aa1eeVdo9MH8uX+G8WGw+gfl3qY9x0ZHTRLTSwwhvGgOxDqVQCa73xp8BLSMRa4nvFbi
         KOhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=BSspt8jwrKTCt93AwmW7n7K6BNdHgpfntgbv9NKfDD4=;
        b=uImvHfStRvqS/XtGA9YXWHQVnFEoRX92F9+/aW33RxEmgc8XCwJoaW65G3Zbfia8hh
         B7g0Ns6ICvhiP6Kx5nz8v4GlOWnKqJh1VqBeAozu1H8ZQBQ6uG+SEGsPwP6leBCfBTqV
         VL0aGXNGbQijoMEsacKBWS1nc7EXKUiTybl0+pO03n/qd2SlQxKSjiuMAikWOHr3YQst
         E5cJRpaFsv9wUt5Cr3sPqpRgSFnWQC7oT4mNXAfSY7oirE1CuWhhSL89sdFiNoP7xYJo
         spCGEZGiLdsBTL5HibqJjs/0HtK2SLQtFU/0x357frde89kl9RKtwJxg8PNXPhvr5zIn
         s1zQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=0Xu74FoZ;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=0Xu74FoZ;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 12/72] ipv4: fix uninit-value in ip_route_output_key_hash_rcu()
Date: Mon, 14 May 2018 08:48:29 +0200
Message-Id: <20180514064823.571761843@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421533096477895?=
X-GMAIL-MSGID: =?utf-8?q?1600421713553827647?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2306,13 +2306,14 @@ struct rtable *ip_route_output_key_hash(
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
