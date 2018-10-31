Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5E3C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40EC42080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjHh5zDi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40EC42080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbeKAIGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:06:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727809AbeKAIGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:06:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0094520838;
        Wed, 31 Oct 2018 23:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027172;
        bh=m0eYymLvQVdqV99aj3t6WUzgHN/QGirqZSA4T+l0rLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cjHh5zDiwcm+GU8WffNJOrmGzSFo+9WGgKK+HQrcRBLAEeJql0DYooXdGWUBQ8aXu
         wZ9tyvGdYG0gXA8qI6YmP4p9oFrkGTSR83zLPaDXxlQgYVWhEWOvdZqx557HTwJ3ua
         v6Gq8rgu9ZKRex5vPfiEI2eusaAt3nWPN3auFGGQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 033/146] ACPI/PPTT: Handle architecturally unknown cache types
Date:   Wed, 31 Oct 2018 19:03:48 -0400
Message-Id: <20181031230541.28822-33-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeffrey Hugo <jhugo@codeaurora.org>

[ Upstream commit 59bbff3775c0951300f7b41345a54b999438f8d0 ]

The type of a cache might not be specified by architectural mechanisms (ie
system registers), but its type might be specified in the PPTT.  In this
case, we should populate the type of the cache, rather than leave it
undefined.

This fixes the issue where the cacheinfo driver will not populate sysfs
for such caches, resulting in the information missing from utilities like
lstopo and lscpu, thus degrading the user experience.

Fixes: 2bd00bcd73e5 (ACPI/PPTT: Add Processor Properties Topology Table parsing)
Reported-by: Vijaya Kumar K <vkilari@codeaurora.org>
Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/pptt.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index d1e26cb599bf..da031b1df6f5 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -338,9 +338,6 @@ static struct acpi_pptt_cache *acpi_find_cache_node(struct acpi_table_header *ta
 	return found;
 }
 
-/* total number of attributes checked by the properties code */
-#define PPTT_CHECKED_ATTRIBUTES 4
-
 /**
  * update_cache_properties() - Update cacheinfo for the given processor
  * @this_leaf: Kernel cache info structure being updated
@@ -357,25 +354,15 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
 				    struct acpi_pptt_cache *found_cache,
 				    struct acpi_pptt_processor *cpu_node)
 {
-	int valid_flags = 0;
-
 	this_leaf->fw_token = cpu_node;
-	if (found_cache->flags & ACPI_PPTT_SIZE_PROPERTY_VALID) {
+	if (found_cache->flags & ACPI_PPTT_SIZE_PROPERTY_VALID)
 		this_leaf->size = found_cache->size;
-		valid_flags++;
-	}
-	if (found_cache->flags & ACPI_PPTT_LINE_SIZE_VALID) {
+	if (found_cache->flags & ACPI_PPTT_LINE_SIZE_VALID)
 		this_leaf->coherency_line_size = found_cache->line_size;
-		valid_flags++;
-	}
-	if (found_cache->flags & ACPI_PPTT_NUMBER_OF_SETS_VALID) {
+	if (found_cache->flags & ACPI_PPTT_NUMBER_OF_SETS_VALID)
 		this_leaf->number_of_sets = found_cache->number_of_sets;
-		valid_flags++;
-	}
-	if (found_cache->flags & ACPI_PPTT_ASSOCIATIVITY_VALID) {
+	if (found_cache->flags & ACPI_PPTT_ASSOCIATIVITY_VALID)
 		this_leaf->ways_of_associativity = found_cache->associativity;
-		valid_flags++;
-	}
 	if (found_cache->flags & ACPI_PPTT_WRITE_POLICY_VALID) {
 		switch (found_cache->attributes & ACPI_PPTT_MASK_WRITE_POLICY) {
 		case ACPI_PPTT_CACHE_POLICY_WT:
@@ -402,11 +389,17 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
 		}
 	}
 	/*
-	 * If the above flags are valid, and the cache type is NOCACHE
-	 * update the cache type as well.
+	 * If cache type is NOCACHE, then the cache hasn't been specified
+	 * via other mechanisms.  Update the type if a cache type has been
+	 * provided.
+	 *
+	 * Note, we assume such caches are unified based on conventional system
+	 * design and known examples.  Significant work is required elsewhere to
+	 * fully support data/instruction only type caches which are only
+	 * specified in PPTT.
 	 */
 	if (this_leaf->type == CACHE_TYPE_NOCACHE &&
-	    valid_flags == PPTT_CHECKED_ATTRIBUTES)
+	    found_cache->flags & ACPI_PPTT_CACHE_TYPE_VALID)
 		this_leaf->type = CACHE_TYPE_UNIFIED;
 }
 
-- 
2.17.1

