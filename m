Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938316AbeE1Lg0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:36:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424220AbeE1LNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:13:08 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vivek Gautam <vivek.gautam@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 201/272] phy: qcom-qmp: Fix phy pipe clock gating
Date: Mon, 28 May 2018 12:03:54 +0200
Message-Id: <20180528100257.428919683@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vivek Gautam <vivek.gautam@codeaurora.org>

[ Upstream commit f8ba22a39e985c93e278709b1d5f20857a26b49b ]

Pipe clock comes out of the phy and is available as long as
the phy is turned on. Clock controller fails to gate this
clock after the phy is turned off and generates a warning.

/ # [   33.048561] gcc_usb3_phy_pipe_clk status stuck at 'on'
[   33.048585] ------------[ cut here ]------------
[   33.052621] WARNING: CPU: 1 PID: 18 at ../drivers/clk/qcom/clk-branch.c:97 clk_branch_wait+0xf0/0x108
[   33.057384] Modules linked in:
[   33.066497] CPU: 1 PID: 18 Comm: kworker/1:0 Tainted: G        W       4.12.0-rc7-00024-gfe926e34c36d-dirty #96
[   33.069451] Hardware name: Qualcomm Technologies, Inc. DB820c (DT)
...
[   33.278565] [<ffff00000849b27c>] clk_branch_wait+0xf0/0x108
[   33.286375] [<ffff00000849b2f4>] clk_branch2_disable+0x28/0x34
[   33.291761] [<ffff0000084868dc>] clk_core_disable+0x5c/0x88
[   33.297660] [<ffff000008487d68>] clk_core_disable_lock+0x20/0x34
[   33.303129] [<ffff000008487d98>] clk_disable+0x1c/0x24
[   33.309384] [<ffff0000083ccd78>] qcom_qmp_phy_poweroff+0x20/0x48
[   33.314328] [<ffff0000083c53f4>] phy_power_off+0x80/0xdc
[   33.320492] [<ffff00000875c950>] dwc3_core_exit+0x94/0xa0
[   33.325784] [<ffff00000875c9ac>] dwc3_suspend_common+0x50/0x60
[   33.331080] [<ffff00000875ca04>] dwc3_runtime_suspend+0x48/0x6c
[   33.336810] [<ffff0000085b82f4>] pm_generic_runtime_suspend+0x28/0x38
[   33.342627] [<ffff0000085bace0>] __rpm_callback+0x150/0x254
[   33.349222] [<ffff0000085bae08>] rpm_callback+0x24/0x78
[   33.354604] [<ffff0000085b9fd8>] rpm_suspend+0xe0/0x4e4
[   33.359813] [<ffff0000085bb784>] pm_runtime_work+0xdc/0xf0
[   33.365028] [<ffff0000080d7b30>] process_one_work+0x12c/0x28c
[   33.370576] [<ffff0000080d7ce8>] worker_thread+0x58/0x3b8
[   33.376393] [<ffff0000080dd4a8>] kthread+0x100/0x12c
[   33.381776] [<ffff0000080836c0>] ret_from_fork+0x10/0x50

Fix this by disabling it as the first thing in phy_exit().

Fixes: e78f3d15e115 ("phy: qcom-qmp: new qmp phy driver for qcom-chipsets")
Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -751,8 +751,6 @@ static int qcom_qmp_phy_poweroff(struct
 	struct qmp_phy *qphy = phy_get_drvdata(phy);
 	struct qcom_qmp *qmp = qphy->qmp;
 
-	clk_disable_unprepare(qphy->pipe_clk);
-
 	regulator_bulk_disable(qmp->cfg->num_vregs, qmp->vregs);
 
 	return 0;
@@ -936,6 +934,8 @@ static int qcom_qmp_phy_exit(struct phy
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	int i = cfg->num_clks;
 
+	clk_disable_unprepare(qphy->pipe_clk);
+
 	/* PHY reset */
 	qphy_setbits(qphy->pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
 
