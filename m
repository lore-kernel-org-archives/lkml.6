Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B28C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A6B20989
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675524;
	bh=EnXLy199du4IHhuxqf6xO94qbChrDPrkV0fGX5nQjZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K5EDtQY2XJjQMf9m9mxiJM7fED0bBp01Q8qG0dvcjda3xulHTJsnUq3UwFqgmNR9R
	 VKSBBxLCHEILfhcZ5IPfu0jl/OIvgL93JPfAOiDUmGC06h6S8WfH6MraxPY0q207XA
	 GqFZGoFg9p3KkyP3IeSvrMnEoZFchvB77e4ahJOA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90A6B20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbeLMEcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:32:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:44872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727978AbeLMEb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:31:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78E9720873;
        Thu, 13 Dec 2018 04:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675516;
        bh=EnXLy199du4IHhuxqf6xO94qbChrDPrkV0fGX5nQjZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZZkAVzcIiSbTZFxU0/Ix89PVQ9vo83DxWdSjMGI3KYlR22VKbFj6LHVkMXeRHj7mT
         l4z794CCVa/sfvDvVUuKHisXxhcWuvy2mBfsKC7xtAswxBbY6fIE/RYA9eX5T8GeEu
         pdoiYrIvSnus4Uz7Xmo0RtO/Le8qjO9hgy7n07OA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 38/41] i2c: uniphier: fix violation of tLOW requirement for Fast-mode
Date:   Wed, 12 Dec 2018 23:30:51 -0500
Message-Id: <20181213043054.75891-38-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043054.75891-1-sashal@kernel.org>
References: <20181213043054.75891-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit 8469636ab5d8c77645b953746c10fda6983a8830 ]

Currently, the clock duty is set as tLOW/tHIGH = 1/1. For Fast-mode,
tLOW is set to 1.25 us while the I2C spec requires tLOW >= 1.3 us.

tLOW/tHIGH = 5/4 would meet both Standard-mode and Fast-mode:
  Standard-mode: tLOW = 5.56 us, tHIGH = 4.44 us
  Fast-mode:     tLOW = 1.39 us, tHIGH = 1.11 us

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-uniphier.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-uniphier.c b/drivers/i2c/busses/i2c-uniphier.c
index 454f914ae66d..c488e558aef7 100644
--- a/drivers/i2c/busses/i2c-uniphier.c
+++ b/drivers/i2c/busses/i2c-uniphier.c
@@ -320,7 +320,13 @@ static void uniphier_i2c_hw_init(struct uniphier_i2c_priv *priv)
 
 	uniphier_i2c_reset(priv, true);
 
-	writel((cyc / 2 << 16) | cyc, priv->membase + UNIPHIER_I2C_CLK);
+	/*
+	 * Bit30-16: clock cycles of tLOW.
+	 *  Standard-mode: tLOW = 4.7 us, tHIGH = 4.0 us
+	 *  Fast-mode:     tLOW = 1.3 us, tHIGH = 0.6 us
+	 * "tLow/tHIGH = 5/4" meets both.
+	 */
+	writel((cyc * 5 / 9 << 16) | cyc, priv->membase + UNIPHIER_I2C_CLK);
 
 	uniphier_i2c_reset(priv, false);
 }
-- 
2.19.1

