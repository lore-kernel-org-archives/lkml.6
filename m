Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D1DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040CA214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864560;
	bh=ajZhGLCOwFYcMduKx6/A6wcvKwELBEMJ0JBe+DbhiG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hJxOwHdpeKEI3tyv4asy1qax6x2Voo8NsvY5TdXYMbxPXOlSkVUIqIo57pGi2FMog
	 EMbzt/fmcKIS0UbQ8tpQrTn/slpSZxtyoDrb4qu2uW6eCCZ2KDZoXW1o9oSuBa0Mvy
	 MRYC8FP0DpmzcPaBDRTCieHdPWiPKMpVJzZR8J5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbeLZWtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:49:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:38062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728558AbeLZWhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:37:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5877920651;
        Wed, 26 Dec 2018 22:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863873;
        bh=ajZhGLCOwFYcMduKx6/A6wcvKwELBEMJ0JBe+DbhiG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gveZWiJMKyXRyO9ws+Iuk8seo2wklxr1dKdrf1EyPChKNGDwh5ctTdSq3TFj2BHX/
         HWee5OWEB0364vus1jNufN2uYasV/0qwyMi0sVMbQp14RPx6aZHRdB2R0xJRq0oImF
         Ow7pl6X0w7RVIHb2xxWYERfuzUq4gU7s13xqb0bE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shalom Toledo <shalomt@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 67/97] mlxsw: core: Increase timeout during firmware flash process
Date:   Wed, 26 Dec 2018 17:35:27 -0500
Message-Id: <20181226223557.149329-67-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shalom Toledo <shalomt@mellanox.com>

[ Upstream commit cf0b70e71b32137ccf9c1f3dd9fb30cbf89b4322 ]

During the firmware flash process, some of the EMADs get timed out, which
causes the driver to send them again with a limit of 5 retries. There are
some situations in which 5 retries is not enough and the EMAD access fails.
If the failed EMAD was related to the flashing process, the driver fails
the flashing.

The reason for these timeouts during firmware flashing is cache misses in
the CPU running the firmware. In case the CPU needs to fetch instructions
from the flash when a firmware is flashed, it needs to wait for the
flashing to complete. Since flashing takes time, it is possible for pending
EMADs to timeout.

Fix by increasing EMADs' timeout while flashing firmware.

Fixes: ce6ef68f433f ("mlxsw: spectrum: Implement the ethtool flash_device callback")
Signed-off-by: Shalom Toledo <shalomt@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/core.c    | 19 ++++++++++++++++++-
 drivers/net/ethernet/mellanox/mlxsw/core.h    |  3 +++
 .../net/ethernet/mellanox/mlxsw/spectrum.c    |  7 ++++++-
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.c b/drivers/net/ethernet/mellanox/mlxsw/core.c
index 30f751e69698..f7154f358f27 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -81,6 +81,7 @@ struct mlxsw_core {
 	struct mlxsw_core_port *ports;
 	unsigned int max_ports;
 	bool reload_fail;
+	bool fw_flash_in_progress;
 	unsigned long driver_priv[0];
 	/* driver_priv has to be always the last item */
 };
@@ -428,12 +429,16 @@ struct mlxsw_reg_trans {
 	struct rcu_head rcu;
 };
 
-#define MLXSW_EMAD_TIMEOUT_MS 200
+#define MLXSW_EMAD_TIMEOUT_DURING_FW_FLASH_MS	3000
+#define MLXSW_EMAD_TIMEOUT_MS			200
 
 static void mlxsw_emad_trans_timeout_schedule(struct mlxsw_reg_trans *trans)
 {
 	unsigned long timeout = msecs_to_jiffies(MLXSW_EMAD_TIMEOUT_MS);
 
+	if (trans->core->fw_flash_in_progress)
+		timeout = msecs_to_jiffies(MLXSW_EMAD_TIMEOUT_DURING_FW_FLASH_MS);
+
 	queue_delayed_work(trans->core->emad_wq, &trans->timeout_dw, timeout);
 }
 
@@ -1854,6 +1859,18 @@ int mlxsw_core_kvd_sizes_get(struct mlxsw_core *mlxsw_core,
 }
 EXPORT_SYMBOL(mlxsw_core_kvd_sizes_get);
 
+void mlxsw_core_fw_flash_start(struct mlxsw_core *mlxsw_core)
+{
+	mlxsw_core->fw_flash_in_progress = true;
+}
+EXPORT_SYMBOL(mlxsw_core_fw_flash_start);
+
+void mlxsw_core_fw_flash_end(struct mlxsw_core *mlxsw_core)
+{
+	mlxsw_core->fw_flash_in_progress = false;
+}
+EXPORT_SYMBOL(mlxsw_core_fw_flash_end);
+
 static int __init mlxsw_core_module_init(void)
 {
 	int err;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.h b/drivers/net/ethernet/mellanox/mlxsw/core.h
index c35be477856f..c4e4971764e5 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.h
@@ -292,6 +292,9 @@ int mlxsw_core_kvd_sizes_get(struct mlxsw_core *mlxsw_core,
 			     u64 *p_single_size, u64 *p_double_size,
 			     u64 *p_linear_size);
 
+void mlxsw_core_fw_flash_start(struct mlxsw_core *mlxsw_core);
+void mlxsw_core_fw_flash_end(struct mlxsw_core *mlxsw_core);
+
 bool mlxsw_core_res_valid(struct mlxsw_core *mlxsw_core,
 			  enum mlxsw_res_id res_id);
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index ada644d90029..3d1159f8a53f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -308,8 +308,13 @@ static int mlxsw_sp_firmware_flash(struct mlxsw_sp *mlxsw_sp,
 		},
 		.mlxsw_sp = mlxsw_sp
 	};
+	int err;
+
+	mlxsw_core_fw_flash_start(mlxsw_sp->core);
+	err = mlxfw_firmware_flash(&mlxsw_sp_mlxfw_dev.mlxfw_dev, firmware);
+	mlxsw_core_fw_flash_end(mlxsw_sp->core);
 
-	return mlxfw_firmware_flash(&mlxsw_sp_mlxfw_dev.mlxfw_dev, firmware);
+	return err;
 }
 
 static int mlxsw_sp_fw_rev_validate(struct mlxsw_sp *mlxsw_sp)
-- 
2.19.1

