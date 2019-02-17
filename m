Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99B8C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F47218AD
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1RNXBQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbfBQQXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 11:23:36 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36997 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbfBQQXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 11:23:34 -0500
Received: by mail-pl1-f195.google.com with SMTP id q3so117915pll.4;
        Sun, 17 Feb 2019 08:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l0Z1b8BC2pttHCDOIu6v+lf74XsTzc0qioBaG3nshfk=;
        b=H1RNXBQyWwvUvFimsnQaKsApwBgZZRoA48sVue+RJ/bohxA/tPVw/7Wu68+shB4ytR
         IkztkblLHEI3PV0Qm7JY+0kMgUz4Wc0N0PH0HfJjF8yDSxyFg2ZVl845X4H2iFyTSfZO
         ZUOs9+EYZJJ1eASZQW+LE2Zy7RmHZpzQ2VsrbHOnk/5XPD347SuQ7QG3MDrXgPmaIqeP
         2yulNvyME88OSBPdqtVcqhHW9WiUUBqS6J1AiNLaAdEF/8cVf1LJH79Ihiai3xD+MP2L
         PZ54teH89F+2KnLwrp28Pi58fZRGTn4DS+TPK/q0n0F05VbnsfOM3D7YQG+UFMlTkbxr
         A68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l0Z1b8BC2pttHCDOIu6v+lf74XsTzc0qioBaG3nshfk=;
        b=floVHKSMPo/aA3RjHgg3ySZ/czDE3UQUIpf3GgmyGqIG+eLh5UWnN92SUiGN2SbSHp
         daYU1EpnDQLtonuog/yeGG7e3Mt1ZAI3+RLeCRPQNJ69f2mIkLpEoXsP9dUJq3TaX0Kl
         2KLVS50sDqKFKAgW4kbLeFPeVUREphX67/k2tzYEG6kXZ0wpmvPAMjSnJM935yYq7uyB
         TgMTcgNL5FDGFSsgeLSXttoCyMn/SHtzKnZfkU5hmpk+exogmrjCaqlVaTTWjTNgoemH
         JEnCsb7UqP6G96445tJOZt+Z+hskO/SJJ4isOnH9bX3HNx0ZnObhRsjXP7FUTZEjxoRb
         zCXg==
X-Gm-Message-State: AHQUAuakok2E4QiIYkTRF4sNFZepMLraG8Ne0GxaV96SJonmwtbEJmB1
        yq5j23OzzLwt85vkS7fwQx0=
X-Google-Smtp-Source: AHgI3IatCozi52BBjxYj9wpcWegsHycTPpd+H3xV8EpBNaBUTb92zGixVALQES0YRocPtZTjcjg/fg==
X-Received: by 2002:a17:902:2aa8:: with SMTP id j37mr19969310plb.226.1550420614357;
        Sun, 17 Feb 2019 08:23:34 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id x11sm12541697pgp.88.2019.02.17.08.23.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Feb 2019 08:23:33 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 2/5] nvmem: sunxi-sid: add support for H5's SID controller
Date:   Sun, 17 Feb 2019 11:23:13 -0500
Message-Id: <20190217162316.14111-3-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190217162316.14111-1-tiny.windzz@gmail.com>
References: <20190217162316.14111-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for H5's SID controller.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/nvmem/sunxi_sid.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 570a2e354f30..036029e90921 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -219,11 +219,17 @@ static const struct sunxi_sid_cfg sun50i_a64_cfg = {
 	.size = 0x100,
 };
 
+static const struct sunxi_sid_cfg sun50i_h5_cfg = {
+	.value_offset = 0x200,
+	.size = 0x100,
+};
+
 static const struct of_device_id sunxi_sid_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-sid", .data = &sun4i_a10_cfg },
 	{ .compatible = "allwinner,sun7i-a20-sid", .data = &sun7i_a20_cfg },
 	{ .compatible = "allwinner,sun8i-h3-sid", .data = &sun8i_h3_cfg },
 	{ .compatible = "allwinner,sun50i-a64-sid", .data = &sun50i_a64_cfg },
+	{ .compatible = "allwinner,sun50i-h5-sid", .data = &sun50i_h5_cfg },
 	{/* sentinel */},
 };
 MODULE_DEVICE_TABLE(of, sunxi_sid_of_match);
-- 
2.17.0

