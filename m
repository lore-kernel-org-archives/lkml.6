Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC59C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E15623E87
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E15623E87
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933324AbeGFMul (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:50:41 -0400
Received: from foss.arm.com ([217.140.101.70]:36066 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932569AbeGFMuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:50:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 047B218A;
        Fri,  6 Jul 2018 05:50:40 -0700 (PDT)
Received: from usa.arm.com (unknown [10.1.211.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 19DBD3F5BA;
        Fri,  6 Jul 2018 05:50:38 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2][REPOST] drivers: base: cacheinfo: use OF property_read_u32 instead of get_property,read_number
Date:   Fri,  6 Jul 2018 13:50:31 +0100
Message-Id: <1530881431-14233-1-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_property_read_u32 searches for a property in a device node and read
a 32-bit value from it. Instead of using of_get_property to get the
property and then read 32-bit value using of_read_number, we can
simplify it by using of_property_read_u32.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/cacheinfo.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

Hi Greg,

Can you pick this up for v4.19 ? It was too late for v4.18 and was not
pulled with other changes to this file. Just reposting the same, Andy
did say LGTM.

Regards,
Sudeep

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 2880e2ab01f5..5d5b5988e88b 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -74,52 +74,48 @@ static inline int get_cacheinfo_idx(enum cache_type type)
 static void cache_size(struct cacheinfo *this_leaf, struct device_node *np)
 {
 	const char *propname;
-	const __be32 *cache_size;
 	int ct_idx;
 
 	ct_idx = get_cacheinfo_idx(this_leaf->type);
 	propname = cache_type_info[ct_idx].size_prop;
 
-	cache_size = of_get_property(np, propname, NULL);
-	if (cache_size)
-		this_leaf->size = of_read_number(cache_size, 1);
+	if (of_property_read_u32(np, propname, &this_leaf->size))
+		this_leaf->size = 0;
 }
 
 /* not cache_line_size() because that's a macro in include/linux/cache.h */
 static void cache_get_line_size(struct cacheinfo *this_leaf,
 				struct device_node *np)
 {
-	const __be32 *line_size;
 	int i, lim, ct_idx;
 
 	ct_idx = get_cacheinfo_idx(this_leaf->type);
 	lim = ARRAY_SIZE(cache_type_info[ct_idx].line_size_props);
 
 	for (i = 0; i < lim; i++) {
+		int ret;
+		u32 line_size;
 		const char *propname;
 
 		propname = cache_type_info[ct_idx].line_size_props[i];
-		line_size = of_get_property(np, propname, NULL);
-		if (line_size)
+		ret = of_property_read_u32(np, propname, &line_size);
+		if (!ret) {
+			this_leaf->coherency_line_size = line_size;
 			break;
+		}
 	}
-
-	if (line_size)
-		this_leaf->coherency_line_size = of_read_number(line_size, 1);
 }
 
 static void cache_nr_sets(struct cacheinfo *this_leaf, struct device_node *np)
 {
 	const char *propname;
-	const __be32 *nr_sets;
 	int ct_idx;
 
 	ct_idx = get_cacheinfo_idx(this_leaf->type);
 	propname = cache_type_info[ct_idx].nr_sets_prop;
 
-	nr_sets = of_get_property(np, propname, NULL);
-	if (nr_sets)
-		this_leaf->number_of_sets = of_read_number(nr_sets, 1);
+	if (of_property_read_u32(np, propname, &this_leaf->number_of_sets))
+		this_leaf->number_of_sets = 0;
 }
 
 static void cache_associativity(struct cacheinfo *this_leaf)
-- 
2.7.4

