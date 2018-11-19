Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105AEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D1E20870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S10WdbZc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D1E20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731201AbeKTC5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:57:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:56756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730453AbeKTC5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:57:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FE322086A;
        Mon, 19 Nov 2018 16:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645226;
        bh=zPGBwM97Q8voOqTJX1iaCX3jGCyDxCPhpHV7ZBnr3oM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S10WdbZcKsV61Qnk2b9+/rJydr3xko6yU8r1vTsZv1RWmlHKwG0AbhkVhAnX7Gq7H
         q5rA/9109MLWC2vw4vXR30nncBC7LxYQGUjwMWOLYKwP7S1J/eQYnQv5n7qUt8tcbA
         6Rsw6y0jNgQZ4IdQqjOauTIMwAti43GNE0TIxwik=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 4.19 084/205] clk: rockchip: Fix static checker warning in rockchip_ddrclk_get_parent call
Date:   Mon, 19 Nov 2018 17:26:31 +0100
Message-Id: <20181119162631.361773829@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Enric Balletbo i Serra <enric.balletbo@collabora.com>

commit 665636b2940d0897c4130253467f5e8c42eea392 upstream.

Fixes the signedness bug returning '(-22)' on the return type by removing the
sanity checker in rockchip_ddrclk_get_parent(). The function should return
and unsigned value only and it's safe to remove the sanity checker as the
core functions that call get_parent like clk_core_get_parent_by_index already
ensures the validity of the clk index returned (index >= core->num_parents).

Fixes: a4f182bf81f18 ("clk: rockchip: add new clock-type for the ddrclk")
Cc: stable@vger.kernel.org
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/rockchip/clk-ddr.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/drivers/clk/rockchip/clk-ddr.c
+++ b/drivers/clk/rockchip/clk-ddr.c
@@ -80,16 +80,12 @@ static long rockchip_ddrclk_sip_round_ra
 static u8 rockchip_ddrclk_get_parent(struct clk_hw *hw)
 {
 	struct rockchip_ddrclk *ddrclk = to_rockchip_ddrclk_hw(hw);
-	int num_parents = clk_hw_get_num_parents(hw);
 	u32 val;
 
 	val = clk_readl(ddrclk->reg_base +
 			ddrclk->mux_offset) >> ddrclk->mux_shift;
 	val &= GENMASK(ddrclk->mux_width - 1, 0);
 
-	if (val >= num_parents)
-		return -EINVAL;
-
 	return val;
 }
 


