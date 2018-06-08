Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id NAGVEtFoGlu/UAAAmS7hNA
	; Fri, 08 Jun 2018 11:30:37 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EDEC96089E; Fri,  8 Jun 2018 11:30:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 79B63607A4;
	Fri,  8 Jun 2018 11:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 79B63607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753006AbeFHLad (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 07:30:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:32425 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752756AbeFHLaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 07:30:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2018 04:30:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,490,1520924400";
   d="scan'208";a="62389008"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Jun 2018 04:29:58 -0700
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jun Li <jun.li@nxp.com>,
        Mats Karrman <mats.dev.list@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 7/8] usb: typec: pi3usb30532: Start using generic state values
Date: Fri,  8 Jun 2018 14:29:40 +0300
Message-Id: <20180608112941.26332-8-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180608112941.26332-1-heikki.krogerus@linux.intel.com>
References: <20180608112941.26332-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of the tcpm specific mux states, using the generic
USB type-c connector state values, and with DisplayPort
using connector states defined for the DisplayPort Alt Mode.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/mux/pi3usb30532.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/typec/mux/pi3usb30532.c b/drivers/usb/typec/mux/pi3usb30532.c
index b0e88db60ecf..bcea242852f2 100644
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
-			   PI3USB30532_CONF_USB3;
+			PI3USB30532_CONF_USB3;
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
2.17.1
