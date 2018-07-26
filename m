Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31214C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D4D2083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D4D2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbeGZH42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 03:56:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10126 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725941AbeGZH41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 03:56:27 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 34D284F535352;
        Thu, 26 Jul 2018 14:41:04 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.382.0; Thu, 26 Jul 2018
 14:40:57 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <jeffrey.t.kirsher@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <intel-wired-lan@lists.osuosl.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] i40e/i40evf: remove redundant functions i40evf_aq_{set/get}_phy_register
Date:   Thu, 26 Jul 2018 14:37:36 +0800
Message-ID: <20180726063736.10404-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no in-tree callers.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/intel/i40evf/i40e_common.c | 69 -------------------------
 1 file changed, 69 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40e_common.c b/drivers/net/ethernet/intel/i40evf/i40e_common.c
index 9cef549..eea280ba 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_common.c
@@ -1021,75 +1021,6 @@ void i40evf_write_rx_ctl(struct i40e_hw *hw, u32 reg_addr, u32 reg_val)
 }
 
 /**
- * i40evf_aq_set_phy_register
- * @hw: pointer to the hw struct
- * @phy_select: select which phy should be accessed
- * @dev_addr: PHY device address
- * @reg_addr: PHY register address
- * @reg_val: new register value
- * @cmd_details: pointer to command details structure or NULL
- *
- * Reset the external PHY.
- **/
-i40e_status i40evf_aq_set_phy_register(struct i40e_hw *hw,
-				       u8 phy_select, u8 dev_addr,
-				       u32 reg_addr, u32 reg_val,
-				       struct i40e_asq_cmd_details *cmd_details)
-{
-	struct i40e_aq_desc desc;
-	struct i40e_aqc_phy_register_access *cmd =
-		(struct i40e_aqc_phy_register_access *)&desc.params.raw;
-	i40e_status status;
-
-	i40evf_fill_default_direct_cmd_desc(&desc,
-					    i40e_aqc_opc_set_phy_register);
-
-	cmd->phy_interface = phy_select;
-	cmd->dev_address = dev_addr;
-	cmd->reg_address = cpu_to_le32(reg_addr);
-	cmd->reg_value = cpu_to_le32(reg_val);
-
-	status = i40evf_asq_send_command(hw, &desc, NULL, 0, cmd_details);
-
-	return status;
-}
-
-/**
- * i40evf_aq_get_phy_register
- * @hw: pointer to the hw struct
- * @phy_select: select which phy should be accessed
- * @dev_addr: PHY device address
- * @reg_addr: PHY register address
- * @reg_val: read register value
- * @cmd_details: pointer to command details structure or NULL
- *
- * Reset the external PHY.
- **/
-i40e_status i40evf_aq_get_phy_register(struct i40e_hw *hw,
-				       u8 phy_select, u8 dev_addr,
-				       u32 reg_addr, u32 *reg_val,
-				       struct i40e_asq_cmd_details *cmd_details)
-{
-	struct i40e_aq_desc desc;
-	struct i40e_aqc_phy_register_access *cmd =
-		(struct i40e_aqc_phy_register_access *)&desc.params.raw;
-	i40e_status status;
-
-	i40evf_fill_default_direct_cmd_desc(&desc,
-					    i40e_aqc_opc_get_phy_register);
-
-	cmd->phy_interface = phy_select;
-	cmd->dev_address = dev_addr;
-	cmd->reg_address = cpu_to_le32(reg_addr);
-
-	status = i40evf_asq_send_command(hw, &desc, NULL, 0, cmd_details);
-	if (!status)
-		*reg_val = le32_to_cpu(cmd->reg_value);
-
-	return status;
-}
-
-/**
  * i40e_aq_send_msg_to_pf
  * @hw: pointer to the hardware structure
  * @v_opcode: opcodes for VF-PF communication
-- 
2.7.0


