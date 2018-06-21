Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B36C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A20F223E7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uSxrMk2T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A20F223E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934026AbeFUV3P (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:29:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41764 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933944AbeFUV3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aN/ujayXDIeT8PvAahIwgPTtiODsoJarrTXA0pOcGs4=; b=uSxrMk2TUY65KwQgP5SLiGMRr
        t8noaFZGZkpWzXeu/rmJPJ9D2u4SaYXa9OS1ra0B54S6RKqXjpnq+M1TkgkPiXYp9fW5Z91DQTTiO
        ktkGUbVfUn+cyomTsBSZUKo3vsRkBBNgtqPnixcD7GOZ/vZtfxJpM1QiePP5C2KGrB5dmH4HnUe0D
        6dOBBKxVKuJvVDIWtBxtn83Hb+3fMWsoBq6iq031TkPZdkbPewUBdpT4I4B2XKizC5/9auE0yuu6/
        P00W7T+4wZW2J8gZRoCIh+G0B448h9uCqnfKWw8ahGKU6Awql1YppGnuf0FNZqRXApJgGMdVM4BZS
        iIu9Sh//g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW78e-0001b9-89; Thu, 21 Jun 2018 21:29:08 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 08/26] sd: Convert to new IDA interface
Date:   Thu, 21 Jun 2018 14:28:17 -0700
Message-Id: <20180621212835.5636-9-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180621212835.5636-1-willy@infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows us to remove an explicit spinlock.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/scsi/sd.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 9421d9877730..8a493e64856c 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -123,7 +123,6 @@ static void scsi_disk_release(struct device *cdev);
 static void sd_print_sense_hdr(struct scsi_disk *, struct scsi_sense_hdr *);
 static void sd_print_result(const struct scsi_disk *, const char *, int);
 
-static DEFINE_SPINLOCK(sd_index_lock);
 static DEFINE_IDA(sd_index_ida);
 
 /* This semaphore is used to mediate the 0->1 reference get in the
@@ -3339,16 +3338,8 @@ static int sd_probe(struct device *dev)
 	if (!gd)
 		goto out_free;
 
-	do {
-		if (!ida_pre_get(&sd_index_ida, GFP_KERNEL))
-			goto out_put;
-
-		spin_lock(&sd_index_lock);
-		error = ida_get_new(&sd_index_ida, &index);
-		spin_unlock(&sd_index_lock);
-	} while (error == -EAGAIN);
-
-	if (error) {
+	index = ida_alloc(&sd_index_ida, GFP_KERNEL);
+	if (index < 0) {
 		sdev_printk(KERN_WARNING, sdp, "sd_probe: memory exhausted.\n");
 		goto out_put;
 	}
@@ -3392,9 +3383,7 @@ static int sd_probe(struct device *dev)
 	return 0;
 
  out_free_index:
-	spin_lock(&sd_index_lock);
-	ida_remove(&sd_index_ida, index);
-	spin_unlock(&sd_index_lock);
+	ida_free(&sd_index_ida, index);
  out_put:
 	put_disk(gd);
  out_free:
@@ -3459,9 +3448,7 @@ static void scsi_disk_release(struct device *dev)
 	struct scsi_disk *sdkp = to_scsi_disk(dev);
 	struct gendisk *disk = sdkp->disk;
 	
-	spin_lock(&sd_index_lock);
-	ida_remove(&sd_index_ida, sdkp->index);
-	spin_unlock(&sd_index_lock);
+	ida_free(&sd_index_ida, sdkp->index);
 
 	disk->private_data = NULL;
 	put_disk(disk);
-- 
2.17.1

