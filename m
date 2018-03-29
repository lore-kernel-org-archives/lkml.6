Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+wddEPVKMhkNcNKxBr/UlNmd5GOTYP+Zp8LKTFb9aL39QQVYifPqsqG0cIYTq03X9Wi/fj
ARC-Seal: i=1; a=rsa-sha256; t=1522346833; cv=none;
        d=google.com; s=arc-20160816;
        b=mfgKw0Y1l9dRqEiDfvChrjzsXdDw6jiWtVOPCXlgQlWTfIZJ0iNxFMOeYs5D9S22su
         fib2SUIOR6XrZ1gAWo+S5P4Pz/YlO2E3u3Q2W+hp6/8wRsvRpZUsX/mcB+neWmL9Tn1u
         xxT/w/m8Te/dN3ILIw7YsnqEHirP0nnrd3SxHdV5JBNClRBp3yHJBuUX7Lk+h+XBWcyH
         pJoNHI7aKJkmMXh6O5EcpK34hssK1R2jE7jy2s+8FtUnth2LIYkrItdmoxLt2Uj+t3yv
         lXRpesPv/nWfQu6m7X9OJFdVdOR+fcirVLTcKcXceUJTK7auw/Cy55Zw7GtFjRpCWnfQ
         +pog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BKIQip2HbbhiYopDFjlwj30PPH6Ce2+a9VTaNibMmr4=;
        b=hIFmKSYH6XPMcfZ8APucCKXVdOqHRpjyUwmLdDLiPtLMVV8JK5/ecW8bwboh7FqgXs
         HTDfMutjyN+e3sCKupmCkjeFjHRmV9C0VodHeq/Cfm53jNqeF07bl/9vPEKDIZ4D0iZ0
         jZnaL8AmnCWPhgY5tJbsthYq27W430ws3juU9zYhSXqtF9hAOJyTyAFQJFFLFyq1nvD9
         NdThdz0T8k2etHm+z4G5wucHkC9s7bHkwVA1tvHOxCnqZpoM4/+mPnhAaoYZnfqGfjLp
         3XLGlrv5R8b9ITJY2i1RLD9ZYeg+cWtpzaIUqpSOB63udEEvP96gkADAxwx74oKtlxqH
         OMRQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	xu heng <xuheng333@zoho.com>,
	Guillaume Nault <g.nault@alphalink.fr>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 04/28] ppp: avoid loop in xmit recursion detection code
Date: Thu, 29 Mar 2018 20:00:23 +0200
Message-Id: <20180329175733.996446710@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175733.447823703@linuxfoundation.org>
References: <20180329175733.447823703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296036023455533?=
X-GMAIL-MSGID: =?utf-8?q?1596296353390862748?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guillaume Nault <g.nault@alphalink.fr>


[ Upstream commit 6d066734e9f09cdea4a3b9cb76136db3f29cfb02 ]

We already detect situations where a PPP channel sends packets back to
its upper PPP device. While this is enough to avoid deadlocking on xmit
locks, this doesn't prevent packets from looping between the channel
and the unit.

The problem is that ppp_start_xmit() enqueues packets in ppp->file.xq
before checking for xmit recursion. Therefore, __ppp_xmit_process()
might dequeue a packet from ppp->file.xq and send it on the channel
which, in turn, loops it back on the unit. Then ppp_start_xmit()
queues the packet back to ppp->file.xq and __ppp_xmit_process() picks
it up and sends it again through the channel. Therefore, the packet
will loop between __ppp_xmit_process() and ppp_start_xmit() until some
other part of the xmit path drops it.

