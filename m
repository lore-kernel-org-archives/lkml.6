Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045E7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1959223D8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VJXf+H8j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1959223D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbeKLUp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:45:59 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36497 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729212AbeKLUp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 15:45:58 -0500
Received: by mail-pg1-f196.google.com with SMTP id z17-v6so3916123pgv.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 02:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=FwjO0MD8IjFvB0k6XnXwl4d6sfbxSCkhEER4jXSCxHs=;
        b=VJXf+H8jSteGTRTA3h1R6PCMsuMqpxwracH6HnMorGhA7ANZROK/7P0lQr5KXQlAmC
         nUpKF6EzXeTfLXCkD2rMAeirWVg5Deujwh4csS4URC12mu9yRWakMkSJbYVo7y4bik4G
         jXVyLvEskXCkNYENtjk6RuzoTWx8Rd14vshG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=FwjO0MD8IjFvB0k6XnXwl4d6sfbxSCkhEER4jXSCxHs=;
        b=VnWM2bsHpdMuJQSXO5jjp0TxTOwWvoTtHCPdL+KctyOshSsR6k1NlL1sgxeffzDZUb
         x8gp9ChLW/lDrpQ5Qvo3mLo7n3jymeec7nUmbGsfCo1yPf7B5XIvyNV4/SFQH13Egp4R
         P80zGX8EICbTX8lGe7xYt7K4EY3iPYutzpSdWCyY26ylWFSLg5PRI1DvyDbULjxtTrm0
         vxJtR/tWOJhkEwnfPgUBPZ711MPG0yH2aeAxy49MtMTvFU7cKT1k800konD5MgEybVfZ
         YMrRJgsVlROryj4CbvsOV/8ylNThQNZRd/5cG9IRFZf/6iL9UMsj4gll9UfO6B/C1FW1
         3jnQ==
X-Gm-Message-State: AGRZ1gJ5RVTglyJhh/VuA4f/v1ekxxOwwFyzRiAyCJ+ChdnD4EC0IMTN
        ksTQhFLjCQlWLby+FQcMQ589XGBOp2GXLkPT
X-Google-Smtp-Source: AJdET5e7ViAl/kTVAsa2ImwcosG9aOkE3Gme8rhQ4rEaAT19JPeIkydmx2wcpL1lnwa14DymwfpKEw==
X-Received: by 2002:a63:1a4b:: with SMTP id a11mr404110pgm.254.1542019995522;
        Mon, 12 Nov 2018 02:53:15 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 186-v6sm17545705pfe.39.2018.11.12.02.53.12
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 02:53:14 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuanjiang.yu@unisoc.com, baolin.wang@linaro.org, broonie@kernel.org
Subject: [PATCH 4/4] power: supply: sc2731_charger: Free battery information
Date:   Mon, 12 Nov 2018 18:52:38 +0800
Message-Id: <ac427c3cca2cc783a82a3d8d62270c1ed139e8c4.1542019800.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <5d096dec07f6808a70edcfaad6e8f77039f21a9b.1542019800.git.baolin.wang@linaro.org>
References: <5d096dec07f6808a70edcfaad6e8f77039f21a9b.1542019800.git.baolin.wang@linaro.org>
In-Reply-To: <5d096dec07f6808a70edcfaad6e8f77039f21a9b.1542019800.git.baolin.wang@linaro.org>
References: <5d096dec07f6808a70edcfaad6e8f77039f21a9b.1542019800.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free battery information in case of adding battery OCV tables.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/sc2731_charger.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/supply/sc2731_charger.c b/drivers/power/supply/sc2731_charger.c
index 49b3f0c..335cb85 100644
--- a/drivers/power/supply/sc2731_charger.c
+++ b/drivers/power/supply/sc2731_charger.c
@@ -408,6 +408,8 @@ static int sc2731_charger_hw_init(struct sc2731_charger_info *info)
 			vol_val = (term_voltage - 4200) / 100;
 		else
 			vol_val = 0;
+
+		power_supply_put_battery_info(info->psy_usb, &bat_info);
 	}
 
 	/* Set charge termination current */
-- 
1.7.9.5

