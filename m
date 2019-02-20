Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06B8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB862147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="So0YMxkZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbfBTHMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 02:12:01 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24914 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfBTHMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 02:12:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550646721; x=1582182721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Tk5/ymUCtSagdiY+kvSyhh1HiqyYgHHb0Vp1thsVv9g=;
  b=So0YMxkZ5+v2cucnjv7HGJIdID/6kBtEkATBBWJU/mvEp/1csw9KXivp
   Errwy3MkBxY4qjjB1NV0E+9M2YYKasG8J1OboN/DTJ8ZxsHvK9H1Rw6Hx
   p2qjLacc1MUtM6pST0LpfkEa3V6Tut9Gzw+ShoecjBEXbvWpvccK6z5u5
   VHr2wOc5fognVCBMqWlnUJ6kGkIRv7+lvgOIXlYFrzhY78GRgZDHgKZjM
   S6ukazeTVIpAVaV3h/b5Z+wytIGDD+a1hZKo5pfKls8DXAoS/klHPD9ft
   //r1Tsw89MJjbqcizyJ5wQyWjB7yc9Gec+sbaPwkdj3ognVRy+XqkqDeK
   w==;
X-IronPort-AV: E=Sophos;i="5.58,388,1544457600"; 
   d="scan'208";a="103461522"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2019 15:12:00 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 19 Feb 2019 22:50:23 -0800
Received: from kfae422988.sdcorp.global.sandisk.com ([10.0.230.227])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Feb 2019 23:11:58 -0800
From:   Avri Altman <avri.altman@wdc.com>
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Bean Huo <beanhuo@micron.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: [REPOST PATCH v4 2/3] scsi: ufs: Allow reading descriptor via raw upiu
Date:   Wed, 20 Feb 2019 09:11:13 +0200
Message-Id: <1550646674-15258-3-git-send-email-avri.altman@wdc.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550646674-15258-1-git-send-email-avri.altman@wdc.com>
References: <1550646674-15258-1-git-send-email-avri.altman@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to read descriptors via raw upiu. This in fact was forbidden just
as a precaution, as ufs-bsg actually enforces which functionality is
supported.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
Reviewed-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Bean Huo <beanhuo@micron.com>
---
 drivers/scsi/ufs/ufshcd.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 5ca4581..7b5b601 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -5780,6 +5780,20 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 
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
@@ -5815,11 +5829,6 @@ int ufshcd_exec_raw_upiu_cmd(struct ufs_hba *hba,
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
@@ -5860,7 +5869,6 @@ int ufshcd_exec_raw_upiu_cmd(struct ufs_hba *hba,
 		break;
 	}
 
-out:
 	return err;
 }
 
-- 
1.9.1

