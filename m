Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D0DC43612
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 11:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A64E20879
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 11:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfAMLbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 06:31:08 -0500
Received: from mga17.intel.com ([192.55.52.151]:22351 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfAMLbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 06:31:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2019 03:31:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,473,1539673200"; 
   d="scan'208";a="266762705"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by orsmga004.jf.intel.com with ESMTP; 13 Jan 2019 03:31:05 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>, stable@vger.kernel.org
Subject: [char-misc 1/3] mei: dma: silent the reject message
Date:   Sun, 13 Jan 2019 14:24:46 +0200
Message-Id: <20190113122449.7252-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all FW versions support DMA on their first release,
hence it is normal behavior to receive a reject response
upon DMA setup request.
In order to prevent confusion, the DMA setup reject message
is printed only in debug level.

Cc: <stable@vger.kernel.org> #v5.0+
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/hbm.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/mei/hbm.c b/drivers/misc/mei/hbm.c
index 78c26cebf5d4..8f7616557c97 100644
--- a/drivers/misc/mei/hbm.c
+++ b/drivers/misc/mei/hbm.c
@@ -1187,9 +1187,15 @@ int mei_hbm_dispatch(struct mei_device *dev, struct mei_msg_hdr *hdr)
 		dma_setup_res = (struct hbm_dma_setup_response *)mei_msg;
 
 		if (dma_setup_res->status) {
-			dev_info(dev->dev, "hbm: dma setup response: failure = %d %s\n",
-				 dma_setup_res->status,
-				 mei_hbm_status_str(dma_setup_res->status));
+			u8 status = dma_setup_res->status;
+
+			if (status == MEI_HBMS_NOT_ALLOWED) {
+				dev_dbg(dev->dev, "hbm: dma setup not allowed\n");
+			} else {
+				dev_info(dev->dev, "hbm: dma setup response: failure = %d %s\n",
+					 status,
+					 mei_hbm_status_str(status));
+			}
 			dev->hbm_f_dr_supported = 0;
 			mei_dmam_ring_free(dev);
 		}
-- 
2.20.1

