Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3D5C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC760218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358146;
	bh=ZoFd9iTr8r1MNRxGvSBgU/exFEkL8tocvlHRZmjrWpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pm6og7NCJQmd95EfGu4PqXj4tyKk8sHJYzgk+sRCQGEyOHhwra1x8EbU40wz5U+lj
	 zD1FGXIWey/+kg709BtI1fEZy+RWyElW//Vq+xfa6pM/a3DSRVhv9LS33twPC/rIYW
	 /orGK5Ey6d6igTfRWdKcjRidBVMRQWaWtdsoCQQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbfAXT3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:29:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:55974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730623AbfAXT27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:28:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F31A218E2;
        Thu, 24 Jan 2019 19:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358139;
        bh=ZoFd9iTr8r1MNRxGvSBgU/exFEkL8tocvlHRZmjrWpA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dnRhsMl635ooZ4qwo+sj/6TfeNvggErSe+bT+nMD/Y2byctHRW+cxfaMVBBb/2N1d
         yb0nb55n+ZlN2WYkL6D7i2LsHRUmL6a+tayQMsKycfh/wXZ89LLJl3mWCAW6M0YZTY
         eOsLPMDMvSOdTqlfG3tIarfVa+Hvw8KNGrQ/DZMM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Dong Aisheng <Aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 088/104] clk: imx6q: reset exclusive gates on init
Date:   Thu, 24 Jan 2019 20:20:17 +0100
Message-Id: <20190124190204.651934273@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
index a0df83e6b84b..46c05c9a9354 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -239,8 +239,12 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
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



