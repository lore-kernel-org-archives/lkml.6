Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFABC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A8262190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026879;
	bh=hudbPPq2wsnn673GkKZ6TJB4xcclMV3mS4tVqlm3Mow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QLfQbyD+tMYTmp49ZZjjbauRzdDDdZ5NauVTkE8do/rX65g0Re6QWzIuWXAhrVvlp
	 xqyBPTEwvOrbGKEJmdPTJhSTLJaMZx7cNSe1nci6vAjpiYAWFd6Kl94GIXXbj66apA
	 2S/E9ye29Hbvluo/j+BxQnxIhwGh0Oh2VIDCyZN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390301AbfBMDBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:01:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:39360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388047AbfBMCfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:35:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74EB1222CD;
        Wed, 13 Feb 2019 02:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025338;
        bh=hudbPPq2wsnn673GkKZ6TJB4xcclMV3mS4tVqlm3Mow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nII3WzL4gQkE2ym8i4D3Li3Junntrcr5SxW+BjUUOINEKGJA+GxmHXQOL3VlNDJVL
         /juWM+W0ADxJE/XwCEw5W+R5M0dninMYTIKXP2pzrvYVBAMsi7m+rK/gG+KxWukv9l
         BX5NwHgiAbeLZnuf50Ac7KbcllCRqFb0PPxSStfU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wen Yang <wen.yang99@zte.com.cn>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        xen-devel@lists.xenproject.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 078/105] pvcalls-front: fix potential null dereference
Date:   Tue, 12 Feb 2019 21:33:09 -0500
Message-Id: <20190213023336.19019-78-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wen.yang99@zte.com.cn>

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
index 6357160d466a..91da7e44d5d4 100644
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

