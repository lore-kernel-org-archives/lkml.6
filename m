Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB92FECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689E920834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sc26p1ta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 689E920834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbeJYWuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:50:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727974AbeJYWup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:50:45 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 987232085B;
        Thu, 25 Oct 2018 14:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477068;
        bh=38fBg9Jy67SFicz4xTx2ApK2YUdL9sGNCTGMj2CNctM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sc26p1tav6T2D6qhiKq7xEuwHc1jo5kM+pGqiudZCI4vOXNkJz1OcyN9mtiylRuaO
         FCpSZb4FuxXXeJeA7Nqn6FBZQJOTwjsrmD2o5pmOKTNCusM8MQlst1yFFwrjZJEc1n
         oD/OJnYj+rENreK/Bwe0Ov97pfAWjvKfAC7SV5tE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 24/65] ASoC: ak4613: Enable cache usage to fix crashes on resume
Date:   Thu, 25 Oct 2018 10:16:24 -0400
Message-Id: <20181025141705.213937-24-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141705.213937-1-sashal@kernel.org>
References: <20181025141705.213937-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

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

