Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A36DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F65A205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HL+7N80/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F65A205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731323AbeK3BZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:25:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:49346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728855AbeK3BZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:25:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70103205C9;
        Thu, 29 Nov 2018 14:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501220;
        bh=35bDtTHkNOuH9vtegi14pWJJgSx1PrHTgLBhMKpaHqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HL+7N80/W4KEBhS99eRmLf1QObdGJ+5cm5zjiA3vvkvQ3uwuVUDtC3yBQwYWoQM1O
         sA7vWEP+RlbxrAoJGKLtBUcNuFoEdWo9eDTFc/oD2dIHkRETF+g2cNqoAi/TObqk60
         5YM08cQUK5flStXjQtJn65JAKMFcrcmor8JcUs5Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sahitya Tummala <stummala@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.4 76/86] scsi: ufshcd: release resources if probe fails
Date:   Thu, 29 Nov 2018 15:12:41 +0100
Message-Id: <20181129140116.004356968@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140109.832117862@linuxfoundation.org>
References: <20181129140109.832117862@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Subhash Jadavani <subhashj@codeaurora.org>

commit afa3dfd42d205b106787476647735aa1de1a5d02 upstream.

If ufshcd pltfrm/pci driver's probe fails for some reason then ensure
that scsi host is released to avoid memory leak but managed memory
allocations (via devm_* calls) need not to be freed explicitly on probe
failure as memory allocated with these functions is automatically freed
on driver detach.

Reviewed-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/ufs/ufshcd-pci.c    |    2 ++
 drivers/scsi/ufs/ufshcd-pltfrm.c |    5 +----
 drivers/scsi/ufs/ufshcd.c        |    3 ---
 3 files changed, 3 insertions(+), 7 deletions(-)

--- a/drivers/scsi/ufs/ufshcd-pci.c
+++ b/drivers/scsi/ufs/ufshcd-pci.c
@@ -104,6 +104,7 @@ static void ufshcd_pci_remove(struct pci
 	pm_runtime_forbid(&pdev->dev);
 	pm_runtime_get_noresume(&pdev->dev);
 	ufshcd_remove(hba);
+	ufshcd_dealloc_host(hba);
 }
 
 /**
@@ -147,6 +148,7 @@ ufshcd_pci_probe(struct pci_dev *pdev, c
 	err = ufshcd_init(hba, mmio_base, pdev->irq);
 	if (err) {
 		dev_err(&pdev->dev, "Initialization failed\n");
+		ufshcd_dealloc_host(hba);
 		return err;
 	}
 
--- a/drivers/scsi/ufs/ufshcd-pltfrm.c
+++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
@@ -161,7 +161,7 @@ static int ufshcd_populate_vreg(struct d
 	if (ret) {
 		dev_err(dev, "%s: unable to find %s err %d\n",
 				__func__, prop_name, ret);
-		goto out_free;
+		goto out;
 	}
 
 	vreg->min_uA = 0;
@@ -183,9 +183,6 @@ static int ufshcd_populate_vreg(struct d
 
 	goto out;
 
-out_free:
-	devm_kfree(dev, vreg);
-	vreg = NULL;
 out:
 	if (!ret)
 		*out_vreg = vreg;
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -5385,8 +5385,6 @@ void ufshcd_remove(struct ufs_hba *hba)
 	ufshcd_disable_intr(hba, hba->intr_mask);
 	ufshcd_hba_stop(hba);
 
-	scsi_host_put(hba->host);
-
 	ufshcd_exit_clk_gating(hba);
 	if (ufshcd_is_clkscaling_enabled(hba))
 		devfreq_remove_device(hba->devfreq);
@@ -5733,7 +5731,6 @@ exit_gating:
 	ufshcd_exit_clk_gating(hba);
 out_disable:
 	hba->is_irq_enabled = false;
-	scsi_host_put(host);
 	ufshcd_hba_exit(hba);
 out_error:
 	return err;


