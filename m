Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpjOWmnlwf1sNBVApM0/O2MhGGH5QDd4rAHVNveTYVV1Uekj/EqqatNADPWGZ3CAFp1icBL
ARC-Seal: i=1; a=rsa-sha256; t=1526631683; cv=none;
        d=google.com; s=arc-20160816;
        b=1CadBzidePfNTVIeQ/nyvLXGm03EPYq54vBFNjNl8mrwr0BS8UEFGOW8xkUHgqS4EN
         GD0CQWIY03BBZ+KM5KdnxTFNo29Fh7y7g5ErsjKwFJOIrTAuwMQ14h9p4QDAJaQtdG5f
         TZC1Ybsxj5Xrm22TjhaL70uHHgaTdfK9BAlubB/07FjherAd8Qt5qAvtyFbfwRq+AD+j
         0ofRbAtt4j46weB5X5BBvOr/7+NglgddemJ+rPnYPssOcauoWmeltKi7+cYrRKH/RenU
         F5YV0SQ0kOphhNPdmJtwFEAKvF08uXPw47dEZo7GppzgvDMAwq6OxDfEAwUlCfiBGjif
         vsyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=x5+ac4Jeo3GBBjs1+pVJkr2XWKZrDlUNBzpyVJ/xmww=;
        b=SnGSDHgwO6WaHU7C1FHIBV4FeClA8uOEVbklIMtCetW8ll8GtdSO2CZIowu6iDhONX
         mwFBdnwlE+5bOz2GnJQQ8JBTvYvkrxvd/f65MXtyGMIdZZrvifo0KhYjLwmbA4dLeAcR
         +cGhsMkIxLqSaGptPu2glcaXjoxah9IDvYJO7qFGdNBL6d4R/dkRddXbYcyNZtvmIWBQ
         +IVWldIdxR8ACNJGBxoAh2kLLoPE+TI8PshgHEeqRaOTdt+RNjBL8PCAr59SRgGLQOxr
         AWYeTdWNOmvv8YE8co+ot2dld/AYZ8AouyUeDCee8BPPidoJkJHaysvhZVIzZaUI98/i
         Pdwg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Sw+22bfg;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Sw+22bfg;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 10/33] net_sched: fq: take care of throttled flows before reuse
Date: Fri, 18 May 2018 10:15:49 +0200
Message-Id: <20180518081535.494493502@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081535.096308218@linuxfoundation.org>
References: <20180518081535.096308218@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789091707384328?=
X-GMAIL-MSGID: =?utf-8?q?1600789344176235161?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 7df40c2673a1307c3260aab6f9d4b9bf97ca8fd7 ]

Normally, a socket can not be freed/reused unless all its TX packets
left qdisc and were TX-completed. However connect(AF_UNSPEC) allows
this to happen.

With commit fc59d5bdf1e3 ("pkt_sched: fq: clear time_next_packet for
reused flows") we cleared f->time_next_packet but took no special
action if the flow was still in the throttled rb-tree.

Since f->time_next_packet is the key used in the rb-tree searches,
blindly clearing it might break rb-tree integrity. We need to make
sure the flow is no longer in the rb-tree to avoid this problem.

Fixes: fc59d5bdf1e3 ("pkt_sched: fq: clear time_next_packet for reused flows")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_fq.c |   37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -128,6 +128,28 @@ static bool fq_flow_is_detached(const st
 	return f->next == &detached;
 }
 
+static bool fq_flow_is_throttled(const struct fq_flow *f)
+{
+	return f->next == &throttled;
+}
+
+static void fq_flow_add_tail(struct fq_flow_head *head, struct fq_flow *flow)
+{
+	if (head->first)
+		head->last->next = flow;
+	else
+		head->first = flow;
+	head->last = flow;
+	flow->next = NULL;
+}
+
+static void fq_flow_unset_throttled(struct fq_sched_data *q, struct fq_flow *f)
+{
+	rb_erase(&f->rate_node, &q->delayed);
+	q->throttled_flows--;
+	fq_flow_add_tail(&q->old_flows, f);
+}
+
 static void fq_flow_set_throttled(struct fq_sched_data *q, struct fq_flow *f)
 {
 	struct rb_node **p = &q->delayed.rb_node, *parent = NULL;
@@ -155,15 +177,6 @@ static void fq_flow_set_throttled(struct
 
 static struct kmem_cache *fq_flow_cachep __read_mostly;
 
-static void fq_flow_add_tail(struct fq_flow_head *head, struct fq_flow *flow)
-{
-	if (head->first)
-		head->last->next = flow;
-	else
-		head->first = flow;
-	head->last = flow;
-	flow->next = NULL;
-}
 
 /* limit number of collected flows per round */
 #define FQ_GC_MAX 8
@@ -267,6 +280,8 @@ static struct fq_flow *fq_classify(struc
 				     f->socket_hash != sk->sk_hash)) {
 				f->credit = q->initial_quantum;
 				f->socket_hash = sk->sk_hash;
+				if (fq_flow_is_throttled(f))
+					fq_flow_unset_throttled(q, f);
 				f->time_next_packet = 0ULL;
 			}
 			return f;
@@ -430,9 +445,7 @@ static void fq_check_throttled(struct fq
 			q->time_next_delayed_flow = f->time_next_packet;
 			break;
 		}
-		rb_erase(p, &q->delayed);
-		q->throttled_flows--;
-		fq_flow_add_tail(&q->old_flows, f);
+		fq_flow_unset_throttled(q, f);
 	}
 }
 
