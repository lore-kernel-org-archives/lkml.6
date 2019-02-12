Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C28C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFDE222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731346AbfBLSML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:12:11 -0500
Received: from gateway34.websitewelcome.com ([192.185.150.114]:21536 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726943AbfBLSMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:12:10 -0500
X-Greylist: delayed 1315 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Feb 2019 13:12:10 EST
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 5CB52423D6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 11:50:15 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id tcCFgHadB90ontcCFgf0Rl; Tue, 12 Feb 2019 11:50:15 -0600
X-Authority-Reason: nr=8
Received: from [189.250.119.20] (port=49616 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gtcCE-001nhJ-K0; Tue, 12 Feb 2019 11:50:14 -0600
Date:   Tue, 12 Feb 2019 11:50:14 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] rapidio/mport_cdev: mark expected switch fall-through
Message-ID: <20190212175014.GA14326@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.119.20
X-Source-L: No
X-Exim-ID: 1gtcCE-001nhJ-K0
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.119.20]:49616
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

n preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warning:

drivers/rapidio/devices/rio_mport_cdev.c: In function ‘mport_release_mapping’:
drivers/rapidio/devices/rio_mport_cdev.c:2151:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
   rio_unmap_inb_region(mport, map->phys_addr);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  CC      drivers/regulator/fixed-helper.o
  CC      drivers/pinctrl/stm32/pinctrl-stm32f429.o
drivers/rapidio/devices/rio_mport_cdev.c:2152:2: note: here
  case MAP_DMA:
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/rapidio/devices/rio_mport_cdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index cbe467ff1aba..1e1f42e210a0 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -2149,6 +2149,7 @@ static void mport_release_mapping(struct kref *ref)
 	switch (map->dir) {
 	case MAP_INBOUND:
 		rio_unmap_inb_region(mport, map->phys_addr);
+		/* fall through */
 	case MAP_DMA:
 		dma_free_coherent(mport->dev.parent, map->size,
 				  map->virt_addr, map->phys_addr);
-- 
2.20.1

