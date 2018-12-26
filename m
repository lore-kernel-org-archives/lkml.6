Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5087DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2DB218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864923;
	bh=ix6BQ4iFK/BtGityYPUUl6oPHBdwvNrWvJtiJLpUc8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D4Rhby75lqkS3j3BsLgIt6mZGSeHIZ5u/ow7IqKDm0DWIDPVF6AsF7Si0+X+2vwmw
	 C8gRo4KVaoZpQH/3Gk5te/Gk0ski4HJil9HfzYkRlzb13YpydqSo0Zt57q71Veecge
	 BdI2JALnvZPlJ8UyK234obEFoyoB7O0ObBTiIl1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbeLZWzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:55:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:56346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730291AbeLZWy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:54:57 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6005121741;
        Wed, 26 Dec 2018 22:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864897;
        bh=ix6BQ4iFK/BtGityYPUUl6oPHBdwvNrWvJtiJLpUc8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z7ykhqQliACV/2Wzv9MBQjoPLeEu/r2llUh9uT+2fItFaIE2VqX1ypEJR/qoL5ZTG
         L/A3z2BwmTX0Czll1BRMdZLf2xNPo86rC8h9y4ZHFvtcUOuhVW4Rt0IcW/0/EbGSQs
         t9TtfAe/KINmFGN+BAcU1onIWIj9UL7/UDQwK5MQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 33/35] vxge: ensure data0 is initialized in when fetching firmware version information
Date:   Wed, 26 Dec 2018 17:41:40 -0500
Message-Id: <20181226224142.150866-33-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226224142.150866-1-sashal@kernel.org>
References: <20181226224142.150866-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit f7db2beb4c2c6cc8111f5ab90fc7363ca91107b6 ]

Currently variable data0 is not being initialized so a garbage value is
being passed to vxge_hw_vpath_fw_api and this value is being written to
the rts_access_steer_data0 register.  There are other occurrances where
data0 is being initialized to zero (e.g. in function
vxge_hw_upgrade_read_version) so I think it makes sense to ensure data0
is initialized likewise to 0.

Detected by CoverityScan, CID#140696 ("Uninitialized scalar variable")

Fixes: 8424e00dfd52 ("vxge: serialize access to steering control register")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/neterion/vxge/vxge-config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/neterion/vxge/vxge-config.c b/drivers/net/ethernet/neterion/vxge/vxge-config.c
index 6223930a8155..6f57b0b7d57a 100644
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

