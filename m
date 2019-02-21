Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFA8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBFDB2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="v6pa9hdq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbfBUPBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:01:24 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33239 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfBUPBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:01:23 -0500
Received: by mail-pl1-f196.google.com with SMTP id y10so14323916plp.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 07:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=XBbl9G0wKYWJ02w6fPGJ9yujxNEIldsmMC4LWlnnNB8=;
        b=v6pa9hdqHvW/yh6SBx8Kr8gnX83/s7fUUkUUomtL4+ML7oui2BZpFFZRKY07f/KX/3
         c8T27YHp8jlyaRk0KT3xbJXAunFIGNUWxQG+AefXDtB8hUMlYAfyQ8fjGDCcyMSk14wL
         G8ph1vk3G/Sn1uNZaaXL19Nls5tyH5oMKSiLGzBUgZTC2mhmaJ/Hq0DGNuM+p7clysFR
         IpdAY7woleDeVwcwprpGn7ZHgd+dslrkrdOslUKtu1NODnWKau462LtfzoHDssWDQ0/4
         JzXkXjSrT2XZBbO/6ngdI0gJh9I7m0jiaiG1IvfDZXhbxjpomniHngZL5B3yRzEjRghp
         WD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XBbl9G0wKYWJ02w6fPGJ9yujxNEIldsmMC4LWlnnNB8=;
        b=s0Mk+NNk34cu/VNqGURx4i7ZDtsPl/ZxjaR8C4ryQ7jTIPW/IR8gZqbkH+95GUbfPj
         mE8e3c0PlpFHEGC11XFR2u7iDthaZBrJaWGKz7sjjKQxRbkoddCBJBooIBqVOV8svzDt
         TrX497gf36ujFureMZhAwz3y+GbxCMN+l8Iq43f6ULYbmcbVWZnxaeojU8eJ8J9gdYgR
         MXGIJDXU6mH02bzaCHMlXkkz5aMH+Wh3tKZc9fVS+yWJHO+IEhI1Gk+h7fvTGo3C40Bm
         AQlW9mZGBlHpqOTMgK3Uvgmkhee8j+tB8NY6tUy2X1YDIBGGOwBptFKA0Nm5wfEPpzfL
         MjGQ==
X-Gm-Message-State: AHQUAuZTym5ftLjoK3XkZIE97mu7yFeqTnR7+Vy6+mUL0qonhHj6jJEP
        uBrrIr0U3bfbJRDVcKdNGZu8fIZ2wzEh5A==
X-Google-Smtp-Source: AHgI3IYC1OWZ1tNMIduBL6euShyuS9ay/P0P0/MrnUsnVT+/4dhfskuCweBgawDeUKycYBpdTRAzmQ==
X-Received: by 2002:a17:902:bc89:: with SMTP id bb9mr43214389plb.212.1550761282910;
        Thu, 21 Feb 2019 07:01:22 -0800 (PST)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id 22sm52976584pfk.53.2019.02.21.07.01.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 07:01:21 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: lp873x: Constify lp873x_buck_ramp_delay array
Date:   Thu, 21 Feb 2019 23:01:11 +0800
Message-Id: <20190221150111.25684-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lp873x_buck_ramp_delay should never change, make it const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/lp873x-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/lp873x-regulator.c b/drivers/regulator/lp873x-regulator.c
index 2ec5e833c379..70651fec8fd9 100644
--- a/drivers/regulator/lp873x-regulator.c
+++ b/drivers/regulator/lp873x-regulator.c
@@ -61,7 +61,7 @@ static const struct regulator_linear_range ldo0_ldo1_ranges[] = {
 	REGULATOR_LINEAR_RANGE(800000, 0x0, 0x19, 100000),
 };
 
-static unsigned int lp873x_buck_ramp_delay[] = {
+static const unsigned int lp873x_buck_ramp_delay[] = {
 	30000, 15000, 10000, 7500, 3800, 1900, 940, 470
 };
 
-- 
2.17.1

