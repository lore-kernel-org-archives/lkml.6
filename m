Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004B3C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA662083D
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA662083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeHaW24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 18:28:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36010 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbeHaW2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 18:28:55 -0400
Received: from [114.245.33.124] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <aaron.ma@canonical.com>)
        id 1fvo1k-0001o1-UX; Fri, 31 Aug 2018 18:20:13 +0000
From:   Aaron Ma <aaron.ma@canonical.com>
To:     aaron.ma@canonical.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        gustavo@padovan.org
Subject: [PATCH 2/2] vgaarb: Keep adding VGA device in queue
Date:   Sat,  1 Sep 2018 02:20:00 +0800
Message-Id: <1535739600-8842-2-git-send-email-aaron.ma@canonical.com>
X-Mailer: git-send-email 1.8.5.5
In-Reply-To: <1535739600-8842-1-git-send-email-aaron.ma@canonical.com>
References: <1535739600-8842-1-git-send-email-aaron.ma@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If failed to find the deivice owning the boot framebuffer,
try to use the first VGA device instead of the last one.

Usually the 1st device is integrated GPU who owns the boot framebuffer.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/gpu/vga/vgaarb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
index 8d90e66994b0..dc8e039bfab5 100644
--- a/drivers/gpu/vga/vgaarb.c
+++ b/drivers/gpu/vga/vgaarb.c
@@ -676,7 +676,7 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
 	vga_arbiter_check_bridge_sharing(vgadev);
 
 	/* Add to the list */
-	list_add(&vgadev->list, &vga_list);
+	list_add_tail(&vgadev->list, &vga_list);
 	vga_count++;
 	vgaarb_info(&pdev->dev, "VGA device added: decodes=%s,owns=%s,locks=%s\n",
 		vga_iostate_to_str(vgadev->decodes),
-- 
2.17.1

