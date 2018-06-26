Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F94C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFB42639E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MKfcOPco"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AFB42639E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965138AbeFZBAU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 21:00:20 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:33774 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755808AbeFZA7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:59:09 -0400
Received: by mail-it0-f66.google.com with SMTP id k17-v6so13828758ita.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 17:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kb0UYNwbePyrqiNt7GbnbXqyF1CVqdK0k2VzOr4z4tc=;
        b=MKfcOPcou+rP5ebOwGl3JSLih/nKY+mYyj6eXIhMPpoWYA1hqZeqlUj8aDr4yv6mVM
         i/ZLQDqRErALjCY/Ghl1D6xSW1Tpt1KJushEyEfhE+qsQDmAHskbyblcnDm6+iHxojLF
         qGpY+KTyxYKbDJoivQasLH0TWp67Mrw8p8HfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kb0UYNwbePyrqiNt7GbnbXqyF1CVqdK0k2VzOr4z4tc=;
        b=uT/F87rK4kO2rhio2j0u/EQwbjFtwfnxCrzr0xFxf6u352DDs9TZjvaGq+1x4Z8gnP
         a0fG22s1PtrGjo0MIP4cwO7joWyFD1JeK/6wP00NmuN5nyCaJCqo2Yrfkbzp1o7xlZOA
         gtY2M1d5WubAbF3o8ji11NEMQ0vP99B9UYIAdcaEn0B09AkdNlEkbwf9L0ZApYtty5Pp
         AcYE5sbjyXWrm9GbEUScyLmYToAmNAfDPvgC2MQ5CUm+lnSF562lKCh5eEajknQ9vHox
         f0SkEfVPvdoHulQ77qPpSWU6mC+oRDL7P6t6/mSHls02yR9y/7tmUOtsOnrBQvZgT1Ev
         4vnA==
X-Gm-Message-State: APt69E27ieYWXBXvl6mHsetYhb+jSO29ZgDAgJHZoa77XoCNqwuwYFzg
        o3nTEsMNE07ef2AQzDFtj04r3w==
X-Google-Smtp-Source: AAOMgpcr1eMJIp1Xb7bpeq3dCHc56CRdpc70sjVeGImnpAD8QKRhBVEjdxUDG9qTaHEbvF8hofx2Ig==
X-Received: by 2002:a24:a0c2:: with SMTP id o185-v6mr2761337ite.34.1529974748959;
        Mon, 25 Jun 2018 17:59:08 -0700 (PDT)
Received: from localhost.localdomain (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.gmail.com with ESMTPSA id f193-v6sm372556itf.9.2018.06.25.17.59.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 17:59:08 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     andy.gross@linaro.org
Cc:     clew@codeaurora.org, aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH resend 08/12] soc: qcom: smem: verify partition header size
Date:   Mon, 25 Jun 2018 19:58:52 -0500
Message-Id: <20180626005856.14174-9-elder@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626005856.14174-1-elder@linaro.org>
References: <20180626005856.14174-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add verification in qcom_smem_partition_header() that the size in a
partition's header structure matches the size in its partition table
entry.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/soc/qcom/smem.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 516a17d340af..95d218d3a595 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -737,6 +737,7 @@ qcom_smem_partition_header(struct qcom_smem *smem,
 		struct smem_ptable_entry *entry)
 {
 	struct smem_partition_header *header;
+	u32 size;
 
 	header = smem->regions[0].virt_base + le32_to_cpu(entry->offset);
 
@@ -747,6 +748,13 @@ qcom_smem_partition_header(struct qcom_smem *smem,
 		return NULL;
 	}
 
+	size = le32_to_cpu(header->size);
+	if (size != le32_to_cpu(entry->size)) {
+		dev_err(smem->dev, "bad partition size (%u != %u)\n",
+			size, le32_to_cpu(entry->size));
+		return NULL;
+	}
+
 	return header;
 }
 
@@ -795,11 +803,6 @@ static int qcom_smem_set_global_partition(struct qcom_smem *smem)
 		return -EINVAL;
 	}
 
-	if (le32_to_cpu(header->size) != le32_to_cpu(entry->size)) {
-		dev_err(smem->dev, "Global partition has invalid size\n");
-		return -EINVAL;
-	}
-
 	size = le32_to_cpu(header->offset_free_uncached);
 	if (size > le32_to_cpu(header->size)) {
 		dev_err(smem->dev,
@@ -870,12 +873,6 @@ static int qcom_smem_enumerate_partitions(struct qcom_smem *smem,
 			return -EINVAL;
 		}
 
-		if (le32_to_cpu(header->size) != le32_to_cpu(entry->size)) {
-			dev_err(smem->dev,
-				"Partition %d has invalid size\n", i);
-			return -EINVAL;
-		}
-
 		if (le32_to_cpu(header->offset_free_uncached) > le32_to_cpu(header->size)) {
 			dev_err(smem->dev,
 				"Partition %d has invalid free pointer\n", i);
-- 
2.17.1

