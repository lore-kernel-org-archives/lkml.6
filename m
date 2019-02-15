Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCFAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27442073D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550197719;
	bh=UNbvbqI1P3qiTB9wUTijxN9B9QGB4i1nhcneVl2DA5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fBV/tU8YH353/GhYn4OZUqIsY9QG6A0plBITDE3yGGkknEyC/Z9sOrnGn3Lj9Hg+E
	 /PdpVK1t1YSy1tv78o0Mgda6LMD+MHwIiLOiLIl0BI7ecqbFhjFVjuNtm3rlo66PoN
	 4EtssOcJNK2PQuSZGE1yyBEnAqp5+aYxAkwYCkv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbfBOC2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:28:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:53308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404694AbfBOCNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:13:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCF61222D4;
        Fri, 15 Feb 2019 02:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196802;
        bh=UNbvbqI1P3qiTB9wUTijxN9B9QGB4i1nhcneVl2DA5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UkyfpNYAVnzPboSS2hQGKQ0bTZnDrw5bLT5JvNLB02CbX4T54j5l7g3S2qL8o89zg
         MNRCgeX5oOrbwPWMybGaBvVKKWjFtmQLImHyNYehpwUsfGpLbPxs2QfPKqcXmZDIJx
         gTfL35bqoO2IhosZJY7OzFtWRM5214slIyRPpNVY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Alexey Firago <alexey_firago@mentor.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-renesas-soc@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 05/40] clk: vc5: Abort clock configuration without upstream clock
Date:   Thu, 14 Feb 2019 21:12:38 -0500
Message-Id: <20190215021313.178476-5-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021313.178476-1-sashal@kernel.org>
References: <20190215021313.178476-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Vasut <marek.vasut@gmail.com>

[ Upstream commit 2137a109a5e39c2bdccfffe65230ed3fadbaac0e ]

In case the upstream clock are not set, which can happen in case the
VC5 has no valid upstream clock, the $src variable is used uninited
by regmap_update_bits(). Check for this condition and return -EINVAL
in such case.

Note that in case the VC5 has no valid upstream clock, the VC5 can
not operate correctly. That is a hardware property of the VC5. The
internal oscilator present in some VC5 models is also considered
upstream clock.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Alexey Firago <alexey_firago@mentor.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org
[sboyd@kernel.org: Added comment about probe preventing this from
happening in the first place]
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-versaclock5.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
index decffb3826ec..a738af893532 100644
--- a/drivers/clk/clk-versaclock5.c
+++ b/drivers/clk/clk-versaclock5.c
@@ -262,8 +262,10 @@ static int vc5_mux_set_parent(struct clk_hw *hw, u8 index)
 
 		if (vc5->clk_mux_ins == VC5_MUX_IN_XIN)
 			src = VC5_PRIM_SRC_SHDN_EN_XTAL;
-		if (vc5->clk_mux_ins == VC5_MUX_IN_CLKIN)
+		else if (vc5->clk_mux_ins == VC5_MUX_IN_CLKIN)
 			src = VC5_PRIM_SRC_SHDN_EN_CLKIN;
+		else /* Invalid; should have been caught by vc5_probe() */
+			return -EINVAL;
 	}
 
 	return regmap_update_bits(vc5->regmap, VC5_PRIM_SRC_SHDN, mask, src);
-- 
2.19.1

