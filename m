Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0E1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5042206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732027AbeLQJ1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:27:37 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16577 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731862AbeLQJ1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:27:36 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 40C8A3F896D5F;
        Mon, 17 Dec 2018 17:27:33 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Mon, 17 Dec 2018
 17:27:26 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <Shahed.Shaikh@cavium.com>,
        <manish.chopra@cavium.com>, <Dept-GELinuxNICDev@cavium.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] qlcnic: remove set but not used variables 'op, cmd_op'
Date:   Mon, 17 Dec 2018 17:27:16 +0800
Message-ID: <20181217092716.30708-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_pf.c:1070:5: warning:
 variable 'op' set but not used [-Wunused-but-set-variable]
drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_pf.c:1342:5: warning:
 variable 'cmd_op' set but not used [-Wunused-but-set-variable]

'op' never used since introduction in commit 7cb03b2347d5 ("qlcnic:
Support VF-PF communication channel commands.")
'cmd_op' not used since commit 6226204bcf20 ("qlcnic: Fix operation
type and command type.")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_pf.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_pf.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_pf.c
index 50eaafa..af3b037 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_pf.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_pf.c
@@ -1067,9 +1067,6 @@ static int qlcnic_sriov_pf_cfg_ip_cmd(struct qlcnic_bc_trans *trans,
 	struct qlcnic_vf_info *vf = trans->vf;
 	struct qlcnic_adapter *adapter = vf->adapter;
 	int err = -EIO;
-	u8 op;
-
-	op =  cmd->req.arg[1] & 0xff;
 
 	cmd->req.arg[1] |= vf->vp->handle << 16;
 	cmd->req.arg[1] |= BIT_31;
@@ -1339,14 +1336,13 @@ static int qlcnic_sriov_pf_get_acl_cmd(struct qlcnic_bc_trans *trans,
 {
 	struct qlcnic_vf_info *vf = trans->vf;
 	struct qlcnic_vport *vp = vf->vp;
-	u8 cmd_op, mode = vp->vlan_mode;
+	u8 mode = vp->vlan_mode;
 	struct qlcnic_adapter *adapter;
 	struct qlcnic_sriov *sriov;
 
 	adapter = vf->adapter;
 	sriov = adapter->ahw->sriov;
 
-	cmd_op = trans->req_hdr->cmd_op;
 	cmd->rsp.arg[0] |= 1 << 25;
 
 	/* For 84xx adapter in case of PVID , PFD should send vlan mode as
-- 
2.7.0


