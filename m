Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166091AbeE1PQY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:16:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033327AbeE1KWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:22:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leon Romanovsky <leonro@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 194/268] net/mlx5: Protect from command bit overflow
Date: Mon, 28 May 2018 12:02:48 +0200
Message-Id: <20180528100224.245683888@linuxfoundation.org>
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

From: Leon Romanovsky <leonro@mellanox.com>

[ Upstream commit 957f6ba8adc7be401a74ccff427e4cfd88d3bfcb ]

The system with CONFIG_UBSAN enabled on produces the following error
during driver initialization. The reason to it that max_reg_cmds can be
larger enough to cause to "1 << max_reg_cmds" overflow the unsigned long.

================================================================================
UBSAN: Undefined behaviour in drivers/net/ethernet/mellanox/mlx5/core/cmd.c:1805:42
signed integer overflow:
-2147483648 - 1 cannot be represented in type 'int'
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.15.0-rc2-00032-g06cda2358d9b-dirty #724
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.7.5-0-ge51488c-20140602_164612-nilsson.home.kraxel.org 04/01/2014
Call Trace:
 dump_stack+0xe9/0x18f
 ? dma_virt_alloc+0x81/0x81
 ubsan_epilogue+0xe/0x4e
 handle_overflow+0x187/0x20c
 mlx5_cmd_init+0x73a/0x12b0
 mlx5_load_one+0x1c3d/0x1d30
 init_one+0xd02/0xf10
 pci_device_probe+0x26c/0x3b0
 driver_probe_device+0x622/0xb40
 __driver_attach+0x175/0x1b0
 bus_for_each_dev+0xef/0x190
 bus_add_driver+0x2db/0x490
 driver_register+0x16b/0x1e0
 __pci_register_driver+0x177/0x1b0
 init+0x6d/0x92
 do_one_initcall+0x15b/0x270
 kernel_init_freeable+0x2d8/0x3d0
 kernel_init+0x14/0x190
 ret_from_fork+0x24/0x30
================================================================================

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -1623,7 +1623,7 @@ int mlx5_cmd_init(struct mlx5_core_dev *
 
 	cmd->checksum_disabled = 1;
 	cmd->max_reg_cmds = (1 << cmd->log_sz) - 1;
-	cmd->bitmask = (1 << cmd->max_reg_cmds) - 1;
+	cmd->bitmask = (1UL << cmd->max_reg_cmds) - 1;
 
 	cmd->cmdif_rev = ioread32be(&dev->iseg->cmdif_rev_fw_sub) >> 16;
 	if (cmd->cmdif_rev > CMD_IF_REV) {
