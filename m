Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48564C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 082462075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 082462075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbeIHCF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:05:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46394 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeIHCF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:05:59 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C270AEF6;
        Fri,  7 Sep 2018 21:23:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 4.18 125/145] udlfb: make a local copy of fb_ops
Date:   Fri,  7 Sep 2018 23:09:51 +0200
Message-Id: <20180907210913.261157540@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 2c29cfc3eaf11779176bf41475cfca49bccba11c upstream.

The defio subsystem overwrites the method fb_osp->mmap. That method is
stored in module's static data - and that means that if we have multiple
diplaylink adapters, they will over write each other's method.

In order to avoid interference between multiple adapters, we copy the
fb_ops structure to a device-local memory.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/fbdev/udlfb.c |    3 ++-
 include/video/udlfb.h       |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1665,7 +1665,8 @@ static void dlfb_init_framebuffer_work(s
 	dlfb->info = info;
 	info->par = dlfb;
 	info->pseudo_palette = dlfb->pseudo_palette;
-	info->fbops = &dlfb_ops;
+	dlfb->ops = dlfb_ops;
+	info->fbops = &dlfb->ops;
 
 	retval = fb_alloc_cmap(&info->cmap, 256, 0);
 	if (retval < 0) {
--- a/include/video/udlfb.h
+++ b/include/video/udlfb.h
@@ -51,6 +51,7 @@ struct dlfb_data {
 	int base8;
 	u32 pseudo_palette[256];
 	int blank_mode; /*one of FB_BLANK_ */
+	struct fb_ops ops;
 	/* blit-only rendering path metrics, exposed through sysfs */
 	atomic_t bytes_rendered; /* raw pixel-bytes driver asked to render */
 	atomic_t bytes_identical; /* saved effort with backbuffer comparison */


