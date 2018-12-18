Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C28C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9D8218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbeLRPTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:19:50 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33021 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbeLRPTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:19:50 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gZH9v-00050O-Ga; Tue, 18 Dec 2018 15:19:47 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jon Mason <jdmason@kudzu.us>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] vxge: ensure data0 is initialized in when fetching firmware version information
Date:   Tue, 18 Dec 2018 15:19:47 +0000
Message-Id: <20181218151947.31406-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently variable data0 is not being initialized so a garbage value is
being passed to vxge_hw_vpath_fw_api and this value is being written to
the rts_access_steer_data0 register.  There are other occurrances where
data0 is being initialized to zero (e.g. in function
vxge_hw_upgrade_read_version) so I think it makes sense to ensure data0
is initialized likewise to 0.

Detected by CoverityScan, CID#140696 ("Uninitialized scalar variable")

Fixes: 8424e00dfd52 ("vxge: serialize access to steering control register")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/neterion/vxge/vxge-config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/neterion/vxge/vxge-config.c b/drivers/net/ethernet/neterion/vxge/vxge-config.c
index 4c1fb7e57888..7cde387e5ec6 100644
--- a/drivers/net/ethernet/neterion/vxge/vxge-config.c
+++ b/drivers/net/ethernet/neterion/vxge/vxge-config.c
@@ -808,7 +808,7 @@ __vxge_hw_vpath_fw_ver_get(struct __vxge_hw_virtualpath *vpath,
 	struct vxge_hw_device_date *fw_date = &hw_info->fw_date;
 	struct vxge_hw_device_version *flash_version = &hw_info->flash_version;
 	struct vxge_hw_device_date *flash_date = &hw_info->flash_date;
-	u64 data0, data1 = 0, steer_ctrl = 0;
+	u64 data0 = 0, data1 = 0, steer_ctrl = 0;
 	enum vxge_hw_status status;
 
 	status = vxge_hw_vpath_fw_api(vpath,
-- 
2.19.1

