Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAF8C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49802639C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="goiqlv03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C49802639C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965030AbeFZA7o (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:59:44 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:50817 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935001AbeFZA7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:59:12 -0400
Received: by mail-it0-f65.google.com with SMTP id u4-v6so15219640itg.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 17:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yQsG3HksJrmEyKMAvWxROvNnNiE4MTIEcDcHnZhiDeA=;
        b=goiqlv03NXEFvtFEjqBahJL6aeavffQFIQj66/uEUOt06Fs6IPdPemOxNa/vtYEiYP
         jNdqAQujBIH5+tkNVZNwlTplXND+VKlUW0ji/Is1D45UGed8D9MCq1q3xZsqG4QwVxuN
         jei58ukutx0F+T0CpeG3F/F6sS1TIFV+OVYN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yQsG3HksJrmEyKMAvWxROvNnNiE4MTIEcDcHnZhiDeA=;
        b=ClRkS2W+mmgdIGkfyKHZ+WRx0mtWvWhA8ZrDIj/TZVwO0/r+NclDwh8/oAMMOHiAxN
         2FOi8KnT2BSbPwyPug/RXEQEGNciu+Zni6eoazZPz11Nz2G238EvE3x/6FXslUenMm/f
         qv43KolyVDrNpX4AyGuyh3d3WNNP4BDNwGA/RXiXrn8BlK5Pgx6FsMH3fSzjDZ/6C17n
         DhZUUpl8sq/bI2bCXOoTEQU3wu7j5hCHNFmjLNsc+VtdB1r5o+/dIGha6qF/vfhDGxXp
         1p6fnnoMz99atUq96rBl78HgWistlQfwdq8+o31gxxr2l8FlAgdEy1B9YCF9pbfYUljT
         4kDQ==
X-Gm-Message-State: APt69E0xcBNuuP6MAA43K1NUoiGKExhCI3sJ4pZiMuZRY4udqO5gc/LO
        fpgOHH8M0cyjCA8pQ+wrEqrrtw==
X-Google-Smtp-Source: ADUXVKIkSxnsPqt6nJf3AD5lwpKdgPMpFSbHQcy6d8I+5rzVLmYkyxHSRbTAj8xfWAy9Z1YgyNwDnw==
X-Received: by 2002:a02:6065:: with SMTP id d37-v6mr12091820jaf.106.1529974751766;
        Mon, 25 Jun 2018 17:59:11 -0700 (PDT)
Received: from localhost.localdomain (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.gmail.com with ESMTPSA id f193-v6sm372556itf.9.2018.06.25.17.59.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 17:59:11 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     andy.gross@linaro.org
Cc:     clew@codeaurora.org, aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH resend 11/12] soc: qcom: smem: verify partition host ids match
Date:   Mon, 25 Jun 2018 19:58:55 -0500
Message-Id: <20180626005856.14174-12-elder@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626005856.14174-1-elder@linaro.org>
References: <20180626005856.14174-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add verification in qcom_smem_partition_header() that the host ids
found in a partition's header structure match those in its partition
table entry.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/soc/qcom/smem.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 8597aa03232c..7383a0e1b468 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -734,7 +734,7 @@ static u32 qcom_smem_get_item_count(struct qcom_smem *smem)
  */
 static struct smem_partition_header *
 qcom_smem_partition_header(struct qcom_smem *smem,
-		struct smem_ptable_entry *entry)
+		struct smem_ptable_entry *entry, u16 host0, u16 host1)
 {
 	struct smem_partition_header *header;
 	u32 size;
@@ -748,6 +748,17 @@ qcom_smem_partition_header(struct qcom_smem *smem,
 		return NULL;
 	}
 
+	if (host0 != le16_to_cpu(header->host0)) {
+		dev_err(smem->dev, "bad host0 (%hu != %hu)\n",
+				host0, le16_to_cpu(header->host0));
+		return NULL;
+	}
+	if (host1 != le16_to_cpu(header->host1)) {
+		dev_err(smem->dev, "bad host1 (%hu != %hu)\n",
+				host1, le16_to_cpu(header->host1));
+		return NULL;
+	}
+
 	size = le32_to_cpu(header->size);
 	if (size != le32_to_cpu(entry->size)) {
 		dev_err(smem->dev, "bad partition size (%u != %u)\n",
@@ -769,7 +780,6 @@ static int qcom_smem_set_global_partition(struct qcom_smem *smem)
 	struct smem_partition_header *header;
 	struct smem_ptable_entry *entry;
 	struct smem_ptable *ptable;
-	u32 host0, host1;
 	bool found = false;
 	int i;
 
@@ -798,18 +808,11 @@ static int qcom_smem_set_global_partition(struct qcom_smem *smem)
 		return -EINVAL;
 	}
 
-	header = qcom_smem_partition_header(smem, entry);
+	header = qcom_smem_partition_header(smem, entry,
+				SMEM_GLOBAL_HOST, SMEM_GLOBAL_HOST);
 	if (!header)
 		return -EINVAL;
 
-	host0 = le16_to_cpu(header->host0);
-	host1 = le16_to_cpu(header->host1);
-
-	if (host0 != SMEM_GLOBAL_HOST || host1 != SMEM_GLOBAL_HOST) {
-		dev_err(smem->dev, "Global partition hosts are invalid\n");
-		return -EINVAL;
-	}
-
 	smem->global_partition = header;
 	smem->global_cacheline = le32_to_cpu(entry->cacheline);
 
@@ -860,19 +863,10 @@ static int qcom_smem_enumerate_partitions(struct qcom_smem *smem,
 			return -EINVAL;
 		}
 
-		header = qcom_smem_partition_header(smem, entry);
+		header = qcom_smem_partition_header(smem, entry, host0, host1);
 		if (!header)
 			return -EINVAL;
 
-		host0 = le16_to_cpu(header->host0);
-		host1 = le16_to_cpu(header->host1);
-
-		if (host0 != host0 || host1 != host1) {
-			dev_err(smem->dev,
-				"Partition %d hosts don't match\n", i);
-			return -EINVAL;
-		}
-
 		smem->partitions[remote_host] = header;
 		smem->cacheline[remote_host] = le32_to_cpu(entry->cacheline);
 	}
-- 
2.17.1

