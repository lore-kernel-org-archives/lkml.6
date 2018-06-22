Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6400EC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152C923EB7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kqLbuKHW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 152C923EB7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932819AbeFVIKV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:10:21 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36757 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754338AbeFVIKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:10:14 -0400
Received: by mail-pf0-f193.google.com with SMTP id a12-v6so2847500pfi.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 01:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=y6rwY3jFptgeXlF1nA+iIjbA4Z16sjg0bDMz2V84xl4=;
        b=kqLbuKHW/+VNUrQYSiHOPno0CbY7pYXtYPCLda0MHAVsKgMwbbqOzL8820VxtCZPQT
         NURCutWbp1fdESZz1H1QyYckGS2Yaqil24aAhMzAban4tAuH3A/ZYAFloAMg1mw6kMg+
         skmpvY6VCP/bR6rfDvlPz7iPfdpnSTJ0SCRbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=y6rwY3jFptgeXlF1nA+iIjbA4Z16sjg0bDMz2V84xl4=;
        b=t2IbvdMmTe6GPzZPPzdS6bQczIEqONwd4RpiyqfUuYnURK9iZzS9oYs8XPSsKUCz+3
         94ynr0xGAA+h+JoKx0KaHlQVZxftFKvCtL8sCoF7MgQho7VN4upf6Iq83DJ9+scP4pYY
         mhZEokR9mtMHag2XVciuti1BjSwyiX9xQnMCqRD12lK4OKI5YjbrfVL/dxQKzccERFqv
         SHt7LMVVEiV/FSA8qvccWnuip+8NlkntwtQ6Tml37HlECJKEIESJgx0xcTg+hyo2j64Z
         999zkDASL6anZ3B3dlQCn0rUL0NMg/BaXSeSxOqehOtY2lJfO6s/0twpu9viGatxIfsE
         /fEg==
X-Gm-Message-State: APt69E1jvebdvtD2lhAb2tyBu23ySY6HZkYZCgHSg2J8InEnXXeuJMef
        89UWs3okPisZ4t2NW2G6E/NENQ==
X-Google-Smtp-Source: ADUXVKKvEyXNuTHzTU6Jw8b3Rn+PLh/JWLMib5LJqPhLWqXFG0o218fgv5sFfR6ynjddqnDKBHlavg==
X-Received: by 2002:a65:62cd:: with SMTP id m13-v6mr501456pgv.207.1529655014243;
        Fri, 22 Jun 2018 01:10:14 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id i65-v6sm22656131pfd.17.2018.06.22.01.10.11
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Jun 2018 01:10:13 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, broonie@kernel.org
Cc:     baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] spi: sprd: Change to use devm_hwspin_lock_request_specific()
Date:   Fri, 22 Jun 2018 16:09:05 +0800
Message-Id: <1662400fb204bbbe9a36edf580ea267079a2a02e.1529654288.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
References: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
In-Reply-To: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
References: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change to use devm_hwspin_lock_request_specific() instead of
freeing the hwlock explicitly when unbound the device.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/spi/spi-sprd-adi.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index d8d5e2f..6fb5c0c 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -465,7 +465,7 @@ static int sprd_adi_probe(struct platform_device *pdev)
 		goto put_ctlr;
 	}
 
-	sadi->hwlock = hwspin_lock_request_specific(ret);
+	sadi->hwlock = devm_hwspin_lock_request_specific(&pdev->dev, ret);
 	if (!sadi->hwlock) {
 		ret = -ENXIO;
 		goto put_ctlr;
@@ -483,7 +483,7 @@ static int sprd_adi_probe(struct platform_device *pdev)
 	ret = devm_spi_register_controller(&pdev->dev, ctlr);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register SPI controller\n");
-		goto free_hwlock;
+		goto put_ctlr;
 	}
 
 	sadi->restart_handler.notifier_call = sprd_adi_restart_handler;
@@ -491,13 +491,11 @@ static int sprd_adi_probe(struct platform_device *pdev)
 	ret = register_restart_handler(&sadi->restart_handler);
 	if (ret) {
 		dev_err(&pdev->dev, "can not register restart handler\n");
-		goto free_hwlock;
+		goto put_ctlr;
 	}
 
 	return 0;
 
-free_hwlock:
-	hwspin_lock_free(sadi->hwlock);
 put_ctlr:
 	spi_controller_put(ctlr);
 	return ret;
@@ -509,7 +507,6 @@ static int sprd_adi_remove(struct platform_device *pdev)
 	struct sprd_adi *sadi = spi_controller_get_devdata(ctlr);
 
 	unregister_restart_handler(&sadi->restart_handler);
-	hwspin_lock_free(sadi->hwlock);
 	return 0;
 }
 
-- 
1.7.9.5

