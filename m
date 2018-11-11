Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B73C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E597A2148E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E597A2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731967AbeKLGGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:06:16 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53222 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730491AbeKLGGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:06:15 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt9-0000tu-8H; Sun, 11 Nov 2018 19:59:19 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsP-0001RQ-JT; Sun, 11 Nov 2018 19:58:33 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Christophe Jaillet" <christophe.jaillet@wanadoo.fr>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.25780586@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 067/366] scsi: qlogicpti: Fix an error handling path
 in 'qpti_sbus_probe()'
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Jaillet <christophe.jaillet@wanadoo.fr>

commit 51b910c3c70986a5a0a84eea11cb8e904e37ba8b upstream.

The 'free_irq()' call is not at the right place in the error handling
path.  The changed order has been introduced in commit 3d4253d9afab
("[SCSI] qlogicpti: Convert to new SBUS device framework.")

Fixes: 3d4253d9afab ("[SCSI] qlogicpti: Convert to new SBUS device framework.")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/scsi/qlogicpti.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -1386,6 +1386,9 @@ fail_unmap_queues:
 			  qpti->req_cpu, qpti->req_dvma);
 #undef QSIZE
 
+fail_free_irq:
+	free_irq(qpti->irq, qpti);
+
 fail_unmap_regs:
 	of_iounmap(&op->resource[0], qpti->qregs,
 		   resource_size(&op->resource[0]));
@@ -1393,9 +1396,6 @@ fail_unmap_regs:
 		of_iounmap(&op->resource[0], qpti->sreg,
 			   sizeof(unsigned char));
 
-fail_free_irq:
-	free_irq(qpti->irq, qpti);
-
 fail_unlink:
 	scsi_host_put(host);
 

