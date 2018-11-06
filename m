Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7C2C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 05:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06FCC20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 05:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gutae7G7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06FCC20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbeKFOZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 09:25:31 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40509 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729794AbeKFOZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 09:25:31 -0500
Received: by mail-pl1-f194.google.com with SMTP id q19-v6so2579118pll.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 21:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Ipu0OKiVTAGWTLE4fg/nM2ymSy+8y5EVSd0lvjhlhp8=;
        b=gutae7G74a5xWjvogNtC3uF7yCVomb6SNDj4i/rOZwIqyQrrPMcLKpUVx0rsnX15Ju
         kE3KVj6sicYEePLve7JYvmafJCZsUduo0QgnTSQFHG2AvthQXdg3uIeN7/WCdzg61MOC
         MlSY9nCD6TpzzC31M86yCd7b1Xa81FTIzHdoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Ipu0OKiVTAGWTLE4fg/nM2ymSy+8y5EVSd0lvjhlhp8=;
        b=FHRu2RaHfNhOfxaoBm1wxElg6JRsBZ/GJ3Xn5ZCLGjlSwdTEY7nc0WwFIy0fD1LDeM
         xPANDb4IWwxoKoAE3Ychs2Dbfzv82g/lA6NOTpwMNT/ERgxKHqkovmCW6xinlAeAQNm8
         O9A0Bss6K7AEx+Tf+aeCOfkK7Xv+gvIto6F8OSPK/LygSVDT1ElnVer07UBGBpE1aFjE
         shNVmAb9hOQuOTPgfN4WJ/fH9dpKIhlqHLrSUDBt5G6Y7cs29E+RGT4Hntq66q47vrZY
         2hniYaX2E2jwbhaZIUUmdt50mcg3nctMYbsYWM2qQ+Z6g0lVn2kK+735embwbOiKonAc
         tANQ==
X-Gm-Message-State: AGRZ1gIPAiTodEn1L5ukZko0qtJ7uPFFhUQFFKCAi/iQ3Vrl0QJ8Jh1z
        bNgzQZcK+3bmWKXFxuLt/I5kEQ==
X-Google-Smtp-Source: AJdET5ejAw5ZSntam1RDEA1skDfRYO2Q88ZXm3BjphhZKf+kfSrc0digFKk9c1c/5ZbHRlQdO8x+IA==
X-Received: by 2002:a17:902:4222:: with SMTP id g31-v6mr24679107pld.236.1541480528979;
        Mon, 05 Nov 2018 21:02:08 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id o7-v6sm55735416pfb.23.2018.11.05.21.02.06
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Nov 2018 21:02:08 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org, eric.long@unisoc.com
Cc:     broonie@kernel.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 3/7] dmaengine: sprd: Fix the last link-list configuration
Date:   Tue,  6 Nov 2018 13:01:33 +0800
Message-Id: <95cbea4b835bb2689036afe78ff0b2239a24f352.1541480353.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1541480353.git.baolin.wang@linaro.org>
References: <cover.1541480353.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1541480353.git.baolin.wang@linaro.org>
References: <cover.1541480353.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Long <eric.long@spreadtrum.com>

We will pass sglen as 0 configure the last link-list configuration
when filling the descriptor, which will cause the incorrect link-list
configuration. Thus we should check if the sglen is 0 to configure
the correct link-list configuration.

Signed-off-by: Eric Long <eric.long@spreadtrum.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 4f3587b..e6a74dc 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -697,7 +697,8 @@ static int sprd_dma_fill_desc(struct dma_chan *chan,
 		hw->cfg |= SPRD_DMA_LINKLIST_EN;
 
 		/* link-list index */
-		temp = (sg_index + 1) % sglen;
+		temp = sglen ? (sg_index + 1) % sglen : 0;
+
 		/* Next link-list configuration's physical address offset */
 		temp = temp * sizeof(*hw) + SPRD_DMA_CHN_SRC_ADDR;
 		/*
-- 
1.7.9.5

