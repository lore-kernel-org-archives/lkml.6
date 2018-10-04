Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37DFC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4F52082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RXP/e0gm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TWOBSEL3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4F52082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbeJDWOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:14:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56732 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbeJDWOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:14:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C28B260D84; Thu,  4 Oct 2018 15:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538666437;
        bh=jMf+39+yDtjpVAt90Py1Zf3oIxoOh1kTS88F9ToNgR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RXP/e0gmFwRz0w9QVIMR4l3U9lknhk56Lzx1ZPXE/TaMCE0FBGJrGRbHKg07Nm+l1
         hhevhHeyK/LEuNTWY1CizJhm4/lFw1geYARMRKliFQwxf0ke+kK4mwcHvbTTWZIwI7
         Z00/ezeOTkJq5OhOo3lnZH/GwYeDrPlFssxZBvSw=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F325E60D84;
        Thu,  4 Oct 2018 15:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538666436;
        bh=jMf+39+yDtjpVAt90Py1Zf3oIxoOh1kTS88F9ToNgR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TWOBSEL3FhZZy2Gz0yjtBdf18FsTuwuuSdQVZ3Dx3Gn+J5hIRWnmHuDlP6RNlfFOT
         HMxVXCVAyaVa7ZfpLhuc1eDiN2eX2O3whJbY9BYwNTD65WlZRQcaSJ24y+r+BRaEm8
         bIKCB2gVR+4yL/e4JI4xqbuS3e69h1nuw74Dj1bg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F325E60D84
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, linux-acpi@vger.kernel.org,
        jeremy.linton@arm.com
Cc:     linux-kernel@vger.kernel.org, vkilari@codeaurora.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v4 2/2] ACPI/PPTT: Handle architecturally unknown cache types
Date:   Thu,  4 Oct 2018 09:20:06 -0600
Message-Id: <1538666406-7504-3-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538666406-7504-1-git-send-email-jhugo@codeaurora.org>
References: <1538666406-7504-1-git-send-email-jhugo@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/acpi/pptt.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index d1e26cb..da031b1 100644
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
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

