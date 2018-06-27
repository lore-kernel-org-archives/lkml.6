Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC1EC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8AD625E5E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8AD625E5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934639AbeF0PUP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:20:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:5408 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933703AbeF0PUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:20:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2018 08:20:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,279,1526367600"; 
   d="scan'208";a="67768818"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jun 2018 08:20:09 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>,
        Mats Karrman <mats.dev.list@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] usb: typec: pi3usb30532: Start using generic state values
Date:   Wed, 27 Jun 2018 18:19:52 +0300
Message-Id: <20180627151953.30942-8-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180627151953.30942-1-heikki.krogerus@linux.intel.com>
References: <20180627151953.30942-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of the tcpm specific mux states, using the generic
USB Type-C connector state values, and with DisplayPort
using connector states defined for the DisplayPort Alt Mode.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/mux/pi3usb30532.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/typec/mux/pi3usb30532.c b/drivers/usb/typec/mux/pi3usb30532.c
index b0e88db60ecf..64eb5983e17a 100644
--- a/drivers/usb/typec/mux/pi3usb30532.c
+++ b/drivers/usb/typec/mux/pi3usb30532.c
@@ -9,7 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/usb/tcpm.h>
+#include <linux/usb/typec_dp.h>
 #include <linux/usb/typec_mux.h>
 
 #define PI3USB30532_CONF			0x00
@@ -83,21 +83,24 @@ static int pi3usb30532_mux_set(struct typec_mux *mux, int state)
 	new_conf = pi->conf;
 
 	switch (state) {
-	case TYPEC_MUX_NONE:
+	case TYPEC_STATE_SAFE:
 		new_conf = PI3USB30532_CONF_OPEN;
 		break;
-	case TYPEC_MUX_USB:
+	case TYPEC_STATE_USB:
 		new_conf = (new_conf & PI3USB30532_CONF_SWAP) |
 			   PI3USB30532_CONF_USB3;
 		break;
-	case TYPEC_MUX_DP:
+	case TYPEC_DP_STATE_C:
+	case TYPEC_DP_STATE_E:
 		new_conf = (new_conf & PI3USB30532_CONF_SWAP) |
 			   PI3USB30532_CONF_4LANE_DP;
 		break;
-	case TYPEC_MUX_DOCK:
+	case TYPEC_DP_STATE_D:
 		new_conf = (new_conf & PI3USB30532_CONF_SWAP) |
 			   PI3USB30532_CONF_USB3_AND_2LANE_DP;
 		break;
+	default:
+		break;
 	}
 
 	ret = pi3usb30532_set_conf(pi, new_conf);
-- 
2.18.0

