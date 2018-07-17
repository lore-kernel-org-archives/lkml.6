Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382D4ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8268206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8268206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbeGQSNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 14:13:19 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.163]:13509 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729721AbeGQSNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 14:13:19 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id F3CDF400D4943
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 12:39:36 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id fTwDf5UrpPvAdfTwYfAiHo; Tue, 17 Jul 2018 12:39:36 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=49734 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ffTwD-003btg-DR; Tue, 17 Jul 2018 12:39:01 -0500
Date:   Tue, 17 Jul 2018 12:39:00 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] vfio/pci: Fix potential Spectre v1
Message-ID: <20180717173900.GA24627@embeddedor.com>
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
X-Exim-ID: 1ffTwD-003btg-DR
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:49734
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

info.index can be indirectly controlled by user-space, hence leading
to a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

drivers/vfio/pci/vfio_pci.c:734 vfio_pci_ioctl()
warn: potential spectre issue 'vdev->region'

Fix this by sanitizing info.index before indirectly using it to index
vdev->region

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/vfio/pci/vfio_pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index b423a30..125b58e 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -28,6 +28,7 @@
 #include <linux/uaccess.h>
 #include <linux/vfio.h>
 #include <linux/vgaarb.h>
+#include <linux/nospec.h>
 
 #include "vfio_pci_private.h"
 
@@ -727,6 +728,9 @@ static long vfio_pci_ioctl(void *device_data,
 			if (info.index >=
 			    VFIO_PCI_NUM_REGIONS + vdev->num_regions)
 				return -EINVAL;
+			info.index = array_index_nospec(info.index,
+							VFIO_PCI_NUM_REGIONS +
+							vdev->num_regions);
 
 			i = info.index - VFIO_PCI_NUM_REGIONS;
 
-- 
2.7.4

