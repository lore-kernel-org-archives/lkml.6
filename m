Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17783C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D841E217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359770;
	bh=uYKYFhhxP8sPwZhLsxOVWmIxuKJmedH0SR9lsisN6q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DdK9bNA30A7AxoopnAJJOeDED+YPHhwvg44OBVFDgQ8bwbMoe47DxNhDh+KurvFYA
	 LMJXpNjiMNP2A77Rgw6gkHEr+Y2kfeJHXTc4UboUYvlTJjuU8nzPy/EnSyTDgLIuyn
	 aE29U3OIPGs85Uh/OJD5gbfusYMESCFye5+TC8EU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbfAXT4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:56:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:36220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732461AbfAXTgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:36:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 656BA218FC;
        Thu, 24 Jan 2019 19:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358571;
        bh=uYKYFhhxP8sPwZhLsxOVWmIxuKJmedH0SR9lsisN6q0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ref4MQkB/wvDMY9btXku+ppXdN2MoUiJrC+6LPKj1Pquk6GciePpWK1zxkb1P0XnA
         u7fw6fbJNIJ1BLl+dl3n7VIhGWhl983+B2oBWdyRleinKQbE01rapMe/erbBjswAnQ
         SJq4nvDIHlQ02FpV9fdbYzsri0vqj8kxmG8qi6iM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Dong Aisheng <Aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 054/106] clk: imx6q: reset exclusive gates on init
Date:   Thu, 24 Jan 2019 20:20:11 +0100
Message-Id: <20190124190209.864469393@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit f7542d817733f461258fd3a47d77da35b2d9fc81 ]

The exclusive gates may be set up in the wrong way by software running
before the clock driver comes up. In that case the exclusive setup is
locked in its initial state, as the complementary function can't be
activated without disabling the initial setup first.

To avoid this lock situation, reset the exclusive gates to the off
state and allow the kernel to provide the proper setup.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Dong Aisheng <Aisheng.dong@nxp.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-imx6q.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index 8c7c2fcb8d94..c509324f6338 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -508,8 +508,12 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	 * lvds1_gate and lvds2_gate are pseudo-gates.  Both can be
 	 * independently configured as clock inputs or outputs.  We treat
 	 * the "output_enable" bit as a gate, even though it's really just
-	 * enabling clock output.
+	 * enabling clock output. Initially the gate bits are cleared, as
+	 * otherwise the exclusive configuration gets locked in the setup done
+	 * by software running before the clock driver, with no way to change
+	 * it.
 	 */
+	writel(readl(base + 0x160) & ~0x3c00, base + 0x160);
 	clk[IMX6QDL_CLK_LVDS1_GATE] = imx_clk_gate_exclusive("lvds1_gate", "lvds1_sel", base + 0x160, 10, BIT(12));
 	clk[IMX6QDL_CLK_LVDS2_GATE] = imx_clk_gate_exclusive("lvds2_gate", "lvds2_sel", base + 0x160, 11, BIT(13));
 
-- 
2.19.1



