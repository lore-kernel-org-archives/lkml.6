Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C350C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F7A20883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F7A20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbeKITPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:15:24 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:55172 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbeKITPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:15:24 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1gL3CU-0000te-Qy; Fri, 09 Nov 2018 10:35:39 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 3/3] slab: use logical instead of bitwise operation in kmalloc_type()
Date:   Fri,  9 Nov 2018 10:35:34 +0100
Message-Id: <20181109093534.15121-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181109093534.15121-1-johannes@sipsolutions.net>
References: <20181109093534.15121-1-johannes@sipsolutions.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The operation here really is more logical than bitwise, even if
due to the setup the bitwise operation works fine. However, this
causes a complaint from sparse that the operation doesn't really
make sense due to the not.

Use a logical and instead of bitwise.

In my (somewhat unscientific) test this caused no differences in
the generated code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/slab.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 918f374e7156..d395c7366312 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -329,7 +329,7 @@ static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
 	 * If an allocation is both __GFP_DMA and __GFP_RECLAIMABLE, return
 	 * KMALLOC_DMA and effectively ignore __GFP_RECLAIMABLE
 	 */
-	return type_dma + (is_reclaimable & !is_dma) * KMALLOC_RECLAIM;
+	return type_dma + (is_reclaimable && !is_dma) * KMALLOC_RECLAIM;
 }
 
 /*
-- 
2.17.2

