Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE13C46464
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 01:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1373222436
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 01:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E3IbYcNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1373222436
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbeHKEHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 00:07:38 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43073 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725199AbeHKEHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 00:07:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id j26-v6so5260620pfi.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 18:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=8CDeotPCFhWraUTKO4OTKwuHQrhaCDvB5WlDvjgwrqk=;
        b=E3IbYcNPU87ATDvdxX2es1fhPdEJ6mt9XAiAM4FpKCcmNOQ+u05ZGQLRQdmbgGDX/7
         n324cRqMlfkDGTUMeBcMGI+vm8cU+fnq3cEOeGV/XwDnW/okCNyO651W3Bvm311XnxFQ
         vLi6F1Iw3ml9T4VuVSkb3269Ez5wjSdombkNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=8CDeotPCFhWraUTKO4OTKwuHQrhaCDvB5WlDvjgwrqk=;
        b=LAi/LIoe+r6OKJg6yFOUEtn9Twu4bmtINDfMR7LTLSYXoTO6NvBGAji8Rb65nIutOw
         cSsMwuNEev1o+XKluwANFhExWxHdFunx192t+2Ngf/BCpXZCrvvDk3R/EdByCbFL4gDe
         plUjowM616LnvYq1s2QbEKRNfnu+G5V0mmonBUt4Y3D7l5hhS3AYZ9AP5Lgf92HisLyO
         YilavmlhWSdyzEqCRpf8EugZMOxrIAuijIDsq0/jdCGA5AX7k/eF42EF1WaWDRF6b/23
         iAkChnhwFiJRDYlrZdld42MNot2wtrrVEB3b9HTm0miuhP7qbAT67xZyBgFc76o4UAmu
         4MWw==
X-Gm-Message-State: AOUpUlG2w8Ves/++syqKW4Mfew6L2FQBukoSluapA9+kewGlC/3YSilA
        pWAV66embesYP/kEWgGVoxlUJg==
X-Google-Smtp-Source: AA+uWPwOe1P0/YjRM2N+7hPT/iKK6+HDLx69KXj8zv1Lbx0QyqYYN7fXHhSARwFdj/JYx8EYh4j3jA==
X-Received: by 2002:a63:ff21:: with SMTP id k33-v6mr8357019pgi.38.1533951317037;
        Fri, 10 Aug 2018 18:35:17 -0700 (PDT)
Received: from ubuntu.localdomain ([45.56.155.48])
        by smtp.gmail.com with ESMTPSA id d22-v6sm21722373pfk.69.2018.08.10.18.35.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Aug 2018 18:35:16 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        broonie@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] serial: sprd: Remove unnecessary resource validation
Date:   Fri, 10 Aug 2018 18:34:25 -0700
Message-Id: <b48edead2c6abb862b121d347b01bf07dec818ea.1533950271.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <50e1f7f4673bff9d71936b4eb34cbf2571b0fda9.1533950271.git.baolin.wang@linaro.org>
References: <50e1f7f4673bff9d71936b4eb34cbf2571b0fda9.1533950271.git.baolin.wang@linaro.org>
In-Reply-To: <50e1f7f4673bff9d71936b4eb34cbf2571b0fda9.1533950271.git.baolin.wang@linaro.org>
References: <50e1f7f4673bff9d71936b4eb34cbf2571b0fda9.1533950271.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_ioremap_resource() will valid the resources, thus remove the
unnecessary resource validation in the driver.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/tty/serial/sprd_serial.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index e18d8af..03b0cd4 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -710,15 +710,12 @@ static int sprd_probe(struct platform_device *pdev)
 		up->uartclk = clk_get_rate(clk);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "not provide mem resource\n");
-		return -ENODEV;
-	}
-	up->mapbase = res->start;
 	up->membase = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(up->membase))
 		return PTR_ERR(up->membase);
 
+	up->mapbase = res->start;
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "not provide irq resource: %d\n", irq);
-- 
1.9.1

