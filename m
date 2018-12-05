Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F54C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E592213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544039473;
	bh=U50Zq77ncGYcmYAhQDTC/XXZkhoHhCW+X2zYm2QWSaE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=1z1KxNr4fpo4itlAAl8q6KjBZdq8NE9Um705fsJa33o+udic1VB9iXQzKGRjHM0np
	 DExm8jhxTchso1xhxv42PnDJkZ8OA4XoDiI8cdLmNj0zkOBoSNd257N2PK2c54OfWG
	 lcdIDr41yyxbTdvpl4eVF9MVdvU5YWKeJF01K9bw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E592213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbeLETvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:51:11 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40308 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbeLETvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:51:07 -0500
Received: by mail-ot1-f66.google.com with SMTP id s5so19787833oth.7;
        Wed, 05 Dec 2018 11:51:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UoMXli4wLudycVk090xGqvFRiOpNcp3Ts+CNJQ3TMZ0=;
        b=W3iCR7/ZLJyxJ+nSWnOl2b/a4o/rai2OMivnr8AHSn5J6/TJe2yHEspmHuyt95DQJb
         wbPXptzRmkrjfJB8y3cBErFnN+tZc+I8hYnx0suVkpWl4rqSlt15jrl/ulxqcGvaZlBX
         8yXt/xXofi1h+AqXYR0l6BrCEAT+fEJa1qBXR54oBhK7Sw2yu/ZglHKoGogc8DKPXlcL
         ySL+aGPs3etTKMkMzb3RKCQH9RDDAi9AykEpq4J3lbjYaQ1L+O3FeKpTVLrBtiWrEx2f
         bZABctRjS6v5lDeLSkbNGxqrENPlZuruvbifMKXF0DVgWKlrJoKdgp2/m4w5Le6bpiCn
         L0HQ==
X-Gm-Message-State: AA+aEWZqPR8MFsgGuGB9oWUYkjgGCGUtbIalB6x1RYnPVglkHKu4jweP
        SeFAH2f0nR5qwwP+jMUgDlNfc2g=
X-Google-Smtp-Source: AFSGD/WiOsRw7ejsnrYzRVAIvTMM6woq+fAdokQVWg5e3ogdICci58PAAQ2ObfgHfkO6+rYKhmlSow==
X-Received: by 2002:a9d:72a:: with SMTP id 39mr17624814ote.134.1544039466351;
        Wed, 05 Dec 2018 11:51:06 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.51.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 11:51:05 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>,
        linux-omap@vger.kernel.org
Subject: [PATCH] memory: omap-gpmc: Use of_node_name_eq for node name comparisons
Date:   Wed,  5 Dec 2018 13:50:30 -0600
Message-Id: <20181205195050.4759-14-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

For instances using of_node_cmp, this has the side effect of now using
case sensitive comparisons. This should not matter for any FDT based
system which this is.

Cc: Roger Quadros <rogerq@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/memory/omap-gpmc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 8abb9e94916a..ab5925c6d012 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -2060,7 +2060,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 	 * timings.
 	 */
 	name = gpmc_cs_get_name(cs);
-	if (name && of_node_cmp(child->name, name) == 0)
+	if (name && of_node_name_eq(child, name))
 		goto no_timings;
 
 	ret = gpmc_cs_request(cs, resource_size(&res), &base);
@@ -2068,7 +2068,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 		dev_err(&pdev->dev, "cannot request GPMC CS %d\n", cs);
 		return ret;
 	}
-	gpmc_cs_set_name(cs, child->name);
+	gpmc_cs_set_name(cs, child->full_name);
 
 	gpmc_read_settings_dt(child, &gpmc_s);
 	gpmc_read_timings_dt(child, &gpmc_t);
@@ -2113,7 +2113,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 		goto err;
 	}
 
-	if (of_node_cmp(child->name, "nand") == 0) {
+	if (of_node_name_eq(child, "nand")) {
 		/* Warn about older DT blobs with no compatible property */
 		if (!of_property_read_bool(child, "compatible")) {
 			dev_warn(&pdev->dev,
@@ -2123,7 +2123,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 		}
 	}
 
-	if (of_node_cmp(child->name, "onenand") == 0) {
+	if (of_node_name_eq(child, "onenand")) {
 		/* Warn about older DT blobs with no compatible property */
 		if (!of_property_read_bool(child, "compatible")) {
 			dev_warn(&pdev->dev,
-- 
2.19.1

