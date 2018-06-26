Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC06C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF5026390
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KbbcVmT2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF5026390
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934744AbeFZA7H (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:59:07 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:42778 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755764AbeFZA7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:59:04 -0400
Received: by mail-io0-f196.google.com with SMTP id r24-v6so14309608ioh.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 17:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gb0nb2yDTdFiuOpR0M5eWYBBjXEZNg/qX7xReBdXIr0=;
        b=KbbcVmT205ORikHxa+fJHoNTiOBxXiI3YQM2Cczb6SXLZjj8XLpAXiuWBRp7K9UrGa
         73oSUZ20muO/UHLR5vOAs/A0I31e/FSsGeTOxtt0H7PffOd4h8qs6DRlFtbWNEOpaoIw
         cWTcLch+eccaMgc0meNOEyK3Lee9qAFxAIkPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gb0nb2yDTdFiuOpR0M5eWYBBjXEZNg/qX7xReBdXIr0=;
        b=NgzfQa3vaCFxe25xwfrWcXHga12Fu2fgd5+OG4ZYkqgZC76Jln4rWq1jdb8/dN68ue
         XV6yvaPb+3wc3YxvLcypi2vO6sfvZoKx6RAi49fxPWSRTRx1qQ9IEWJIoWiYf+aU8c6m
         Xg4r6Z0ti2UZqo+8eKPCDDc5AMPAijSI7wN7YHOLpWdL+CnRkzvcRfu+o8zgNfKryEnZ
         6N4JK8hUVcbHbjYlImkP7YlK5CgRY57mRKHMWkef2o23/u8y6OZrIt+9z96V7dLvw4s4
         pZMFI6wSF5G8khgSE8O1vnzCMfHEOV2H/N58WhdDZC9tpMoVsJvv9nZa6xjaXR6Bcasq
         m+yQ==
X-Gm-Message-State: APt69E3+ART6UnloP+n7EB9zz8XK/g67Tzrcys96E6rq5K6FFl4quGs+
        OUv1ka0sz8VTb25HBPaESuGZzQ==
X-Google-Smtp-Source: AAOMgpdrQfMfAJl78SaXrAp+1j143Bp41XqOamLsO9HkkT/GSxypFp1tr5foAa1wRd3yvqqaQIj/RA==
X-Received: by 2002:a6b:17c7:: with SMTP id 190-v6mr11392890iox.17.1529974743381;
        Mon, 25 Jun 2018 17:59:03 -0700 (PDT)
Received: from localhost.localdomain (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.gmail.com with ESMTPSA id f193-v6sm372556itf.9.2018.06.25.17.59.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 17:59:02 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     andy.gross@linaro.org
Cc:     clew@codeaurora.org, aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH resend 02/12] soc: qcom: smem: initialize region struct only when successful
Date:   Mon, 25 Jun 2018 19:58:46 -0500
Message-Id: <20180626005856.14174-3-elder@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626005856.14174-1-elder@linaro.org>
References: <20180626005856.14174-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hold off initializing anything for the array entry representing a
memory region in qcom_smem_map_memory() until we know we've
successfully mapped it.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/soc/qcom/smem.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index c46bb43c0f3d..d8008bf480a4 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -887,6 +887,7 @@ static int qcom_smem_map_memory(struct qcom_smem *smem, struct device *dev,
 {
 	struct device_node *np;
 	struct resource r;
+	resource_size_t size;
 	int ret;
 
 	np = of_parse_phandle(dev->of_node, name, 0);
@@ -899,12 +900,13 @@ static int qcom_smem_map_memory(struct qcom_smem *smem, struct device *dev,
 	of_node_put(np);
 	if (ret)
 		return ret;
+	size = resource_size(&r);
 
-	smem->regions[i].aux_base = (u32)r.start;
-	smem->regions[i].size = resource_size(&r);
-	smem->regions[i].virt_base = devm_ioremap_wc(dev, r.start, resource_size(&r));
+	smem->regions[i].virt_base = devm_ioremap_wc(dev, r.start, size);
 	if (!smem->regions[i].virt_base)
 		return -ENOMEM;
+	smem->regions[i].aux_base = (u32)r.start;
+	smem->regions[i].size = size;
 
 	return 0;
 }
-- 
2.17.1

