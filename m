Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EE0C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F76420852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F76420852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936142AbeFRLHq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:07:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:43897 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936057AbeFRLHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:07:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 04:07:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,238,1526367600"; 
   d="scan'208";a="64113342"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 18 Jun 2018 04:07:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id AABF7553; Mon, 18 Jun 2018 14:07:31 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christian Kellner <christian@kellner.me>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 4/5] thunderbolt: Use correct ICM commands in system suspend
Date:   Mon, 18 Jun 2018 14:07:30 +0300
Message-Id: <20180618110731.57427-5-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618110731.57427-1-mika.westerberg@linux.intel.com>
References: <20180618110731.57427-1-mika.westerberg@linux.intel.com>
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
2.17.1

