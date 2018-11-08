Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8652ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844B7208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ba7v2zVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844B7208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbeKIHht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:37:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:56494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730428AbeKIHhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:37:47 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 980B520892;
        Thu,  8 Nov 2018 22:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714418;
        bh=OWl9NWPu/6LlX6K1rVi8kHLF7o06ZcHului8Bk9MezI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ba7v2zVJJaCskwH7OyDbkql4okKS9sWmi21LxOYmxq5Dpbk2MWN/Q75mTm1BeMIX0
         9hlagzrmhOyfOVprcqhj0qR6Y5Pz8vPxgMaDh9dmTeo4lwidT6aaDk3miwxrBykWeZ
         OK1lpGk0LbfsdyOCLwidTs+FzxCSyOKEHTnIvCY4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 042/114] ASoC: ak4613: Enable cache usage to fix crashes on resume
Date:   Thu,  8 Nov 2018 13:50:57 -0800
Message-Id: <20181108215104.935906051@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit dcd2d1f78664fdc75eadaaf65257834e24383d01 ]

During system resume:

    kernel BUG at drivers/base/regmap/regcache.c:347!
    ...
    PC is at regcache_sync+0x1c/0x128
    LR is at ak4613_resume+0x28/0x34

The ak4613 driver is using a regmap cache sync to restore the
configuration of the chip on resume but does not actually define a
register cache which means that the resume is never going to work and we
trigger asserts in regmap.  Fix this by enabling caching.

Based on commit d3030d11961a8c10 ("ASoC: ak4642: Enable cache usage to
fix crashes on resume") by Mark Brown <broonie@kernel.org>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/ak4613.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/ak4613.c b/sound/soc/codecs/ak4613.c
index 07a266460ec3..b4b36cc92ffe 100644
--- a/sound/soc/codecs/ak4613.c
+++ b/sound/soc/codecs/ak4613.c
@@ -143,6 +143,7 @@ static const struct regmap_config ak4613_regmap_cfg = {
 	.max_register		= 0x16,
 	.reg_defaults		= ak4613_reg,
 	.num_reg_defaults	= ARRAY_SIZE(ak4613_reg),
+	.cache_type		= REGCACHE_RBTREE,
 };
 
 static const struct of_device_id ak4613_of_match[] = {
-- 
2.17.1



