Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B5AC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84CC126399
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g+DmuyN5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84CC126399
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935100AbeFZA7T (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:59:19 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:50812 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934844AbeFZA7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:59:10 -0400
Received: by mail-it0-f68.google.com with SMTP id u4-v6so15219556itg.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 17:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WXW2CQ4taCc5cvUraPVxkiewob/irwXrM2tspZPurSM=;
        b=g+DmuyN5g7Pa85Aui/dA6zzbZ/kDMw/bfmuSfHi9dLRwzwb8qRasQ1xDceVE01x2a8
         oKBCDnj4SEYOEhZP82OA3MdxuAV72Y0v9Zb+kF3EkOuScM7Xql3NxG65AJInRnpsRdq9
         OTaFVAzbTWMxTg1AuqjhyxSfQhg8UrO1B1OXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WXW2CQ4taCc5cvUraPVxkiewob/irwXrM2tspZPurSM=;
        b=t9jldL0Vn5uIqeiwtmMRO/M+lRHHIMI1kJ5YEtXsj9+WqKCRqQUlMVW+GqmXkG0IuM
         eKFZ2sPxg+E5dYGCEdue0RNhf32s6a8tx47LbKxEw2D5sklE4PECy9yndQ7GwOg/GKtX
         FMihMy3yUyfFk3J3afas3Pe1lO2y5ZaEKxFTJc7Qn8QeFQVJMAxzNAOGxUxuNcyVrEET
         Br7n/eTjiVArzf3i7dDGq7ry06ZSq2Oga0SxB/OXXseIswI2b/6SYPLc091JPxlmWS9p
         X5lvii87DJXhiykbReibVeajbrkjFzRxu2/jKNbmkaOw+6f/BP4IQ8Uwj9qQmP557JT9
         oxiw==
X-Gm-Message-State: APt69E16gAiPhuMQ+A8KzRJShM42acOEXpeiF0zjTjTXroEjqI+dvd2t
        wdpwZutYKw+bEAtqdyOxecDy5Q==
X-Google-Smtp-Source: ADUXVKLqn1TPYq2AoKwy/nLWkBBVF6sUv+Mq6gtIuaHIfdDC2wkj7GnxPl4UZSS6u0ABZo8H9kTzyw==
X-Received: by 2002:a24:fc83:: with SMTP id b125-v6mr366151ith.13.1529974749884;
        Mon, 25 Jun 2018 17:59:09 -0700 (PDT)
Received: from localhost.localdomain (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.gmail.com with ESMTPSA id f193-v6sm372556itf.9.2018.06.25.17.59.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 17:59:09 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     andy.gross@linaro.org
Cc:     clew@codeaurora.org, aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH resend 09/12] soc: qcom: smem: verify partition offset_free_uncached
Date:   Mon, 25 Jun 2018 19:58:53 -0500
Message-Id: <20180626005856.14174-10-elder@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626005856.14174-1-elder@linaro.org>
References: <20180626005856.14174-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add verification in qcom_smem_partition_header() that the
offset_free_uncached field in a partition's header structure does
not exceed the partition's size.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/soc/qcom/smem.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 95d218d3a595..f5d7af1623a9 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -755,6 +755,12 @@ qcom_smem_partition_header(struct qcom_smem *smem,
 		return NULL;
 	}
 
+	if (le32_to_cpu(header->offset_free_uncached) > size) {
+		dev_err(smem->dev, "bad partition free uncached (%u > %u)\n",
+			le32_to_cpu(header->offset_free_uncached), size);
+		return NULL;
+	}
+
 	return header;
 }
 
@@ -763,7 +769,7 @@ static int qcom_smem_set_global_partition(struct qcom_smem *smem)
 	struct smem_partition_header *header;
 	struct smem_ptable_entry *entry;
 	struct smem_ptable *ptable;
-	u32 host0, host1, size;
+	u32 host0, host1;
 	bool found = false;
 	int i;
 
@@ -803,13 +809,6 @@ static int qcom_smem_set_global_partition(struct qcom_smem *smem)
 		return -EINVAL;
 	}
 
-	size = le32_to_cpu(header->offset_free_uncached);
-	if (size > le32_to_cpu(header->size)) {
-		dev_err(smem->dev,
-			"Global partition has invalid free pointer\n");
-		return -EINVAL;
-	}
-
 	smem->global_partition = header;
 	smem->global_cacheline = le32_to_cpu(entry->cacheline);
 
@@ -873,12 +872,6 @@ static int qcom_smem_enumerate_partitions(struct qcom_smem *smem,
 			return -EINVAL;
 		}
 
-		if (le32_to_cpu(header->offset_free_uncached) > le32_to_cpu(header->size)) {
-			dev_err(smem->dev,
-				"Partition %d has invalid free pointer\n", i);
-			return -EINVAL;
-		}
-
 		smem->partitions[remote_host] = header;
 		smem->cacheline[remote_host] = le32_to_cpu(entry->cacheline);
 	}
-- 
2.17.1

