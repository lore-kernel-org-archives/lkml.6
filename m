Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Hx6gISdRGFtpTgAAmS7hNA
	; Wed, 06 Jun 2018 21:32:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 165EF608BF; Wed,  6 Jun 2018 21:32:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 86332607F7;
	Wed,  6 Jun 2018 21:32:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 86332607F7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932108AbeFFVci (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 17:32:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:11662 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752042AbeFFVcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 17:32:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2018 14:32:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,484,1520924400";
   d="scan'208";a="47331358"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.43])
  by orsmga008.jf.intel.com with ESMTP; 06 Jun 2018 14:32:34 -0700
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc 2/2] mei: discard messages from not connected client during power down.
Date: Thu,  7 Jun 2018 00:31:48 +0300
Message-Id: <20180606213148.9469-3-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180606213148.9469-1-tomas.winkler@intel.com>
References: <20180606213148.9469-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

This fixes regression introduced by
commit 8d52af6795c0 ("mei: speed up the power down flow")

In power down or suspend flow a message can still be received
from the FW because the clients fake disconnection.
In normal case we interpret messages w/o destination as corrupted
and link reset is performed in order to clean the channel,
but during power down link reset is already in progress resulting
in endless loop. To resolve the issue under power down flow we
discard messages silently.

Cc: <stable@vger.kernel.org> 4.16+
Fixes: 8d52af6795c0 ("mei: speed up the power down flow")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=199541
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/interrupt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/mei/interrupt.c b/drivers/misc/mei/interrupt.c
index b0b8f18a85e3..6649f0d56d2f 100644
--- a/drivers/misc/mei/interrupt.c
+++ b/drivers/misc/mei/interrupt.c
@@ -310,8 +310,11 @@ int mei_irq_read_handler(struct mei_device *dev,
 	if (&cl->link == &dev->file_list) {
 		/* A message for not connected fixed address clients
 		 * should be silently discarded
+		 * On power down client may be force cleaned,
+		 * silently discard such messages
 		 */
-		if (hdr_is_fixed(mei_hdr)) {
+		if (hdr_is_fixed(mei_hdr) ||
+		    dev->dev_state == MEI_DEV_POWER_DOWN) {
 			mei_irq_discard_msg(dev, mei_hdr);
 			ret = 0;
 			goto reset_slots;
-- 
2.14.4
