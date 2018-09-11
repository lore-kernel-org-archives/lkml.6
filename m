Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD8DC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 19:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C8C2206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 19:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nqujDIUu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="o8pB3392"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C8C2206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbeILAd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 20:33:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53244 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbeILAd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 20:33:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 40FA8607C6; Tue, 11 Sep 2018 19:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536694358;
        bh=iN843eDPY2wSQrCsjtacWkwVYAC3Eh44Pu1soY5v+V4=;
        h=From:To:Cc:Subject:Date:From;
        b=nqujDIUu/5XewpNInHKiwqqpI3ReginRBupVJQHo6GrmO14rnS3laYL0Ec92jfxgg
         GXVHRD1ILs/xbgNe0OB/xBj7UkF01et3qBbysQIPgd6ypQ45yBn2z+3CVGWTwU+yeX
         nuLTDaZAsEVu2XRJ09Or2rT9FQcCcGi8cae+yKg8=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1A18760721;
        Tue, 11 Sep 2018 19:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536694357;
        bh=iN843eDPY2wSQrCsjtacWkwVYAC3Eh44Pu1soY5v+V4=;
        h=From:To:Cc:Subject:Date:From;
        b=o8pB3392Mep5g4NYLO6X/vE7EBSg84k5RvQ7IVXpVmbzNm6zoxF8w1D7CFgQb3DI1
         i6KPX8hnXp8eCdGGzYPlQ2lWyi87SMQNTMYEX0AzCQEWhAgCwJTzh9b00b7ard/oqg
         403NIIRyUasnmMiOUrEz0FLUfvbzPeaj4470B85A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1A18760721
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     rjw@rjwysocki.net, linux-acpi@vger.kernel.org,
        jeremy.linton@arm.com
Cc:     linux-kernel@vger.kernel.org, vkilari@codeaurora.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH] ACPI/PPTT: Handle architecturally unknown cache types
Date:   Tue, 11 Sep 2018 13:32:14 -0600
Message-Id: <1536694334-5811-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The type of a cache might not be specified by architectural mechanisms (ie
system registers), but its type might be specified in the PPTT.  In this
case, following the PPTT specification, we should identify the cache as
the type specified by PPTT.

This fixes the following lscpu issue where only the cache type sysfs file
is missing which results in no output providing a poor user experience in
the above system configuration-
lscpu: cannot open /sys/devices/system/cpu/cpu0/cache/index3/type: No such
file or directory

Fixes: 2bd00bcd73e5 (ACPI/PPTT: Add Processor Properties Topology Table parsing)
Reported-by: Vijaya Kumar K <vkilari@codeaurora.org>
Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 drivers/acpi/pptt.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index d1e26cb..3c6db09 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -401,6 +401,21 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
 			break;
 		}
 	}
+	if ((this_leaf->type == CACHE_TYPE_NOCACHE) &&
+	    (found_cache->flags & ACPI_PPTT_CACHE_TYPE_VALID)) {
+		switch (found_cache->attributes & ACPI_PPTT_MASK_CACHE_TYPE) {
+		case ACPI_PPTT_CACHE_TYPE_DATA:
+			this_leaf->type = CACHE_TYPE_DATA;
+			break;
+		case ACPI_PPTT_CACHE_TYPE_INSTR:
+			this_leaf->type = CACHE_TYPE_INST;
+			break;
+		case ACPI_PPTT_CACHE_TYPE_UNIFIED:
+		case ACPI_PPTT_CACHE_TYPE_UNIFIED_ALT:
+			this_leaf->type = CACHE_TYPE_UNIFIED;
+			break;
+		}
+	}
 	/*
 	 * If the above flags are valid, and the cache type is NOCACHE
 	 * update the cache type as well.
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

