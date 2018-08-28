Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9182FC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308B3208AD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308B3208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeH1LUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 07:20:40 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:37523 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbeH1LUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 07:20:40 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.1]) by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee55b84fa077cc-281fd; Tue, 28 Aug 2018 15:30:16 +0800 (CST)
X-RM-TRANSID: 2ee55b84fa077cc-281fd
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee15b84fa072c8-57919;
        Tue, 28 Aug 2018 15:30:16 +0800 (CST)
X-RM-TRANSID: 2ee15b84fa072c8-57919
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] block: Fix unneeded NULL check
Date:   Tue, 28 Aug 2018 15:30:13 +0800
Message-Id: <1535441413-8583-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if icq_cache is null, kmem_cache_destroy will do nothing.
So, remove the null check.

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 block/elevator.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 5ea6e7d..6a06b5d 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -895,8 +895,7 @@ int elv_register(struct elevator_type *e)
 	spin_lock(&elv_list_lock);
 	if (elevator_find(e->elevator_name, e->uses_mq)) {
 		spin_unlock(&elv_list_lock);
-		if (e->icq_cache)
-			kmem_cache_destroy(e->icq_cache);
+		kmem_cache_destroy(e->icq_cache);
 		return -EBUSY;
 	}
 	list_add_tail(&e->list, &elv_list);
-- 
1.9.1



