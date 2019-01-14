Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81067C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB6A206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gH8jzLC+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfANPuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:50:37 -0500
Received: from m12-12.163.com ([220.181.12.12]:55573 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbfANPuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 10:50:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=R7cWA0rAR99iOdomE7
        NfAjm4s0f19VxumPd+0wyXzNg=; b=gH8jzLC+rtkO7GCj7LMLOrqcR0aZERT7rE
        fn1p5ULIFWbn4mjTQ8Pqkpag+M4Hztxa+7g2VbOtdxfpjImaYWI6orC1biHWJI0K
        V3BaF3yHP23fe5grIGcgf8MXnDBL+C+are2/d54P6mTFbgV6cxyjoiGtwW0P4OzR
        ajT4woNcM=
Received: from localhost.localdomain (unknown [171.213.47.169])
        by smtp8 (Coremail) with SMTP id DMCowADX389QrzxcjExAAw--.49367S2;
        Mon, 14 Jan 2019 23:48:33 +0800 (CST)
From:   wangbo <wdjjwb@163.com>
To:     linux-kernel@vger.kernel.org
Cc:     jgross@suse.com, sstabellini@kernel.org,
        xen-devel@lists.xenproject.org, wang.bo116@zte.com.cn,
        wangbo <wdjjwb@163.com>
Subject: [PATCH] pvcalls-front: Replace GFP_KERNEL with GFP_ATOMIC in create_active
Date:   Mon, 14 Jan 2019 23:48:29 +0800
Message-Id: <1547480909-11844-1-git-send-email-wdjjwb@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DMCowADX389QrzxcjExAAw--.49367S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFWxurW8Jw1Duw1DKFWkXrb_yoWDAFg_GF
        WUZw13Gr4jgFsxWF1qkwsxZF9Yyayqqa48uFsI9a47Jw4vyr4DZrW8Zr45Kws3GFW8C3y3
        tw45Xr18ZF4UtjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUndWrJUUUUU==
X-Originating-IP: [171.213.47.169]
X-CM-SenderInfo: xzgmy4re6rljoofrz/xtbB0gk8GVUMMsEWuwAAs5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create_active may called inside spinlock,replace GFP_KERNEL with GFP_ATOMIC

Signed-off-by: wangbo <wang.bo116@zte.com.cn>
---
 drivers/xen/pvcalls-front.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
index 77224d8..31bd3c9 100644
--- a/drivers/xen/pvcalls-front.c
+++ b/drivers/xen/pvcalls-front.c
@@ -344,11 +344,11 @@ static int create_active(struct sock_mapping *map, int *evtchn)
 	init_waitqueue_head(&map->active.inflight_conn_req);
 
 	map->active.ring = (struct pvcalls_data_intf *)
-		__get_free_page(GFP_KERNEL | __GFP_ZERO);
+		__get_free_page(GFP_ATOMIC | __GFP_ZERO);
 	if (map->active.ring == NULL)
 		goto out_error;
 	map->active.ring->ring_order = PVCALLS_RING_ORDER;
-	bytes = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
+	bytes = (void *)__get_free_pages(GFP_ATOMIC | __GFP_ZERO,
 					PVCALLS_RING_ORDER);
 	if (bytes == NULL)
 		goto out_error;
-- 
2.7.4


