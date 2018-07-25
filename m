Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A52C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25042064D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25042064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbeGYJN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 05:13:57 -0400
Received: from mga01.intel.com ([192.55.52.88]:40581 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728505AbeGYJNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 05:13:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2018 01:03:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,400,1526367600"; 
   d="scan'208";a="70119348"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jul 2018 01:03:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 700D52BC; Wed, 25 Jul 2018 11:03:22 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] thunderbolt: Use correct ICM commands in system suspend
Date:   Wed, 25 Jul 2018 11:03:19 +0300
Message-Id: <20180725080321.35746-6-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180725080321.35746-1-mika.westerberg@linux.intel.com>
References: <20180725080321.35746-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct way to put the ICM into suspend state is to send it
NHI_MAILBOX_DRV_UNLOADS mailbox command. NHI_MAILBOX_SAVE_DEVS is not
needed on Intel Titan Ridge so we can skip it.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/icm.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index ad4eeaa59b16..5ed3f8a31b0a 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -60,6 +60,7 @@
  * @is_supported: Checks if we can support ICM on this controller
  * @get_mode: Read and return the ICM firmware mode (optional)
  * @get_route: Find a route string for given switch
+ * @save_devices: Ask ICM to save devices to ACL when suspending (optional)
  * @driver_ready: Send driver ready message to ICM
  * @device_connected: Handle device connected ICM message
  * @device_disconnected: Handle device disconnected ICM message
@@ -76,6 +77,7 @@ struct icm {
 	bool (*is_supported)(struct tb *tb);
 	int (*get_mode)(struct tb *tb);
 	int (*get_route)(struct tb *tb, u8 link, u8 depth, u64 *route);
+	void (*save_devices)(struct tb *tb);
 	int (*driver_ready)(struct tb *tb,
 			    enum tb_security_level *security_level,
 			    size_t *nboot_acl);
@@ -258,6 +260,11 @@ static int icm_fr_get_route(struct tb *tb, u8 link, u8 depth, u64 *route)
 	return ret;
 }
 
+static void icm_fr_save_devices(struct tb *tb)
+{
+	nhi_mailbox_cmd(tb->nhi, NHI_MAILBOX_SAVE_DEVS, 0);
+}
+
 static int
 icm_fr_driver_ready(struct tb *tb, enum tb_security_level *security_level,
 		    size_t *nboot_acl)
@@ -1665,13 +1672,12 @@ static int icm_driver_ready(struct tb *tb)
 
 static int icm_suspend(struct tb *tb)
 {
-	int ret;
+	struct icm *icm = tb_priv(tb);
 
-	ret = nhi_mailbox_cmd(tb->nhi, NHI_MAILBOX_SAVE_DEVS, 0);
-	if (ret)
-		tb_info(tb, "Ignoring mailbox command error (%d) in %s\n",
-			ret, __func__);
+	if (icm->save_devices)
+		icm->save_devices(tb);
 
+	nhi_mailbox_cmd(tb->nhi, NHI_MAILBOX_DRV_UNLOADS, 0);
 	return 0;
 }
 
@@ -1879,6 +1885,7 @@ struct tb *icm_probe(struct tb_nhi *nhi)
 	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI:
 		icm->is_supported = icm_fr_is_supported;
 		icm->get_route = icm_fr_get_route;
+		icm->save_devices = icm_fr_save_devices;
 		icm->driver_ready = icm_fr_driver_ready;
 		icm->device_connected = icm_fr_device_connected;
 		icm->device_disconnected = icm_fr_device_disconnected;
@@ -1896,6 +1903,7 @@ struct tb *icm_probe(struct tb_nhi *nhi)
 		icm->is_supported = icm_ar_is_supported;
 		icm->get_mode = icm_ar_get_mode;
 		icm->get_route = icm_ar_get_route;
+		icm->save_devices = icm_fr_save_devices;
 		icm->driver_ready = icm_ar_driver_ready;
 		icm->device_connected = icm_fr_device_connected;
 		icm->device_disconnected = icm_fr_device_disconnected;
-- 
2.18.0

