Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609B2C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3182320645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3182320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbeJNXdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:33:39 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36118 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727876AbeJNXL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:58 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLl-0004cp-4f; Sun, 14 Oct 2018 16:30:37 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLZ-0000hH-Gf; Sun, 14 Oct 2018 16:30:25 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
        "Julian Wiedmann" <jwi@linux.ibm.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.239408358@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 317/366] s390/qdio: don't release memory in
 qdio_setup_irq()
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Wiedmann <jwi@linux.ibm.com>

commit 2e68adcd2fb21b7188ba449f0fab3bee2910e500 upstream.

Calling qdio_release_memory() on error is just plain wrong. It frees
the main qdio_irq struct, when following code still uses it.

Also, no other error path in qdio_establish() does this. So trust
callers to clean up via qdio_free() if some step of the QDIO
initialization fails.

Fixes: 779e6e1c724d ("[S390] qdio: new qdio driver.")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/s390/cio/qdio_setup.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

--- a/drivers/s390/cio/qdio_setup.c
+++ b/drivers/s390/cio/qdio_setup.c
@@ -406,7 +406,6 @@ int qdio_setup_irq(struct qdio_initializ
 {
 	struct ciw *ciw;
 	struct qdio_irq *irq_ptr = init_data->cdev->private->qdio_data;
-	int rc;
 
 	memset(&irq_ptr->qib, 0, sizeof(irq_ptr->qib));
 	memset(&irq_ptr->siga_flag, 0, sizeof(irq_ptr->siga_flag));
@@ -443,16 +442,14 @@ int qdio_setup_irq(struct qdio_initializ
 	ciw = ccw_device_get_ciw(init_data->cdev, CIW_TYPE_EQUEUE);
 	if (!ciw) {
 		DBF_ERROR("%4x NO EQ", irq_ptr->schid.sch_no);
-		rc = -EINVAL;
-		goto out_err;
+		return -EINVAL;
 	}
 	irq_ptr->equeue = *ciw;
 
 	ciw = ccw_device_get_ciw(init_data->cdev, CIW_TYPE_AQUEUE);
 	if (!ciw) {
 		DBF_ERROR("%4x NO AQ", irq_ptr->schid.sch_no);
-		rc = -EINVAL;
-		goto out_err;
+		return -EINVAL;
 	}
 	irq_ptr->aqueue = *ciw;
 
@@ -460,9 +457,6 @@ int qdio_setup_irq(struct qdio_initializ
 	irq_ptr->orig_handler = init_data->cdev->handler;
 	init_data->cdev->handler = qdio_int_handler;
 	return 0;
-out_err:
-	qdio_release_memory(irq_ptr);
-	return rc;
 }
 
 void qdio_print_subchannel_info(struct qdio_irq *irq_ptr,

