Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937B0C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA0C22BD2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA0C22BD2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934355AbeGFUuT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 16:50:19 -0400
Received: from mail.ispras.ru ([83.149.199.45]:56380 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933584AbeGFUuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 16:50:17 -0400
Received: from localhost.localdomain (ppp85-140-187-172.pppoe.mtu-net.ru [85.140.187.172])
        by mail.ispras.ru (Postfix) with ESMTPSA id 42F90540089;
        Fri,  6 Jul 2018 23:50:15 +0300 (MSK)
From:   Alexey Khoroshilov <khoroshilov@ispras.ru>
To:     Gerd Hoffmann <kraxel@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] sample: vfio-mdev: avoid deadlock in mdev_access()
Date:   Fri,  6 Jul 2018 23:50:06 +0300
Message-Id: <1530910206-24948-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mdev_access() calls mbochs_get_page() with mdev_state->ops_lock held,
while mbochs_get_page() locks the mutex by itself.
It leads to unavoidable deadlock.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 samples/vfio-mdev/mbochs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/samples/vfio-mdev/mbochs.c b/samples/vfio-mdev/mbochs.c
index 2960e26c6ea4..6295a21381eb 100644
--- a/samples/vfio-mdev/mbochs.c
+++ b/samples/vfio-mdev/mbochs.c
@@ -178,6 +178,8 @@ static const char *vbe_name(u32 index)
 	return "(invalid)";
 }
 
+static struct page *__mbochs_get_page(struct mdev_state *mdev_state,
+				      pgoff_t pgoff);
 static struct page *mbochs_get_page(struct mdev_state *mdev_state,
 				    pgoff_t pgoff);
 
@@ -394,7 +396,7 @@ static ssize_t mdev_access(struct mdev_device *mdev, char *buf, size_t count,
 		   MBOCHS_MEMORY_BAR_OFFSET + mdev_state->memsize) {
 		pos -= MBOCHS_MMIO_BAR_OFFSET;
 		poff = pos & ~PAGE_MASK;
-		pg = mbochs_get_page(mdev_state, pos >> PAGE_SHIFT);
+		pg = __mbochs_get_page(mdev_state, pos >> PAGE_SHIFT);
 		map = kmap(pg);
 		if (is_write)
 			memcpy(map + poff, buf, count);
-- 
2.7.4

