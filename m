Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+mQjyQmsH1oPzyzWTdkLT0KqXwjkZR3Fv+sZbY0SSgpZIm7NoRVAHSglr0Bx0Hfq8fKL4C
ARC-Seal: i=1; a=rsa-sha256; t=1523472687; cv=none;
        d=google.com; s=arc-20160816;
        b=IM5fOEjBjlNK36bp8aTkhxp8VqbNs6Iy/PAMX264DgMohePwT57LhNAEuPkKhs6TrH
         LduNVIKIVtOVAWUND8WhGnrTJEjNa6EZ6IgllmZlXsJOhGNViKBvI9l6fHUz/5seSMSB
         fUB6EOHku5EHAhcqprqdgNaUYv52VlnTrI5kBg1LWQetSJTDiJ/YbY5cJUntHf4xfBdT
         w6u1vAbyF5e2+7AePeFWJbKBKkYWBbrQvpjPC9JWbYoQ2z3vXOKRjjmeVSsGiKJ095Yc
         fkrbt6itWQ0D5nLfEtluFnfY/6rA0OQvHdDm9PmINF/Xc62WALbZjRTxRF+Gc4QDsY7P
         zkoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BW9wv8SOZi+RxkanYO6iDsjQ0v0MLHtBMyPL+RM8s5U=;
        b=wnnrqQ7GWUv9Vtjvt1uV0vqHndH/hZlMs/OyQ4A0PIoBPtbtlfKV2XpjLUMVa9V5SN
         TvFpMpjXud788lYLllD13vouS/GOMSC9OLWm2pSy0G5rTqRsSvI4BHzbpM354cFR9zc5
         cnKw+ia+aQFDX+OPoaH0mkTU8nzcxx7pfFUkNKglZGsA2ziJx3uWEcRnMNwoQuncHx3i
         asIlDjViEji78ISj1lOpTy4hy5/aUL+6aLNnGfYko3Pa5r9HYPXigxmpAOco03vfs3xL
         RTPPF1fx0dcmjOU8vloLaf+ujI24wSXwtm7Q85ZxyHM+RSgM0zDft6SKmegLf8voI2f/
         IpFA==
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
Subject: [PATCH 4.4 140/190] sctp: fix recursive locking warning in sctp_do_peeloff
Date: Wed, 11 Apr 2018 20:36:26 +0200
Message-Id: <20180411183600.791413624@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476274816601516?=
X-GMAIL-MSGID: =?utf-8?q?1597476897298209266?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1518,7 +1518,7 @@ static void sctp_close(struct sock *sk,
 
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
