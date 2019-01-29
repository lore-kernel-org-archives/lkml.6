Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21630C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE33220856
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbfA2URt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:17:49 -0500
Received: from gateway34.websitewelcome.com ([192.185.148.204]:33043 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727308AbfA2URt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 15:17:49 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 46627BCC23
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 14:17:48 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id oZpMgAZ0g90onoZpMgafs3; Tue, 29 Jan 2019 14:17:48 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=48550 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1goZpH-0019U8-0t; Tue, 29 Jan 2019 14:17:47 -0600
Date:   Tue, 29 Jan 2019 14:17:42 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/via: mark expected switch fall-throughs
Message-ID: <20190129201742.GA25660@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1goZpH-0019U8-0t
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:48550
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

This patch fixes the following warnings:

drivers/gpu/drm/via/via_dmablit.c:179:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/gpu/drm/via/via_dmablit.c:185:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/gpu/drm/via/via_dmablit.c:187:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/gpu/drm/via/via_dmablit.c:195:3: warning: this statement may fall through [-Wimplicit-fallthrough=]

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enabling
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/via/via_dmablit.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/via/via_dmablit.c b/drivers/gpu/drm/via/via_dmablit.c
index 345bda4494e1..8bf3a7c23ed3 100644
--- a/drivers/gpu/drm/via/via_dmablit.c
+++ b/drivers/gpu/drm/via/via_dmablit.c
@@ -177,12 +177,14 @@ via_free_sg_info(struct pci_dev *pdev, drm_via_sg_info_t *vsg)
 	switch (vsg->state) {
 	case dr_via_device_mapped:
 		via_unmap_blit_from_device(pdev, vsg);
+		/* fall through */
 	case dr_via_desc_pages_alloc:
 		for (i = 0; i < vsg->num_desc_pages; ++i) {
 			if (vsg->desc_pages[i] != NULL)
 				free_page((unsigned long)vsg->desc_pages[i]);
 		}
 		kfree(vsg->desc_pages);
+		/* fall through */
 	case dr_via_pages_locked:
 		for (i = 0; i < vsg->num_pages; ++i) {
 			if (NULL != (page = vsg->pages[i])) {
@@ -191,8 +193,10 @@ via_free_sg_info(struct pci_dev *pdev, drm_via_sg_info_t *vsg)
 				put_page(page);
 			}
 		}
+		/* fall through */
 	case dr_via_pages_alloc:
 		vfree(vsg->pages);
+		/* fall through */
 	default:
 		vsg->state = dr_via_sg_init;
 	}
-- 
2.20.1

