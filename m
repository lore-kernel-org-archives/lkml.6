Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5977C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 14:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E992086B
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 14:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNQ1+1xI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E992086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbeKYA4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 19:56:01 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45435 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbeKYA4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 19:56:00 -0500
Received: by mail-pl1-f194.google.com with SMTP id a14so11777509plm.12;
        Sat, 24 Nov 2018 06:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=z+GeO1yKII1JBTU4yyaWadnrwV1C8JieV8R/c1/X7PE=;
        b=BNQ1+1xIHOAFZUTh1uxVPg3lT3qdKLIx+fA9b/we57DQW7tXEFdBOQvdWddJzyERmX
         /8l/nNJXQ1QI/EXyJ6oF5bAgEmbc8d+ugEf2dYAt3Z3o3g3xTReHjWIOy8/r/knSqPDw
         7/ug9bWnJi4btiTNHB3YS3PLbiifh9BtXAK/2nT072bbP3wD61RH8zXiftSt3X5XmWv7
         I3OPVh7pT1awrawEQfi/uIlkHm7L/pWF1levaZZy6PEOCUm97Z5FNzM8Q1/DPOdIU8nz
         wsCdNsZEQGIwQiYQ+2JZKy6DKqvx+0c5uS9Z7I4QHEd0zGtHCL0HUGwB7CEUx92W6gCM
         MFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=z+GeO1yKII1JBTU4yyaWadnrwV1C8JieV8R/c1/X7PE=;
        b=cF+AnhNDgcWMLZvhFxigV/00B/az3L8ETjnNHP48ECO9PuQ2MvbY0etEcWj4qDT1xG
         BfFekYpY2/LO2VfH5wGPC6qS49ac0vt9Tc6fvuvQg6fsO54V+rlcfIDgnhnzEA5/lv1U
         iRmSr2Kuy8CYlOCcQ9fRtbpS8nThxu753Vr/k6XBR280UgNbc7j0alDhob7ao/o1Z8Qp
         rdUchT204eGt3PVe5VbyowDVSE+Q+eJ0QYxSiEGY7meAECR3FywpgJO1YNEr5kXrAxus
         fQA8mXPhiOVkq5NaYyKDP59prebv7cQS8y/S3jvWIOARjZdH074Gq5BJ7gDRgK70Y3cj
         RJwQ==
X-Gm-Message-State: AA+aEWaFEVtzlS1wEYk34IHsaL+hrz03MnfLC515+HpXZWVENe+jVO8h
        uOhWSL6ou2mmqk8CTUlbd4M=
X-Google-Smtp-Source: AFSGD/UaYuzhkIN+z4AiAkQ9kKDJjTqsfDwKvm1qUiCWCQ6mnZjc9YVVtM0muOMSwDsCTuCOqhy0BQ==
X-Received: by 2002:a17:902:110a:: with SMTP id d10-v6mr20194488pla.85.1543068449938;
        Sat, 24 Nov 2018 06:07:29 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id e14-v6sm63069483pfn.46.2018.11.24.06.07.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 24 Nov 2018 06:07:28 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     robh@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
        digetx@gmail.com, linux-kernel@vger.kernel.org
Cc:     linux-tegra@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] memory: tegra: Convert to using %pOFn instead of device_node.name
Date:   Sat, 24 Nov 2018 09:07:25 -0500
Message-Id: <20181124140725.28593-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/memory/tegra/mc.c           |  6 +++---
 drivers/memory/tegra/tegra124-emc.c | 12 ++++++------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index bd25faf6d13d..24afc36833bf 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -345,7 +345,7 @@ static int load_one_timing(struct tegra_mc *mc,
 	err = of_property_read_u32(node, "clock-frequency", &tmp);
 	if (err) {
 		dev_err(mc->dev,
-			"timing %s: failed to read rate\n", node->name);
+			"timing %pOFn: failed to read rate\n", node);
 		return err;
 	}
 
@@ -360,8 +360,8 @@ static int load_one_timing(struct tegra_mc *mc,
 					 mc->soc->num_emem_regs);
 	if (err) {
 		dev_err(mc->dev,
-			"timing %s: failed to read EMEM configuration\n",
-			node->name);
+			"timing %pOFn: failed to read EMEM configuration\n",
+			node);
 		return err;
 	}
 
diff --git a/drivers/memory/tegra/tegra124-emc.c b/drivers/memory/tegra/tegra124-emc.c
index 392dc8dd481f..eedb7d48e2ea 100644
--- a/drivers/memory/tegra/tegra124-emc.c
+++ b/drivers/memory/tegra/tegra124-emc.c
@@ -888,8 +888,8 @@ static int load_one_timing_from_dt(struct tegra_emc *emc,
 
 	err = of_property_read_u32(node, "clock-frequency", &value);
 	if (err) {
-		dev_err(emc->dev, "timing %s: failed to read rate: %d\n",
-			node->name, err);
+		dev_err(emc->dev, "timing %pOFn: failed to read rate: %d\n",
+			node, err);
 		return err;
 	}
 
@@ -900,16 +900,16 @@ static int load_one_timing_from_dt(struct tegra_emc *emc,
 					 ARRAY_SIZE(timing->emc_burst_data));
 	if (err) {
 		dev_err(emc->dev,
-			"timing %s: failed to read emc burst data: %d\n",
-			node->name, err);
+			"timing %pOFn: failed to read emc burst data: %d\n",
+			node, err);
 		return err;
 	}
 
 #define EMC_READ_PROP(prop, dtprop) { \
 	err = of_property_read_u32(node, dtprop, &timing->prop); \
 	if (err) { \
-		dev_err(emc->dev, "timing %s: failed to read " #prop ": %d\n", \
-			node->name, err); \
+		dev_err(emc->dev, "timing %pOFn: failed to read " #prop ": %d\n", \
+			node, err); \
 		return err; \
 	} \
 }
-- 
2.17.0

