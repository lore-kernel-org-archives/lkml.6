Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A33ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615C721525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CYLR1rKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 615C721525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388614AbeIUBDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:03:22 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37683 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388566AbeIUBDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:03:21 -0400
Received: by mail-pf1-f195.google.com with SMTP id h69-v6so4825643pfd.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gcLCDx5D6wD8A3b7yK58PSHPfb+H13w3trkFLuJ5fBM=;
        b=CYLR1rKwtRNoTrId7loK8npSAiyBYHfQoe//GEvC1gwd2gmO/YEXx9lqkkLba8/WUO
         RvsuPQQ9EnCIgwtpaD9Suz65DM8SNX5Ma7Vc9RJLENGzVlNty4RDmQznTi7H6igdpLec
         gRfQe3xRTwhvqEzMo0WWCC+37IBsWvwQKKVnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gcLCDx5D6wD8A3b7yK58PSHPfb+H13w3trkFLuJ5fBM=;
        b=kc2BGTWT/iA3vfUMGh33afrBvguz2q56brXGLuxiOVFxSfHHVOCYSS0lTk+f+uwZtB
         7wzqYDLkIzcqtQZ081XUFfPQN3IuSAAlXqDnATu3z/h/HSOifvPQQcK574ke5Seivfsc
         1+ByxGHVvTjar9PE9N3ntwuk1zzRJFtUXvcGAKok0Wz2Fdsh48VUwarjEFYe6Km2lSde
         DYCaNPR9C6dWPQTl65OiIsxVBpp18q6IUnO9Wd68sB21j5jlhJd8+l8PqdlZ0nqCTgrt
         XYjKr3LmyHwKMwVOgrXvVO0tlA5MP0l2nUhzhc2TEMy7/FCuMBoVL8wmdtIzJje55YJX
         GhSA==
X-Gm-Message-State: APzg51BPd0mZ2I1GnFtlV2+AfnZCWK3XrATZOXFBRjZnqhMa/yggiuOa
        N8gp/4i/zh3LPArqLUWtU2pl66uCcH8=
X-Google-Smtp-Source: ANB0VdbnzdnoWLldvmCW9cN2k4a6d5zjTYFgDCeGyKCiNHOKv42KKnrg7R7Ehfkg9ZrtsPs77TuwRw==
X-Received: by 2002:a63:3dc6:: with SMTP id k189-v6mr38015235pga.191.1537471102750;
        Thu, 20 Sep 2018 12:18:22 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.18.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:18:21 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 01/44] coresight: Document error handling in coresight_register
Date:   Thu, 20 Sep 2018 13:17:36 -0600
Message-Id: <1537471099-19781-2-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

commit 6403587a930c ("coresight: use put_device() instead of kfree()")
fixes the double freeing of resources and ensures that the device
refcount is dropped properly. Add a comment to explain this to
help the readers and prevent people trying to "unfix" it again.

While at it, rename the labels for better readability.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 3e07fd335f8c..9fd0c387e678 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -1006,7 +1006,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 	csdev = kzalloc(sizeof(*csdev), GFP_KERNEL);
 	if (!csdev) {
 		ret = -ENOMEM;
-		goto err_kzalloc_csdev;
+		goto err_out;
 	}
 
 	if (desc->type == CORESIGHT_DEV_TYPE_LINK ||
@@ -1022,7 +1022,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 	refcnts = kcalloc(nr_refcnts, sizeof(*refcnts), GFP_KERNEL);
 	if (!refcnts) {
 		ret = -ENOMEM;
-		goto err_kzalloc_refcnts;
+		goto err_free_csdev;
 	}
 
 	csdev->refcnt = refcnts;
@@ -1035,7 +1035,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 		conns = kcalloc(csdev->nr_outport, sizeof(*conns), GFP_KERNEL);
 		if (!conns) {
 			ret = -ENOMEM;
-			goto err_kzalloc_conns;
+			goto err_free_refcnts;
 		}
 
 		for (i = 0; i < csdev->nr_outport; i++) {
@@ -1062,7 +1062,11 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 	ret = device_register(&csdev->dev);
 	if (ret) {
 		put_device(&csdev->dev);
-		goto err_kzalloc_csdev;
+		/*
+		 * All resources are free'd explicitly via
+		 * coresight_device_release(), triggered from put_device().
+		 */
+		goto err_out;
 	}
 
 	mutex_lock(&coresight_mutex);
@@ -1074,11 +1078,11 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 
 	return csdev;
 
-err_kzalloc_conns:
+err_free_refcnts:
 	kfree(refcnts);
-err_kzalloc_refcnts:
+err_free_csdev:
 	kfree(csdev);
-err_kzalloc_csdev:
+err_out:
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(coresight_register);
-- 
2.7.4

