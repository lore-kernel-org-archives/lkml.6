Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6FDC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1502086C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="H0R6Lj3x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfBHMnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:43:08 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45942 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfBHMnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:43:07 -0500
Received: by mail-pf1-f195.google.com with SMTP id j3so1607996pfi.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 04:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=5f91YQKwd491u0t4eWDPDSWvFMrnMjzA+UDQPHXk908=;
        b=H0R6Lj3xGtUZCt3Z8XQD+K0yZfvR88Jihs9VzmYAS5Dl+FmqsRVtgE+MA2Y5IPJAEp
         DAHCA5ENqMVZi1/nkx7VRz505YQWuH+hyCJNJ5z/vcF25xotJOT6rO4YTKfms2G8+mZ5
         q4paupamGpzYyaB6x7vKGTYYqX1d5Er0IN4I+jJeFBQ8nR9k1x9Rgb6MBrc7IIyhf98+
         A2vf8oAXR3sdMY7nT9CRfglb1bKlDuSKYd5kGsiBHL2EiwdCxV2CKiSjAkBY2vZB29Ml
         3oFzr7la2Erz8swZM/rZ5oOhehtO2m+LossIBqZu10SUGe3//gAe7Z6WOoTCQ4mcj3hn
         nF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5f91YQKwd491u0t4eWDPDSWvFMrnMjzA+UDQPHXk908=;
        b=X3SKnQuq4y58QTC9TV7os3IwNb72hSrEwvtNRM1+PfcHgpw1KNn8SuVsBwFOkPxLwg
         uZu9q6KA+wED8NbYTFffZItTUEAKiNIExg/cww8UjQXfof51rU9eQF+YvBShPkWroTov
         OsDoH2onDq/Jrs6loKibSJGZOq7Y0z1ou0B/xLqtSmbya4vAWJtDVZLvDe9chff/dpxD
         BTaosqxdOaENe4OpSUh/e7BIXYv7e5/qCIj6s8eJnzx9GMEP9PB73aljKbtb7SS2UJ4a
         rKpgddIL+vLxEsLCixVg6Bs0YG+QMN9KTzsH7av1rafWiwvh/BAmLhopgaZPhLLlEgn8
         SKCw==
X-Gm-Message-State: AHQUAuaVtIUcmmxAN3+ujvB0mjuzoGG13ux8AzjN8s+D0PBlIvZArBNm
        Pm9A8YCqclPR9lpn9ZXtjuggSg==
X-Google-Smtp-Source: AHgI3IYAfbJqKIvn1xzB/kl93PLJyfXL8JqAO9J9wXA5SLZODWl7/FJIpMDQJaBvHnqjK8ECLJJYnQ==
X-Received: by 2002:a63:524c:: with SMTP id s12mr20160537pgl.437.1549629785668;
        Fri, 08 Feb 2019 04:43:05 -0800 (PST)
Received: from localhost.localdomain (36-239-237-75.dynamic-ip.hinet.net. [36.239.237.75])
        by smtp.gmail.com with ESMTPSA id m67sm4408121pfm.73.2019.02.08.04.43.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 04:43:04 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Beomho Seo <beomho.seo@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: rt5033: Constify rt5033_safe_ldo_ops and rt5033_buck_ops
Date:   Fri,  8 Feb 2019 20:42:47 +0800
Message-Id: <20190208124247.30746-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/rt5033-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/rt5033-regulator.c b/drivers/regulator/rt5033-regulator.c
index 96d2c18e051a..639cbadc044a 100644
--- a/drivers/regulator/rt5033-regulator.c
+++ b/drivers/regulator/rt5033-regulator.c
@@ -16,14 +16,14 @@
 #include <linux/mfd/rt5033-private.h>
 #include <linux/regulator/of_regulator.h>
 
-static struct regulator_ops rt5033_safe_ldo_ops = {
+static const struct regulator_ops rt5033_safe_ldo_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
 	.list_voltage		= regulator_list_voltage_linear,
 };
 
-static struct regulator_ops rt5033_buck_ops = {
+static const struct regulator_ops rt5033_buck_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
-- 
2.17.1

