Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F4DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 397162089D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gTp6Rlk8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 397162089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389576AbeKPVOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 16:14:01 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40414 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389548AbeKPVOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 16:14:00 -0500
Received: by mail-pl1-f196.google.com with SMTP id b22-v6so5569956pls.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 03:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=L0xxyPjE8jBaIz9DC2r/ZKc+hYCfYlfYhlTPplJ8+20=;
        b=gTp6Rlk8HY7VLKjMhf6stj3PTnfOgE97FBcG62ZQAdB/Af8TqsQXH2pIH4adcwWGCB
         yBaeFJZl3fu+4VdwiydWoTWIaO2oIHnnsFEITi7b7QYr4ueIZhAfTdJgOFb6o5ZXDWgk
         ChlLSlhlxfKW+zj8fOS9RBOdsIEEzGtE552uI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=L0xxyPjE8jBaIz9DC2r/ZKc+hYCfYlfYhlTPplJ8+20=;
        b=InOh8GSs3V4jwJ1fXQXBciCkVz55M9DJwtyRR8a6GlcF+emhrHg2xYedcslZRPaC9B
         1bYiG33W8WP0Yyei7hDeN60gmyIWbTt2saWLsSXzaYMwQbn4/x8gnRBgvgqOavOKFLcN
         y4VrIiVAMNkaBCHbDBt19FjEuBcDS3ssWybok/mQOFO0IsPxUl7MeMDNFSy4aiUgzySG
         Lcm9RApZp3OZpdSrqedOqkh34VIeEQGRlAsosbCVS06M6fJ6ssMNmNUyjjSOhN/yaHEA
         4DLEXq3Pw+DELk4VKBYljXcbmDUgZvLtNl33sfIXbhSzyiKiXQgRxjgb+yX6Mrjin4tf
         u2/g==
X-Gm-Message-State: AGRZ1gIWqLtT3hA/fEUU2CEDVG9S2s86f3axj1XhEnRHyROOxCBZd20e
        hhGOy3n1qp71pjV6Sy1dOXS9Iw==
X-Google-Smtp-Source: AJdET5ecI8xeHd96IbsUVDWxyijJGYzDgELZQqV+WowqMjKAuSs6K/mwt37V3vFW8y4VYqqNIOrRxQ==
X-Received: by 2002:a17:902:be07:: with SMTP id r7-v6mr10284545pls.137.1542366129680;
        Fri, 16 Nov 2018 03:02:09 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 202sm21268106pfy.87.2018.11.16.03.02.05
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Nov 2018 03:02:08 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org,
        linus.walleij@linaro.org
Subject: [PATCH 4/6] power: supply: charger-manager: Make code more readable
Date:   Fri, 16 Nov 2018 19:01:11 +0800
Message-Id: <12b1b583c3da503be4ad7bed01e7b07a0a2b2126.1542362262.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
References: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
In-Reply-To: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
References: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make code more readable.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/charger-manager.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index a52bc77..dc0c9a6 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1520,19 +1520,19 @@ static struct charger_desc *of_cm_parse_desc(struct device *dev)
 	/* chargers */
 	of_property_read_u32(np, "cm-num-chargers", &num_chgs);
 	if (num_chgs) {
+		int i;
+
 		/* Allocate empty bin at the tail of array */
 		desc->psy_charger_stat = devm_kcalloc(dev,
 						      num_chgs + 1,
 						      sizeof(char *),
 						      GFP_KERNEL);
-		if (desc->psy_charger_stat) {
-			int i;
-			for (i = 0; i < num_chgs; i++)
-				of_property_read_string_index(np, "cm-chargers",
-						i, &desc->psy_charger_stat[i]);
-		} else {
+		if (!desc->psy_charger_stat)
 			return ERR_PTR(-ENOMEM);
-		}
+
+		for (i = 0; i < num_chgs; i++)
+			of_property_read_string_index(np, "cm-chargers",
+						      i, &desc->psy_charger_stat[i]);
 	}
 
 	of_property_read_string(np, "cm-fuel-gauge", &desc->psy_fuel_gauge);
-- 
1.7.9.5

