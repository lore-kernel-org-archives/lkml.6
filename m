Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu980fPD5B+o7lKang1nl5fv2X6GVofsfFonOfDZ6+3qyxIFXtu+HmvHmhxnuanTCBTO/Eg
ARC-Seal: i=1; a=rsa-sha256; t=1521800284; cv=none;
        d=google.com; s=arc-20160816;
        b=wpcQunRXSIllykAfx+lCxsRidgn5bjn744deAz6tjWCdxJXedc/b9LDdCc8zVndoDn
         Jt3Jv3iuwTGRomKCzezBRR3UXXCdqD1+cunIeGIAosGbR40PPANrHuhNWszsec+ZnP62
         eR+qphgT2zjJpMmZ5C4hpQQ2xL+ucNQbW4UQCqQPDqx+7M4P3oQ7XlCkM+vOCDALZFEQ
         zshLBSDHGuICkn1A+7htaFEoItLvOz/wU94FgsHrXtVymfmMcWQ4x5nnAaq1HkS6/+Ky
         cJlq5+d64lKWu72sPvNfIWROEdeEp7dVe34PHhCZ0zBO08nNHvO8G/sP5WZt19J+7ZhT
         Degg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0EYbbyyBH08O9rcqz0XRiwwQOSwapi9Ntpn0v5orEDI=;
        b=DK9ellS8xM+dUHdSRxx8/OZRZ3ZnzbtJSJoej3+DvZ9mt8bX/BvKEkgG82F2iQsEgN
         NYSeECABDAwsF393vXzubB4UELoOneoJbZQNpYG7WD6jQgQwfZmrwEfCVMnolF/JocWX
         pcxOjOlId8zgPZ7BrAFIoEVc4q3ZZzDJfzgUNKG673s0kfdIZNWu5seK1cYxJy5938Jl
         sYXUw9S0AlPKBMeK8F1oVIK9NOubrJyhqjVnj4ek6GQK+A+p9rToKms3lcSdSZKAS6bA
         jpg0Q2T9Mvg0fx5dT1IS1kgAsUxx7KbBkxTTuN3j1KrHbKWaXo/lInsuxYqSBo8IK+RA
         5eWw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Yuchung Cheng <ycheng@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 14/47] tcp: remove poll() flakes with FastOpen
Date: Fri, 23 Mar 2018 10:55:05 +0100
Message-Id: <20180323094248.739074746@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722503417920435?=
X-GMAIL-MSGID: =?utf-8?q?1595723254376008205?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit 0f9fa831aecfc297b7b45d4f046759bcefcf87f0 ]

When using TCP FastOpen for an active session, we send one wakeup event
from tcp_finish_connect(), right before the data eventually contained in
the received SYNACK is queued to sk->sk_receive_queue.

This means that depending on machine load or luck, poll() users
might receive POLLOUT events instead of POLLIN|POLLOUT

To fix this, we need to move the call to sk->sk_state_change()
after the (optional) call to tcp_rcv_fastopen_synack()

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_input.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5322,10 +5322,6 @@ void tcp_finish_connect(struct sock *sk,
 	else
 		tp->pred_flags = 0;
 
-	if (!sock_flag(sk, SOCK_DEAD)) {
-		sk->sk_state_change(sk);
-		sk_wake_async(sk, SOCK_WAKE_IO, POLL_OUT);
-	}
 }
 
 static bool tcp_rcv_fastopen_synack(struct sock *sk, struct sk_buff *synack,
@@ -5380,6 +5376,7 @@ static int tcp_rcv_synsent_state_process
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct tcp_fastopen_cookie foc = { .len = -1 };
 	int saved_clamp = tp->rx_opt.mss_clamp;
+	bool fastopen_fail;
 
 	tcp_parse_options(skb, &tp->rx_opt, 0, &foc);
 	if (tp->rx_opt.saw_tstamp && tp->rx_opt.rcv_tsecr)
@@ -5482,10 +5479,15 @@ static int tcp_rcv_synsent_state_process
 
 		tcp_finish_connect(sk, skb);
 
-		if ((tp->syn_fastopen || tp->syn_data) &&
-		    tcp_rcv_fastopen_synack(sk, skb, &foc))
-			return -1;
+		fastopen_fail = (tp->syn_fastopen || tp->syn_data) &&
+				tcp_rcv_fastopen_synack(sk, skb, &foc);
 
+		if (!sock_flag(sk, SOCK_DEAD)) {
+			sk->sk_state_change(sk);
+			sk_wake_async(sk, SOCK_WAKE_IO, POLL_OUT);
+		}
+		if (fastopen_fail)
+			return -1;
 		if (sk->sk_write_pending ||
 		    icsk->icsk_accept_queue.rskq_defer_accept ||
 		    icsk->icsk_ack.pingpong) {
