Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D20EC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93D02082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93D02082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbeLEAyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 19:54:40 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:56482 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbeLEAyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 19:54:40 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 70BF2FA57192F284CD9B;
        Wed,  5 Dec 2018 08:54:37 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wB50sVtn050945;
        Wed, 5 Dec 2018 08:54:31 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018120508544998-14779780 ;
          Wed, 5 Dec 2018 08:54:49 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     christoffer.dall@arm.com, marc.zyngier@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH]  kvm/arm: return 0 when the number of objects is not less than min
Date:   Wed, 5 Dec 2018 09:15:51 +0800
Message-Id: <1543972551-60951-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-12-05 08:54:50,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-05 08:54:23,
        Serialize complete at 2018-12-05 08:54:23
X-MAIL: mse01.zte.com.cn wB50sVtn050945
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return 0 when there is enough kvm_mmu_memory_cache object.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 virt/kvm/arm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index ed162a6..fcda0ce 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -127,7 +127,7 @@ static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache,
 	while (cache->nobjs < max) {
 		page = (void *)__get_free_page(PGALLOC_GFP);
 		if (!page)
-			return -ENOMEM;
+			return cache->nobjs >= min ? 0 : -ENOMEM;
 		cache->objects[cache->nobjs++] = page;
 	}
 	return 0;
-- 
1.8.3.1

