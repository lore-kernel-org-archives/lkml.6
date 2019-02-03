Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7ECFC282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B79E0205C9
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbfBCOUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:20:34 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55390 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729840AbfBCOUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:25 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIdD-0006Is-Ui; Sun, 03 Feb 2019 14:20:24 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqICc-0008Lx-Ui; Sun, 03 Feb 2019 14:52:54 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Colin Ian King" <colin.king@canonical.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.872160895@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 300/305] vxge: ensure data0 is initialized in when
 fetching firmware version information
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

commit f7db2beb4c2c6cc8111f5ab90fc7363ca91107b6 upstream.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/neterion/vxge/vxge-config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/neterion/vxge/vxge-config.c
+++ b/drivers/net/ethernet/neterion/vxge/vxge-config.c
@@ -808,7 +808,7 @@ __vxge_hw_vpath_fw_ver_get(struct __vxge
 	struct vxge_hw_device_date *fw_date = &hw_info->fw_date;
 	struct vxge_hw_device_version *flash_version = &hw_info->flash_version;
 	struct vxge_hw_device_date *flash_date = &hw_info->flash_date;
-	u64 data0, data1 = 0, steer_ctrl = 0;
+	u64 data0 = 0, data1 = 0, steer_ctrl = 0;
 	enum vxge_hw_status status;
 
 	status = vxge_hw_vpath_fw_api(vpath,

