Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZowzxJsdcCSx9VRl1ustImCrCIn0ywXZV0AOM1UaXMERZxX1ZR/JVMNq8jWAttsZPjl82uY
ARC-Seal: i=1; a=rsa-sha256; t=1526631571; cv=none;
        d=google.com; s=arc-20160816;
        b=iZhY2Em1zYJvl/ruO8v9DrkiMXn0LA+RnJIzcAFwE8hCMW3zwWIJ5mE/YX5f0HIqfe
         lRXLAA8OV0cBOJ0iDQPvO6Ps0Igq2h/bSDpnR6ye9NJcLkilpFMTF9A8Xe17soAH4uVl
         h9kmbTcc+7TeigRbhpey8+bh1F3rUox96VS416z/NHkO/i0lvyev8EHZ/eHURPirwO/H
         kNzpswUVZx49Erixs2ddzrrAleOgLjZbcbyUtjmBxL1ZAzcwWn8nh3YuEomtBlMjA5rC
         f8npFDikoN5GnYjsmpYQYTrAEjrBnolcv9yADbKGJEoiEJyC+PfkjNqzNfL9IXXQ2Thw
         eH2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=LNLFk6MIRMgICrBK9LMjbO4xG6B6bmOxtCIE4i8C404=;
        b=dIFe9bCQu/uJUNFKNrozIg+/tNR2WJafBUwAFMBcKEVtILCxTbGa4alewLMmOlJi6P
         Xjpdd1K4247yGCjImogbYAnqEylHV6TWYaMbPm4tGtvhfA/8jpJ9KmN7eLWDECjWg8VV
         sZ+5eELaSwf02W6FHHpSSc3PU0cJa8W+JpSXBpese39miDvHxWyGUxTljee1UAxYEJl+
         jETFBuLIpvheXVpxi333MkrH6/vuQNx7wXYW8yc9vsS8pIYXeOvftqZDKDZ3sHpvKuvo
         t8HQgnBlX1fypF0cJrVMfTHUHRkQMtkXITWyHi7hAfnvAAxIUh+xe+yRDOUbF7CICDL/
         CqZg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=V7fO1YKg;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=V7fO1YKg;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 14/45] net_sched: fq: take care of throttled flows before reuse
Date: Fri, 18 May 2018 10:15:31 +0200
Message-Id: <20180518081531.057018934@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
References: <20180518081530.331586165@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789091707384328?=
X-GMAIL-MSGID: =?utf-8?q?1600789226585979054?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -438,9 +453,7 @@ static void fq_check_throttled(struct fq
 			q->time_next_delayed_flow = f->time_next_packet;
 			break;
 		}
-		rb_erase(p, &q->delayed);
-		q->throttled_flows--;
-		fq_flow_add_tail(&q->old_flows, f);
+		fq_flow_unset_throttled(q, f);
 	}
 }
 
