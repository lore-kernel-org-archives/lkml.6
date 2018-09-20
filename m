Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF0AC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684C921525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kwR5roM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684C921525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388749AbeIUBDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:03:35 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38256 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388702AbeIUBDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:03:34 -0400
Received: by mail-pl1-f196.google.com with SMTP id u11-v6so4799653plq.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zGBDLzKG1oqzc5ywY84XT73T119/4mrlMyUfeCO+MxU=;
        b=kwR5roM+/WuD1YOY3r6vZQ+XHyFBEtu20K5Nm+jKjlTKNAuh/0EaVXIDZc240ZIOi1
         usUC64kBxcQBqtFNFciLHR+NYAOG5HAzgR47PLpV0nZHY2M/KvEu1C3YJMYy7mILI2qa
         q5/cdI/XoY+9ff+c88f0G80BO1xdMrTebr1YY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zGBDLzKG1oqzc5ywY84XT73T119/4mrlMyUfeCO+MxU=;
        b=dZY3sWpTzDTQ/YS3o+5+X3RVutpLX3SLtNGu6S8YSjZtnkk4k0Ao5L5Yvt6BX1pZrG
         1I4UJdVYztWA9pC4Ojk50B/JwDGOK/5Sv1SzrdTg/3csum4nFJWUISLIR/SmcMUwWn9t
         fqpZ6NJ/RQqukbM29gBeTFPy+mc7Gx4JeQBW4siYK8xGvcSQW0l/wa6oB+QDP7h9ETnk
         hC7gaPH9nvhsDOjsG6DD7iZEMtSYiHNvO+YebyXbozBp3CwT5I24zKe62SyrLot39xV/
         N+O3aZSxwBbu8MbTHLzhcgNfqrDlj4J8HShDm/PYCR6deEzr5ah3NOzaWnLXYy/VQ1Sb
         +MNg==
X-Gm-Message-State: APzg51C5iVLJI4POi+9uRmLE1MMr4M0iMls7r7cvoCmRHSwxOy+rxGl7
        y6WuumCT/pRBupVP8nwvccAyP4d3WTI=
X-Google-Smtp-Source: ANB0Vdar1WLi93mq10zKVQzvJi0PHwazB1cnTRJDVV0FI8FL3JcVpVBPqW4IH9v3DxKmxlzVReLK3A==
X-Received: by 2002:a17:902:9a8a:: with SMTP id w10-v6mr39947209plp.14.1537471115263;
        Thu, 20 Sep 2018 12:18:35 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.18.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:18:34 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 09/44] coresight: Use ERR_CAST instead of ERR_PTR
Date:   Thu, 20 Sep 2018 13:17:44 -0600
Message-Id: <1537471099-19781-10-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhong jiang <zhongjiang@huawei.com>

Use ERR_CAT inlined function to replace the ERR_PTR(PTR_ERR). It
make the code more concise.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 2eda5de304c2..11963647e19a 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -536,7 +536,7 @@ tmc_init_etr_sg_table(struct device *dev, int node,
 	sg_table = tmc_alloc_sg_table(dev, node, nr_tpages, nr_dpages, pages);
 	if (IS_ERR(sg_table)) {
 		kfree(etr_table);
-		return ERR_PTR(PTR_ERR(sg_table));
+		return ERR_CAST(sg_table);
 	}
 
 	etr_table->sg_table = sg_table;
-- 
2.7.4

