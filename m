Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872C1C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C85A2086E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A6Qbu09j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C85A2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390251AbeIUT3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:29:44 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41443 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbeIUT3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:29:43 -0400
Received: by mail-io1-f65.google.com with SMTP id q4-v6so12225059iob.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 06:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cXmp87CurS0y2IxorCWvR9CIJ3TsSUwOh7LASSZh2R4=;
        b=A6Qbu09jzFs1MEjA+D99lpA9jHfb3Ii9YTjxpQCQv0amqSqER0FOlP2j52W1vuXOK/
         BsxOhQRoqMcEHPwJ8tFQG6VBzipg5+uHfen3j9KVB50tNDZ6q7PInYzCYxMIeEmjGcjI
         bKdM/1mxj0q0PTxrtEK1JP43vsQS2MXRsceK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cXmp87CurS0y2IxorCWvR9CIJ3TsSUwOh7LASSZh2R4=;
        b=h5iR7jOR6UCjPIwPBDzwk+BCzDdw2NOgLPGuSkZbUKDay0mqig69Z/PcIsIs54DR3t
         QdjqkrkRU/mqE/cvLsNWDOnSqyQ/Y1eS9rzqcbXjD1+do9+eJwDFROTpzTbFNjMtz57n
         el8ZHMkN4Rexj3UTZ2PwENVPv4orut04hnCtGGvRmB3SJNgFM7V7gJTq3fJiv1vZlh89
         nz5fBT7YFTNfr8dRDLFCJ0BPbtRe2uF6QXZcrYMh3R/X/CAC8oXNxDs74udC0po72Uzk
         thcMVeP2cpf4sc8NhGe+WvdcV/wvlMFaVmHcLBEBCKgPftADRk9mmlia/KeNT+EMRrPi
         jhfw==
X-Gm-Message-State: APzg51AG7QMrtlzvSP6apdSyIvX1mGICqn4fw8NBRaapnxTlFhIot8mF
        guNPHbgZC0o5TQXHWwrwAqly4g==
X-Google-Smtp-Source: ANB0VdYLn8fLu/6TH0xmItYzeGJyM8CJr1ooHrH/arPMY16vmnFsHZ4Uy7AY4xFisN7nIuBacR01qA==
X-Received: by 2002:a6b:9895:: with SMTP id a143-v6mr38774602ioe.290.1537537248231;
        Fri, 21 Sep 2018 06:40:48 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id c12-v6sm9896298ioq.81.2018.09.21.06.40.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 06:40:47 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 12/26] nvmem: mxs-ocotp: use devm_nvmem_register()
Date:   Fri, 21 Sep 2018 06:40:12 -0700
Message-Id: <20180921134026.4596-13-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
References: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the resource managed variant of nvmem_register();

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/mxs-ocotp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/mxs-ocotp.c b/drivers/nvmem/mxs-ocotp.c
index 7018e2ef5714..53122f59c4b2 100644
--- a/drivers/nvmem/mxs-ocotp.c
+++ b/drivers/nvmem/mxs-ocotp.c
@@ -177,7 +177,7 @@ static int mxs_ocotp_probe(struct platform_device *pdev)
 	ocotp_config.size = data->size;
 	ocotp_config.priv = otp;
 	ocotp_config.dev = dev;
-	otp->nvmem = nvmem_register(&ocotp_config);
+	otp->nvmem = devm_nvmem_register(dev, &ocotp_config);
 	if (IS_ERR(otp->nvmem)) {
 		ret = PTR_ERR(otp->nvmem);
 		goto err_clk;
@@ -199,7 +199,7 @@ static int mxs_ocotp_remove(struct platform_device *pdev)
 
 	clk_unprepare(otp->clk);
 
-	return nvmem_unregister(otp->nvmem);
+	return 0;
 }
 
 static struct platform_driver mxs_ocotp_driver = {
-- 
2.19.0

