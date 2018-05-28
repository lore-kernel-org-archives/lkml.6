Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939696AbeE1PIj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:08:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033792AbeE1KYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:24:32 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 233/268] clk: rockchip: Prevent calculating mmc phase if clock rate is zero
Date: Mon, 28 May 2018 12:03:27 +0200
Message-Id: <20180528100229.729430836@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shawn Lin <shawn.lin@rock-chips.com>

[ Upstream commit 4bf59902b50012b1dddeeaa23b217d9c4956cdda ]

The MMC sample and drv clock for rockchip platforms are derived from
the bus clock output to the MMC/SDIO card. So it should never happens
that the clk rate is zero given it should inherits the clock rate from
its parent. If something goes wrong and makes the clock rate to be zero,
the calculation would be wrong but may still make the mmc tuning process
work luckily. However it makes people harder to debug when the following
data transfer is unstable.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/rockchip/clk-mmc-phase.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

--- a/drivers/clk/rockchip/clk-mmc-phase.c
+++ b/drivers/clk/rockchip/clk-mmc-phase.c
@@ -60,6 +60,12 @@ static int rockchip_mmc_get_phase(struct
 	u16 degrees;
 	u32 delay_num = 0;
 
+	/* See the comment for rockchip_mmc_set_phase below */
+	if (!rate) {
+		pr_err("%s: invalid clk rate\n", __func__);
+		return -EINVAL;
+	}
+
 	raw_value = readl(mmc_clock->reg) >> (mmc_clock->shift);
 
 	degrees = (raw_value & ROCKCHIP_MMC_DEGREE_MASK) * 90;
@@ -86,6 +92,23 @@ static int rockchip_mmc_set_phase(struct
 	u32 raw_value;
 	u32 delay;
 
+	/*
+	 * The below calculation is based on the output clock from
+	 * MMC host to the card, which expects the phase clock inherits
+	 * the clock rate from its parent, namely the output clock
+	 * provider of MMC host. However, things may go wrong if
+	 * (1) It is orphan.
+	 * (2) It is assigned to the wrong parent.
+	 *
+	 * This check help debug the case (1), which seems to be the
+	 * most likely problem we often face and which makes it difficult
+	 * for people to debug unstable mmc tuning results.
+	 */
+	if (!rate) {
+		pr_err("%s: invalid clk rate\n", __func__);
+		return -EINVAL;
+	}
+
 	nineties = degrees / 90;
 	remainder = (degrees % 90);
 
