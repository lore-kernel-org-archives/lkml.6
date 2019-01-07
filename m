Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45B2C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74EB2217D4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866055;
	bh=T+GbNDvXXAdGPmQNn7YU6TFZvOEG6J03FiP8Pb8wa0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D2heckVIerUARWu9qzEgtG7AvOMmwkQxx/dwiXuI0WUgEjA6uPzaDcljoDdz1sZ1w
	 iz1bn4wmqnTYItZAbdWtOTz53SpKQC+tj8wFPz9xS69G7lmh/r6ziLymmoJttf1wDH
	 Aoa3O63N3oDWBvE70pNrP39LGDrWNiHLvv3xjkY4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbfAGNAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:00:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:48328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730480AbfAGNAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:00:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BE5C2173C;
        Mon,  7 Jan 2019 13:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866051;
        bh=T+GbNDvXXAdGPmQNn7YU6TFZvOEG6J03FiP8Pb8wa0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SKfGHmKt8ZwJDVfmfWohh3SOWwX5t/y2Azg/bWt4E0J4D0rQHZ+L+G0TaQJS8ak6R
         R7kHDnO+Gzj1wgnrezWIXjnnfE3q23Um07TJ8Mnn13vheayBTOgXnblDF+1d08m3qu
         G1N1/k0r7623iv+KZwE0+3bPSfEs5qUs/sytSqeI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shalom Toledo <shalomt@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 029/101] mlxsw: core: Increase timeout during firmware flash process
Date:   Mon,  7 Jan 2019 13:32:17 +0100
Message-Id: <20190107105334.499873395@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
References: <20190107105330.372621917@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/core.c     |   19 ++++++++++++++++++-
 drivers/net/ethernet/mellanox/mlxsw/core.h     |    3 +++
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c |    7 ++++++-
 3 files changed, 27 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -113,6 +113,7 @@ struct mlxsw_core {
 	struct mlxsw_thermal *thermal;
 	struct mlxsw_core_port *ports;
 	unsigned int max_ports;
+	bool fw_flash_in_progress;
 	unsigned long driver_priv[0];
 	/* driver_priv has to be always the last item */
 };
@@ -460,12 +461,16 @@ struct mlxsw_reg_trans {
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
 
@@ -1791,6 +1796,18 @@ void mlxsw_core_flush_owq(void)
 }
 EXPORT_SYMBOL(mlxsw_core_flush_owq);
 
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
--- a/drivers/net/ethernet/mellanox/mlxsw/core.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.h
@@ -312,6 +312,9 @@ struct mlxsw_driver {
 	const struct mlxsw_config_profile *profile;
 };
 
+void mlxsw_core_fw_flash_start(struct mlxsw_core *mlxsw_core);
+void mlxsw_core_fw_flash_end(struct mlxsw_core *mlxsw_core);
+
 bool mlxsw_core_res_valid(struct mlxsw_core *mlxsw_core,
 			  enum mlxsw_res_id res_id);
 
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -333,8 +333,13 @@ static int mlxsw_sp_firmware_flash(struc
 		},
 		.mlxsw_sp = mlxsw_sp
 	};
+	int err;
 
-	return mlxfw_firmware_flash(&mlxsw_sp_mlxfw_dev.mlxfw_dev, firmware);
+	mlxsw_core_fw_flash_start(mlxsw_sp->core);
+	err = mlxfw_firmware_flash(&mlxsw_sp_mlxfw_dev.mlxfw_dev, firmware);
+	mlxsw_core_fw_flash_end(mlxsw_sp->core);
+
+	return err;
 }
 
 static bool mlxsw_sp_fw_rev_ge(const struct mlxsw_fw_rev *a,


