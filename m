Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD4BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD7F20861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD7F20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbeIHB4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:56:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41554 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbeIHB4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:56:48 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 75EDCFEB;
        Fri,  7 Sep 2018 21:14:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Frederic Barrat <fbarrat@linux.ibm.com>,
        Alastair DSilva <alastair@d-silva.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.18 039/145] ocxl: Fix page fault handler in case of fault on dying process
Date:   Fri,  7 Sep 2018 23:08:25 +0200
Message-Id: <20180907210907.758021684@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frederic Barrat <fbarrat@linux.ibm.com>

commit d497ebf5fb3a026c0817f8c96cde578787f24093 upstream.

If a process exits without doing proper cleanup, there's a window
where an opencapi device can try to access the memory of the dying
process and may trigger a page fault. That's an expected scenario and
the ocxl driver holds a reference on the mm_struct of the process
until the opencapi device is notified of the process exiting.
However, if mm_users is already at 0, i.e. the address space of the
process has already been destroyed, the driver shouldn't try resolving
the page fault, as it will fail, but it can also try accessing already
freed data.

It is fixed by only calling the bottom half of the page fault handler
if mm_users is greater than 0 and get a reference on mm_users instead
of mm_count. Otherwise, we can safely return a translation fault to
the device, as its associated memory context is being removed. The
opencapi device will be properly cleaned up shortly after when closing
the file descriptors.

Fixes: 5ef3166e8a32 ("ocxl: Driver code for 'generic' opencapi devices")
Cc: stable@vger.kernel.org # v4.16+
Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Reviewed-By: Alastair D'Silva <alastair@d-silva.org>
Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/ocxl/link.c |   24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

--- a/drivers/misc/ocxl/link.c
+++ b/drivers/misc/ocxl/link.c
@@ -136,7 +136,7 @@ static void xsl_fault_handler_bh(struct
 	int rc;
 
 	/*
-	 * We need to release a reference on the mm whenever exiting this
+	 * We must release a reference on mm_users whenever exiting this
 	 * function (taken in the memory fault interrupt handler)
 	 */
 	rc = copro_handle_mm_fault(fault->pe_data.mm, fault->dar, fault->dsisr,
@@ -172,7 +172,7 @@ static void xsl_fault_handler_bh(struct
 	}
 	r = RESTART;
 ack:
-	mmdrop(fault->pe_data.mm);
+	mmput(fault->pe_data.mm);
 	ack_irq(spa, r);
 }
 
@@ -184,6 +184,7 @@ static irqreturn_t xsl_fault_handler(int
 	struct pe_data *pe_data;
 	struct ocxl_process_element *pe;
 	int lpid, pid, tid;
+	bool schedule = false;
 
 	read_irq(spa, &dsisr, &dar, &pe_handle);
 	trace_ocxl_fault(spa->spa_mem, pe_handle, dsisr, dar, -1);
@@ -226,14 +227,19 @@ static irqreturn_t xsl_fault_handler(int
 	}
 	WARN_ON(pe_data->mm->context.id != pid);
 
-	spa->xsl_fault.pe = pe_handle;
-	spa->xsl_fault.dar = dar;
-	spa->xsl_fault.dsisr = dsisr;
-	spa->xsl_fault.pe_data = *pe_data;
-	mmgrab(pe_data->mm); /* mm count is released by bottom half */
-
+	if (mmget_not_zero(pe_data->mm)) {
+			spa->xsl_fault.pe = pe_handle;
+			spa->xsl_fault.dar = dar;
+			spa->xsl_fault.dsisr = dsisr;
+			spa->xsl_fault.pe_data = *pe_data;
+			schedule = true;
+			/* mm_users count released by bottom half */
+	}
 	rcu_read_unlock();
-	schedule_work(&spa->xsl_fault.fault_work);
+	if (schedule)
+		schedule_work(&spa->xsl_fault.fault_work);
+	else
+		ack_irq(spa, ADDRESS_ERROR);
 	return IRQ_HANDLED;
 }
 


