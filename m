Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1C8C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1522263AD
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="O+rMum1z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1522263AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935249AbeFZBBX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 21:01:23 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:32891 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755789AbeFZA7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:59:04 -0400
Received: by mail-io0-f195.google.com with SMTP id d185-v6so14331451ioe.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 17:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XA/E3QTALeKtLrl2UKl+cued+8oFK5Fk+61ksYnsJDA=;
        b=O+rMum1zamoWjUYs2wfTqNzfawRpjRbLU17yyjd6Nvl9aMiSNZMcr7W0y1EbC4DU3Q
         Ho0qI5xbHJFolESzOSB0C3PWF63FufIZwUBo+L9w3Nj4Cp9RytkoH18045hg2tJx2BeK
         j0fmRCr770eW9l1kLkIXA1BI6cXP1TSDXrp3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XA/E3QTALeKtLrl2UKl+cued+8oFK5Fk+61ksYnsJDA=;
        b=csLzOAeyU5Sy6Dhg2RhlIkAs5N7tPtoG8E+VW//d65bigqlsAfNFXw7Lp3UipRu/IB
         A9seyOVsTq7+Hug4bhi1jPnZQIMCOAJ/D0Dyb6kxAQI6CnjGxYRZtLou0+VSpwjyd1pB
         z37JkwZegj+lD/GZCpiliXoVf7ndpHGSZdCqZjvxvPrmrVFI7zus75gomXd+pdqrSnqP
         hb8/HZKu1Ng1PMtMWDimvPvDBeKwHdKc0H0JlE+iawevlv9R47Psf97VvtSqAHcpjrqS
         7byb1Dgtu1xG7jonjq83C28uwtlALqQNuporbURmwf1tD2V7wFm5u/BxRzaEM9DxC/W4
         3/HA==
X-Gm-Message-State: APt69E0HoUFSIm8cCSVqrED1mlEPnLX4SCSMOGfqEmE5u76kHn7/PvKh
        RryJnQQnwd4OmtpZ5HSqSUal6Q==
X-Google-Smtp-Source: AAOMgpcAC0Jz2RUzZNV2RnESeAxXhfxu8mH4UJ4Omoo+6sUiThId/ohxEaKQpShIvOPCRU01SGX/AA==
X-Received: by 2002:a6b:9fcb:: with SMTP id i194-v6mr9879060ioe.286.1529974744327;
        Mon, 25 Jun 2018 17:59:04 -0700 (PDT)
Received: from localhost.localdomain (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.gmail.com with ESMTPSA id f193-v6sm372556itf.9.2018.06.25.17.59.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 17:59:03 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     andy.gross@linaro.org
Cc:     clew@codeaurora.org, aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH resend 03/12] soc: qcom: smem: always ignore partitions with 0 offset or size
Date:   Mon, 25 Jun 2018 19:58:47 -0500
Message-Id: <20180626005856.14174-4-elder@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626005856.14174-1-elder@linaro.org>
References: <20180626005856.14174-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In qcom_smem_enumerate_partitions(), any partition table entry
having a zero offset or size field is ignored.  Move those checks
earlier in the loop, because there's no sense in examining the
host fields for those entries.

Add the same checks in qcom_smem_set_global_partition(), so the
scan for the global partition skips over these invalid entries.
This allows a later check for zero size or offset once the global
entry is found to be eliminated.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/soc/qcom/smem.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index d8008bf480a4..83ba549cfea0 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -742,9 +742,13 @@ static int qcom_smem_set_global_partition(struct qcom_smem *smem)
 
 	for (i = 0; i < le32_to_cpu(ptable->num_entries); i++) {
 		entry = &ptable->entry[i];
+		if (!le32_to_cpu(entry->offset))
+			continue;
+		if (!le32_to_cpu(entry->size))
+			continue;
+
 		host0 = le16_to_cpu(entry->host0);
 		host1 = le16_to_cpu(entry->host1);
-
 		if (host0 == SMEM_GLOBAL_HOST && host0 == host1) {
 			found = true;
 			break;
@@ -756,11 +760,6 @@ static int qcom_smem_set_global_partition(struct qcom_smem *smem)
 		return -EINVAL;
 	}
 
-	if (!le32_to_cpu(entry->offset) || !le32_to_cpu(entry->size)) {
-		dev_err(smem->dev, "Invalid entry for global partition\n");
-		return -EINVAL;
-	}
-
 	header = smem->regions[0].virt_base + le32_to_cpu(entry->offset);
 	host0 = le16_to_cpu(header->host0);
 	host1 = le16_to_cpu(header->host1);
@@ -809,18 +808,16 @@ static int qcom_smem_enumerate_partitions(struct qcom_smem *smem,
 
 	for (i = 0; i < le32_to_cpu(ptable->num_entries); i++) {
 		entry = &ptable->entry[i];
+		if (!le32_to_cpu(entry->offset))
+			continue;
+		if (!le32_to_cpu(entry->size))
+			continue;
+
 		host0 = le16_to_cpu(entry->host0);
 		host1 = le16_to_cpu(entry->host1);
-
 		if (host0 != local_host && host1 != local_host)
 			continue;
 
-		if (!le32_to_cpu(entry->offset))
-			continue;
-
-		if (!le32_to_cpu(entry->size))
-			continue;
-
 		if (host0 == local_host)
 			remote_host = host1;
 		else
-- 
2.17.1

