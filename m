Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD53C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0DB8208DC
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0DB8208DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934377AbeGDLbd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:31:33 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:46077 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933596AbeGDLb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:31:28 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from moshe@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 4 Jul 2018 14:34:13 +0300
Received: from dev-l-vrt-136.mtl.labs.mlnx (dev-l-vrt-136.mtl.labs.mlnx [10.134.136.1])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id w64BVNcO031471;
        Wed, 4 Jul 2018 14:31:23 +0300
Received: from dev-l-vrt-136.mtl.labs.mlnx (localhost [127.0.0.1])
        by dev-l-vrt-136.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id w64BVNeo024670;
        Wed, 4 Jul 2018 14:31:23 +0300
Received: (from moshe@localhost)
        by dev-l-vrt-136.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id w64BVNMr024669;
        Wed, 4 Jul 2018 14:31:23 +0300
From:   Moshe Shemesh <moshe@mellanox.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 10/10] bnxt_en: Add bnxt_en initial params table and register it.
Date:   Wed,  4 Jul 2018 14:30:37 +0300
Message-Id: <1530703837-24563-11-git-send-email-moshe@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1530703837-24563-1-git-send-email-moshe@mellanox.com>
References: <1530703837-24563-1-git-send-email-moshe@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasundhara Volam <vasundhara-v.volam@broadcom.com>

Create initial devlink parameters table for bnxt_en.
Table consists of a permanent generic parameter.

enable_sriov - Enables Single-Root Input/Output Virtualization(SR-IOV)
characteristic of the device.

Reviewed-by: Jiri Pirko <jiri@mellanox.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c | 121 ++++++++++++++++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.h |  15 +++
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h     |  13 +++
 drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c     |   9 +-
 4 files changed, 147 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index 402fa32..7bd96ab 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -21,16 +21,99 @@
 #endif /* CONFIG_BNXT_SRIOV */
 };
 
+static const struct bnxt_dl_nvm_param nvm_params[] = {
+	{DEVLINK_PARAM_GENERIC_ID_ENABLE_SRIOV, NVM_OFF_ENABLE_SRIOV,
+	 BNXT_NVM_SHARED_CFG, 1},
+};
+
+static int bnxt_hwrm_nvm_req(struct bnxt *bp, u32 param_id, void *msg,
+			     int msg_len, union devlink_param_value *val)
+{
+	struct hwrm_nvm_variable_input *req = msg;
+	void *data_addr = NULL, *buf = NULL;
+	struct bnxt_dl_nvm_param nvm_param;
+	int bytesize, idx = 0, rc, i;
+	dma_addr_t data_dma_addr;
+
+	/* Get/Set NVM CFG parameter is supported only on PFs */
+	if (BNXT_VF(bp))
+		return -EPERM;
+
+	for (i = 0; i < ARRAY_SIZE(nvm_params); i++) {
+		if (nvm_params[i].id == param_id) {
+			nvm_param = nvm_params[i];
+			break;
+		}
+	}
+
+	if (nvm_param.dir_type == BNXT_NVM_PORT_CFG)
+		idx = bp->pf.port_id;
+	else if (nvm_param.dir_type == BNXT_NVM_FUNC_CFG)
+		idx = bp->pf.fw_fid - BNXT_FIRST_PF_FID;
+
+	bytesize = roundup(nvm_param.num_bits, BITS_PER_BYTE) / BITS_PER_BYTE;
+	if (nvm_param.num_bits == 1)
+		buf = &val->vbool;
+
+	data_addr = dma_zalloc_coherent(&bp->pdev->dev, bytesize,
+					&data_dma_addr, GFP_KERNEL);
+	if (!data_addr)
+		return -ENOMEM;
+
+	req->data_addr = cpu_to_le64(data_dma_addr);
+	req->data_len = cpu_to_le16(nvm_param.num_bits);
+	req->option_num = cpu_to_le16(nvm_param.offset);
+	req->index_0 = cpu_to_le16(idx);
+	if (idx)
+		req->dimensions = cpu_to_le16(1);
+
+	if (req->req_type == HWRM_NVM_SET_VARIABLE)
+		memcpy(data_addr, buf, bytesize);
+
+	rc = hwrm_send_message(bp, msg, msg_len, HWRM_CMD_TIMEOUT);
+	if (!rc && req->req_type == HWRM_NVM_GET_VARIABLE)
+		memcpy(buf, data_addr, bytesize);
+
+	dma_free_coherent(&bp->pdev->dev, bytesize, data_addr, data_dma_addr);
+	if (rc)
+		return -EIO;
+	return 0;
+}
+
+static int bnxt_dl_nvm_param_get(struct devlink *dl, u32 id,
+				 struct devlink_param_gset_ctx *ctx)
+{
+	struct hwrm_nvm_get_variable_input req = {0};
+	struct bnxt *bp = bnxt_get_bp_from_dl(dl);
+
+	bnxt_hwrm_cmd_hdr_init(bp, &req, HWRM_NVM_GET_VARIABLE, -1, -1);
+	return bnxt_hwrm_nvm_req(bp, id, &req, sizeof(req), &ctx->val);
+}
+
+static int bnxt_dl_nvm_param_set(struct devlink *dl, u32 id,
+				 struct devlink_param_gset_ctx *ctx)
+{
+	struct hwrm_nvm_set_variable_input req = {0};
+	struct bnxt *bp = bnxt_get_bp_from_dl(dl);
+
+	bnxt_hwrm_cmd_hdr_init(bp, &req, HWRM_NVM_SET_VARIABLE, -1, -1);
+	return bnxt_hwrm_nvm_req(bp, id, &req, sizeof(req), &ctx->val);
+}
+
+static const struct devlink_param bnxt_dl_params[] = {
+	DEVLINK_PARAM_GENERIC(ENABLE_SRIOV,
+			      BIT(DEVLINK_PARAM_CMODE_PERMANENT),
+			      bnxt_dl_nvm_param_get, bnxt_dl_nvm_param_set,
+			      NULL),
+};
+
 int bnxt_dl_register(struct bnxt *bp)
 {
 	struct devlink *dl;
 	int rc;
 
-	if (!pci_find_ext_capability(bp->pdev, PCI_EXT_CAP_ID_SRIOV))
-		return 0;
-
-	if (bp->hwrm_spec_code < 0x10803) {
-		netdev_warn(bp->dev, "Firmware does not support SR-IOV E-Switch SWITCHDEV mode.\n");
+	if (bp->hwrm_spec_code < 0x10600) {
+		netdev_warn(bp->dev, "Firmware does not support NVM params");
 		return -ENOTSUPP;
 	}
 
@@ -41,16 +124,34 @@ int bnxt_dl_register(struct bnxt *bp)
 	}
 
 	bnxt_link_bp_to_dl(bp, dl);
-	bp->eswitch_mode = DEVLINK_ESWITCH_MODE_LEGACY;
+
+	/* Add switchdev eswitch mode setting, if SRIOV supported */
+	if (pci_find_ext_capability(bp->pdev, PCI_EXT_CAP_ID_SRIOV) &&
+	    bp->hwrm_spec_code > 0x10803)
+		bp->eswitch_mode = DEVLINK_ESWITCH_MODE_LEGACY;
+
 	rc = devlink_register(dl, &bp->pdev->dev);
 	if (rc) {
-		bnxt_link_bp_to_dl(bp, NULL);
-		devlink_free(dl);
 		netdev_warn(bp->dev, "devlink_register failed. rc=%d", rc);
-		return rc;
+		goto err_dl_free;
+	}
+
+	rc = devlink_params_register(dl, bnxt_dl_params,
+				     ARRAY_SIZE(bnxt_dl_params));
+	if (rc) {
+		netdev_warn(bp->dev, "devlink_params_register failed. rc=%d",
+			    rc);
+		goto err_dl_unreg;
 	}
 
 	return 0;
+
+err_dl_unreg:
+	devlink_unregister(dl);
+err_dl_free:
+	bnxt_link_bp_to_dl(bp, NULL);
+	devlink_free(dl);
+	return rc;
 }
 
 void bnxt_dl_unregister(struct bnxt *bp)
