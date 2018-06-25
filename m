Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B21C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 20:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A58124E8C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 20:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UozIUjzV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A58124E8C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755653AbeFYUGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 16:06:19 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:39179 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750792AbeFYUGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 16:06:17 -0400
Received: by mail-pg0-f65.google.com with SMTP id n2-v6so3106857pgq.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 13:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QndvnwoOLFEz/PPR9HVV246ksdoIpO5uDePDYkrsMv4=;
        b=UozIUjzVL87pGRI/2NKxPyhv2zjP7MrahYQ/Yzeq3z28OHslAa0OtadzpIaxWkATkh
         LumiHQ0MoYymk4Y11JZnHDGsWkKyh7NMEZrlFlEcG4GKTxZkovKpyZ5jdU5TQWffswSJ
         rAsSweY6LlnLQ27cW6K029xBcLD8J4e2vE25s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QndvnwoOLFEz/PPR9HVV246ksdoIpO5uDePDYkrsMv4=;
        b=he/nsBeFcQu2+yG3n5gf647eyKaSbAhqIvTAuQ48oQUEbV7i1S8qGU7PymVlDG3WyM
         niQ9iwQQ5jvHB8dLPRIWEoAdnh12GG73RI/rXAzF359jmk7YycQ0n/GXhPPUH7eyMUx5
         TT+kSf3zj68fbhTKqLBh3ZnumyyCz83+2zLg+ogOAvtPR2f3VdW210jzvh697DfOjiTw
         9wi2BJNZ9Nu1Gj76BXhb/Stn8YlStd5EMf/JHN/PhkIEBHQEAwUOadSEzyNwdIcUKOUH
         TAGNyfDKgy0taTSzXif7fpI+ajWf8zmjcst9gTGuvqN08qPWAoKtfkmGa8ES6Mp0Lat8
         h5Eg==
X-Gm-Message-State: APt69E3PbXRkOLoLfViaZsw1U+TugSHeP9T5xZRS5mL6yBtqORMv59R8
        ulKLFuC0YUKZ8z1NRR9vUoh4IA==
X-Google-Smtp-Source: ADUXVKI4P+C8crh8CJBW8b+HyuVisAWBwajOOG7Jn0qJ8o4/Vy7txFW/T3dlZ6KOuS/L/Q7gd/AHxQ==
X-Received: by 2002:a63:9611:: with SMTP id c17-v6mr11793277pge.361.1529957176762;
        Mon, 25 Jun 2018 13:06:16 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g78-v6sm28810383pfe.39.2018.06.25.13.06.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 13:06:16 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alex Elder <elder@linaro.org>
Subject: [PATCH] soc: qcom: smem: Correct check for global partition
Date:   Mon, 25 Jun 2018 13:06:13 -0700
Message-Id: <20180625200613.20245-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The moved check for the global partition ended up in the wrong place and I
failed to spot this in my review. This moves it to the correct place.

Fixes: 11d2e7edac6a ("soc: qcom: smem: check sooner in qcom_smem_set_global_partition()")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/soc/qcom/smem.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 70b2ee80d6bd..bf4bd71ab53f 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -364,11 +364,6 @@ static int qcom_smem_alloc_private(struct qcom_smem *smem,
 	end = phdr_to_last_uncached_entry(phdr);
 	cached = phdr_to_last_cached_entry(phdr);
 
-	if (smem->global_partition) {
-		dev_err(smem->dev, "Already found the global partition\n");
-		return -EINVAL;
-	}
-
 	while (hdr < end) {
 		if (hdr->canary != SMEM_PRIVATE_CANARY)
 			goto bad_canary;
@@ -736,6 +731,11 @@ static int qcom_smem_set_global_partition(struct qcom_smem *smem)
 	bool found = false;
 	int i;
 
+	if (smem->global_partition) {
+		dev_err(smem->dev, "Already found the global partition\n");
+		return -EINVAL;
+	}
+
 	ptable = qcom_smem_get_ptable(smem);
 	if (IS_ERR(ptable))
 		return PTR_ERR(ptable);
-- 
2.17.0

