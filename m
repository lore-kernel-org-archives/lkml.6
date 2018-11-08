Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226C2C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE38B20844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRo8LlMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE38B20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbeKIHht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:37:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:56520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730429AbeKIHhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:37:48 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 398C9208E3;
        Thu,  8 Nov 2018 22:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714419;
        bh=2UB67ox6gxwUH6NKKEoSQPAKnt5QF/kRQV2bUtVlYlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KRo8LlMbyquYLS6zECoxucbcZ+BiwpI5r4a2p3NuGYMXJOm7dRzJqGW0IGHBqu/td
         yrryyYUqd+K6ogm58ELgkA/hkDOfH0oKy4jBFllTVBlvzSHsWkbs6Pniiy67gFXVw6
         JvzvbQ7G1e/oatT40TzL+uxlhB7NdD2gJ8RCrWSM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 043/114] ASoC: wm8940: Enable cache usage to fix crashes on resume
Date:   Thu,  8 Nov 2018 13:50:58 -0800
Message-Id: <20181108215105.027594568@linuxfoundation.org>
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



