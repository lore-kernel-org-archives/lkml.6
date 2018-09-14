Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B678ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4473620861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cF5I2Gtu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cF5I2Gtu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4473620861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbeINVnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 17:43:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44790 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbeINVnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 17:43:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E67AE60BEE; Fri, 14 Sep 2018 16:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536942507;
        bh=j8OVDhmcnh6KWtNd/PaNAFrweODC+KGgAcag7eUfWWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cF5I2Gtu/m7QyqRqj2/EFJl9UNpxG2hk/BXjNkgAmZJDKeHS7O39UrHu3bdTa8mFw
         d/LUzM6C2FpUJwSnBvdd4Ds2upFgef2r3ALkSb+D3CYi+SD6Fb5BfEJZhPbnw8eDxA
         lT6ejSsaz96RpTu+ynzFCpWXR77ZgOmkGlSDNjRo=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9B1CD60C4C;
        Fri, 14 Sep 2018 16:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536942507;
        bh=j8OVDhmcnh6KWtNd/PaNAFrweODC+KGgAcag7eUfWWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cF5I2Gtu/m7QyqRqj2/EFJl9UNpxG2hk/BXjNkgAmZJDKeHS7O39UrHu3bdTa8mFw
         d/LUzM6C2FpUJwSnBvdd4Ds2upFgef2r3ALkSb+D3CYi+SD6Fb5BfEJZhPbnw8eDxA
         lT6ejSsaz96RpTu+ynzFCpWXR77ZgOmkGlSDNjRo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9B1CD60C4C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, linux-acpi@vger.kernel.org,
        jeremy.linton@arm.com
Cc:     linux-kernel@vger.kernel.org, vkilari@codeaurora.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v2 2/2] ACPI/PPTT: Handle architecturally unknown cache types
Date:   Fri, 14 Sep 2018 10:28:09 -0600
Message-Id: <1536942489-4018-3-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1536942489-4018-1-git-send-email-jhugo@codeaurora.org>
References: <1536942489-4018-1-git-send-email-jhugo@codeaurora.org>
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
---
 drivers/acpi/pptt.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index d1e26cb..bb00ed9 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -402,11 +402,18 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
 		}
 	}
 	/*
-	 * If the above flags are valid, and the cache type is NOCACHE
-	 * update the cache type as well.
+	 * If cache type is NOCACHE, then the cache hasn't been specified
+	 * via other mechanisms.  Update the type if either the cache has
+	 * been fully specified in PPTT, or a cache type has been provided.
+	 *
+	 * Note, we assume such caches are unified based on conventional system
+	 * design and known examples.  Significant work is required elsewhere to
+	 * fully support data/instruction only type caches which are only
+	 * specified in PPTT.
 	 */
-	if (this_leaf->type == CACHE_TYPE_NOCACHE &&
-	    valid_flags == PPTT_CHECKED_ATTRIBUTES)
+	if ((this_leaf->type == CACHE_TYPE_NOCACHE) &&
+	    (valid_flags == PPTT_CHECKED_ATTRIBUTES ||
+	     found_cache->flags & ACPI_PPTT_CACHE_TYPE_VALID))
 		this_leaf->type = CACHE_TYPE_UNIFIED;
 }
 
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

