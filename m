Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACEBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8470021848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130370;
	bh=ngd2hv2C+xOqZ6NIAey0kne+9azHNbd9E8y5BxLShlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lHJ6ZnQsbw0nn57jUxD0exRf8A4tSkWb2yhGOr3nX4D37/p5WNw211TEpfBWL+w0c
	 OTH4OORhMvVx2vbDN6Q4D6nurJzwO2MoeXxMNpEZe4W4rde0PTaVxdkPdYnoqS6DND
	 YBfpB6TeVLOUHzUtej7FHyKXybYgAYfp0tLQHp/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732323AbfBYVcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:32:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:38490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732540AbfBYVco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:32:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C692D217F5;
        Mon, 25 Feb 2019 21:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130363;
        bh=ngd2hv2C+xOqZ6NIAey0kne+9azHNbd9E8y5BxLShlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=njUoWzcR1shJ7sZOHSYT0L70zRkfuR8JEC0jxhNkTRZE8ILIONhF71KV0Gg7IxYMa
         cdOPFKshmfyLnN2nT02gLM9Zi6MKBbxCKFNpxXSI3L0LBl/XeTMXy2qodtZNPldqr2
         qOOVYwJisany1neRkZyq+Jt6evSpMzKfcy1sObVY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 096/183] pvcalls-front: fix potential null dereference
Date:   Mon, 25 Feb 2019 22:11:09 +0100
Message-Id: <20190225195110.866022400@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit b4711098066f1cf808d4dc11a1a842860a3292fe ]

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

Fixes: 9f51c05dc41a ("pvcalls-front: Avoid get_free_pages(GFP_KERNEL) under spinlock")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Suggested-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC: Juergen Gross <jgross@suse.com>
CC: Stefano Stabellini <sstabellini@kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>
CC: xen-devel@lists.xenproject.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/pvcalls-front.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
index 6357160d466ab..91da7e44d5d4f 100644
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
2.19.1



