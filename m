Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E1CC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE862080F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731258AbfBDPSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:18:47 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50636 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfBDPSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 10:18:46 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gqg1D-0003dY-T6; Mon, 04 Feb 2019 15:18:43 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Whitmore <johnfwhitmore@gmail.com>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] staging: rtl8192u: remove redundant nul check on pointer dev
Date:   Mon,  4 Feb 2019 15:18:43 +0000
Message-Id: <20190204151843.15915-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a null check on pointer dev which implies it may be null, however
dev can never be null as it is set in rtl8192_usb_probe via the call
to usb_set_intfdata.

Detected by CoverityScan, CID#143078 ("Dereference after null check")

Fixes: 8fc8598e61f6 ("Staging: Added Realtek rtl8192u driver to staging")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: 
1. change title of commit from "staging: rtl8192u: fix a null pointer 
   dereference on a null dev pointer"
2. remove null check, thanks to Dan Carpenter for spotting this

---

 drivers/staging/rtl8192u/r8192U_core.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 0ac0bbf7d923..f1eaab337dca 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -4957,20 +4957,18 @@ static void rtl8192_usb_disconnect(struct usb_interface *intf)
 	struct net_device *dev = usb_get_intfdata(intf);
 	struct r8192_priv *priv = ieee80211_priv(dev);
 
-	if (dev) {
-		unregister_netdev(dev);
-
-		RT_TRACE(COMP_DOWN,
-			 "=============>wlan driver to be removed\n");
-		rtl8192_proc_remove_one(dev);
-
-		rtl8192_down(dev);
-		kfree(priv->pFirmware);
-		priv->pFirmware = NULL;
-		rtl8192_usb_deleteendpoints(dev);
-		usleep_range(10000, 11000);
-	}
+	unregister_netdev(dev);
+
+	RT_TRACE(COMP_DOWN, "=============>wlan driver to be removed\n");
+	rtl8192_proc_remove_one(dev);
+
+	rtl8192_down(dev);
+	kfree(priv->pFirmware);
+	priv->pFirmware = NULL;
+	rtl8192_usb_deleteendpoints(dev);
+	usleep_range(10000, 11000);
 	free_ieee80211(dev);
+
 	RT_TRACE(COMP_DOWN, "wlan driver removed\n");
 }
 
-- 
2.20.1

