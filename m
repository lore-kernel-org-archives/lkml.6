Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FB0C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 02:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0DC218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 02:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lUqUQLBZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbfB0C0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 21:26:45 -0500
Received: from m12-17.163.com ([220.181.12.17]:59617 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729243AbfB0C0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 21:26:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=btUcs3+/xyWYxVRVE5
        2HFznfCYpsm3BUMuXFtIGU9Qw=; b=lUqUQLBZznXZsTROYcOsm7SzLMS5p4lN5V
        cfJ9eb8QboGKMdsqnwSbvCDPLsOvILKr8mx1+faC5IUkKYQ+dNN4d3MYROGqk+yX
        2qDsztZxbMwRxogVlSAcQlJHFq8VGyxip2RoGH/kD0Aqo91IKVSwvZYLjZRnA3/h
        b3Jw9GhXg=
Received: from localhost.localdomain (unknown [182.151.187.141])
        by smtp13 (Coremail) with SMTP id EcCowABnNtdJ9XVcr0WqHg--.29349S2;
        Wed, 27 Feb 2019 10:26:18 +0800 (CST)
From:   WangBo <wdjjwb@163.com>
To:     linux-kernel@vger.kernel.org
Cc:     rmk+kernel@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        wang.bo116@zte.com.cn
Subject: [PATCH] ARM: dmabounce: NULL check before some freeing functions is 
Date:   Wed, 27 Feb 2019 10:26:15 +0800
Message-Id: <1551234375-6223-1-git-send-email-wdjjwb@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: EcCowABnNtdJ9XVcr0WqHg--.29349S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrur15GF1fCryUCr1rCw4DJwb_yoWfAFg_Ar
        yxt3ykur95ZF4kWF4ayr1rur1fA3yrXFWFvF18Jrs7GanYqr9xArnrZ3yfK3W2gayjvr9x
        XrWUZryjyr12kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnjsjUUUUUU==
X-Originating-IP: [182.151.187.141]
X-CM-SenderInfo: xzgmy4re6rljoofrz/xtbBEApoGVUMK+Nl1wAAsI
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function dma_pool_destroy(NULL) is safe, so removes NULL check before 
freeing the mem. This patch also fix the ifnullfree.cocci warnings.

Signed-off-by: WangBo <wang.bo116@zte.com.cn>
---
 arch/arm/common/dmabounce.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index 5ba4622..dd520a3 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -563,10 +563,8 @@ void dmabounce_unregister_dev(struct device *dev)
 		BUG();
 	}
 
-	if (device_info->small.pool)
-		dma_pool_destroy(device_info->small.pool);
-	if (device_info->large.pool)
-		dma_pool_destroy(device_info->large.pool);
+	dma_pool_destroy(device_info->small.pool);
+	dma_pool_destroy(device_info->large.pool);
 
 #ifdef STATS
 	if (device_info->attr_res == 0)
-- 
2.7.4


