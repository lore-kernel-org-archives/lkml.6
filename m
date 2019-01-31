Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7524DC282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D3E820989
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PP4P6uEI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfAaCCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 21:02:00 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36650 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfAaCB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 21:01:58 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so732791pfc.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 18:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=HjDYVVjAsz/4oVbkOE/Mrv8HvKO47yQvu96bDy25tg8=;
        b=PP4P6uEIkFYFypugevC/CAzFdBY6dZKtcvfDvBvdZ1JCQqxL4y9hkjulkEFOAPkR8k
         a/UccZS5SiJRyGU81gNEh11LpNFPCpB+/r9K3+6fqa6TjQr3YF6EGvIAMauEAFnsJXr1
         vJYkjuMNUp/1Sr3gboSU9vrV+XWX+o5BHKZCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HjDYVVjAsz/4oVbkOE/Mrv8HvKO47yQvu96bDy25tg8=;
        b=tGB5JMWUaqy1n9N+n6gVlGOmRRN3ll0GDODawi0BNeUEvGoaEQ7dvSOcLPlf+yknaS
         v0GLmWEdtLbtf8BM1UVTIdzgLUd9Ag/vTw0YwsA6NZ5VWtSpi9FNxcaYzVY+70PpRoqL
         oiYJ2lkPM8EeCQulFmrkRF1hUiX1YZoMqnluQEGlS/BO4SmcgGjRVZ5HI0HWLQvGIsuy
         v1aQkEog/MUv8R1BKJDemwbqMwA6iMexwRiiftPupjZIDlOmnauFDmlHNgSxXNuZvb9C
         XPA/1VHTPNsN8qsOdYtBvfE+JR3fVIA/4CWfr/mTHk0D7czaxyh/WHix29nol+XxTXmu
         jzPQ==
X-Gm-Message-State: AJcUukeqploKpM1O6nEVgv+hAd1EUi4TWvh71Od9O2zByAcnHqzXNGIu
        EzEm1OIyI5Lt4bh2+RIEex/a5Q==
X-Google-Smtp-Source: ALg8bN673hIaMuJXFR4m1K9z+qx8Rmf57vyXdzupJDj0dBgrgCKEo1NWs3rIChi6W9lNqweCqC+FlQ==
X-Received: by 2002:a62:528e:: with SMTP id g136mr34406859pfb.111.1548900117539;
        Wed, 30 Jan 2019 18:01:57 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id n78sm4957822pfk.19.2019.01.30.18.01.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 18:01:56 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [RESEND PATCH] amba: Allow pclk to be controlled by power domain
Date:   Wed, 30 Jan 2019 18:01:41 -0800
Message-Id: <20190131020141.28352-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
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

Resending this separate from the series it was originally part of.

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

