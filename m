Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F8EC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3DB22421
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XFfZl2sa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E3DB22421
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934121AbeFUVc7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:32:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41788 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933955AbeFUV3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DgiDTYObtEDk2O8cnHX6t2kCdY4GY3B7mxCy/I7vJRQ=; b=XFfZl2saElqcS2NGS8hcA8/yN
        tkZSfN1Q9cQSKg4+Tbe5fX4PyLmWGlQonXy4DIM804o/uS9EGjm7fBs2psUF+PShM8/a8a+ePFS6Q
        fHBrR15RPRxhxOt3bYIHYiFcTOuaZeK5oTkzryaGHXtwcvzHp8QoRkObQUnS+Z8nru8Ewqt8rz18i
        v+LCv9YwHxQDo6SF0wjnfqJsFlg5KerhOh/0+unZXuvIPPsC8SPlWzNKRoDYEbYQDfzUSdY/LyoGu
        Bk7Q3jyjYnenakP7++hQr97GT+cWuFglrpWOGNYZTP7H5uNdi/DQ+lHuvsLvL8JOp9Z2QVZOMkI/1
        2AZ8KnOkA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW78e-0001bE-I1; Thu, 21 Jun 2018 21:29:08 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Boaz Harrosh <ooo@electrozaur.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 09/26] osd: Convert to new IDA API
Date:   Thu, 21 Jun 2018 14:28:18 -0700
Message-Id: <20180621212835.5636-10-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180621212835.5636-1-willy@infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Slightly simpler code.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/scsi/osd/osd_uld.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/osd/osd_uld.c b/drivers/scsi/osd/osd_uld.c
index 0e56f1eb05dc..eaf36ccf58db 100644
--- a/drivers/scsi/osd/osd_uld.c
+++ b/drivers/scsi/osd/osd_uld.c
@@ -423,19 +423,11 @@ static int osd_probe(struct device *dev)
 	if (scsi_device->type != TYPE_OSD)
 		return -ENODEV;
 
-	do {
-		if (!ida_pre_get(&osd_minor_ida, GFP_KERNEL))
-			return -ENODEV;
-
-		error = ida_get_new(&osd_minor_ida, &minor);
-	} while (error == -EAGAIN);
-
-	if (error)
-		return error;
-	if (minor >= SCSI_OSD_MAX_MINOR) {
-		error = -EBUSY;
-		goto err_retract_minor;
-	}
+	minor = ida_alloc_max(&osd_minor_ida, SCSI_OSD_MAX_MINOR, GFP_KERNEL);
+	if (minor == -ENOSPC)
+		return -EBUSY;
+	if (minor < 0)
+		return -ENODEV;
 
 	error = -ENOMEM;
 	oud = kzalloc(sizeof(*oud), GFP_KERNEL);
@@ -499,7 +491,7 @@ static int osd_probe(struct device *dev)
 err_free_osd:
 	put_device(&oud->class_dev);
 err_retract_minor:
-	ida_remove(&osd_minor_ida, minor);
+	ida_free(&osd_minor_ida, minor);
 	return error;
 }
 
@@ -514,7 +506,7 @@ static int osd_remove(struct device *dev)
 	}
 
 	cdev_device_del(&oud->cdev, &oud->class_dev);
-	ida_remove(&osd_minor_ida, oud->minor);
+	ida_free(&osd_minor_ida, oud->minor);
 	put_device(&oud->class_dev);
 
 	return 0;
-- 
2.17.1

