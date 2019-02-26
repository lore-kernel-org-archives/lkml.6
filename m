Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF43BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 05:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E7172147C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 05:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="fjD5MDrV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfBZFwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 00:52:47 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36862 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfBZFwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 00:52:46 -0500
Received: by mail-pg1-f195.google.com with SMTP id r124so5670506pgr.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 21:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zj98awOVyEzRCTMyfdfQgxPQRaXSdb4ofKohfF6+sBI=;
        b=fjD5MDrVZ3nCF+5GCCC5oIVn/z7zJIyV+ef/i4EVBvtkdMUM9s/OP9zVWHKoqI+399
         q5ieUqiRy7bUy1Al0yUDri86y1Cman4NgkTk/71yA5Q37QUfb5WM0sXwpr4ctW21fURq
         vH6hvRZ97jpINX0o44QtJLSb8NuC9S3a1kf9zI/1bUL57ZrD9p11ecAAOBxvZ/wgEdRD
         A3IDxgkJLRKXieQocSOjXDWurEMmnecumdxeoC1lkfScnCjs6CkXNN8ceTPTE/yK1Jxj
         S/U5j+zQF8A86ZjOmXM6kJpwDf2rkF5/XSQ5cfo7twT4xikxPa7b5ovE6O3Q77rDxqjN
         OVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zj98awOVyEzRCTMyfdfQgxPQRaXSdb4ofKohfF6+sBI=;
        b=Inb0tZxuVntF+zy5Ovng498ubaW44xusKYlcT2uqiFA6GMl2eVvNe+zOnR+jGN7/4F
         mFJr1VKFct3qy85AnSSPx3uimdCfACAhS104T522yV2lP78jqMhq4nFzJRF00SbGQ7Nm
         q+5HpMAS+5nSJLtllTesbjFuJJT1ZDe1XlN4ovsL7Q/AW6LCnUeDNiqsvRPZFL7lUJQL
         eYDGnZUoOLnMydGf09xjjKK1evDnq1fHo/G1OTH96xpDSKYfxZunYIBcpqxNxDhvqwkS
         MkyGCCQA4Zp2/nxsgL1yRGJa0Zx9ezECMumOdc11jyopgIiQcn9hRY8J8e3v39EXS8pP
         1X5w==
X-Gm-Message-State: AHQUAuY0gITfyfkKrqUtYrxLyKTDrOpbF3HVx7TnUgD5Mnn1zvZ/sAvx
        b8c99WirTHA2hSqWGPZJc5AVWw==
X-Google-Smtp-Source: AHgI3IZdKegmDdnJSV7gXAzqMDLRWj60kR4I9UNvQlzKmLCT97sjZucRMpmPvYNGKiI6vtDfYKgoLA==
X-Received: by 2002:a65:4243:: with SMTP id d3mr5183980pgq.56.1551160364753;
        Mon, 25 Feb 2019 21:52:44 -0800 (PST)
Received: from localhost.localdomain (36-239-237-193.dynamic-ip.hinet.net. [36.239.237.193])
        by smtp.gmail.com with ESMTPSA id l79sm25061506pfb.102.2019.02.25.21.52.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 21:52:44 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: cpcap: Constify omap4_regulators and xoom_regulators
Date:   Tue, 26 Feb 2019 13:52:30 +0800
Message-Id: <20190226055230.25482-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190226055230.25482-1-axel.lin@ingics.com>
References: <20190226055230.25482-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They should never change, make them const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/cpcap-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/cpcap-regulator.c b/drivers/regulator/cpcap-regulator.c
index c15ced1b5968..e7dab5c4d1d1 100644
--- a/drivers/regulator/cpcap-regulator.c
+++ b/drivers/regulator/cpcap-regulator.c
@@ -334,7 +334,7 @@ static const unsigned int vaudio_val_tbl[] = { 0, 2775000, };
  * SW1 to SW4 and SW6 seems to be unused for mapphone. Note that VSIM and
  * VSIMCARD have a shared resource assignment bit.
  */
-static struct cpcap_regulator omap4_regulators[] = {
+static const struct cpcap_regulator omap4_regulators[] = {
 	CPCAP_REG(SW1, CPCAP_REG_S1C1, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_SW1_SEL, unknown_val_tbl,
 		  0, 0, 0, 0, 0),
@@ -410,7 +410,7 @@ static struct cpcap_regulator omap4_regulators[] = {
 	{ /* sentinel */ },
 };
 
-static struct cpcap_regulator xoom_regulators[] = {
+static const struct cpcap_regulator xoom_regulators[] = {
 	CPCAP_REG(SW1, CPCAP_REG_S1C1, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_SW1_SEL, unknown_val_tbl,
 		  0, 0, 0, 0, 0),
-- 
2.17.1

