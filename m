Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35518C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E203D20877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KOyh3egX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E203D20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbeIYPL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:11:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53274 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbeIYPL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:11:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id b19-v6so12519817wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 02:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2GO8tdB0VqF/b2ulgCZCuFFs0ie3KdkmUxeTxxbYG3I=;
        b=KOyh3egXVnoup8Dg4CvBj/Aq3XnB2Z9Jn0rwy6SseExGuOW/eWS4yRRbJpX7hLf7f7
         3pa0iMIQy0wrYn+04NfvD3SqceW9W1svCl3IywZ70NMtIkJy/JqRewnMHs/115//+MVh
         tMmjyJ3gAe78KtjmMXn3uIsWF7P5AZXlmGz/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2GO8tdB0VqF/b2ulgCZCuFFs0ie3KdkmUxeTxxbYG3I=;
        b=BXyEligTMBqt3/9JocfxMp4CmAaaHdfJWQNAqEyZ1XXMobCEYocChy8iEGEu5irQjB
         BpHsL/hQoeSStMJPbBtzcBbNenu2L9lQBSQScCl3VJ0NJely49+srLHugWOave7XNfJx
         rCLKUyekdwDehk8jdNXayP4KVDmCP8gKA/dTHDQRpbwPeKzsJ1RzHz+M51GgPY+EFSMl
         U5GSJEfPwqCD/6osEjNlD0a8PhlL4yi1u7+EnYd7w1phtrMWMoRMJtl2J6tIlMS/DkZ2
         mVX3urz/0NgFJspVAC46d63kPHeLu3gaHH+AmIzVRd9PnHycMtc4D1dljl5QwJVwMgHJ
         Nnuw==
X-Gm-Message-State: ABuFfoiCaE72XcTd3FO4PaHHJRg9hVMFd2sLPTO3+etUNoreoaKsC7O6
        Wg+b4ZvpEo/bY3gyv3717OZOeQ==
X-Google-Smtp-Source: ACcGV635Xv/YujAroy4RRVeSE5kz/CceBXIU0wiFoXgaUYKj0MI1RlWwagysKD496PbRnZDZVX08EQ==
X-Received: by 2002:a1c:7d51:: with SMTP id y78-v6mr55960wmc.37.1537866293946;
        Tue, 25 Sep 2018 02:04:53 -0700 (PDT)
Received: from localhost.localdomain (251.150.136.77.rev.sfr.net. [77.136.150.251])
        by smtp.gmail.com with ESMTPSA id y206-v6sm1523828wmg.14.2018.09.25.02.04.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Sep 2018 02:04:51 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     edubezval@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, leo.yan@linaro.org,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 11/14] thermal/drivers/hisi: Remove pointless irq field
Date:   Tue, 25 Sep 2018 11:03:09 +0200
Message-Id: <1537866192-12320-12-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The irq field in the data structure is pointless as the scope of its
usage is just to request the interrupt. It can be replaced by a local
variable.

Use the 'ret' variable to get the interrupt number.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 941c2c4..87d8a13 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -83,7 +83,6 @@ struct hisi_thermal_data {
 	struct clk *clk;
 	void __iomem *regs;
 	int nr_sensors;
-	int irq;
 };
 
 /*
@@ -579,16 +578,16 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 			return ret;
 		}
 
-		data->irq = platform_get_irq_byname(pdev, sensor->irq_name);
-		if (data->irq < 0)
-			return data->irq;
+		ret = platform_get_irq_byname(pdev, sensor->irq_name);
+		if (ret < 0)
+			return ret;
 
-		ret = devm_request_threaded_irq(dev, data->irq, NULL,
+		ret = devm_request_threaded_irq(dev, ret, NULL,
 						hisi_thermal_alarm_irq_thread,
 						IRQF_ONESHOT, sensor->irq_name,
 						sensor);
 		if (ret < 0) {
-			dev_err(dev, "failed to request alarm irq: %d\n", ret);
+			dev_err(dev, "Failed to request alarm irq: %d\n", ret);
 			return ret;
 		}
 
-- 
2.7.4

