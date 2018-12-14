Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FD5C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86E9208C1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544824203;
	bh=KJ4xo3XlylGcEUsVeQVGwT3irBkYd0CC/9e7cbPK/ns=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=UF7Ww7/su0HJ2ClanIV3sxKiQtMNe1KE4A27WL7P3RnmA53sTJCGsjBpQ/IK06Hmu
	 omwFsifNZhXn/fV0i8s1DbMthVeTc+RAdzchpJs3FhiPJVtvSez4ZjRTlcfIXQBx5b
	 sgxEiZYCzgvnB12V666dpO1MVDzO0ipOq/sBTmpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbeLNVuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 16:50:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:48004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730734AbeLNVuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 16:50:01 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDADA2086D;
        Fri, 14 Dec 2018 21:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544824201;
        bh=KJ4xo3XlylGcEUsVeQVGwT3irBkYd0CC/9e7cbPK/ns=;
        h=From:To:Cc:Subject:Date:From;
        b=BC8ANbEO0TGcULe7/GOfYrEyPSVxhYRd8L9Q7pIsBNrzv91GfNBzJxRPoHJT175rz
         bcbMeYRtA/TJua+P6yV33G1gW9PPZD3nanL43IF4Ft9iOYUaosw/i41jateWl8X/OY
         aGUtWwyWQihtQvJvI9NTkXVzs+u/ieq/OSpAYFMU=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Alexey Firago <alexey_firago@mentor.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] clk: vc5: Initialize src in vc5_mux_set_parent()
Date:   Fri, 14 Dec 2018 13:49:59 -0800
Message-Id: <20181214214959.162744-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that it may be possible to get to the regmap update call
without ever initializing this variable, so just set it to 0 to be safe.

Cc: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Alexey Firago <alexey_firago@mentor.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk-versaclock5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
index 5b393e711e94..026f76276933 100644
--- a/drivers/clk/clk-versaclock5.c
+++ b/drivers/clk/clk-versaclock5.c
@@ -246,7 +246,7 @@ static int vc5_mux_set_parent(struct clk_hw *hw, u8 index)
 	struct vc5_driver_data *vc5 =
 		container_of(hw, struct vc5_driver_data, clk_mux);
 	const u8 mask = VC5_PRIM_SRC_SHDN_EN_XTAL | VC5_PRIM_SRC_SHDN_EN_CLKIN;
-	u8 src;
+	u8 src = 0;
 
 	if ((index > 1) || !vc5->clk_mux_ins)
 		return -EINVAL;
-- 
Sent by a computer through tubes

