Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C91C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25EFE2084C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/ZhJaZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25EFE2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388684AbeKLJYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:24:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:43864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388397AbeKLIUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:09 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41725223D1;
        Sun, 11 Nov 2018 22:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975412;
        bh=4QfPqnCb8CbkUg26p6A85Y45uF1qmGMA5bOa49/H1cU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t/ZhJaZ30EVZFF23RCqCQnRuNEuONNpjDqTI3jhP5RWbDyXcA4/gXajaWq33aVLRx
         t3HGZV2lCSgA4/MFYdCjmuOBQkn96xoDJ28pO2LPhCpNa4DWTz9fb5nlOBh/95sDA2
         8+G5q0CbZVkDA+LVlPwKdn2N6RheU/1lOPqsk2XE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vijaya Kumar K <vkilari@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 091/350] ACPI/PPTT: Handle architecturally unknown cache types
Date:   Sun, 11 Nov 2018 14:19:15 -0800
Message-Id: <20181111221710.918280380@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/pptt.c |   33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -338,9 +338,6 @@ static struct acpi_pptt_cache *acpi_find
 	return found;
 }
 
-/* total number of attributes checked by the properties code */
-#define PPTT_CHECKED_ATTRIBUTES 4
-
 /**
  * update_cache_properties() - Update cacheinfo for the given processor
  * @this_leaf: Kernel cache info structure being updated
@@ -357,25 +354,15 @@ static void update_cache_properties(stru
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
@@ -402,11 +389,17 @@ static void update_cache_properties(stru
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
 


