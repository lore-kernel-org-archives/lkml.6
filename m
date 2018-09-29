Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B72C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 18:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172B320882
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 18:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 172B320882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbeI3BKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 21:10:44 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:40864 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbeI3BKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 21:10:44 -0400
Received: from svr-orw-mbx-02.mgc.mentorg.com ([147.34.90.202])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1g6KAx-0000Ow-VY from Steve_Longerbeam@mentor.com ; Sat, 29 Sep 2018 11:41:12 -0700
Received: from mappy.world.mentorg.com (147.34.91.1) by
 svr-orw-mbx-02.mgc.mentorg.com (147.34.90.202) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Sat, 29 Sep 2018 11:41:09 -0700
From:   Steve Longerbeam <steve_longerbeam@mentor.com>
To:     <linux-media@vger.kernel.org>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Sebastian Reichel <sre@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 01/17] media: v4l2-fwnode: ignore endpoints that have no remote port parent
Date:   Sat, 29 Sep 2018 11:40:36 -0700
Message-ID: <20180929184052.19479-2-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180929184052.19479-1-steve_longerbeam@mentor.com>
References: <20180929184052.19479-1-steve_longerbeam@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-04.mgc.mentorg.com (147.34.90.204) To
 svr-orw-mbx-02.mgc.mentorg.com (147.34.90.202)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/devicetree/bindings/media/video-interfaces.txt states that
the 'remote-endpoint' property is optional.

So v4l2_async_notifier_fwnode_parse_endpoint() should not return error
if the endpoint has no remote port parent. Just ignore the endpoint,
skip adding an asd to the notifier and return 0.
__v4l2_async_notifier_parse_fwnode_endpoints() will then continue
parsing the remaining port endpoints of the device.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
---
Changes since v6:
- none
Changes since v5:
- none
Changes since v4:
- none
Changes since v3:
- none
Changes since v2:
- none
Changes since v1:
- don't pass an empty endpoint to the parse_endpoint callback,
  v4l2_async_notifier_fwnode_parse_endpoint() now just ignores them
  and returns success. The current users of
  v4l2_async_notifier_parse_fwnode_endpoints() (omap3isp, rcar-vin,
  intel-ipu3) no longer need modification.
---
 drivers/media/v4l2-core/v4l2-fwnode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index 169bdbb1f61a..0b8c736b1606 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -367,7 +367,7 @@ static int v4l2_async_notifier_fwnode_parse_endpoint(
 		fwnode_graph_get_remote_port_parent(endpoint);
 	if (!asd->match.fwnode) {
 		dev_warn(dev, "bad remote port parent\n");
-		ret = -EINVAL;
+		ret = -ENOTCONN;
 		goto out_err;
 	}
 
-- 
2.17.1

