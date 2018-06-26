Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3028FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C513F26398
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YSdoX1rP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C513F26398
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935145AbeFZA7U (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:59:20 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53206 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934965AbeFZA7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:59:11 -0400
Received: by mail-it0-f66.google.com with SMTP id m194-v6so15208131itg.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 17:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T4CUDx/3MI0mxSRgg3ZDgSPUHt20uXodH0yLTHynxPE=;
        b=YSdoX1rPHCapO7bHzHg6fURu96OYAzv1qrrFa/3E8tlPxek7+KNsr/nHmwe1aNmFoG
         BAO/8/GBPVXeiKPk8DRYjlBWkhsyr9D8gtnfkOJnHjDFX8c7eP3UWdRtYjvAA6f/MH/6
         wkkFNhj6djxqK7DOmYn10Abo6YStA3DunPZ+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T4CUDx/3MI0mxSRgg3ZDgSPUHt20uXodH0yLTHynxPE=;
        b=tAzlaK0HZnMZHJ46YmwH9VI8KOoL5G9cA5LkcgtA2XUh59XRhjMXpE6E+D//rZVp1E
         aRYXxicn4BIf2ZixcssljUy24fy7jO692p8cjKuONde8S7cET7pPL2ptonKRSrqVfjfA
         lSCPZMO/9T+c34vrNHj+QvD+kJRUGNonR9wkJ80NqRoD/W3fFAQsnbgduDmBRuSbb9Zt
         Gdqy4MmU8pGoCGbPAZ+C7775GMkHaSPGvz496zQ46MajhTnZzzKjOX7jhWfDZMW1BE+2
         qEutG3qB/3VSlFlzDcgQ3B50cPPUJRoWPHh9g8J6g96TASnoivagu77QpdKSiYcAcabL
         Lz8A==
X-Gm-Message-State: APt69E0ZXCsqY1WfuTVmSC0bolFHC0ymZDrcbxys79PCDaU9a+/b55yl
        1MV2PqUEfYUmaSSvkKR5wMrcpg==
X-Google-Smtp-Source: ADUXVKKYcIEgjX3iPdDeHsyViLGz9mGIwzFMEERTdggvGHZWUEBrgh5/dhlKzM3KulraURRi0biobw==
X-Received: by 2002:a24:eb17:: with SMTP id h23-v6mr2648601itj.17.1529974750868;
        Mon, 25 Jun 2018 17:59:10 -0700 (PDT)
Received: from localhost.localdomain (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.gmail.com with ESMTPSA id f193-v6sm372556itf.9.2018.06.25.17.59.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 17:59:10 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     andy.gross@linaro.org
Cc:     clew@codeaurora.org, aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH resend 10/12] soc: qcom: smem: small change in global entry loop
Date:   Mon, 25 Jun 2018 19:58:54 -0500
Message-Id: <20180626005856.14174-11-elder@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626005856.14174-1-elder@linaro.org>
References: <20180626005856.14174-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the logic in the loop that finds that global host entry in
the partition table not require the host0 and host1 local variables.
The next patch will remove them.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/soc/qcom/smem.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index f5d7af1623a9..8597aa03232c 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -784,9 +784,10 @@ static int qcom_smem_set_global_partition(struct qcom_smem *smem)
 		if (!le32_to_cpu(entry->size))
 			continue;
 
-		host0 = le16_to_cpu(entry->host0);
-		host1 = le16_to_cpu(entry->host1);
-		if (host0 == SMEM_GLOBAL_HOST && host0 == host1) {
+		if (le16_to_cpu(entry->host0) != SMEM_GLOBAL_HOST)
+			continue;
+
+		if (le16_to_cpu(entry->host1) == SMEM_GLOBAL_HOST) {
 			found = true;
 			break;
 		}
-- 
2.17.1

