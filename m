Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3109C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 22:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF0620833
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 22:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfBBW4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 17:56:30 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:46319 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfBBW4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 17:56:30 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gq4D5-0007MK-Gj; Sat, 02 Feb 2019 22:56:27 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Whitmore <johnfwhitmore@gmail.com>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192u: fix a null pointer dereference on a null dev pointer
Date:   Sat,  2 Feb 2019 22:56:27 +0000
Message-Id: <20190202225627.27116-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is an earlier null check on pointer dev which implies it may be null,
however the assignment of pointer pref and the call to free_ieee82011 on
a null dev can cause null pointer dereference errors.  Fix this by moving
the assignment of priv and the the call to free_ieee80211 into the block of
code that performs the null dev sanity check.

Detected by CoverityScan, CID#143078 ("Dereference after null check")

Fixes: 8fc8598e61f6 ("Staging: Added Realtek rtl8192u driver to staging")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 0ac0bbf7d923..4741a29326ea 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -4955,9 +4955,10 @@ static void rtl8192_cancel_deferred_work(struct r8192_priv *priv)
 static void rtl8192_usb_disconnect(struct usb_interface *intf)
 {
 	struct net_device *dev = usb_get_intfdata(intf);
-	struct r8192_priv *priv = ieee80211_priv(dev);
 
 	if (dev) {
+		struct r8192_priv *priv = ieee80211_priv(dev);
+
 		unregister_netdev(dev);
 
 		RT_TRACE(COMP_DOWN,
@@ -4969,8 +4970,8 @@ static void rtl8192_usb_disconnect(struct usb_interface *intf)
 		priv->pFirmware = NULL;
 		rtl8192_usb_deleteendpoints(dev);
 		usleep_range(10000, 11000);
+		free_ieee80211(dev);
 	}
-	free_ieee80211(dev);
 	RT_TRACE(COMP_DOWN, "wlan driver removed\n");
 }
 
-- 
2.20.1

