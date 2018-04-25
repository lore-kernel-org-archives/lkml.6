Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49Vn2w8/eBXz3XGz4AL6UW5L93QDwWtFDQDyBn8ruK3bTFYVYtgc85/Lc7EylsmLTaqOjjA
ARC-Seal: i=1; a=rsa-sha256; t=1524653069; cv=none;
        d=google.com; s=arc-20160816;
        b=OyvFgDGJq+knrqUGPs1L+p9YteIqq5e89/W5Os+dJFV88vCB2MxG7j0mIktbgYy9uG
         TGEc4NQoJ1M9mb5/yMMvq+A/Uda0TdHpgcNpzN4gcgQxXcFEn1TcHU6gTUNWaQB4PUnf
         83oTVPf1kuqzkzf3iWwKjIQ0B87F1+5zkwcaUCDd272s+DLJQCKnp03zJWp0CG2UKu7y
         CGcnUXlXie0g2buNnplY8/8Q/rw5Ti9wBPdrMxu2ibmFxKUSUNt0bpThI8LgrC9pK5cl
         5658nq/hMz/R6669cftoHpJpg8pmsG5czGNvk5jhPbCgB/084ETv85QEf1aK5bxj6APG
         +Ldw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XLtu/uANDQJPLKfajFSIqlXEloH3CfLSDdQhxV44gT0=;
        b=fuKcbF5ex1re4lxZb/mr7jv37e95NdmGoPtKbz5ldnPg6mLXvSww7Vjoz7fXtbdMZQ
         A17VHgfKYNtX9vIAaKc1wYzlX2jCFvairAAz+WKfzvQkVEeitF54RCVXTe/YleTWVj7y
         bvrg8PS2DDSe/PdBL3RdcEfFGIgpcpm0tEvi2VFG7Oyzj7ngqZBuvFE/epry6QYzm2dD
         sX3K5o2rXYU/oTdOFX7s+wzIXUerdKVYKRimw/P3d1kvJSAYSbHXyZo2r7wtTHKf/6nz
         bXZ6AdcIUuRcAHsHiI9JBSdIdf4j7eX0GOktJW0izLsnKlT4hKWv4XwGZZX2Q4Ssg1Ip
         GpyQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Sergey Gorenko <sergeygo@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 172/183] RDMA/core: Reduce poll batch for direct cq polling
Date: Wed, 25 Apr 2018 12:36:32 +0200
Message-Id: <20180425103249.422929682@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714617798201516?=
X-GMAIL-MSGID: =?utf-8?q?1598714617798201516?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Max Gurtovoy <maxg@mellanox.com>


[ Upstream commit d3b9e8ad425cfd5b9116732e057f1b48e4d3bcb8 ]

Fix warning limit for kernel stack consumption:

drivers/infiniband/core/cq.c: In function 'ib_process_cq_direct':
drivers/infiniband/core/cq.c:78:1: error: the frame size of 1032 bytes
is larger than 1024 bytes [-Werror=frame-larger-than=]

Using smaller ib_wc array on the stack brings us comfortably below that
limit again.

Fixes: 246d8b184c10 ("IB/cq: Don't force IB_POLL_DIRECT poll context for ib_process_cq_direct")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Sergey Gorenko <sergeygo@mellanox.com>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/cq.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -17,6 +17,7 @@
 
 /* # of WCs to poll for with a single call to ib_poll_cq */
 #define IB_POLL_BATCH			16
+#define IB_POLL_BATCH_DIRECT		8
 
 /* # of WCs to iterate over before yielding */
 #define IB_POLL_BUDGET_IRQ		256
@@ -25,18 +26,18 @@
 #define IB_POLL_FLAGS \
 	(IB_CQ_NEXT_COMP | IB_CQ_REPORT_MISSED_EVENTS)
 
-static int __ib_process_cq(struct ib_cq *cq, int budget, struct ib_wc *poll_wc)
+static int __ib_process_cq(struct ib_cq *cq, int budget, struct ib_wc *wcs,
+			   int batch)
 {
 	int i, n, completed = 0;
-	struct ib_wc *wcs = poll_wc ? : cq->wc;
 
 	/*
 	 * budget might be (-1) if the caller does not
 	 * want to bound this call, thus we need unsigned
 	 * minimum here.
 	 */
-	while ((n = ib_poll_cq(cq, min_t(u32, IB_POLL_BATCH,
-			budget - completed), wcs)) > 0) {
+	while ((n = ib_poll_cq(cq, min_t(u32, batch,
+					 budget - completed), wcs)) > 0) {
 		for (i = 0; i < n; i++) {
 			struct ib_wc *wc = &wcs[i];
 
@@ -48,8 +49,7 @@ static int __ib_process_cq(struct ib_cq
 
 		completed += n;
 
-		if (n != IB_POLL_BATCH ||
-		    (budget != -1 && completed >= budget))
+		if (n != batch || (budget != -1 && completed >= budget))
 			break;
 	}
 
@@ -72,9 +72,9 @@ static int __ib_process_cq(struct ib_cq
  */
 int ib_process_cq_direct(struct ib_cq *cq, int budget)
 {
-	struct ib_wc wcs[IB_POLL_BATCH];
+	struct ib_wc wcs[IB_POLL_BATCH_DIRECT];
 
-	return __ib_process_cq(cq, budget, wcs);
+	return __ib_process_cq(cq, budget, wcs, IB_POLL_BATCH_DIRECT);
 }
 EXPORT_SYMBOL(ib_process_cq_direct);
 
@@ -88,7 +88,7 @@ static int ib_poll_handler(struct irq_po
 	struct ib_cq *cq = container_of(iop, struct ib_cq, iop);
 	int completed;
 
-	completed = __ib_process_cq(cq, budget, NULL);
+	completed = __ib_process_cq(cq, budget, cq->wc, IB_POLL_BATCH);
 	if (completed < budget) {
 		irq_poll_complete(&cq->iop);
 		if (ib_req_notify_cq(cq, IB_POLL_FLAGS) > 0)
@@ -108,7 +108,8 @@ static void ib_cq_poll_work(struct work_
 	struct ib_cq *cq = container_of(work, struct ib_cq, work);
 	int completed;
 
-	completed = __ib_process_cq(cq, IB_POLL_BUDGET_WORKQUEUE, NULL);
+	completed = __ib_process_cq(cq, IB_POLL_BUDGET_WORKQUEUE, cq->wc,
+				    IB_POLL_BATCH);
 	if (completed >= IB_POLL_BUDGET_WORKQUEUE ||
 	    ib_req_notify_cq(cq, IB_POLL_FLAGS) > 0)
 		queue_work(ib_comp_wq, &cq->work);
