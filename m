Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CA8C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045EA222B4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="hhMUV7IH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbfBKN73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:59:29 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:34766 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbfBKN70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:59:26 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id C46E125BEE3;
        Tue, 12 Feb 2019 00:59:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1549893554; bh=0j2z6+KXRydd/jReknatuwD3IzdLYhSm+8uzKhTgJms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hhMUV7IHfixNixyb7KERthnWjFdVrLnLpkh8cgZEkfq3x2CkjnLOUfmc7ESLMBb8H
         JVqRpJtZz68YqKM+qG6bgBFnEbuh/srTjdiXzTwQHXlqxPRiO3wSNjqPC0FO7N6cAB
         HUbDOqI1noG5PumIaaWMrNJkyOxtGvmKRuFVZTsA=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id C6E1794057D; Mon, 11 Feb 2019 14:59:11 +0100 (CET)
From:   Simon Horman <horms+renesas@verge.net.au>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v5 4/6] clk: renesas: rcar-gen3: Support Z and Z2 clocks with high frequency parents
Date:   Mon, 11 Feb 2019 14:58:56 +0100
Message-Id: <20190211135858.23635-5-horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190211135858.23635-1-horms+renesas@verge.net.au>
References: <20190211135858.23635-1-horms+renesas@verge.net.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support Z and Z2 clocks with parent frequencies greater than UINT32_MAX Hz
(~4.29GHz).

The DIV_ROUND_CLOSEST_ULL() macro accepts a 64bit dividend and 32bit
divisor. This leads to truncation of the divisor, which is the Z or Z2
parent clock frequency in HZ, on platforms where frequency of that clock is
greater than UINT32_MAX Hz.

To resolve this problem the DIV64_U64_ROUND_CLOSEST() macro, which takes
on an unsigned 64bit dividend and divisor, is used.

An earlier version of this patch made use of the existing
DIV_ROUND_CLOSEST() macro, which accepts the prevailing type of the
dividend and divisor. However, this does not compile on 32bit systems, such
as i386 and mips, when called with the types used at this call site, an
unsigned long long dividend and unsigned long divisor.

This work is in preparation for supporting the Z2 cloco on the R-Car Gen3
E3 (r8a77990) SoC which has a 4.8GHz parent clock.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v5: Move adding DIV64_U64_ROUND_CLOSEST to a separate patch
    Revise changelog

v4: Add and use DIV64_U64_ROUND_CLOSEST

v2: New patch
---
 drivers/clk/renesas/rcar-gen3-cpg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c b/drivers/clk/renesas/rcar-gen3-cpg.c
index 6b146c2cf6a3..4513bb705b03 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.c
+++ b/drivers/clk/renesas/rcar-gen3-cpg.c
@@ -120,8 +120,8 @@ static int cpg_z_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned int i;
 	u32 val, kick;
 
-	mult = DIV_ROUND_CLOSEST_ULL(rate * 32ULL * zclk->fixed_div,
-				     parent_rate);
+	mult = DIV64_U64_ROUND_CLOSEST(rate * 32ULL * zclk->fixed_div,
+				       parent_rate);
 	mult = clamp(mult, 1U, 32U);
 
 	if (readl(zclk->kick_reg) & CPG_FRQCRB_KICK)
-- 
2.11.0

