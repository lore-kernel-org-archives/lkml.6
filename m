Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BCEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5398221927
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550198112;
	bh=sLMiLbh8zwh/uj4cUVukNmd5vhgTbSsjTjwDskVCIjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i6DX5Rr0F0b5G2Q6fHpitQ2xSjt69/NPHEtmq5uZ/k6cavTkYFdfCBY9N0/rRW09a
	 vYN1RF8fcKmWgm8R4xpSe0nU0McbviNEd3iGPAfRi8rBA0x5etP4cHf6KOdd6WncOr
	 Dw3QqeEFoQqFydtdVWZZKTcYBH71x9DIPlNOAlGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732528AbfBOCfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:35:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:51534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390758AbfBOCL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:11:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA688222D0;
        Fri, 15 Feb 2019 02:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196689;
        bh=sLMiLbh8zwh/uj4cUVukNmd5vhgTbSsjTjwDskVCIjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eqiBmc90Afu6d+HC0eS2ENkG6p8t8goSQcD3TWj7IaMQ16eNF6UY9i32oPnVwtHWn
         HQd3nMWwHLL/R+dNxhopGR7vk1RSj9r6AzaKyLgt8ZQ++eu9vPc92xc8Lxpvrij7Gq
         cYzvGvtqHTIqxWSdNNaqBWdH7z7qcXk4hANesxDg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yizhuo <yzhai003@ucr.edu>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 04/65] ASoC: Variable "val" in function rt274_i2c_probe() could be uninitialized
Date:   Thu, 14 Feb 2019 21:10:20 -0500
Message-Id: <20190215021121.177674-4-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021121.177674-1-sashal@kernel.org>
References: <20190215021121.177674-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yizhuo <yzhai003@ucr.edu>

[ Upstream commit 8c3590de0a378c2449fc1aec127cc693632458e4 ]

Inside function rt274_i2c_probe(), if regmap_read() function
returns -EINVAL, then local variable "val" leaves uninitialized
but used in if statement. This is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt274.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt274.c b/sound/soc/codecs/rt274.c
index d88e67341083..18a931c25ca5 100644
--- a/sound/soc/codecs/rt274.c
+++ b/sound/soc/codecs/rt274.c
@@ -1126,8 +1126,11 @@ static int rt274_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	regmap_read(rt274->regmap,
+	ret = regmap_read(rt274->regmap,
 		RT274_GET_PARAM(AC_NODE_ROOT, AC_PAR_VENDOR_ID), &val);
+	if (ret)
+		return ret;
+
 	if (val != RT274_VENDOR_ID) {
 		dev_err(&i2c->dev,
 			"Device with ID register %#x is not rt274\n", val);
-- 
2.19.1

