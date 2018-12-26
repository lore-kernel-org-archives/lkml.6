Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2021C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFA6218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545866548;
	bh=cgAvGLw5MKumpvZHD0fd2AvbD0PKD7fkvs79h4LY5jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yE01H/B1agyJGnNzUt1+2IwrICeCJL0O3CmH/+7mPqYnIfH8LeiQXebdD0ZYtF/cP
	 g3EIZ91a2u7jPiNExVXYohfRefv7cJ6JIM9jyntL7Yl+mG75fjRG65FULW2GkiMXhC
	 zK8xXr3ii7i6ts5smxPsIwOldjGP+niyiRLckSQU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbeLZXW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 18:22:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:44058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728704AbeLZXWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 18:22:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77E0320811;
        Wed, 26 Dec 2018 23:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545866541;
        bh=cgAvGLw5MKumpvZHD0fd2AvbD0PKD7fkvs79h4LY5jc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ln+zydmwdyCOqqkbUHw36wUOUykFxuntH9yqTx3M1vWU8gjflCkV5yNKYcRJgosao
         Xntmh3UoFdEZdtcgdOPO6TCiK+Q8nSo0Mo1mommvxrzQxnG0upL+5cOcge1wZITszI
         1sw4hT+fUztLXrvubxhaJ+TbyasK5FhNFh67txrg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 10/12] vxge: ensure data0 is initialized in when fetching firmware version information
Date:   Wed, 26 Dec 2018 17:57:38 -0500
Message-Id: <20181226225741.151608-10-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226225741.151608-1-sashal@kernel.org>
References: <20181226225741.151608-1-sashal@kernel.org>
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
index 2bbd01fcb9b0..4332ebbd7162 100644
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

