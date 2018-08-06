Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D46BC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05BE21A52
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F05BE21A52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732376AbeHFQ7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 12:59:08 -0400
Received: from mga06.intel.com ([134.134.136.31]:6633 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731194AbeHFQ7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 12:59:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2018 07:49:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,452,1526367600"; 
   d="scan'208";a="79309088"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by orsmga001.jf.intel.com with ESMTP; 06 Aug 2018 07:49:39 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: [char-misc-next] mei: ignore not found client in the enumeration
Date:   Mon,  6 Aug 2018 17:47:33 +0300
Message-Id: <20180806144733.19680-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

Some of the ME clients are available only for BIOS operation and are
removed during hand off to an OS. However the removal is not instant.
A client may be visible on the client list when the mei driver requests
for enumeration, while the subsequent request for properties will be
answered with client not found error value. The default behavior
for an error is to perform client reset while this error is harmless and
the link reset should be prevented. This issue started to be visible due to
suspend/resume timing changes. Currently reported only on the Haswell
based system.

Fixes:
[33.564957] mei_me 0000:00:16.0: hbm: properties response: wrong status = 1 CLIENT_NOT_FOUND
[33.564978] mei_me 0000:00:16.0: mei_irq_read_handler ret = -71.
[33.565270] mei_me 0000:00:16.0: unexpected reset: dev_state = INIT_CLIENTS fw status = 1E000255 60002306 00000200 00004401 00000000 00000010

Cc: <stable@vger.kernel.org>
Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/hbm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/mei/hbm.c b/drivers/misc/mei/hbm.c
index f15d44bda28e..fa0f8e91e86f 100644
--- a/drivers/misc/mei/hbm.c
+++ b/drivers/misc/mei/hbm.c
@@ -1244,15 +1244,18 @@ int mei_hbm_dispatch(struct mei_device *dev, struct mei_msg_hdr *hdr)
 
 		props_res = (struct hbm_props_response *)mei_msg;
 
-		if (props_res->status) {
+		if (props_res->status == MEI_HBMS_CLIENT_NOT_FOUND) {
+			dev_dbg(dev->dev, "hbm: properties response: %d CLIENT_NOT_FOUND\n",
+				props_res->me_addr);
+		} else if (props_res->status) {
 			dev_err(dev->dev, "hbm: properties response: wrong status = %d %s\n",
 				props_res->status,
 				mei_hbm_status_str(props_res->status));
 			return -EPROTO;
+		} else {
+			mei_hbm_me_cl_add(dev, props_res);
 		}
 
-		mei_hbm_me_cl_add(dev, props_res);
-
 		/* request property for the next client */
 		if (mei_hbm_prop_req(dev, props_res->me_addr + 1))
 			return -EIO;
-- 
2.14.4

