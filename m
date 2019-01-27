Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AB0C282C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 07:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329DC214C6
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 07:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PibYvW6p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfA0HIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 02:08:31 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:4391 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfA0HIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 02:08:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1548572911; x=1580108911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=QxuRPPDSvUnjZmfzIphSkJNf+emFCuhe7yO3D1CmbuY=;
  b=PibYvW6pyf/DoPsCurOmo8nvdFV2YhgTebNGfw6Acu1PdEke/Dh7/qcz
   82WVQb9JtfelCFixDEJN+1nBSWjLmHnGOLPly4pIs46mqPm3CoPIttbDj
   VPN8IXdy6TdKp0Mccu9NScC+tigT0xEXxK3WUO6ANxe4sYgTC2yxhi4an
   xr6Dxz/Bq/FebsItpX9K+ZvkFqiP9hKcbAK9U3wp5QGR0nJH/S7d3mmiC
   EBwWFAqOsSKlUQWnB1lpNKKuta++yVuS5XTnfkPrePW7+emmGirxcFFss
   zlvGz7DBHnz2pqpdT4KPXbHtAo7MvmEdeQx9tNRDtyVx5Y15LjT791cmy
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,529,1539619200"; 
   d="scan'208";a="99875948"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2019 15:08:31 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 26 Jan 2019 22:47:36 -0800
Received: from kfae422988.sdcorp.global.sandisk.com ([10.0.230.227])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Jan 2019 23:08:28 -0800
From:   Avri Altman <avri.altman@wdc.com>
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evan Green <evgreen@chromium.org>
Cc:     Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v4 2/3] scsi: ufs: Allow reading descriptor via raw upiu
Date:   Sun, 27 Jan 2019 09:07:47 +0200
Message-Id: <1548572868-12589-3-git-send-email-avri.altman@wdc.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548572868-12589-1-git-send-email-avri.altman@wdc.com>
References: <1548572868-12589-1-git-send-email-avri.altman@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to read descriptors via raw upiu. This in fact was forbidden just
as a precaution, as ufs-bsg actually enforces which functionality is
supported.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
Reviewed-by: Evan Green <evgreen@chromium.org>
---
 drivers/scsi/ufs/ufshcd.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 2ddf244..6b9ed21 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -5775,6 +5775,20 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 
 	/* just copy the upiu response as it is */
 	memcpy(rsp_upiu, lrbp->ucd_rsp_ptr, sizeof(*rsp_upiu));
+	if (desc_buff && desc_op == UPIU_QUERY_OPCODE_READ_DESC) {
+		u8 *descp = (u8 *)lrbp->ucd_rsp_ptr + sizeof(*rsp_upiu);
+		u16 resp_len = be32_to_cpu(lrbp->ucd_rsp_ptr->header.dword_2) &
+			       MASK_QUERY_DATA_SEG_LEN;
+
+		if (*buff_len >= resp_len) {
+			memcpy(desc_buff, descp, resp_len);
+			*buff_len = resp_len;
+		} else {
+			dev_warn(hba->dev, "rsp size is bigger than buffer");
+			*buff_len = 0;
+			err = -EINVAL;
+		}
+	}
 
 	ufshcd_put_dev_cmd_tag(hba, tag);
 	wake_up(&hba->dev_cmd.tag_wq);
@@ -5810,11 +5824,6 @@ int ufshcd_exec_raw_upiu_cmd(struct ufs_hba *hba,
 	int ocs_value;
 	u8 tm_f = be32_to_cpu(req_upiu->header.dword_1) >> 16 & MASK_TM_FUNC;
 
-	if (desc_buff && desc_op != UPIU_QUERY_OPCODE_WRITE_DESC) {
-		err = -ENOTSUPP;
-		goto out;
-	}
-
 	switch (msgcode) {
 	case UPIU_TRANSACTION_NOP_OUT:
 		cmd_type = DEV_CMD_TYPE_NOP;
@@ -5855,7 +5864,6 @@ int ufshcd_exec_raw_upiu_cmd(struct ufs_hba *hba,
 		break;
 	}
 
-out:
 	return err;
 }
 
-- 
1.9.1

