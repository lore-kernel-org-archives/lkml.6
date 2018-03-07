Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuMOMyLeJIQhZSa9/31c8CpH27RQkfTcINndFLi91tIR6qSYMU0pn/HrCZmqnEEMN38TVPR
ARC-Seal: i=1; a=rsa-sha256; t=1520451793; cv=none;
        d=google.com; s=arc-20160816;
        b=GdWZE7kj/F9c+fbqifrW3nQ298yYOIZuYcc5cjGcMPB1G3Pj1skzw8Vim8rzWyvBHq
         t2LR/z371/kDCDqZPl7kBpF/Dm1arVXQ/UukbDH2oBuTJuwhlXjq7ZhJYOFeX5FcxokO
         wqMGbptajXww3aVisSHPxx5S1anbD4mUzjfZXSzlgy6Hy2I8fKd5YFhIcQGwV18nDqbP
         V+8hNqM/3/ZoDupRAFN4qTAi1Rcdn6TJVTxhW7aKpaIpQ58DA+vz2scyS1GOctqcN6co
         vvw8sPQp5NYpmCrCvbdMQ+Jz9HCrTpNIkcL1NvzkXtJpiZi3gQ5+SMONSddVDZL9kY4y
         FoLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nw5vl3bevftyBim6zkajlXLsZ3DwDcrbtG9IiFsMifc=;
        b=JXS3LGu49h7en1STwnR01IpQRFcnYAeB9OoAojLPRHi5KUoypG8BDIxaaFJuln06qW
         rEZsptCDgL1kWfHn7to8RA3cFFCMVcndONLhpGgIaCnbObWOUUKBdou6X7kL+4DhzqG2
         wo+FhjseN0AvR2ebfJyDQcnjmBaWd6AshWkawRcxR+tqBLXdAWvTu64TTBDWQ8Fzwuha
         dxTRo5pgGgTvKAFsvGRChFh8cttTdFFP5mtfNq83BI/lovTRSXMvbhdMErJrUYPm6+8J
         2+FG6OnRIt5jebHNk4DdvdxwLvmtPB6eOk2so23TnzXaUurQXd3Id2Wbb2Yet75MQlxY
         /Eqg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Teodor Milkov <tm@del.bg>,
	Yuchung Cheng <ycheng@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 096/122] tcp: revert F-RTO middle-box workaround
Date: Wed,  7 Mar 2018 11:38:28 -0800
Message-Id: <20180307191743.245437591@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309259230127880?=
X-GMAIL-MSGID: =?utf-8?q?1594309259230127880?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuchung Cheng <ycheng@google.com>


[ Upstream commit d4131f09770d9b7471c9da65e6ecd2477746ac5c ]

This reverts commit cc663f4d4c97b7297fb45135ab23cfd508b35a77. While fixing
some broken middle-boxes that modifies receive window fields, it does not
address middle-boxes that strip off SACK options. The best solution is
to fully revert this patch and the root F-RTO enhancement.

Fixes: cc663f4d4c97 ("tcp: restrict F-RTO to work-around broken middle-boxes")
Reported-by: Teodor Milkov <tm@del.bg>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_input.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 45f750e85714..50963f92a67d 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1915,7 +1915,6 @@ void tcp_enter_loss(struct sock *sk)
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct net *net = sock_net(sk);
 	struct sk_buff *skb;
-	bool new_recovery = icsk->icsk_ca_state < TCP_CA_Recovery;
 	bool is_reneg;			/* is receiver reneging on SACKs? */
 	bool mark_lost;
 
@@ -1974,17 +1973,15 @@ void tcp_enter_loss(struct sock *sk)
 	tp->high_seq = tp->snd_nxt;
 	tcp_ecn_queue_cwr(tp);
 
-	/* F-RTO RFC5682 sec 3.1 step 1: retransmit SND.UNA if no previous
-	 * loss recovery is underway except recurring timeout(s) on
-	 * the same SND.UNA (sec 3.2). Disable F-RTO on path MTU probing
-	 *
-	 * In theory F-RTO can be used repeatedly during loss recovery.
-	 * In practice this interacts badly with broken middle-boxes that
-	 * falsely raise the receive window, which results in repeated
-	 * timeouts and stop-and-go behavior.
+	/* F-RTO RFC5682 sec 3.1 step 1 mandates to disable F-RTO
+	 * if a previous recovery is underway, otherwise it may incorrectly
+	 * call a timeout spurious if some previously retransmitted packets
+	 * are s/acked (sec 3.2). We do not apply that retriction since
+	 * retransmitted skbs are permanently tagged with TCPCB_EVER_RETRANS
+	 * so FLAG_ORIG_SACK_ACKED is always correct. But we do disable F-RTO
+	 * on PTMU discovery to avoid sending new data.
 	 */
 	tp->frto = net->ipv4.sysctl_tcp_frto &&
-		   (new_recovery || icsk->icsk_retransmits) &&
 		   !inet_csk(sk)->icsk_mtup.probe_size;
 }
 
-- 
2.14.3
