Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5045BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17DC12184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbeLSIWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:22:46 -0500
Received: from smtpbg321.qq.com ([14.17.32.30]:57543 "EHLO smtpbg321.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727721AbeLSIWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:22:46 -0500
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Dec 2018 03:22:43 EST
X-QQ-mid: bizesmtp22t1545207302tyfesoyl
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp6.qq.com (ESMTP) with 
        id ; Wed, 19 Dec 2018 16:14:57 +0800 (CST)
X-QQ-SSF: 01100000002000F0FG42B00A0000000
X-QQ-FEAT: FRkVFvYdryUwci0fG4Rp91xRGhz0N1J6Ls26DjcnUqiFsh2sFOobAJ8IswJ8T
        wh0+apxGDflxofdRiDL6lshOFANtLApP4aWkIQYF3E+GUPehwEvPBwxMPiGutgzhNBK+xvw
        4+cBh3zDP08pqkbRXWvuF/F6ND75DWZtmOw+7eAk/FyFMpEXbwv+zFmsJb18uS2GRzfaFLU
        JfOOv6o5sR6crXk8+Yot0qB4R407MvoPt43m/0uDTZY1ZExYQb97skQK27uVGnpNIMaJ5ls
        Gv5/2kZsA7sW3a+pUtr7lrRfsMW6s4V/pV7w==
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: [PATCH V3] cacheinfo: Keep the old value if of_property_read_u32 fails
Date:   Wed, 19 Dec 2018 16:16:03 +0800
Message-Id: <1545207363-7402-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:lemote.com:qybgweb:qybgweb2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 448a5a552f336bd7b847b1951 ("drivers: base: cacheinfo: use OF
property_read_u32 instead of get_property,read_number") makes cache
size and number_of_sets be 0 if DT doesn't provide there values. I
think this is unreasonable so make them keep the old values, which is
the same as old kernels.

Fixes: 448a5a552f33 ("drivers: base: cacheinfo: use OF property_read_u32 instead of get_property,read_number")
Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---
V2: Add Cc and Reviewed-by
V3: Add ChangeLog

 drivers/base/cacheinfo.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index cf78fa6..a735953 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -79,8 +79,7 @@ static void cache_size(struct cacheinfo *this_leaf, struct device_node *np)
 	ct_idx = get_cacheinfo_idx(this_leaf->type);
 	propname = cache_type_info[ct_idx].size_prop;
 
-	if (of_property_read_u32(np, propname, &this_leaf->size))
-		this_leaf->size = 0;
+	of_property_read_u32(np, propname, &this_leaf->size);
 }
 
 /* not cache_line_size() because that's a macro in include/linux/cache.h */
@@ -114,8 +113,7 @@ static void cache_nr_sets(struct cacheinfo *this_leaf, struct device_node *np)
 	ct_idx = get_cacheinfo_idx(this_leaf->type);
 	propname = cache_type_info[ct_idx].nr_sets_prop;
 
-	if (of_property_read_u32(np, propname, &this_leaf->number_of_sets))
-		this_leaf->number_of_sets = 0;
+	of_property_read_u32(np, propname, &this_leaf->number_of_sets);
 }
 
 static void cache_associativity(struct cacheinfo *this_leaf)
-- 
2.7.0

