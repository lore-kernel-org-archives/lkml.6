Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDA4ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982BD2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vM6i7w80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 982BD2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbeJYWus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:50:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727974AbeJYWur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:50:47 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F25FA20868;
        Thu, 25 Oct 2018 14:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477070;
        bh=oXrGIfYtdEl6nA458pfPl32TW/ynkWjO/pxpeebFqqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vM6i7w80SbzQ8pYxxsdHvOMskly7I47y2shBdTKDNkdPSXo4oZ4a/mxJgQY2syBT1
         aiSyXfwc4J96o8Px+89JKQJcdbXpMNlojOande/lPk21Sc1HJBj57H1fpy9sf8c6KE
         fPmQdh6eIupm8QY7N06kzq8CYTmg7DBfgLRO8xdU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 25/65] ASoC: wm8940: Enable cache usage to fix crashes on resume
Date:   Thu, 25 Oct 2018 10:16:25 -0400
Message-Id: <20181025141705.213937-25-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141705.213937-1-sashal@kernel.org>
References: <20181025141705.213937-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 50c7a0ef2d97e56c7ce2f1ea5fe1d8e25aadc1bb ]

The wm8940 driver is using a regmap cache sync to restore the
configuration of the chip when switching from OFF to STANDBY, but does
not actually define a register cache which means that the restore is
never going to work and we trigger asserts in regmap.  Fix this by
enabling caching.

Based on commit d3030d11961a8c10 ("ASoC: ak4642: Enable cache usage to
fix crashes on resume") by Mark Brown <broonie@kernel.org>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm8940.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index f6f9395ea38e..1c600819f768 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -743,6 +743,7 @@ static const struct regmap_config wm8940_regmap = {
 	.max_register = WM8940_MONOMIX,
 	.reg_defaults = wm8940_reg_defaults,
 	.num_reg_defaults = ARRAY_SIZE(wm8940_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
 
 	.readable_reg = wm8940_readable_register,
 	.volatile_reg = wm8940_volatile_register,
-- 
2.17.1

