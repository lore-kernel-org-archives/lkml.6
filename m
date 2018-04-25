Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+G5BQFKUZfhD+HYX3wjM/F+Nqvk18+n6I/GE9+qKEjk9OX44uRdv/zZsS0iQWP7VfbEh5j
ARC-Seal: i=1; a=rsa-sha256; t=1524652744; cv=none;
        d=google.com; s=arc-20160816;
        b=E941UBodLds2JEmxDdI3AAR/YByhPVpa0Zmf9WvJJ1Pla7O4wM8+lbmQbLTuwNhXGC
         ixLZHttP+vyqfRiJlG2r0bpeU3bI6yqqiSnBkP6OTjdpNZcR+5r7W2aXO3kAph1h7AmI
         h8bDhug5ItxpyKgY9LYgQTfGWSvuBHGIK0FAFTx+W+Fie2jkh5MyzT4rB+ilVubAy06e
         0VBB8945CeS4c1JWegXRSdNNBhkx/U61ZEqg+zbHKrxejh3pz8AvqZ1hVnLjzNl7uQVU
         l6LF+qesUSy3HsFAU9aNoUn5AWWxe71qgsDzryyCy6/Wra/V6ghfAPMmp0HmvSjlJ+uF
         fqHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/crdaq9WXOtpiTRBCOsxqpmNQmZcnI4GjPHayNuDF+8=;
        b=Yd76CbKxETBd18DzAt+CjI7wyvC1qXZ8yMnIs3yr/JsUrr9YDWCzFlzusMJNTmY0bu
         +eWQMTWwMNIi+rJmcrjTe32oNQ/DoIjiT996tYQZR/RPCRHf6VNCqfLBuWj36fMzyK9b
         D/FowN3eDUVLWR4SUXwflzpf623LYcnelbj+NyvZyFoVzmzWM7w9EL3RTVclRCUPqT6G
         P82BQxEZ+CDz6knGZXv4KvHRjnxIefb22m4eQvj9aJe4uMPzPzGZZ1Jn/kgcy005rlXj
         OdtZ7mUlmHxr/fjQXlKUWVh4BTVrLKIprb6xG+9hYmerLvCt/JUhj/XCkxWp7ZPHpMUP
         YpDQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Steve Wise <swise@opengridcomputing.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Max Gurtovoy <maxg@mellanox.com>,
	Doug Ledford <dledford@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 053/183] IB/cq: Dont force IB_POLL_DIRECT poll context for ib_process_cq_direct
Date: Wed, 25 Apr 2018 12:34:33 +0200
Message-Id: <20180425103244.681940698@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714276550827836?=
X-GMAIL-MSGID: =?utf-8?q?1598714276550827836?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sagi Grimberg <sagi@grimberg.me>


[ Upstream commit 246d8b184c100e8eb6b4e8c88f232c2ed2a4e672 ]

polling the completion queue directly does not interfere
with the existing polling logic, hence drop the requirement.
Be aware that running ib_process_cq_direct with non IB_POLL_DIRECT
CQ may trigger concurrent CQ processing.

This can be used for polling mode ULPs.

Cc: Bart Van Assche <bart.vanassche@wdc.com>
Reported-by: Steve Wise <swise@opengridcomputing.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
[maxg: added wcs array argument to __ib_process_cq]
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/cq.c |   23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -25,9 +25,10 @@
 #define IB_POLL_FLAGS \
 	(IB_CQ_NEXT_COMP | IB_CQ_REPORT_MISSED_EVENTS)
 
-static int __ib_process_cq(struct ib_cq *cq, int budget)
+static int __ib_process_cq(struct ib_cq *cq, int budget, struct ib_wc *poll_wc)
 {
 	int i, n, completed = 0;
+	struct ib_wc *wcs = poll_wc ? : cq->wc;
 
 	/*
 	 * budget might be (-1) if the caller does not
@@ -35,9 +36,9 @@ static int __ib_process_cq(struct ib_cq
 	 * minimum here.
 	 */
 	while ((n = ib_poll_cq(cq, min_t(u32, IB_POLL_BATCH,
-			budget - completed), cq->wc)) > 0) {
+			budget - completed), wcs)) > 0) {
 		for (i = 0; i < n; i++) {
-			struct ib_wc *wc = &cq->wc[i];
+			struct ib_wc *wc = &wcs[i];
 
 			if (wc->wr_cqe)
 				wc->wr_cqe->done(cq, wc);
@@ -60,18 +61,20 @@ static int __ib_process_cq(struct ib_cq
  * @cq:		CQ to process
  * @budget:	number of CQEs to poll for
  *
- * This function is used to process all outstanding CQ entries on a
- * %IB_POLL_DIRECT CQ.  It does not offload CQ processing to a different
- * context and does not ask for completion interrupts from the HCA.
+ * This function is used to process all outstanding CQ entries.
+ * It does not offload CQ processing to a different context and does
+ * not ask for completion interrupts from the HCA.
+ * Using direct processing on CQ with non IB_POLL_DIRECT type may trigger
+ * concurrent processing.
  *
  * Note: do not pass -1 as %budget unless it is guaranteed that the number
  * of completions that will be processed is small.
  */
 int ib_process_cq_direct(struct ib_cq *cq, int budget)
 {
-	WARN_ON_ONCE(cq->poll_ctx != IB_POLL_DIRECT);
+	struct ib_wc wcs[IB_POLL_BATCH];
 
-	return __ib_process_cq(cq, budget);
+	return __ib_process_cq(cq, budget, wcs);
 }
 EXPORT_SYMBOL(ib_process_cq_direct);
 
@@ -85,7 +88,7 @@ static int ib_poll_handler(struct irq_po
 	struct ib_cq *cq = container_of(iop, struct ib_cq, iop);
 	int completed;
 
-	completed = __ib_process_cq(cq, budget);
+	completed = __ib_process_cq(cq, budget, NULL);
 	if (completed < budget) {
 		irq_poll_complete(&cq->iop);
 		if (ib_req_notify_cq(cq, IB_POLL_FLAGS) > 0)
@@ -105,7 +108,7 @@ static void ib_cq_poll_work(struct work_
 	struct ib_cq *cq = container_of(work, struct ib_cq, work);
 	int completed;
 
-	completed = __ib_process_cq(cq, IB_POLL_BUDGET_WORKQUEUE);
+	completed = __ib_process_cq(cq, IB_POLL_BUDGET_WORKQUEUE, NULL);
 	if (completed >= IB_POLL_BUDGET_WORKQUEUE ||
 	    ib_req_notify_cq(cq, IB_POLL_FLAGS) > 0)
 		queue_work(ib_comp_wq, &cq->work);
