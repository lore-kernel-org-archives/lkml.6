Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D243ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25F921531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C6c/Xhga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25F921531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388555AbeIUBFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:05:36 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33545 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389005AbeIUBEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:04:07 -0400
Received: by mail-pl1-f196.google.com with SMTP id b97-v6so4812091plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V6vu1RIZBsPM7h6OM/OfrWdKkRSO5vP9cV5FH4ePhdM=;
        b=C6c/XhgaZor+HAv6JiOxdav3v6vR8+mbX1mUgcpeTuJgztugUORTRCiW7s9mmA81Ih
         1c7xx8hIxug/bPhBcJBsegcbNLI4WKHtf+86pYzPuj8dpyijFYXkCrHofCG8YKk2fLPP
         A2koKFJyK1vFXrX3h80f5hPrt1jV9tlhRpzt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V6vu1RIZBsPM7h6OM/OfrWdKkRSO5vP9cV5FH4ePhdM=;
        b=Gq2fzUjO9sKv/THMZLG5Km61Jq3V5ItO8g7D53uOUpKcFrqKGwhYcNrlQGGaBK5k/6
         U9Z6rwP7Vr9aZqbcKE64lT8FQM6+9UE+WCj6jnpcc4yRLcXUAe48tEkGFllihgQxvbCE
         Lm+4hZdFZ/gx4eZZkMzDfNZM+tsHysq48Y7XoVrt6+EILvck80jhM0EhghOv4zJsEanc
         aP5K9VapsuxehVUJZwEfM4a7QR7AuGE9GT9iZghkMZBNAgo4KFzqeSlnRNcfdK4BWcZo
         /ieCYF89IcNOQav1n3nU+yoo0/ilZcu8KPN/zb26pBTmPVLtoQ5RB3dtLU9IpLT3XNp/
         PO+Q==
X-Gm-Message-State: APzg51B8cfvD0eZyWvLZhc4hXbz7G8nn0eBou5hsY05YB8pdb8MlPzK5
        OXcfYfFyX9CT7E1g1goHkCXIk1O3XUw=
X-Google-Smtp-Source: ANB0Vdbj7QK/Sua221Qyp1+ZazOPyCW6v1ly1zfls0QiExc33cFLHQKyEDsn3RFPkiI2IyoJIn19xA==
X-Received: by 2002:a17:902:c85:: with SMTP id 5-v6mr40952054plt.141.1537471147788;
        Thu, 20 Sep 2018 12:19:07 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.19.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:19:06 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 30/44] coresight: tmc-etr: Handle errors enabling CATU
Date:   Thu, 20 Sep 2018 13:18:05 -0600
Message-Id: <1537471099-19781-31-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Make sure we honor the errors in CATU device and abort the operation.
While at it, delay setting the etr_buf for the session until we are
sure that we are indeed enabling the ETR.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index c42693542ec8..daad52146140 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -751,12 +751,14 @@ tmc_etr_get_catu_device(struct tmc_drvdata *drvdata)
 	return NULL;
 }
 
-static inline void tmc_etr_enable_catu(struct tmc_drvdata *drvdata)
+static inline int tmc_etr_enable_catu(struct tmc_drvdata *drvdata,
+				      struct etr_buf *etr_buf)
 {
 	struct coresight_device *catu = tmc_etr_get_catu_device(drvdata);
 
 	if (catu && helper_ops(catu)->enable)
-		helper_ops(catu)->enable(catu, drvdata->etr_buf);
+		return helper_ops(catu)->enable(catu, etr_buf);
+	return 0;
 }
 
 static inline void tmc_etr_disable_catu(struct tmc_drvdata *drvdata)
@@ -971,6 +973,8 @@ static void __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 static int tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
 			     struct etr_buf *etr_buf)
 {
+	int rc;
+
 	/* Callers should provide an appropriate buffer for use */
 	if (WARN_ON(!etr_buf))
 		return -EINVAL;
@@ -982,16 +986,17 @@ static int tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
 	if (WARN_ON(drvdata->etr_buf))
 		return -EBUSY;
 
-	/* Set the buffer for the session */
-	drvdata->etr_buf = etr_buf;
 	/*
 	 * If this ETR is connected to a CATU, enable it before we turn
 	 * this on.
 	 */
-	tmc_etr_enable_catu(drvdata);
+	rc = tmc_etr_enable_catu(drvdata, etr_buf);
+	if (!rc) {
+		drvdata->etr_buf = etr_buf;
+		__tmc_etr_enable_hw(drvdata);
+	}
 
-	__tmc_etr_enable_hw(drvdata);
-	return 0;
+	return rc;
 }
 
 /*
-- 
2.7.4

