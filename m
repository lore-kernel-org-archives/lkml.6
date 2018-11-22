Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E59C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 02:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BC8204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 02:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FZlYu0ql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BC8204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbeKVMoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:44:54 -0500
Received: from m12-11.163.com ([220.181.12.11]:54006 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728243AbeKVMoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 07:44:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=fAshg5hnRoROfJ4sR5
        6Svjjp16WDuq8l8inCytpfi0A=; b=FZlYu0qlqImItoWuUZJuTRix6fF1olA0mn
        Xdf4jlcywG3QvwItjFFQC78bU/cC/liMsKdGmyf6FyAKqqvN6P7nIu/U+HrWS8Bz
        dauyF2qktESfWWSAYotCarSZci7f4mLHo1+ueum+1F3YkL4q96gi9vCbdh2fPtly
        kR/vyVKRM=
Received: from bp.localdomain (unknown [106.120.213.96])
        by smtp7 (Coremail) with SMTP id C8CowABHl2NMD_Zbya5UBQ--.15401S3;
        Thu, 22 Nov 2018 10:07:11 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pvcalls-front: fixes incorrect error handling
Date:   Thu, 22 Nov 2018 10:07:12 +0800
Message-Id: <1542852432-30019-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: C8CowABHl2NMD_Zbya5UBQ--.15401S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrur48Kw18tF4fCFWkurWfZrb_yoWfZrg_CF
        4Uuwn7Wr4qqFWDW3Wjy39xZFyFkFn0qF1fXFsF93y3AFyxAr4DZrZ2qws5Grs3WrW0ya43
        Kr4UZr1Ikw1xtjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5I0PDUUUUU==
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBUQ8HclaD0Q1x-wAAss
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kfree() is incorrectly used to release the pages allocated by
__get_free_page() and __get_free_pages(). Use the matching deallocators
i.e., free_page() and free_pages(), respectively.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/xen/pvcalls-front.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
index 2f11ca7..77224d8 100644
--- a/drivers/xen/pvcalls-front.c
+++ b/drivers/xen/pvcalls-front.c
@@ -385,8 +385,8 @@ static int create_active(struct sock_mapping *map, int *evtchn)
 out_error:
 	if (*evtchn >= 0)
 		xenbus_free_evtchn(pvcalls_front_dev, *evtchn);
-	kfree(map->active.data.in);
-	kfree(map->active.ring);
+	free_pages((unsigned long)map->active.data.in, PVCALLS_RING_ORDER);
+	free_page((unsigned long)map->active.ring);
 	return ret;
 }
 
-- 
2.7.4