For L2TP, we rapidly fill the skb's headroom and pppol2tp_xmit() drops
the packet after a few iterations. But PPTP reallocates the headroom
if necessary, letting the loop run and exhaust the machine resources
(as reported in https://bugzilla.kernel.org/show_bug.cgi?id=199109).

Fix this by letting __ppp_xmit_process() enqueue the skb to
ppp->file.xq, so that we can check for recursion before adding it to
the queue. Now ppp_xmit_process() can drop the packet when recursion is
detected.

__ppp_channel_push() is a bit special. It calls __ppp_xmit_process()
without having any actual packet to send. This is used by
ppp_output_wakeup() to re-enable transmission on the parent unit (for
implementations like ppp_async.c, where the .start_xmit() function
might not consume the skb, leaving it in ppp->xmit_pending and
disabling transmission).
Therefore, __ppp_xmit_process() needs to handle the case where skb is
NULL, dequeuing as many packets as possible from ppp->file.xq.

Reported-by: xu heng <xuheng333@zoho.com>
Fixes: 55454a565836 ("ppp: avoid dealock on recursive xmit")
Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ppp/ppp_generic.c |   26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -255,7 +255,7 @@ struct ppp_net {
 /* Prototypes. */
 static int ppp_unattached_ioctl(struct net *net, struct ppp_file *pf,
 			struct file *file, unsigned int cmd, unsigned long arg);
-static void ppp_xmit_process(struct ppp *ppp);
+static void ppp_xmit_process(struct ppp *ppp, struct sk_buff *skb);
 static void ppp_send_frame(struct ppp *ppp, struct sk_buff *skb);
 static void ppp_push(struct ppp *ppp);
 static void ppp_channel_push(struct channel *pch);
@@ -511,13 +511,12 @@ static ssize_t ppp_write(struct file *fi
 		goto out;
 	}
 
-	skb_queue_tail(&pf->xq, skb);
-
 	switch (pf->kind) {
 	case INTERFACE:
-		ppp_xmit_process(PF_TO_PPP(pf));
+		ppp_xmit_process(PF_TO_PPP(pf), skb);
 		break;
 	case CHANNEL:
+		skb_queue_tail(&pf->xq, skb);
 		ppp_channel_push(PF_TO_CHANNEL(pf));
 		break;
 	}
@@ -1261,8 +1260,8 @@ ppp_start_xmit(struct sk_buff *skb, stru
 	put_unaligned_be16(proto, pp);
 
 	skb_scrub_packet(skb, !net_eq(ppp->ppp_net, dev_net(dev)));
-	skb_queue_tail(&ppp->file.xq, skb);
-	ppp_xmit_process(ppp);
+	ppp_xmit_process(ppp, skb);
+
 	return NETDEV_TX_OK;
 
  outf:
@@ -1416,13 +1415,14 @@ static void ppp_setup(struct net_device
  */
 
 /* Called to do any work queued up on the transmit side that can now be done */
-static void __ppp_xmit_process(struct ppp *ppp)
+static void __ppp_xmit_process(struct ppp *ppp, struct sk_buff *skb)
 {
-	struct sk_buff *skb;
-
 	ppp_xmit_lock(ppp);
 	if (!ppp->closing) {
 		ppp_push(ppp);
+
+		if (skb)
+			skb_queue_tail(&ppp->file.xq, skb);
 		while (!ppp->xmit_pending &&
 		       (skb = skb_dequeue(&ppp->file.xq)))
 			ppp_send_frame(ppp, skb);
@@ -1436,7 +1436,7 @@ static void __ppp_xmit_process(struct pp
 	ppp_xmit_unlock(ppp);
 }
 
-static void ppp_xmit_process(struct ppp *ppp)
+static void ppp_xmit_process(struct ppp *ppp, struct sk_buff *skb)
 {
 	local_bh_disable();
 
@@ -1444,7 +1444,7 @@ static void ppp_xmit_process(struct ppp
 		goto err;
 
 	(*this_cpu_ptr(ppp->xmit_recursion))++;
-	__ppp_xmit_process(ppp);
+	__ppp_xmit_process(ppp, skb);
 	(*this_cpu_ptr(ppp->xmit_recursion))--;
 
 	local_bh_enable();
@@ -1454,6 +1454,8 @@ static void ppp_xmit_process(struct ppp
 err:
 	local_bh_enable();
 
+	kfree_skb(skb);
+
 	if (net_ratelimit())
 		netdev_err(ppp->dev, "recursion detected\n");
 }
@@ -1938,7 +1940,7 @@ static void __ppp_channel_push(struct ch
 	if (skb_queue_empty(&pch->file.xq)) {
 		ppp = pch->ppp;
 		if (ppp)
-			__ppp_xmit_process(ppp);
+			__ppp_xmit_process(ppp, NULL);
 	}
 }
 
