Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvyqHkaTUZiEnaBhsYZd0OOk4QXH4EGI++Fc2PiAkZLwNstf4RWQs8ad1uUblagqVUxD2JZ
ARC-Seal: i=1; a=rsa-sha256; t=1520452058; cv=none;
        d=google.com; s=arc-20160816;
        b=lTrGdZSokeMz19/FE6ZStLT6QC+bfG6yXpHleHWStRqNgMVsMlSWhdrvrrdWZOWlIM
         Ie56h61d2Url46AApB2TcU4hFpH/02GRX1IYoK+WdEAgbnuSqkrVCWB3bioQoOvstCNR
         NqDEiz3OGbeksFtRRVsIE7NrJHrEPSQIRD2gH2wi7Sakf+A8bQcGYRuLzNDXy94P8mqs
         PjLAxhFHdOiNHyEJDMyp3aSK5D+/AcEumSsfyGivxvLzkzUIogRevnKPckZW9/Y6qV2V
         +/Gptnt6JbWkb4CkvE7J7shnfsS4qjpQC/JvNPs13f3FaDnWhN2NKBSlhUtfbn0YFdoy
         OylA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uvEUg2epm2iZxtmzPeBFL9qXJSIXQiAYxLeKF5Ya3w4=;
        b=VfguQEr7upRzSGmEHo2FeMMajWJ/b5j2qRTwSOPtLEbwIt1MV/IwtTciecUcvbZMge
         b3DbLolgHEXK6GVSpqUQFxNyB65gUBJO3lAYHrQTrgvzyDwOtdPlzJ2YgRfZ6hcMQMGz
         L97bjFEx+Cit+e0vTHG121U12IZ9bkB79zAwoGkpu+k1+NAVacLylEpWbx8wnU8Ax27J
         1SeBI0ylDVRrwHyvDlQlpIcNTlLgAFkC/Zyn96J8KpdkZNUc0nGQI3RqHnK/mDWxTc6K
         pofAI6TiuHYu46FxZ0si4FtORqpBLvVHPeQb3tF77Ynp1xmQq/QSPXhlXmdE+nC6nu7A
         y3OA==
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
Subject: [PATCH 4.14 054/110] tcp_bbr: better deal with suboptimal GSO
Date: Wed,  7 Mar 2018 11:38:37 -0800
Message-Id: <20180307191046.577013304@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309161153019394?=
X-GMAIL-MSGID: =?utf-8?q?1594309537838747366?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 net/ipv4/tcp_output.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1681,7 +1681,7 @@ u32 tcp_tso_autosize(const struct sock *
 	 */
 	segs = max_t(u32, bytes / mss_now, min_tso_segs);
 
-	return min_t(u32, segs, sk->sk_gso_max_segs);
+	return segs;
 }
 EXPORT_SYMBOL(tcp_tso_autosize);
 
@@ -1693,8 +1693,10 @@ static u32 tcp_tso_segs(struct sock *sk,
 	const struct tcp_congestion_ops *ca_ops = inet_csk(sk)->icsk_ca_ops;
 	u32 tso_segs = ca_ops->tso_segs_goal ? ca_ops->tso_segs_goal(sk) : 0;
 
-	return tso_segs ? :
-		tcp_tso_autosize(sk, mss_now, sysctl_tcp_min_tso_segs);
+	if (!tso_segs)
+		tso_segs = tcp_tso_autosize(sk, mss_now,
+					    sysctl_tcp_min_tso_segs);
+	return min_t(u32, tso_segs, sk->sk_gso_max_segs);
 }
 
 /* Returns the portion of skb which can be sent right away */
