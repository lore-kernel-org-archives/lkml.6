Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AFAECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA6C52086E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA6C52086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbeIXQWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:22:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:60769 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbeIXQWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:22:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 03:21:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,297,1534834800"; 
   d="scan'208";a="94306177"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 24 Sep 2018 03:20:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id B880EB2; Mon, 24 Sep 2018 13:20:45 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] thunderbolt: Do not handle ICM events after domain is stopped
Date:   Mon, 24 Sep 2018 13:20:44 +0300
Message-Id: <20180924102045.75807-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180924102045.75807-1-mika.westerberg@linux.intel.com>
References: <20180924102045.75807-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is a long chain of devices connected when the driver is loaded
ICM sends device connected event for each and those are put to tb->wq
for later processing. Now if the driver gets unloaded in the middle, so
that the work queue is not yet empty it gets flushed by tb_domain_stop().
However, by that time the root switch is already removed so the driver
crashes when it tries to dereference it in ICM event handling callbacks.

Fix this by checking whether the root switch is already removed. If it
is we know that the domain is stopped and we should merely skip handling
the event.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/icm.c | 49 ++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index e1e264a9a4c7..28fc4ce75edb 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -738,14 +738,6 @@ icm_fr_xdomain_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 	u8 link, depth;
 	u64 route;
 
-	/*
-	 * After NVM upgrade adding root switch device fails because we
-	 * initiated reset. During that time ICM might still send
-	 * XDomain connected message which we ignore here.
-	 */
-	if (!tb->root_switch)
-		return;
-
 	link = pkg->link_info & ICM_LINK_INFO_LINK_MASK;
 	depth = (pkg->link_info & ICM_LINK_INFO_DEPTH_MASK) >>
 		ICM_LINK_INFO_DEPTH_SHIFT;
@@ -1037,14 +1029,6 @@ icm_tr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 	if (pkg->hdr.packet_id)
 		return;
 
-	/*
-	 * After NVM upgrade adding root switch device fails because we
-	 * initiated reset. During that time ICM might still send device
-	 * connected message which we ignore here.
-	 */
-	if (!tb->root_switch)
-		return;
-
 	route = get_route(pkg->route_hi, pkg->route_lo);
 	authorized = pkg->link_info & ICM_LINK_INFO_APPROVED;
 	security_level = (pkg->hdr.flags & ICM_FLAGS_SLEVEL_MASK) >>
@@ -1408,19 +1392,26 @@ static void icm_handle_notification(struct work_struct *work)
 
 	mutex_lock(&tb->lock);
 
-	switch (n->pkg->code) {
-	case ICM_EVENT_DEVICE_CONNECTED:
-		icm->device_connected(tb, n->pkg);
-		break;
-	case ICM_EVENT_DEVICE_DISCONNECTED:
-		icm->device_disconnected(tb, n->pkg);
-		break;
-	case ICM_EVENT_XDOMAIN_CONNECTED:
-		icm->xdomain_connected(tb, n->pkg);
-		break;
-	case ICM_EVENT_XDOMAIN_DISCONNECTED:
-		icm->xdomain_disconnected(tb, n->pkg);
-		break;
+	/*
+	 * When the domain is stopped we flush its workqueue but before
+	 * that the root switch is removed. In that case we should treat
+	 * the queued events as being canceled.
+	 */
+	if (tb->root_switch) {
+		switch (n->pkg->code) {
+		case ICM_EVENT_DEVICE_CONNECTED:
+			icm->device_connected(tb, n->pkg);
+			break;
+		case ICM_EVENT_DEVICE_DISCONNECTED:
+			icm->device_disconnected(tb, n->pkg);
+			break;
+		case ICM_EVENT_XDOMAIN_CONNECTED:
+			icm->xdomain_connected(tb, n->pkg);
+			break;
+		case ICM_EVENT_XDOMAIN_DISCONNECTED:
+			icm->xdomain_disconnected(tb, n->pkg);
+			break;
+		}
 	}
 
 	mutex_unlock(&tb->lock);
-- 
2.18.0

