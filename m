Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA5DC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44FAD222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uj3WpOac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404168AbfBMPFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:05:23 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36594 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfBMPFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:05:19 -0500
Received: by mail-wm1-f65.google.com with SMTP id j125so2784114wmj.1;
        Wed, 13 Feb 2019 07:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9PsBb1VPUEYxBAoixX4RuhtRIFTN7lSrrueDRvXF3tE=;
        b=uj3WpOacxzkSG8MLpIdVmB0Be2SWcUpRn1aMpOPSTAcXVUw59GCWAXR2Og+MFubMWs
         KUE0mGegVxIkWaViN2a55rRYpWY/BqcGqotQ2s/nMWNDB+J9T3p99YJfij2SQYku/LZl
         +z4CuspvbBKpVOGarM4tL0PMwR1jDLIq+Qv/zaxn1hCWk37SwtDkkCCoeI2CfOiEPygz
         7vuH963xwWCr4yhnKJT55/s6IhukjHKolN8Si3Mtr2jqDFh49L1LQFJhzs6pH9G84gVI
         0TAsijTU7OMkPsgEeSdQsgIRA6TLiF3yT6M9t+IWLdQRaHOZ5Dev26YtzPQhnAixmdWq
         2cKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9PsBb1VPUEYxBAoixX4RuhtRIFTN7lSrrueDRvXF3tE=;
        b=IsaRwf84ZbpwsTFBVX6k+qkE4rA8EPZjwudPWft3EcB0AdlEcMrO/dvKMZ5SwCZzqL
         PmfcQXAW0tnSMqEWfPUFxwZ/uxn/9C/rlKKoepsv9p01JeHGcajr0asvNd0+Jnhkxhli
         AQc/jFG6f2CAiXItHpKybrlbmMTlcNIGzngQDklGE8iJv0P0uVQA6nH1bQfoV5aiRe6H
         B5lcc41s1NO+28S7HGKC6CEZ3kg0McC+T7JVlLoxAuqu7lK44H4KZydXSED3OYgoufu7
         RG7GPyVIlseuEP8fIitnvAXEWF+LANI7V/QRjuRd2SkrupgO7b/imxCP/FYmVaTc//q3
         LaSQ==
X-Gm-Message-State: AHQUAuaNFH6TXCmAeA98/7n5oxfFF551pQ6Oolb4KpARAjt7VseYYtwc
        dq2x+IRLKTt+8jxsxxCcgzc=
X-Google-Smtp-Source: AHgI3Ib6Ukznc2W2muSuYK3Tzl0hKneFtH3d87RljxelnGDJ+YNMVpNe0YDOrxlH1RakZtXcgtxe2g==
X-Received: by 2002:a7b:c766:: with SMTP id x6mr665699wmk.15.1550070316938;
        Wed, 13 Feb 2019 07:05:16 -0800 (PST)
Received: from fuji.Parrot.Biz (smtp.parrot.biz. [62.23.167.188])
        by smtp.gmail.com with ESMTPSA id f187sm7533959wma.4.2019.02.13.07.05.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 07:05:15 -0800 (PST)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v2 3/3] pwm: hibvt: Add hi3559v100 support
Date:   Wed, 13 Feb 2019 16:05:08 +0100
Message-Id: <20190213150508.11499-3-m.othacehe@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213150508.11499-1-m.othacehe@gmail.com>
References: <20190213150508.11499-1-m.othacehe@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for hi3559v100-shub-pwm and hisilicon,hi3559v100-pwm
platforms. They require a special quirk: pwm has to be enabled again
to force duty_cycle refresh.

Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
---
 drivers/pwm/pwm-hibvt.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
index ffc803818c3c..b6a7942b3367 100644
--- a/drivers/pwm/pwm-hibvt.c
+++ b/drivers/pwm/pwm-hibvt.c
@@ -54,6 +54,7 @@ struct hibvt_pwm_chip {
 
 struct hibvt_pwm_soc {
 	u32 num_pwms;
+	bool quirk_force_enable;
 };
 
 static const struct hibvt_pwm_soc hi3516cv300_soc_info = {
@@ -64,6 +65,16 @@ static const struct hibvt_pwm_soc hi3519v100_soc_info = {
 	.num_pwms = 8,
 };
 
+static const struct hibvt_pwm_soc hi3559v100_shub_soc_info = {
+	.num_pwms = 8,
+	.quirk_force_enable = true,
+};
+
+static const struct hibvt_pwm_soc hi3559v100_soc_info = {
+	.num_pwms = 2,
+	.quirk_force_enable = true,
+};
+
 static inline struct hibvt_pwm_chip *to_hibvt_pwm_chip(struct pwm_chip *chip)
 {
 	return container_of(chip, struct hibvt_pwm_chip, chip);
@@ -152,13 +163,24 @@ static void hibvt_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 static int hibvt_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 				struct pwm_state *state)
 {
+	struct hibvt_pwm_chip *hi_pwm_chip = to_hibvt_pwm_chip(chip);
+
 	if (state->polarity != pwm->state.polarity)
 		hibvt_pwm_set_polarity(chip, pwm, state->polarity);
 
 	if (state->period != pwm->state.period ||
-		state->duty_cycle != pwm->state.duty_cycle)
+		state->duty_cycle != pwm->state.duty_cycle) {
 		hibvt_pwm_config(chip, pwm, state->duty_cycle, state->period);
 
+		/*
+		 * On those platforms, it is required to enable the
+		 * pwm again each time we want to refresh the duty
+		 * cycle.
+		 */
+		if (hi_pwm_chip->soc->quirk_force_enable && state->enabled)
+			hibvt_pwm_enable(chip, pwm);
+	}
+
 	if (state->enabled != pwm->state.enabled) {
 		if (state->enabled)
 			hibvt_pwm_enable(chip, pwm);
@@ -259,6 +281,10 @@ static const struct of_device_id hibvt_pwm_of_match[] = {
 	  .data = &hi3516cv300_soc_info },
 	{ .compatible = "hisilicon,hi3519v100-pwm",
 	  .data = &hi3519v100_soc_info },
+	{ .compatible = "hisilicon,hi3559v100-shub-pwm",
+	  .data = &hi3559v100_shub_soc_info },
+	{ .compatible = "hisilicon,hi3559v100-pwm",
+	  .data = &hi3559v100_soc_info },
 	{  }
 };
 MODULE_DEVICE_TABLE(of, hibvt_pwm_of_match);
-- 
2.17.1

