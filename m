Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7EFC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0172082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:17:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0172082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbeLJRRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:17:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbeLJRNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:13:35 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D6FFC30842D1;
        Mon, 10 Dec 2018 17:13:34 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8CA88605D0;
        Mon, 10 Dec 2018 17:13:34 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 5329C22425E; Mon, 10 Dec 2018 12:13:30 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: [PATCH 20/52] Limit number of pages returned by direct_access()
Date:   Mon, 10 Dec 2018 12:12:46 -0500
Message-Id: <20181210171318.16998-21-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 10 Dec 2018 17:13:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Truncate number of pages mapped by direct_access() to remain with-in window
size. User might request mapping pages beyond window size.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index e4d5e0cd41ba..ef1469b38a6d 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -449,13 +449,14 @@ static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 {
 	struct virtio_fs *fs = dax_get_private(dax_dev);
 	phys_addr_t offset = PFN_PHYS(pgoff);
+	size_t max_nr_pages = fs->window_len/PAGE_SIZE - pgoff;
 
 	if (kaddr)
 		*kaddr = fs->window_kaddr + offset;
 	if (pfn)
 		*pfn = phys_to_pfn_t(fs->window_phys_addr + offset,
 					PFN_DEV | PFN_MAP);
-	return nr_pages;
+	return nr_pages > max_nr_pages ? max_nr_pages : nr_pages;
 }
 
 static size_t virtio_fs_copy_from_iter(struct dax_device *dax_dev,
-- 
2.13.6

