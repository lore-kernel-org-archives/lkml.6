Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D9DC43444
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE05218DE
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H11IiDTl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfAFIKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 03:10:30 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43498 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbfAFIK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 03:10:26 -0500
Received: by mail-pg1-f196.google.com with SMTP id v28so19330219pgk.10
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 00:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6eOA+KowDamTwt9THtkpVEpyZ4rKdyAZPpHHkjZU05U=;
        b=H11IiDTlL5rZfxXSyBdWWhB7DFh/XlD+/c/114NySGh8MmITVRdvbhjs6E7FsSaaff
         fM5tHLsRhilrX4qaIoz/I+0ftniQ8xlVkxAVonc86P9QFkX1MdlwgvtmG7LXrgyWGDUW
         qRJVsc4czoqwwMSTQtlpVz8r46GlA0DNiYF84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6eOA+KowDamTwt9THtkpVEpyZ4rKdyAZPpHHkjZU05U=;
        b=r8403is5q/3vTsW7pub6OQNFBEgF9ysXjhbWDZhary/roak9QSQ0fYfR2ThMV22VTB
         j7WZudNPlliN21l+jHC3zJe34PfbtJj7/H1IFibNhXgAfTfWeBHNQ5zMTE7DWEstlTS1
         5X+ClXd8+fes/qTUMzec52n9JKHmuVV0j7c41XybS6VVKE9/TEkpLrdpiW0FK5LTQcZU
         OM3t2800IMkoa41rX1CmhW06BvFTt6ayR/8fp4vDswLF8oFPMtSB9mzTuFivP85CdTVf
         +tfxQYSLAiQLoQ3+aRRg6OnxMbX8vrcPHZiAY79rPs18wEvOoND5d0pCTItmTmDG5uV2
         GJVg==
X-Gm-Message-State: AJcUukdlc4W602OQC4wqSfuVE6GXqjAmYjXJgk+ZumEPqFtjh+5WGD9m
        tOLL5Eh3s5sOHP6p4V+t6JAYGg==
X-Google-Smtp-Source: ALg8bN4PZSvgdLvZr0uS63gR6uO3wJrxRf7Ob0na3sw+AJmzFqr2Nhb2tMaJpyfnlyq1SQJcVTERlw==
X-Received: by 2002:a63:a064:: with SMTP id u36mr7136362pgn.145.1546762224050;
        Sun, 06 Jan 2019 00:10:24 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v190sm90763364pfv.26.2019.01.06.00.10.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 00:10:23 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Russell King <linux@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] amba: Allow pclk to be controlled by power domain
Date:   Sun,  6 Jan 2019 00:09:14 -0800
Message-Id: <20190106080915.4493-7-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190106080915.4493-1-bjorn.andersson@linaro.org>
References: <20190106080915.4493-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the Qualcomm SDM845 platform the apb_pclk is controlled as part of
the QDSS power/clock domain. Handle this by allowing amba to operate
without direct apb_pclk control, when a powerdomain is attached and no
clock is described.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- New patch

 drivers/amba/bus.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 41b706403ef7..3e13050c6d59 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -219,8 +219,13 @@ static int amba_get_enable_pclk(struct amba_device *pcdev)
 	int ret;
 
 	pcdev->pclk = clk_get(&pcdev->dev, "apb_pclk");
-	if (IS_ERR(pcdev->pclk))
-		return PTR_ERR(pcdev->pclk);
+	if (IS_ERR(pcdev->pclk)) {
+		/* Continue with no clock specified, but pm_domain attached */
+		if (PTR_ERR(pcdev->pclk) == -ENOENT && pcdev->dev.pm_domain)
+			pcdev->pclk = NULL;
+		else
+			return PTR_ERR(pcdev->pclk);
+	}
 
 	ret = clk_prepare_enable(pcdev->pclk);
 	if (ret)
-- 
2.18.0

