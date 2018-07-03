Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E6DC3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3971024EA3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3971024EA3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753449AbeGCBEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 21:04:15 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.154]:25349 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752770AbeGCBEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 21:04:14 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 42CE4400C6E9A
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jul 2018 20:04:13 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id a9jOfdHhD79N3a9jef2VvP; Mon, 02 Jul 2018 20:04:12 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=40376 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fa9jO-001Hoo-0q; Mon, 02 Jul 2018 20:03:46 -0500
Date:   Mon, 2 Jul 2018 20:03:44 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/via: mark expected switch fall-throughs
Message-ID: <20180703010344.GA974@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.65.56
X-Source-L: No
X-Exim-ID: 1fa9jO-001Hoo-0q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:40376
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/via/via_dmablit.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/via/via_dmablit.c b/drivers/gpu/drm/via/via_dmablit.c
index 345bda4..8bf3a7c 100644
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
2.7.4

