Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB5AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DEE21B1A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549898501;
	bh=rO6xCw52fkUG7/SrWPI+bvZsnRhNxOyUkgrSMQuSl6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WxyxXgUfqQGkkUi+UOx1KBCt/Bk4yMbf6GurWv06xcOi7hfJuAXT3aVyFojepA4wA
	 4ZYM6Rev6UtF3oUfeNO1osMIiaomCMEZTrYBHuQAJVyeZlWlpz2yQSDurq0DvXBPj9
	 hJz8uZS6Wm8ZnmNl9MKBr4ITSjPnnIrpPai68/eU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390794AbfBKPE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:04:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:53446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390776AbfBKPE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:04:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26D22222A7;
        Mon, 11 Feb 2019 15:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897465;
        bh=rO6xCw52fkUG7/SrWPI+bvZsnRhNxOyUkgrSMQuSl6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W6QBcnsc6R8tJMuNXvwMVVBp9wFmDEcfuLCwFKQyfLDKbRc/STfN+4bp7V1s+ISb5
         rqxKOFyHM273AMbL1JAokJqgdD4F6x3qwWUYEI7dW+P0h8o7OWE0WQ41LmueBBnQvZ
         OkNNxdlZ8S3/IrXG4IDaEJ7P12BGrlCxBTiplDhc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 191/205] scsi: aic94xx: fix module loading
Date:   Mon, 11 Feb 2019 15:19:49 +0100
Message-Id: <20190211141840.900755496@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Bottomley <James.Bottomley@HansenPartnership.com>

commit 42caa0edabd6a0a392ec36a5f0943924e4954311 upstream.

The aic94xx driver is currently failing to load with errors like

sysfs: cannot create duplicate filename '/devices/pci0000:00/0000:00:03.0/0000:02:00.3/0000:07:02.0/revision'

Because the PCI code had recently added a file named 'revision' to every
PCI device.  Fix this by renaming the aic94xx revision file to
aic_revision.  This is safe to do for us because as far as I can tell,
there's nothing in userspace relying on the current aic94xx revision file
so it can be renamed without breaking anything.

Fixes: 702ed3be1b1b (PCI: Create revision file in sysfs)
Cc: stable@vger.kernel.org
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/aic94xx/aic94xx_init.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/scsi/aic94xx/aic94xx_init.c
+++ b/drivers/scsi/aic94xx/aic94xx_init.c
@@ -281,7 +281,7 @@ static ssize_t asd_show_dev_rev(struct d
 	return snprintf(buf, PAGE_SIZE, "%s\n",
 			asd_dev_rev[asd_ha->revision_id]);
 }
-static DEVICE_ATTR(revision, S_IRUGO, asd_show_dev_rev, NULL);
+static DEVICE_ATTR(aic_revision, S_IRUGO, asd_show_dev_rev, NULL);
 
 static ssize_t asd_show_dev_bios_build(struct device *dev,
 				       struct device_attribute *attr,char *buf)
@@ -478,7 +478,7 @@ static int asd_create_dev_attrs(struct a
 {
 	int err;
 
-	err = device_create_file(&asd_ha->pcidev->dev, &dev_attr_revision);
+	err = device_create_file(&asd_ha->pcidev->dev, &dev_attr_aic_revision);
 	if (err)
 		return err;
 
@@ -500,13 +500,13 @@ err_update_bios:
 err_biosb:
 	device_remove_file(&asd_ha->pcidev->dev, &dev_attr_bios_build);
 err_rev:
-	device_remove_file(&asd_ha->pcidev->dev, &dev_attr_revision);
+	device_remove_file(&asd_ha->pcidev->dev, &dev_attr_aic_revision);
 	return err;
 }
 
 static void asd_remove_dev_attrs(struct asd_ha_struct *asd_ha)
 {
-	device_remove_file(&asd_ha->pcidev->dev, &dev_attr_revision);
+	device_remove_file(&asd_ha->pcidev->dev, &dev_attr_aic_revision);
 	device_remove_file(&asd_ha->pcidev->dev, &dev_attr_bios_build);
 	device_remove_file(&asd_ha->pcidev->dev, &dev_attr_pcba_sn);
 	device_remove_file(&asd_ha->pcidev->dev, &dev_attr_update_bios);


