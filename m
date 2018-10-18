Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A2BECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B6E32098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IBd11yo1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B6E32098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbeJRQww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 12:52:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33376 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbeJRQwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 12:52:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id 78-v6so12194454pfq.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 01:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=wuTLNNFPtvGEn50eKaEyNEzBPZsJcfU/sfOOV2dCAmc=;
        b=IBd11yo1pLxVL9pACURpAokeSMvwGB54pTZFTBDD8U5OhJPNp3MNjH0YCSLKPohgeh
         yrDeKbJ/OYUvodz7eVGrF6ejRZf1J4ke0j10tG1jg9CufQfMuHkz9oxysyphJpDPDf5q
         u4WAzthRr82U7sXz01PHWT3BVFCRPns9eZl7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=wuTLNNFPtvGEn50eKaEyNEzBPZsJcfU/sfOOV2dCAmc=;
        b=KUD8pS8WvIAGGwormG5ebMNS5B/CvI0sa/vjT78HnrhTx1CzmOgyWoq7F7ionZsJ9y
         KUJfsfNhyavFyAJintdwY33Yiua6ILjg6Sc1tJcBqRuknMsbrOUuVRO55IjHVW+LMH1Y
         MtxZhPa0Y+z+whbxCABXae0xOX20hfMX97yLSd2ej/05nGKpOd/5DBdTO3P1FJyGOSu9
         Vu2ad0k9A/zcr59ESIilcBnyN4PoIs3RYumu2ufAIh2VY6lkR/daqNhagqN79tHlz2Ix
         81CTzSZeqI8T/3/C/84yXSJNuG2YbxfV8JHmblI9F0kKwe0EQc9ZlvXyW6/frDn6ZfEA
         reEA==
X-Gm-Message-State: ABuFfojNsN35cZNtIK5ho8rvPU/YIEfYYJyHp4kjqJf+T5ldcn8U3IYj
        FFBuz4jZDhTtneI+48UNPPR1uQ==
X-Google-Smtp-Source: ACcGV63f5WlBH9BArZBXYsB0+bhJStMYdC6U/cnIgWi+r2aZVBIbW1w6kSn/pLi9HOLruEJhslZdaA==
X-Received: by 2002:a63:5021:: with SMTP id e33-v6mr27572885pgb.306.1539852772874;
        Thu, 18 Oct 2018 01:52:52 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id x186-v6sm18467528pfb.125.2018.10.18.01.52.49
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 01:52:51 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     broonie@kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, baolin.wang@linaro.org
Subject: [PATCH 3/5] rtc: sc27xx: Remove interrupts disable and clear in probe()
Date:   Thu, 18 Oct 2018 16:52:28 +0800
Message-Id: <f3a3d5896e07dd6280d0bf450f01ad1bba6f9286.1539851865.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1539851865.git.baolin.wang@linaro.org>
References: <cover.1539851865.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1539851865.git.baolin.wang@linaro.org>
References: <cover.1539851865.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When registering one rtc device, it will check to see if there is an
alarm already set in rtc hardware by issuing __rtc_read_alarm(). So
we should not disable the RTC interrupts and clear the interrupts
status in probe() function.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/rtc/rtc-sc27xx.c |   20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/rtc/rtc-sc27xx.c b/drivers/rtc/rtc-sc27xx.c
index 6ac5653..4ecabe6 100644
--- a/drivers/rtc/rtc-sc27xx.c
+++ b/drivers/rtc/rtc-sc27xx.c
@@ -129,19 +129,6 @@ static int sprd_rtc_clear_alarm_ints(struct sprd_rtc *rtc)
 			    SPRD_RTC_ALM_INT_MASK);
 }
 
-static int sprd_rtc_disable_ints(struct sprd_rtc *rtc)
-{
-	int ret;
-
-	ret = regmap_update_bits(rtc->regmap, rtc->base + SPRD_RTC_INT_EN,
-				 SPRD_RTC_INT_MASK, 0);
-	if (ret)
-		return ret;
-
-	return regmap_write(rtc->regmap, rtc->base + SPRD_RTC_INT_CLR,
-			    SPRD_RTC_INT_MASK);
-}
-
 static int sprd_rtc_lock_alarm(struct sprd_rtc *rtc, bool lock)
 {
 	int ret;
@@ -609,13 +596,6 @@ static int sprd_rtc_probe(struct platform_device *pdev)
 	rtc->dev = &pdev->dev;
 	platform_set_drvdata(pdev, rtc);
 
-	/* clear all RTC interrupts and disable all RTC interrupts */
-	ret = sprd_rtc_disable_ints(rtc);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to disable RTC interrupts\n");
-		return ret;
-	}
-
 	/* check if RTC time values are valid */
 	ret = sprd_rtc_check_power_down(rtc);
 	if (ret) {
-- 
1.7.9.5

