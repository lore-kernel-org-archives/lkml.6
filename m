Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B590C43612
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 02:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549B4206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 02:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfAOCci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 21:32:38 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:44912 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727336AbfAOCch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 21:32:37 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 9D0FBEA33DFF15018DEE;
        Tue, 15 Jan 2019 10:32:02 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x0F2VuRl045233;
        Tue, 15 Jan 2019 10:31:56 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019011510320810-22290381 ;
          Tue, 15 Jan 2019 10:32:08 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     boris.ostrovsky@oracle.com
Cc:     jgross@suse.com, sstabellini@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        Wen Yang <wen.yang99@zte.com.cn>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v2] pvcalls-front: fix potential null dereference
Date:   Tue, 15 Jan 2019 10:31:27 +0800
Message-Id: <1547519487-27586-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-01-15 10:32:08,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-01-15 10:31:53,
        Serialize complete at 2019-01-15 10:31:53
X-MAIL: mse01.zte.com.cn x0F2VuRl045233
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 static checker warning:
    drivers/xen/pvcalls-front.c:373 alloc_active_ring()
    error: we previously assumed 'map->active.ring' could be null
           (see line 357)

drivers/xen/pvcalls-front.c
    351 static int alloc_active_ring(struct sock_mapping *map)
    352 {
    353     void *bytes;
    354
    355     map->active.ring = (struct pvcalls_data_intf *)
    356         get_zeroed_page(GFP_KERNEL);
    357     if (!map->active.ring)
                    ^^^^^^^^^^^^^^^^^
Check

    358         goto out;
    359
    360     map->active.ring->ring_order = PVCALLS_RING_ORDER;
    361     bytes = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
    362                     PVCALLS_RING_ORDER);
    363     if (!bytes)
    364         goto out;
    365
    366     map->active.data.in = bytes;
    367     map->active.data.out = bytes +
    368         XEN_FLEX_RING_SIZE(PVCALLS_RING_ORDER);
    369
    370     return 0;
    371
    372 out:
--> 373     free_active_ring(map);
                                 ^^^
Add null check on map->active.ring before dereferencing it to avoid
any NULL pointer dereferences.

Fixes: 9f51c05dc41a ("pvcalls-front: Avoid get_free_pages(GFP_KERNEL)
under spinlock")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Suggested-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC: Juergen Gross <jgross@suse.com>
CC: Stefano Stabellini <sstabellini@kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>
CC: xen-devel@lists.xenproject.org
CC: linux-kernel@vger.kernel.org
---
v2->v1:
- Add NULL check on map->active.ring and return
  immediately if it is.

 drivers/xen/pvcalls-front.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
index 307861f..8a249c9 100644
--- a/drivers/xen/pvcalls-front.c
+++ b/drivers/xen/pvcalls-front.c
@@ -343,6 +343,9 @@ int pvcalls_front_socket(struct socket *sock)
 
 static void free_active_ring(struct sock_mapping *map)
 {
+	if (!map->active.ring)
+		return;
+
 	free_pages((unsigned long)map->active.data.in,
 			map->active.ring->ring_order);
 	free_page((unsigned long)map->active.ring);
-- 
2.9.5

