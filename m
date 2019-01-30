Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6F8C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFDF621473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="tfzDO/vi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730958AbfA3Nv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:51:29 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44521 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfA3Nv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:51:29 -0500
Received: by mail-pf1-f196.google.com with SMTP id u6so11418748pfh.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 05:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=E9rveGeT3VcQVVT8J5ghbFcoC0JALHLope38/fs3jAI=;
        b=tfzDO/visQXt4b8FAVHTOUBVWxV6EzUbJJYPmtQTynMPF0r8gpf8SbMCHjgP5EI+MR
         Bn7QMok0KpZspg1uJ4IMTgXX45AQjnfcuR0jQn+mcu/2Flss2exLsZh/OqWr25p/firO
         lrpIxddGBZPv9h0GsCZauTh4uwogQMT9wpzOx+aqvgjs68ipouwwRaC5BybpfjsXgoaf
         XgOpvVfhObkKkADUkCYURwDs6s5CskrGPcM4src0bt5ykqW0l8evxARRKmLDf+h3iaXK
         A9ODlWBbdGccCls+NCufk3+fXiq/mpLAACfxUFIg7EaXwHvpCX97+LAfqhlSiAreA9NV
         CYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=E9rveGeT3VcQVVT8J5ghbFcoC0JALHLope38/fs3jAI=;
        b=nudhsy/ZPqmdJnas+02ae9wCCvhFYyWfraAKnOYeUbuWLfrJ9AsRpq0qtR5k0goAvh
         NRwZBytrw8sUqQ2Q2cIK0jY6mTuz8NaXZ7+2ewYuH0caKHjwtP7+vohHzr5ri8kPRKo8
         d9h9GedHuNXo96BMlAzivJ4ZSwYAfQakENEuopwfZl3zAm2Sc3FrfmvsRFvVm9Vq46Qe
         8vpkwS+CevK2Ob+58UeoMzG1fU4CyOvCqVUxWtZYW8RFQDns5ohCZT+uk/wwBq0lTeT0
         toDFOzPvG+Ygidh5DMx32qgV9EzHrlQFZ8vx/YJYRi1RQ49m0RiBqmV8xeae4Wz25mg5
         GCZg==
X-Gm-Message-State: AJcUukeJXcP/UgYVvouKvUb2z95K7hSr791hSwgtJpzxznDbQkTjkvx7
        EaS4B3rM2EcAB7tl9WZSHN9cGg==
X-Google-Smtp-Source: ALg8bN7TBesfJ0b9Gd6wsaQD9fjEcIB+owfN1HkiZQzrR26gMRb0Gk6ULh/zCuTMVKgRk+38A4ZR8w==
X-Received: by 2002:a63:1408:: with SMTP id u8mr27807705pgl.271.1548856288292;
        Wed, 30 Jan 2019 05:51:28 -0800 (PST)
Received: from localhost.localdomain (36-239-242-165.dynamic-ip.hinet.net. [36.239.242.165])
        by smtp.gmail.com with ESMTPSA id f20sm2314338pfn.177.2019.01.30.05.51.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 05:51:27 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: max77620: Add missing .owner field in regulator_desc
Date:   Wed, 30 Jan 2019 21:50:55 +0800
Message-Id: <20190130135056.13535-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing .owner field in regulator_desc, which is used for refcounting.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/max77620-regulator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/max77620-regulator.c b/drivers/regulator/max77620-regulator.c
index cd93cf53e23c..1607ac673e44 100644
--- a/drivers/regulator/max77620-regulator.c
+++ b/drivers/regulator/max77620-regulator.c
@@ -690,6 +690,7 @@ static const struct regulator_ops max77620_regulator_ops = {
 			.active_discharge_mask = MAX77620_SD_CFG1_ADE_MASK, \
 			.active_discharge_reg = MAX77620_REG_##_id##_CFG, \
 			.type = REGULATOR_VOLTAGE,			\
+			.owner = THIS_MODULE,				\
 		},							\
 	}
 
@@ -721,6 +722,7 @@ static const struct regulator_ops max77620_regulator_ops = {
 			.active_discharge_mask = MAX77620_LDO_CFG2_ADE_MASK, \
 			.active_discharge_reg = MAX77620_REG_##_id##_CFG2, \
 			.type = REGULATOR_VOLTAGE,			\
+			.owner = THIS_MODULE,				\
 		},							\
 	}
 
-- 
2.17.1

