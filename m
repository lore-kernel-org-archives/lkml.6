Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CDAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7DB21783
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LeWYlJTQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfAKWyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 17:54:54 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36081 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfAKWyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 17:54:54 -0500
Received: by mail-pl1-f196.google.com with SMTP id g9so7391736plo.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 14:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=mYiqR0xb5DoY083RSC03EBVfuw/quVoV4ynfJVjW+l0=;
        b=LeWYlJTQHbE56G/g/6CMvNZBSvqRjuNTA4wYqQxtbAKteyzP6Ph8OukKeVYVcrva0g
         DSJz6btGAXdPCUVF+JjVErcxOJrS+xVnyFb6B50OYGLZ4DTgGLTeKga9x0GGc/qEsMol
         dg2QZu9J/ojOBYDtab60yDBrlGpDIgTiJ92cM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mYiqR0xb5DoY083RSC03EBVfuw/quVoV4ynfJVjW+l0=;
        b=RuD4LqiS3a1l7khWWeoOYr3SDK2J++KtWu7rc2Ju7reovoRJptzOqic981w6tZOtnw
         11LM/5O4DiixJnI/pGE08ohIuS2yrs+vJWxGmRie/keg/KmYInKrXoqAXid106Clbzp8
         Q3ZtYEGWtY6QbTBc8Gi/8gkijamIiYbWF4hhh6swCCvIWp/1EODOiBUM9lQz+FYN+RVR
         KEyJPXjSn6ip1bmMUClpRS/suGD0e6lQ6AIGaoG7V0tQf+xARPTx05k7et5hdkYLq3ld
         WT18grFO5GMx3c+dlMV5sP8MQeMDzPHW1KRZdc3/RziELKEXtdHJY0usxUocFdskthiH
         QRDw==
X-Gm-Message-State: AJcUukcUDnBGR3GdzdmihzZtdTXRidIQAGbDe5Mb0rsbRIpm/RuyYu7V
        n8dC4FmYhZ0y4/uOmsg8vE698A==
X-Google-Smtp-Source: ALg8bN6Y621GvZnpYvOsHoDSnIctWClfEYLPAFdvl+t1nCT1HxqPa5NK9nFeRsrBgHSgEAN9kJH9OA==
X-Received: by 2002:a17:902:1102:: with SMTP id d2mr16527532pla.138.1547247293624;
        Fri, 11 Jan 2019 14:54:53 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m85sm130301000pfj.171.2019.01.11.14.54.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 14:54:52 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] scsi: ufs: Consider device limitations for dma_mask
Date:   Fri, 11 Jan 2019 14:54:02 -0800
Message-Id: <20190111225402.6133-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Qualcomm SDM845 the capabilities of the UFS MEM controller states
that it's capable of dealing with 64 bit addresses, but DMA addresses
are truncated causing IOMMU faults when trying to issue operations.

Limit the DMA mask to that of the device, so that DMA allocations
is limited to the range supported by the bus and device and not just
following what the controller's capabilities states.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/scsi/ufs/ufshcd.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 9ba7671b84f8..dc0eb59dd46f 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -8151,11 +8151,14 @@ EXPORT_SYMBOL_GPL(ufshcd_dealloc_host);
  */
 static int ufshcd_set_dma_mask(struct ufs_hba *hba)
 {
-	if (hba->capabilities & MASK_64_ADDRESSING_SUPPORT) {
-		if (!dma_set_mask_and_coherent(hba->dev, DMA_BIT_MASK(64)))
-			return 0;
-	}
-	return dma_set_mask_and_coherent(hba->dev, DMA_BIT_MASK(32));
+	u64 dma_mask = dma_get_mask(hba->dev);
+
+	if (hba->capabilities & MASK_64_ADDRESSING_SUPPORT)
+		dma_mask &= DMA_BIT_MASK(64);
+	else
+		dma_mask &= DMA_BIT_MASK(32);
+
+	return dma_set_mask_and_coherent(hba->dev, dma_mask);
 }
 
 /**
-- 
2.18.0

