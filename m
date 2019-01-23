Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A3CC282C5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC5220870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="V1qHlobF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfAWOPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:15:55 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37153 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfAWOPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:15:53 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so2098058wmd.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 06:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7qysfTh5siwOfbKv1X9ginQ3UPSZFJeCzUUMvaoxNkY=;
        b=V1qHlobFyH0W19DrIw4NtoCcPhHkZE6Se59gihjX67LDovB5M23zUYK88eY4kylWBr
         wioAmbcVIidXbaaPmdPKsF1YHc4z+3qJ8PZdTmhRmc3FS65GjmkOS6n73CM9yviswWuS
         Epo6WVm7qFPFUC026hKDmVmd+eZYonk0baNrtgUPy25bxymuOek7DrVNkHC3JS0l+vmC
         lBIsGPNDO+Os5pr16IVd+I6Vdrxm+JxXij+uM8XvJUTgJYuZuEmcrdFlaKXKuzjCMuXR
         pfFovvvHZ7Bn5c6c/HFmKbPiqu0VWOFV4y65yfYAEy/rmnn1fiFkjuDda4Z1Gfx5evyP
         E93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7qysfTh5siwOfbKv1X9ginQ3UPSZFJeCzUUMvaoxNkY=;
        b=ZtNDsEeGueG6nTYunVyhqi05kAbKLkdJ4ayDSuvqK96X+tPMU7mf8bsEPgUbS8nw6X
         7JjxM65VmHQFxBEFmBf1XHGXnuJw7fYkVo3mz3NlXmU/u93RHpLOh6uUzTRogEiiVQLU
         f0XxiUToazCn76HnqcfUxK8hGxWFtIohrhrzxvn78JFxfTCD6z5TlOFhsp99r+dj6uPk
         tUJB7WevPycBjk9Uodb8Kl0vIQR+tnu1gpuqrsmxadygViwl2qD3OmFvFn2Ly1f4Z4b/
         684v2HZGdQI5JfU/QruJsYUYLzSroFvlSd5PghITiifb6qYlM1RzKOtfz9hefMptgFI1
         ++1g==
X-Gm-Message-State: AJcUuke2rA21UawfWItJZYhcAxvrL4Msstmh50gVf2VS9D3ilpWUHjm2
        KjrjuvTEJu+LDuMC6QTSSkzQBg==
X-Google-Smtp-Source: ALg8bN6UXBoh4tXqrK10S2G+XEmMgtbXbaLd8rrv++BsgqtuMr+Rr9xc7qAY7gJV/G3RUicH1X8IUg==
X-Received: by 2002:a7b:c24c:: with SMTP id b12mr2697326wmj.29.1548252951851;
        Wed, 23 Jan 2019 06:15:51 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a8sm29072997wme.23.2019.01.23.06.15.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 06:15:50 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 5/9] gpio: mockup: implement get_multiple()
Date:   Wed, 23 Jan 2019 15:15:34 +0100
Message-Id: <20190123141538.29408-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190123141538.29408-1-brgl@bgdev.pl>
References: <20190123141538.29408-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already support set_multiple(). Implement get_multiple() as well.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/gpio/gpio-mockup.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index b4c1de6acf74..1c945c967f60 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -102,6 +102,22 @@ static int gpio_mockup_get(struct gpio_chip *gc, unsigned int offset)
 	return val;
 }
 
+static int gpio_mockup_get_multiple(struct gpio_chip *gc,
+				    unsigned long *mask, unsigned long *bits)
+{
+	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
+	unsigned int bit, val;
+
+	mutex_lock(&chip->lock);
+	for_each_set_bit(bit, mask, gc->ngpio) {
+		val = __gpio_mockup_get(gc, bit);
+		__assign_bit(bit, bits, val);
+	}
+	mutex_unlock(&chip->lock);
+
+	return 0;
+}
+
 static void __gpio_mockup_set(struct gpio_chip *gc,
 			      unsigned int offset, int value)
 {
@@ -327,6 +343,7 @@ static int gpio_mockup_probe(struct platform_device *pdev)
 	gc->parent = dev;
 	gc->get = gpio_mockup_get;
 	gc->set = gpio_mockup_set;
+	gc->get_multiple = gpio_mockup_get_multiple;
 	gc->set_multiple = gpio_mockup_set_multiple;
 	gc->direction_output = gpio_mockup_dirout;
 	gc->direction_input = gpio_mockup_dirin;
-- 
2.19.1

