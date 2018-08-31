Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E00C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87BE22083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87BE22083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbeHaW2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 18:28:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36005 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbeHaW2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 18:28:51 -0400
Received: from [114.245.33.124] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <aaron.ma@canonical.com>)
        id 1fvo1g-0001o1-Kt; Fri, 31 Aug 2018 18:20:09 +0000
From:   Aaron Ma <aaron.ma@canonical.com>
To:     aaron.ma@canonical.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        gustavo@padovan.org
Subject: [PATCH 1/2] vgaarb: Add support for 64-bit frame buffer address
Date:   Sat,  1 Sep 2018 02:19:59 +0800
Message-Id: <1535739600-8842-1-git-send-email-aaron.ma@canonical.com>
X-Mailer: git-send-email 1.8.5.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EFI GOP uses 64-bit frame buffer address when some BIOS
disabled CSM support. vgaarb only stores lfb_base,
this will lead boot framebuffer to wrong device.

Add ext_lfb_base support to use 64-bit fb address.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/gpu/vga/vgaarb.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
index c61b04555779..8d90e66994b0 100644
--- a/drivers/gpu/vga/vgaarb.c
+++ b/drivers/gpu/vga/vgaarb.c
@@ -1408,6 +1408,18 @@ static void __init vga_arb_select_default_device(void)
 	struct vga_device *vgadev;
 
 #if defined(CONFIG_X86) || defined(CONFIG_IA64)
+	u64 base = screen_info.lfb_base;
+	u64 size = screen_info.lfb_size;
+	u64 limit;
+	resource_size_t start, end;
+	unsigned long flags;
+	int i;
+
+	if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
+		base |= (u64)screen_info.ext_lfb_base << 32;
+
+	limit = base + size;
+
 	list_for_each_entry(vgadev, &vga_list, list) {
 		struct device *dev = &vgadev->pdev->dev;
 		/*
@@ -1418,11 +1430,6 @@ static void __init vga_arb_select_default_device(void)
 		 * Select the device owning the boot framebuffer if there is
 		 * one.
 		 */
-		resource_size_t start, end, limit;
-		unsigned long flags;
-		int i;
-
-		limit = screen_info.lfb_base + screen_info.lfb_size;
 
 		/* Does firmware framebuffer belong to us? */
 		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
@@ -1437,7 +1444,7 @@ static void __init vga_arb_select_default_device(void)
 			if (!start || !end)
 				continue;
 
-			if (screen_info.lfb_base < start || limit >= end)
+			if (base < start || limit >= end)
 				continue;
 
 			if (!vga_default_device())
-- 
2.17.1

