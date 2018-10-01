Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D254C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2425208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A1zHBEPU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2425208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbeJBDX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 23:23:29 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42561 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeJBDX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 23:23:29 -0400
Received: by mail-lf1-f65.google.com with SMTP id s10-v6so3464930lfc.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 13:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=EHFETooOOGtFpaMIHZraXZ0xb8qb6oEsreigPOIAUlo=;
        b=A1zHBEPUigJbpoAVLzyYohO3KMymc+YuNjwwPeD1uDcrbYjwaqqsNVDzPj8FjyDC/Y
         9tMrY/PDnOGKoYFOofAC1F37CcQj09MupEuR8U2CM5CGPD/AkajyWnntRoCgB3foZxAa
         kGlsTPhZR2iqhLFjEO7ldi+jXUg+d/lmu8PcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EHFETooOOGtFpaMIHZraXZ0xb8qb6oEsreigPOIAUlo=;
        b=d/Qmex0l3voLHb+hsZx4R2vMsZyaJfs9INZKL89zlofFgbrMESaoM4xqiINhXUQmcQ
         7ZvLQykprBQxFhdYAA67XhJrSecND893oYcl2TrZbgXOHBd6P3Q7Lt8a2HHtuLwXeOjb
         zQEmPBUqu8c2c5gwOHrP18Agslrh84hO6Y2MeHGKmyj8DEKRm2VL5KPPDW3JnE07AUMr
         Ien57hDkPg6tzC7p7q6nbhiKi1QmPNu19MpygMCB9s5CQGdbIzXgnSRtxtaB998wL5ub
         Bev+mp+bb6CFynQ3b5k2ahxd0pKuoQmurGJV5eFwWXIiov/Mgot5VyQqhaMLijwOsQfd
         1pNA==
X-Gm-Message-State: ABuFfogyI11QHdGPVDui7V8eAMCesf4/8/ftMlJ8yJHYHXlEhvAa2voo
        Ad/L2DOU+maOjX2VNPormFt15A==
X-Google-Smtp-Source: ACcGV606z4WEXgShMFON05nA63AWcEXZQJvVD/hzvk0//Fh1G+T7cJC+tub+p6oKaOYMSu+YyEEmqA==
X-Received: by 2002:a19:2a8c:: with SMTP id q12-v6mr6314314lfq.95.1538426631965;
        Mon, 01 Oct 2018 13:43:51 -0700 (PDT)
Received: from localhost.bredbandsbolaget (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
        by smtp.gmail.com with ESMTPSA id b132-v6sm2777655lfe.56.2018.10.01.13.43.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 13:43:49 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] regulator: fixed: Default enable high on DT regulators
Date:   Mon,  1 Oct 2018 22:43:46 +0200
Message-Id: <20181001204346.4655-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit efdfeb079cc3
("regulator: fixed: Convert to use GPIO descriptor only")
switched to use gpiod_get() to look up the regulator from the
gpiolib core whether that is device tree or boardfile.

This meant that we activate the code in
a603a2b8d86e ("gpio: of: Add special quirk to parse regulator flags")
which means the descriptors coming from the device tree already
have the right inversion and open drain semantics set up from
the gpiolib core.

As the fixed regulator was inspected again we got the
inverted inversion and things broke.

Fix it by ignoring the config in the device tree for now: the
later patches in the series will push all inversion handling
over to the gpiolib core and set it up properly in the
boardfiles for legacy devices, but I did not finish that
for this kernel cycle.

Fixes: commit efdfeb079cc3 ("regulator: fixed: Convert to use GPIO descriptor only")
Reported-by: Leonard Crestez <leonard.crestez@nxp.com>
Reported-by: Fabio Estevam <festevam@gmail.com>
Reported-by: John Stultz <john.stultz@linaro.org>
Reported-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/regulator/fixed.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index 1142f195529b..7d639ad953b6 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -79,9 +79,14 @@ of_get_fixed_voltage_config(struct device *dev,
 
 	of_property_read_u32(np, "startup-delay-us", &config->startup_delay);
 
-	config->enable_high = of_property_read_bool(np, "enable-active-high");
-	config->gpio_is_open_drain = of_property_read_bool(np,
-							   "gpio-open-drain");
+	/*
+	 * FIXME: we pulled active low/high and open drain handling into
+	 * gpiolib so it will be handled there. Delete this in the second
+	 * step when we also remove the custom inversion handling for all
+	 * legacy boardfiles.
+	 */
+	config->enable_high = 1;
+	config->gpio_is_open_drain = 0;
 
 	if (of_find_property(np, "vin-supply", NULL))
 		config->input_supply = "vin";
-- 
2.17.1

