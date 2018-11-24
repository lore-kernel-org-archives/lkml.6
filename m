Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98295C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 14:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5709120645
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 14:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5709120645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbeKYBhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 20:37:18 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36519 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbeKYBhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 20:37:18 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gQZEe-0002Ks-JS; Sat, 24 Nov 2018 14:48:40 +0000
From:   Colin King <colin.king@canonical.com>
To:     Bernie Thompson <bernie@plugable.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] udlfb: don't call unregister_framebuffer on a null pointer
Date:   Sat, 24 Nov 2018 14:48:40 +0000
Message-Id: <20181124144840.14608-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Just before calling unregister_framebuffer with info there is a
null check on info, implying info may possibly zero.  Calling
unregister_framebuffer with a null pointer will cause a null
pointer dereference, fix this by moving the call to the block
where info has been null checked.

Detected by CoverityScan, CID#1473969 ("Dereference after null check")

Fixes: 68a958a915ca ("udlfb: handle unplug properly")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/video/fbdev/udlfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 070026a7e55a..cf8597f43d7e 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1735,9 +1735,9 @@ static void dlfb_usb_disconnect(struct usb_interface *intf)
 		for (i = 0; i < ARRAY_SIZE(fb_device_attrs); i++)
 			device_remove_file(info->dev, &fb_device_attrs[i]);
 		device_remove_bin_file(info->dev, &edid_attr);
+		unregister_framebuffer(info);
 	}
 
-	unregister_framebuffer(info);
 }
 
 static struct usb_driver dlfb_driver = {
-- 
2.19.1

