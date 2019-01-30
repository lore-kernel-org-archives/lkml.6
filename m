Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF75C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBB02184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388164AbfA3VcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 16:32:20 -0500
Received: from mga17.intel.com ([192.55.52.151]:59632 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731978AbfA3VcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 16:32:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2019 13:32:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,542,1539673200"; 
   d="scan'208";a="139303506"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga002.fm.intel.com with ESMTP; 30 Jan 2019 13:32:19 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] HID: intel-ish-hid: Use VID/PID from ISH
Date:   Wed, 30 Jan 2019 13:32:17 -0800
Message-Id: <20190130213217.8060-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Intel ISH HID can now have other devices attached to it, not just
sensors. Hence ISH HID transport is no longer just used for sensors.
Currently the vendor and product id is hardcoded for sensors, but they
can be obtained from ISH firmware for the real device. The driver already
extract them and store as part of device_info structure in client_data.
So use vendor id/product id obtained from the ISH firmware.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ishtp-hid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid.c b/drivers/hid/intel-ish-hid/ishtp-hid.c
index e918d78e541c..bc4c536f3c0d 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid.c
@@ -206,8 +206,8 @@ int ishtp_hid_probe(unsigned int cur_hid_dev,
 	hid->bus = BUS_INTEL_ISHTP;
 	hid->dev.parent = &client_data->cl_device->dev;
 	hid->version = le16_to_cpu(ISH_HID_VERSION);
-	hid->vendor = le16_to_cpu(ISH_HID_VENDOR);
-	hid->product = le16_to_cpu(ISH_HID_PRODUCT);
+	hid->vendor = le16_to_cpu(client_data->hid_devices[cur_hid_dev].vid);
+	hid->product = le16_to_cpu(client_data->hid_devices[cur_hid_dev].pid);
 	snprintf(hid->name, sizeof(hid->name), "%s %04X:%04X", "hid-ishtp",
 		hid->vendor, hid->product);
 
-- 
2.17.2

