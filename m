Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCEBECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8436F2088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8436F2088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbeIQUOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:14:48 -0400
Received: from mga05.intel.com ([192.55.52.43]:5525 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727052AbeIQUOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:14:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2018 07:47:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,385,1531810800"; 
   d="scan'208";a="70657958"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 17 Sep 2018 07:43:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 15DBF1AA; Mon, 17 Sep 2018 17:43:35 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Anthony Wong <anthony.wong@canonical.com>
Subject: [PATCH v2 2/4] thunderbolt: Print connected devices
Date:   Mon, 17 Sep 2018 17:43:32 +0300
Message-Id: <20180917144334.18367-3-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180917144334.18367-1-mika.westerberg@linux.intel.com>
References: <20180917144334.18367-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous patch made the driver less verbose meanining that all the
switch structures and ports are now logged as debug level. However, we
have been missing similar output that USB for intance prints when a new
USB device is connected and disconnected. This information is useful for
end users as well as developers because it immediately shows the actual
device that was connected.

This patch adds printing of the actual connected devices to the driver.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/switch.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 81134ee29578..9f44a2924dac 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1402,6 +1402,14 @@ int tb_switch_add(struct tb_switch *sw)
 	if (ret)
 		return ret;
 
+	if (tb_route(sw)) {
+		dev_info(&sw->dev, "new device found, vendor=%#x device=%#x\n",
+			 sw->vendor, sw->device);
+		if (sw->vendor_name && sw->device_name)
+			dev_info(&sw->dev, "%s %s\n", sw->vendor_name,
+				 sw->device_name);
+	}
+
 	ret = tb_switch_nvm_add(sw);
 	if (ret) {
 		device_del(&sw->dev);
@@ -1453,6 +1461,9 @@ void tb_switch_remove(struct tb_switch *sw)
 		tb_plug_events_active(sw, false);
 
 	tb_switch_nvm_remove(sw);
+
+	if (tb_route(sw))
+		dev_info(&sw->dev, "device disconnected\n");
 	device_unregister(&sw->dev);
 }
 
-- 
2.18.0

