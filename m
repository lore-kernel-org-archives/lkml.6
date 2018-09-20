Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91193C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5245021525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YF42dPFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5245021525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388499AbeIUBEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:04:45 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37763 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388517AbeIUBEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:04:23 -0400
Received: by mail-pf1-f195.google.com with SMTP id h69-v6so4826867pfd.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lEojR96MJu4iyHo4Y0qSuQdeRg8I+A050JDTrUQ4dMg=;
        b=YF42dPFhIvIfWd26UB5GVbVqZ45vldYbKJBXevvUaouVrewwHuwgeqtxmmAvI+VOcw
         fzhlhy+xBVHfYw4ecZ3i/REwLnbTHVAaZW41OfTgSbGFieWR+PRbudVZx1zSztOh4vHs
         bzexd3QHt6+/j1C8jxhDR2uOYo8zg7KSTqnH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lEojR96MJu4iyHo4Y0qSuQdeRg8I+A050JDTrUQ4dMg=;
        b=BTsiEg/7wQR4Q7oOZ0rYsui1vI2sYTHPKPwHRVcX+uT/6TM7yWRkGclPhPH30En5fF
         OPX3YCi8ucGNM+w32i51MpiWUx8AgglRl879dnN3pDocXV559Y3hlDvc63/qCZKm5sBo
         U25iYsHd1a3rzOTkvt3QFE/MgV2EnYyR3s64eBfre5Hx09jCRRYaukGVWcHYlDNtxziV
         RgsPat/GCbUNiYUTAu9TRKP3vAqpTQrKgHIsDf8EZAkNsWghoyToaGBcGJk6+1l+WBMX
         ay7RJ+DeJ+lEq+ja0T8L0kQ1akhiwykU9ZXkuiuTIn4wYJwqYyXF+NjB1oIyurVowqRQ
         2PWg==
X-Gm-Message-State: APzg51A2GiBGsVjVOAyVzoCr6zMLrE7YWPsuTsfbQFBLHU7fusFvqTHc
        rsgDSh5VUpwDXST0sSHe4nINHEwXdmU=
X-Google-Smtp-Source: ANB0Vdbhf0VH+bCOb2Ms3ZNHEbPP2VWe9KjTw4Pws6jxRnlz2yoe1LombuMFiWiwbM22qGYkcUCEnQ==
X-Received: by 2002:a62:4808:: with SMTP id v8-v6mr43044662pfa.89.1537471164307;
        Thu, 20 Sep 2018 12:19:24 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.19.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:19:23 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 41/44] coreisght: tmc: Claim device before use
Date:   Thu, 20 Sep 2018 13:18:16 -0600
Message-Id: <1537471099-19781-42-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Use CLAIM tags to make sure the device is available for use.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 22 +++++++++++++++++++---
 drivers/hwtracing/coresight/coresight-tmc-etr.c |  4 ++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 36af23d2c0f8..53fc83b72a49 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -36,6 +36,11 @@ static void __tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
 
 static int tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
 {
+	int rc = coresight_claim_device(drvdata->base);
+
+	if (rc)
+		return rc;
+
 	__tmc_etb_enable_hw(drvdata);
 	return 0;
 }
@@ -63,7 +68,7 @@ static void tmc_etb_dump_hw(struct tmc_drvdata *drvdata)
 	return;
 }
 
-static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
+static void __tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
 
@@ -79,6 +84,12 @@ static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
+static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
+{
+	coresight_disclaim_device(drvdata);
+	__tmc_etb_disable_hw(drvdata);
+}
+
 static void __tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
@@ -97,6 +108,11 @@ static void __tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
 
 static int tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
 {
+	int rc = coresight_claim_device(drvdata->base);
+
+	if (rc)
+		return rc;
+
 	__tmc_etf_enable_hw(drvdata);
 	return 0;
 }
@@ -107,7 +123,7 @@ static void tmc_etf_disable_hw(struct tmc_drvdata *drvdata)
 
 	tmc_flush_and_stop(drvdata);
 	tmc_disable_hw(drvdata);
-
+	coresight_disclaim_device_unlocked(drvdata->base);
 	CS_LOCK(drvdata->base);
 }
 
@@ -553,7 +569,7 @@ int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
 
 	/* Disable the TMC if need be */
 	if (drvdata->mode == CS_MODE_SYSFS)
-		tmc_etb_disable_hw(drvdata);
+		__tmc_etb_disable_hw(drvdata);
 
 	drvdata->reading = true;
 out:
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index daad52146140..f684283890d3 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -991,6 +991,9 @@ static int tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
 	 * this on.
 	 */
 	rc = tmc_etr_enable_catu(drvdata, etr_buf);
+	if (rc)
+		return rc;
+	rc = coresight_claim_device(drvdata->base);
 	if (!rc) {
 		drvdata->etr_buf = etr_buf;
 		__tmc_etr_enable_hw(drvdata);
@@ -1077,6 +1080,7 @@ static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
 	__tmc_etr_disable_hw(drvdata);
 	/* Disable CATU device if this ETR is connected to one */
 	tmc_etr_disable_catu(drvdata);
+	coresight_disclaim_device(drvdata->base);
 	/* Reset the ETR buf used by hardware */
 	drvdata->etr_buf = NULL;
 }
-- 
2.7.4