@@ -60,6 +161,8 @@ void bnxt_dl_unregister(struct bnxt *bp)
 	if (!dl)
 		return;
 
+	devlink_params_unregister(dl, bnxt_dl_params,
+				  ARRAY_SIZE(bnxt_dl_params));
 	devlink_unregister(dl);
 	devlink_free(dl);
 }
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.h
index e92a35d..2f68dc0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.h
@@ -33,6 +33,21 @@ static inline void bnxt_link_bp_to_dl(struct bnxt *bp, struct devlink *dl)
 	}
 }
 
+#define NVM_OFF_ENABLE_SRIOV		401
+
+enum bnxt_nvm_dir_type {
+	BNXT_NVM_SHARED_CFG = 40,
+	BNXT_NVM_PORT_CFG,
+	BNXT_NVM_FUNC_CFG,
+};
+
+struct bnxt_dl_nvm_param {
+	u16 id;
+	u16 offset;
+	u16 dir_type;
+	u16 num_bits;
+};
+
 int bnxt_dl_register(struct bnxt *bp);
 void bnxt_dl_unregister(struct bnxt *bp);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
index 0fe0ea8..c75d7fa 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
@@ -6201,6 +6201,19 @@ struct hwrm_nvm_install_update_cmd_err {
 	u8	unused_0[7];
 };
 
+struct hwrm_nvm_variable_input {
+	__le16	req_type;
+	__le16	cmpl_ring;
+	__le16	seq_id;
+	__le16	target_id;
+	__le64	resp_addr;
+	__le64	data_addr;
+	__le16	data_len;
+	__le16	option_num;
+	__le16	dimensions;
+	__le16	index_0;
+};
+
 /* hwrm_nvm_get_variable_input (size:320b/40B) */
 struct hwrm_nvm_get_variable_input {
 	__le16	req_type;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c
index 0745f2d..e31f5d8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c
@@ -543,9 +543,14 @@ int bnxt_dl_eswitch_mode_set(struct devlink *devlink, u16 mode)
 		break;
 
 	case DEVLINK_ESWITCH_MODE_SWITCHDEV:
+		if (bp->hwrm_spec_code < 0x10803) {
+			netdev_warn(bp->dev, "FW does not support SRIOV E-Switch SWITCHDEV mode\n");
+			rc = -ENOTSUPP;
+			goto done;
+		}
+
 		if (pci_num_vf(bp->pdev) == 0) {
-			netdev_info(bp->dev,
-				    "Enable VFs before setting switchdev mode");
+			netdev_info(bp->dev, "Enable VFs before setting switchdev mode");
 			rc = -EPERM;
 			goto done;
 		}
-- 
1.8.3.1

