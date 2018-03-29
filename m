Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/6jJz504KO6KFthksKyPGNVknt1/T95m8h80zZaS8hb080rpvPinqNNiZUSTEBkttPgffY
ARC-Seal: i=1; a=rsa-sha256; t=1522346543; cv=none;
        d=google.com; s=arc-20160816;
        b=POYn9jFNFilmcpJacUQ6B3O8zval4DwV0fSfliOvKsUzu8DvLWqumHOSZdKxmMcUN8
         s1AtRt1yYrEZLF6GLJXvFZyk0kpXiKfF0tjyDTGSWKQuSb0Xuuwf1wzyMkoK8DEf8slI
         whLa7jM7hdz1Rx4dyuaIGjKYp69BZSousqlS2yrNrbieZyIohIbc22Yn6JLJehQeAXsg
         sB94wNRUSKmKfIFS31xxnCRP1dnHamBe3t4bj1yqu5TJjMv9T8txYPzvv7jfaJNExoru
         DuVoETKTUopeyzgfaHb1eiM6uDjv6v9YojFLzaICGKSH8B3X2w1v9qOSvCv/oZmJzJ74
         iyYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/dx7niDsBznj5SpnwKteZxwtcUqLT9f4G1ijZfvZrVo=;
        b=IQGdu7609lmQHR48m4zZaHx6/6qtTTl3QK+ChxkNdQdZ8MmVhC2zdbE8eqSU5l8Xkl
         8jnVSaEAwbwEnrpReFTetxIRwmWpLttJMfbISbEC2gTNa0yX/sbCIViIM3ddBG0xSRCy
         KkOAZnu9/tGIMqbqABLRjdHp0tf/B+1nR+kSr39BtE8IH5lyqzY8ch7PwN+2moj1pIK+
         /v/gwvPb/m3L83FVBQmDHARgdt6y+ekI/PkR1vFqreqMkQmRBW7ecJQiaAHvFd5ubVhk
         o4ht/cH29uUJn14UkMC4mVsc/5PylXryn3Iau9pKceOu173ho3fnF9pLBwhDe/jrdn9x
         /vNw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexey Kodanev <alexey.kodanev@oracle.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 22/47] sch_netem: fix skb leak in netem_enqueue()
Date: Thu, 29 Mar 2018 20:00:03 +0200
Message-Id: <20180329175730.884234475@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296048390316813?=
X-GMAIL-MSGID: =?utf-8?q?1596296048390316813?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Kodanev <alexey.kodanev@oracle.com>


[ Upstream commit 35d889d10b649fda66121891ec05eca88150059d ]

When we exceed current packets limit and we have more than one
segment in the list returned by skb_gso_segment(), netem drops
only the first one, skipping the rest, hence kmemleak reports:

unreferenced object 0xffff880b5d23b600 (size 1024):
  comm "softirq", pid 0, jiffies 4384527763 (age 2770.629s)
  hex dump (first 32 bytes):
    00 80 23 5d 0b 88 ff ff 00 00 00 00 00 00 00 00  ..#]............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000d8a19b9d>] __alloc_skb+0xc9/0x520
    [<000000001709b32f>] skb_segment+0x8c8/0x3710
    [<00000000c7b9bb88>] tcp_gso_segment+0x331/0x1830
    [<00000000c921cba1>] inet_gso_segment+0x476/0x1370
    [<000000008b762dd4>] skb_mac_gso_segment+0x1f9/0x510
    [<000000002182660a>] __skb_gso_segment+0x1dd/0x620
    [<00000000412651b9>] netem_enqueue+0x1536/0x2590 [sch_netem]
    [<0000000005d3b2a9>] __dev_queue_xmit+0x1167/0x2120
    [<00000000fc5f7327>] ip_finish_output2+0x998/0xf00
    [<00000000d309e9d3>] ip_output+0x1aa/0x2c0
    [<000000007ecbd3a4>] tcp_transmit_skb+0x18db/0x3670
    [<0000000042d2a45f>] tcp_write_xmit+0x4d4/0x58c0
    [<0000000056a44199>] tcp_tasklet_func+0x3d9/0x540
    [<0000000013d06d02>] tasklet_action+0x1ca/0x250
    [<00000000fcde0b8b>] __do_softirq+0x1b4/0x5a3
    [<00000000e7ed027c>] irq_exit+0x1e2/0x210

Fix it by adding the rest of the segments, if any, to skb 'to_free'
list. Add new __qdisc_drop_all() and qdisc_drop_all() functions
because they can be useful in the future if we need to drop segmented
GSO packets in other places.

Fixes: 6071bd1aa13e ("netem: Segment GSO packets on enqueue")
Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/sch_generic.h |   19 +++++++++++++++++++
 net/sched/sch_netem.c     |    2 +-
 2 files changed, 20 insertions(+), 1 deletion(-)

--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -735,6 +735,16 @@ static inline void __qdisc_drop(struct s
 	*to_free = skb;
 }
 
+static inline void __qdisc_drop_all(struct sk_buff *skb,
+				    struct sk_buff **to_free)
+{
+	if (skb->prev)
+		skb->prev->next = *to_free;
+	else
+		skb->next = *to_free;
+	*to_free = skb;
+}
+
 static inline unsigned int __qdisc_queue_drop_head(struct Qdisc *sch,
 						   struct qdisc_skb_head *qh,
 						   struct sk_buff **to_free)
@@ -853,6 +863,15 @@ static inline int qdisc_drop(struct sk_b
 	qdisc_qstats_drop(sch);
 
 	return NET_XMIT_DROP;
+}
+
+static inline int qdisc_drop_all(struct sk_buff *skb, struct Qdisc *sch,
+				 struct sk_buff **to_free)
+{
+	__qdisc_drop_all(skb, to_free);
+	qdisc_qstats_drop(sch);
+
+	return NET_XMIT_DROP;
 }
 
 /* Length to Time (L2T) lookup in a qdisc_rate_table, to determine how
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -509,7 +509,7 @@ static int netem_enqueue(struct sk_buff
 	}
 
 	if (unlikely(sch->q.qlen >= sch->limit))
-		return qdisc_drop(skb, sch, to_free);
+		return qdisc_drop_all(skb, sch, to_free);
 
 	qdisc_qstats_backlog_inc(sch, skb);
 
