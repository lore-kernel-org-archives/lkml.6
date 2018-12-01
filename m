Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADA5C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655CC21473
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jy+uxs7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 655CC21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeLBDFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 22:05:53 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:47052 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbeLBDFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 22:05:53 -0500
Received: by mail-lf1-f65.google.com with SMTP id f23so6180413lfc.13
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 07:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KuQK+AP+PaPYL/ufObO2FE/V1xtOKXFXPeo5PNTs1lY=;
        b=jy+uxs7eTVMvE8JiKgruxMZtERO9vRBBRI5luHO8adGQ3Vq8vqADvUuT3M7TjhaKqo
         Xh0qcfFvcs1SC7aAB1bWlZoz9mwboFr88O5lEw/HKWE9xli1n3TQ/kSOBGaCFsEPSZ4S
         Gm2eggOXmba7hf8GMldqEEYWkY+LKl50Vl6qY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KuQK+AP+PaPYL/ufObO2FE/V1xtOKXFXPeo5PNTs1lY=;
        b=YuUZ//+8xOzgaN9H/9b6QNqNa5v5UdJRx2cOTbc7MVKqXZ0HO6r0j3YsFAiAamcsKT
         PbPjPHJLfgaytwza4B+50+Lo305zFhn2V49NuksUQ+/hOjpGCrU2l4wNv2HeENsjymSd
         XleB5OX3b7sdNtbYoASawYyatVvsP3lMFEJKBp3+OnJUS41LeHnWKeV8gF2qMAI+vfsL
         eP59FVeCipyvJbk1gC0No61OzW3RqtmarEtgcMM4Tgth44LDev9MKR/nkhBOQoBJZPL5
         5nVUt1ChmFpl1d/2FlRJK0Kha9tcqVtuuhyDlWTHkz9gri4rhZiyXSWhrrUEjEyYzQP+
         Blag==
X-Gm-Message-State: AA+aEWZ7n1t6FCbtC8z+9Q1HR0BrJHvDiB5QzBSxL5nfM1/W2yE9rRPD
        FkffViOJvbnnKM4bSvTX9l5BqQ==
X-Google-Smtp-Source: AFSGD/XXr1DAtfYiSR0A1VA1ELZXDF8Y6sOsQuaNr2bLoxvZ+nEN+w9bqk+nyZMRoi3Wgm7xF4weIg==
X-Received: by 2002:a19:ca51:: with SMTP id h17mr5524716lfj.126.1543679582797;
        Sat, 01 Dec 2018 07:53:02 -0800 (PST)
Received: from localhost.localdomain (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
        by smtp.gmail.com with ESMTPSA id 13-v6sm1365426ljj.49.2018.12.01.07.53.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 07:53:01 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 01/13 v2] regulator: core: Track dangling GPIO descriptors
Date:   Sat,  1 Dec 2018 16:41:39 +0100
Message-Id: <20181201154151.14890-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181201154151.14890-1-linus.walleij@linaro.org>
References: <20181201154151.14890-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a GPIO descriptor is passed to the regulator_register()
function inside the config->ena_gpiod callers must be
sure that once they call this API the regulator core
owns that descriptor and will make sure to issue
gpiod_put() on it, no matter whether the call is
successful or not.

For device tree regulators, the regulator core will
automatically set up regulator init data from the device
tree when registering a regulator by calling
regulator_of_get_init_data() which in turn calls down to
the regulator driver's .of_parse_cb() callback.
This callback (in drivers such as for max77686) may also
choose to fill in the config->ena_gpiod field with a GPIO
descriptor.

Harden the errorpath of regulator_register() to
properly gpiod_put() any passed in cfg->ena_gpiod
or any gpiod coming from the device tree on any type
of error.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- New patch, just numbering v2 to keep it in line with
  the patch set it came out of.
---
 drivers/regulator/core.c | 55 ++++++++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 757619878068..79cb090ff22f 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4868,21 +4868,33 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	struct regulator_config *config = NULL;
 	static atomic_t regulator_no = ATOMIC_INIT(-1);
 	struct regulator_dev *rdev;
