Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C732EC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9567B20651
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865322;
	bh=Ui/NbfU3ZvVkA7x6OqE4nfOXXYoQDlE+C5umM/rFW0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h5PtzTMJlY0FtFF30Bb0fFiKZGYZ2aRnK92/8BCKST5uISVHbZUZgoJ2c9/7RtNxe
	 x26kzk5CgkYwetykE8m7cFcHg9ZO+Tx1/feel3G8tGI5Q9POCdBx6U1YOKgS16yIBl
	 BGoOv017U3gaBT1/kJh8hpzv7Cb7wLN4IGg2BoAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbfAGMsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:48:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:39404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728540AbfAGMsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:48:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81D0221736;
        Mon,  7 Jan 2019 12:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865318;
        bh=Ui/NbfU3ZvVkA7x6OqE4nfOXXYoQDlE+C5umM/rFW0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IkWdbSX8et9c8TnGaDNiIVXoyW1VNveyiDZFmNv6kgIAv0/GHwCNx05lCdE/CPsz+
         uGnKdhX8wkKlT2Ksw943/QkXK1wCVWbCcjCSCLi+A2w6Q2JNPSo4PpPoJGWdbXHzPg
         NwFt/iKbNf3ieR9zwUIA50ZRG0GcV3VpTuSfTBp0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shalom Toledo <shalomt@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 053/170] mlxsw: core: Increase timeout during firmware flash process
Date:   Mon,  7 Jan 2019 13:31:20 +0100
Message-Id: <20190107104459.353629038@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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
 
@@ -1854,6 +1859,18 @@ int mlxsw_core_kvd_sizes_get(struct mlxs
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
--- a/drivers/net/ethernet/mellanox/mlxsw/core.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.h
@@ -292,6 +292,9 @@ int mlxsw_core_kvd_sizes_get(struct mlxs
 			     u64 *p_single_size, u64 *p_double_size,
 			     u64 *p_linear_size);
 
+void mlxsw_core_fw_flash_start(struct mlxsw_core *mlxsw_core);
+void mlxsw_core_fw_flash_end(struct mlxsw_core *mlxsw_core);
+
 bool mlxsw_core_res_valid(struct mlxsw_core *mlxsw_core,
 			  enum mlxsw_res_id res_id);
 
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -308,8 +308,13 @@ static int mlxsw_sp_firmware_flash(struc
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
 
 static int mlxsw_sp_fw_rev_validate(struct mlxsw_sp *mlxsw_sp)


