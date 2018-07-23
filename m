Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC03BECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2E420880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2E420880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389003AbeGWNaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:30:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45780 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387998AbeGWNaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:30:00 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1481FBB3;
        Mon, 23 Jul 2018 12:29:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 4.14 17/44] vfio/pci: Fix potential Spectre v1
Date:   Mon, 23 Jul 2018 14:24:53 +0200
Message-Id: <20180723122438.279932573@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122437.447870153@linuxfoundation.org>
References: <20180723122437.447870153@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit 0e714d27786ce1fb3efa9aac58abc096e68b1c2a upstream.

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
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/vfio/pci/vfio_pci.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -28,6 +28,7 @@
 #include <linux/uaccess.h>
 #include <linux/vfio.h>
 #include <linux/vgaarb.h>
+#include <linux/nospec.h>
 
 #include "vfio_pci_private.h"
 
@@ -746,6 +747,9 @@ static long vfio_pci_ioctl(void *device_
 			if (info.index >=
 			    VFIO_PCI_NUM_REGIONS + vdev->num_regions)
 				return -EINVAL;
+			info.index = array_index_nospec(info.index,
+							VFIO_PCI_NUM_REGIONS +
+							vdev->num_regions);
 
 			i = info.index - VFIO_PCI_NUM_REGIONS;
 


