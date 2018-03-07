Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsdAruQxkbtdIAgtFDOPAW3/O3alk5gZlOhRMiFuwWGYlkFf36T+5n6gGAvSnVY511bwArV
ARC-Seal: i=1; a=rsa-sha256; t=1520451699; cv=none;
        d=google.com; s=arc-20160816;
        b=ze2c3zFcEpmi9wZQuzIk+eMi18JkjA7zg0/rjtm8/yNOivb0fjVDbfxFgKoC4S8E+E
         S3Jmpxxree9qSD/kg3DehwPv2UN7GjMrUvy2ukBwAQrtvpu4rkZbjFUEg/7NfKtIu7c/
         0Rn6Umgr27ONt/ihWJcPd3aJqfPgRLsXM2U0KR/gydiVbAVvYgXcQwlBBAsbCTy4rwEk
         tz+G/cK4gC0qxCZUhOvGsuWSe6BuQ/fY6WNhSBi2YmAVkUR4Er4vSxrCg+kHtWeF/IT4
         hhwjKOe7GKTua2rB2y1J9MEihRdlryi40yH+ABbUmJLClPHM2hJ6dEBctv8uTwxgPnls
         Ue8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qJrx53BHK8tlkpogOjC1ICydeDqnOFHKPrQp3JNXLfA=;
        b=f2c4GnPguh3z/PRQXCiNpPInYDSmY8W/ygGwrR+LvXPx9lKhIQt1ukAZjLAGZUH5lk
         khDzJhNCoEgPr4z9fXHtOkoVlu3UbEZ/ZZglivFSpqio5BpXL94hpkA9L3+vfrtbeaPP
         6tcj7AKXsqmeFNgQFr05e6Vf7GJ+JpPdjFpupPGtXi55UdGn16NoFFc/+0rzH6ycUp3g
         YlVBSMShHRXA04YLfgdGbqJnYdlh/jYU7KJesggg6VP7cHGeo0dmnYUYwNfsN/CnUgQ/
         UZDrew9NJ7De4jSIs1ickx69QVmtbXQ9cGaGEpo7SdhRzVzCZ/ThDr4Bm5GrBuRvI1a1
         aKMA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Oleksandr Natalenko <oleksandr@natalenko.name>,
	Neal Cardwell <ncardwell@google.com>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 059/122] tcp_bbr: better deal with suboptimal GSO
Date: Wed,  7 Mar 2018 11:37:51 -0800
Message-Id: <20180307191737.784959092@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309161153019394?=
X-GMAIL-MSGID: =?utf-8?q?1594309161153019394?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit 350c9f484bde93ef229682eedd98cd5f74350f7f ]

BBR uses tcp_tso_autosize() in an attempt to probe what would be the
burst sizes and to adjust cwnd in bbr_target_cwnd() with following
gold formula :

/* Allow enough full-sized skbs in flight to utilize end systems. */
cwnd += 3 * bbr->tso_segs_goal;

But GSO can be lacking or be constrained to very small
units (ip link set dev ... gso_max_segs 2)

What we really want is to have enough packets in flight so that both
GSO and GRO are efficient.

So in the case GSO is off or downgraded, we still want to have the same
number of packets in flight as if GSO/TSO was fully operational, so
that GRO can hopefully be working efficiently.

To fix this issue, we make tcp_tso_autosize() unaware of
sk->sk_gso_max_segs

Only tcp_tso_segs() has to enforce the gso_max_segs limit.

Tested:

ethtool -K eth0 tso off gso off
tc qd replace dev eth0 root pfifo_fast

Before patch:
for f in {1..5}; do ./super_netperf 1 -H lpaa24 -- -K bbr; done
    691  (ss -temoi shows cwnd is stuck around 6 )
    667
    651
    631
    517

After patch :
# for f in {1..5}; do ./super_netperf 1 -H lpaa24 -- -K bbr; done
   1733 (ss -temoi shows cwnd is around 386 )
   1778
   1746
   1781
   1718

Fixes: 0f8782ea1497 ("tcp_bbr: add BBR congestion control")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Acked-by: Neal Cardwell <ncardwell@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_output.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1730,7 +1730,7 @@ u32 tcp_tso_autosize(const struct sock *
 	 */
 	segs = max_t(u32, bytes / mss_now, min_tso_segs);
 
-	return min_t(u32, segs, sk->sk_gso_max_segs);
+	return segs;
 }
 EXPORT_SYMBOL(tcp_tso_autosize);
 
@@ -1742,9 +1742,10 @@ static u32 tcp_tso_segs(struct sock *sk,
 	const struct tcp_congestion_ops *ca_ops = inet_csk(sk)->icsk_ca_ops;
 	u32 tso_segs = ca_ops->tso_segs_goal ? ca_ops->tso_segs_goal(sk) : 0;
 
-	return tso_segs ? :
-		tcp_tso_autosize(sk, mss_now,
-				 sock_net(sk)->ipv4.sysctl_tcp_min_tso_segs);
+	if (!tso_segs)
+		tso_segs = tcp_tso_autosize(sk, mss_now,
+				sock_net(sk)->ipv4.sysctl_tcp_min_tso_segs);
+	return min_t(u32, tso_segs, sk->sk_gso_max_segs);
 }
 
 /* Returns the portion of skb which can be sent right away */