+	bool dangling_cfg_gpiod = false;
+	bool dangling_of_gpiod = false;
 	struct device *dev;
 	int ret, i;
 
-	if (regulator_desc == NULL || cfg == NULL)
+	if (cfg == NULL)
 		return ERR_PTR(-EINVAL);
+	if (cfg->ena_gpiod)
+		dangling_cfg_gpiod = true;
+	if (regulator_desc == NULL) {
+		ret = -EINVAL;
+		goto rinse;
+	}
 
 	dev = cfg->dev;
 	WARN_ON(!dev);
 
-	if (regulator_desc->name == NULL || regulator_desc->ops == NULL)
-		return ERR_PTR(-EINVAL);
+	if (regulator_desc->name == NULL || regulator_desc->ops == NULL) {
+		ret = -EINVAL;
+		goto rinse;
+	}
 
 	if (regulator_desc->type != REGULATOR_VOLTAGE &&
-	    regulator_desc->type != REGULATOR_CURRENT)
-		return ERR_PTR(-EINVAL);
+	    regulator_desc->type != REGULATOR_CURRENT) {
+		ret = -EINVAL;
+		goto rinse;
+	}
 
 	/* Only one of each should be implemented */
 	WARN_ON(regulator_desc->ops->get_voltage &&
@@ -4893,16 +4905,20 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	/* If we're using selectors we must implement list_voltage. */
 	if (regulator_desc->ops->get_voltage_sel &&
 	    !regulator_desc->ops->list_voltage) {
-		return ERR_PTR(-EINVAL);
+		ret = -EINVAL;
+		goto rinse;
 	}
 	if (regulator_desc->ops->set_voltage_sel &&
 	    !regulator_desc->ops->list_voltage) {
-		return ERR_PTR(-EINVAL);
+		ret = -EINVAL;
+		goto rinse;
 	}
 
 	rdev = kzalloc(sizeof(struct regulator_dev), GFP_KERNEL);
-	if (rdev == NULL)
-		return ERR_PTR(-ENOMEM);
+	if (rdev == NULL) {
+		ret = -ENOMEM;
+		goto rinse;
+	}
 
 	/*
 	 * Duplicate the config so the driver could override it after
@@ -4911,11 +4927,22 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	config = kmemdup(cfg, sizeof(*cfg), GFP_KERNEL);
 	if (config == NULL) {
 		kfree(rdev);
-		return ERR_PTR(-ENOMEM);
+		ret = -ENOMEM;
+		goto rinse;
 	}
 
 	init_data = regulator_of_get_init_data(dev, regulator_desc, config,
 					       &rdev->dev.of_node);
+	/*
+	 * We need to keep track of any GPIO descriptor coming from the
+	 * device tree until we have handled it over to the core. If the
+	 * config that was passed in to this function DOES NOT contain
+	 * a descriptor, and the config after this call DOES contain
+	 * a descriptor, we definately got one from parsing the device
+	 * tree.
+	 */
+	if (!cfg->ena_gpiod && config->ena_gpiod)
+		dangling_of_gpiod = true;
 	if (!init_data) {
 		init_data = config->init_data;
 		rdev->dev.of_node = of_node_get(config->of_node);
@@ -4954,6 +4981,9 @@ regulator_register(const struct regulator_desc *regulator_desc,
 				 config->ena_gpio, ret);
 			goto clean;
 		}
+		/* The regulator core took over the GPIO descriptor */
+		dangling_cfg_gpiod = false;
+		dangling_of_gpiod = false;
 	}
 
 	/* register with sysfs */
@@ -5039,8 +5069,13 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	regulator_ena_gpio_free(rdev);
 	mutex_unlock(&regulator_list_mutex);
 clean:
+	if (dangling_of_gpiod)
+		gpiod_put(config->ena_gpiod);
 	kfree(rdev);
 	kfree(config);
+rinse:
+	if (dangling_cfg_gpiod)
+		gpiod_put(cfg->ena_gpiod);
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(regulator_register);
-- 
2.19.1

