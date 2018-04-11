Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48zNFu6+1Lu8rjrd4Oziw0ZWXtUSJCZ11j6mmbm8lwJQBlXH27+TTwlTvn46mMAOqw+WYmd
ARC-Seal: i=1; a=rsa-sha256; t=1523473409; cv=none;
        d=google.com; s=arc-20160816;
        b=O85+MDrL2iezN9BmB9fxAvIxux1vYK2fejROML5ybSbTzlzRgNV6PwX7xtKzJXNykd
         IQ+ZutpDg6crOCsGbayYYjZBvaWYRpsMTn4nDaCQYuUwsvqt8mDALyHVSyQNRRRw847C
         BSSsRZSPJru9c7iCXJjADQpvTCr2oXUIs6c76kMhlUK/tJfSlEkgowFFgU5CqpbeUi8j
         DtDJIhc6hqUo2nNKf05JB63XCuCjaIjk0Hcy8BBhLrHRAp8WaXUqlNu1ZZT+63bycAvY
         VYTfrwLmf3k08bqSuy1Ibj2dHw/pnCAIoL0F64FqzPzdsaewMKtHyQuOQuwEG6ZMpHma
         rQ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0hcMcK1cTiXZq/+ChpV9WgaOLNYwMh/UbqJ9Z6qhe5M=;
        b=K8aS0X4K3TOUFjG2+KP2Me8YQkMeHA/SLboA4orM2dwwViKPlTjnBNQBKQGq++/pZT
         Q+PEQU/tqUwg0tCIOYhcE7sKi9xB2DBQUXon+ghV7L0E549j5HPrgsFVSwmAbbqA/pyE
         HufqnrdK3ii5pIHMsnbYc/LoBGDXfkADjh1tWaBiGWuIS0o0J+zxO1wKqxxLZWyXEgP0
         BQCzH1hXwQ1r7vlO3EbYWZqts11G0D59o5Du6/7eJXGh3nZdPa2usewipWJclhc8SzEn
         HxWZVbLspiEVVCsd1tremwDME3WhPH4a/ejnvW0agvz5TpRpvPKJvgoKHvZB9P8FZ2u+
         SqMg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 237/310] sctp: fix recursive locking warning in sctp_do_peeloff
Date: Wed, 11 Apr 2018 20:36:16 +0200
Message-Id: <20180411183632.691959267@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476274816601516?=
X-GMAIL-MSGID: =?utf-8?q?1597477653673934400?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>


[ Upstream commit 6dfe4b97e08ec3d1a593fdaca099f0ef0a3a19e6 ]

Dmitry got the following recursive locking report while running syzkaller
fuzzer, the Call Trace:
 __dump_stack lib/dump_stack.c:16 [inline]
 dump_stack+0x2ee/0x3ef lib/dump_stack.c:52
 print_deadlock_bug kernel/locking/lockdep.c:1729 [inline]
 check_deadlock kernel/locking/lockdep.c:1773 [inline]
 validate_chain kernel/locking/lockdep.c:2251 [inline]
 __lock_acquire+0xef2/0x3430 kernel/locking/lockdep.c:3340
 lock_acquire+0x2a1/0x630 kernel/locking/lockdep.c:3755
 lock_sock_nested+0xcb/0x120 net/core/sock.c:2536
 lock_sock include/net/sock.h:1460 [inline]
 sctp_close+0xcd/0x9d0 net/sctp/socket.c:1497
 inet_release+0xed/0x1c0 net/ipv4/af_inet.c:425
 inet6_release+0x50/0x70 net/ipv6/af_inet6.c:432
 sock_release+0x8d/0x1e0 net/socket.c:597
 __sock_create+0x38b/0x870 net/socket.c:1226
 sock_create+0x7f/0xa0 net/socket.c:1237
 sctp_do_peeloff+0x1a2/0x440 net/sctp/socket.c:4879
 sctp_getsockopt_peeloff net/sctp/socket.c:4914 [inline]
 sctp_getsockopt+0x111a/0x67e0 net/sctp/socket.c:6628
 sock_common_getsockopt+0x95/0xd0 net/core/sock.c:2690
 SYSC_getsockopt net/socket.c:1817 [inline]
 SyS_getsockopt+0x240/0x380 net/socket.c:1799
 entry_SYSCALL_64_fastpath+0x1f/0xc2

This warning is caused by the lock held by sctp_getsockopt() is on one
socket, while the other lock that sctp_close() is getting later is on
the newly created (which failed) socket during peeloff operation.

This patch is to avoid this warning by use lock_sock with subclass
SINGLE_DEPTH_NESTING as Wang Cong and Marcelo's suggestion.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Suggested-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Suggested-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/socket.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -1519,7 +1519,7 @@ static void sctp_close(struct sock *sk,
 
 	pr_debug("%s: sk:%p, timeout:%ld\n", __func__, sk, timeout);
 
-	lock_sock(sk);
+	lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
 	sk->sk_shutdown = SHUTDOWN_MASK;
 	sk->sk_state = SCTP_SS_CLOSING;
 
@@ -1569,7 +1569,7 @@ static void sctp_close(struct sock *sk,
 	 * held and that should be grabbed before socket lock.
 	 */
 	spin_lock_bh(&net->sctp.addr_wq_lock);
-	bh_lock_sock(sk);
+	bh_lock_sock_nested(sk);
 
 	/* Hold the sock, since sk_common_release() will put sock_put()
 	 * and we have just a little more cleanup.
