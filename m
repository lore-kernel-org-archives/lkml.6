Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D97C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DB423DDD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6DB423DDD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932443AbeGFLhZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 07:37:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35110 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753545AbeGFLhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 07:37:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 861CF18A;
        Fri,  6 Jul 2018 04:37:21 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 75D233F5BA;
        Fri,  6 Jul 2018 04:37:20 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH] of/fdt: avoid undefined behaviour in populate_properties()
Date:   Fri,  6 Jul 2018 12:37:15 +0100
Message-Id: <20180706113715.30053-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We unflatten a device tree in two passes: the first calculating the size
of the unflattened tree, and the second performing the actual
unflattening into a suitably-sized buffer.

During the first (dryrun) pass, the memory pool is NULL, and we derive
other pointers from this. Mostly these are done though intermediate
casts to unsigned long, which prevents the compiler from being able to
observe this as undefined behaviour. However, in populate_properties()
we derive the pprev pointer from the np pointer, which is NULL if it is
the first element allocated from the memory pool.

This is detected by UBSAN:

================================================================================
UBSAN: Undefined behaviour in drivers/of/fdt.c:190:8
member access within null pointer of type 'struct device_node'
CPU: 0 PID: 0 Comm: swapper Not tainted 4.18.0-rc3+ #13
Hardware name: ARM Juno development board (r1) (DT)
Call trace:
 dump_backtrace+0x0/0x458
 show_stack+0x20/0x30
 dump_stack+0x18c/0x248
 ubsan_epilogue+0x18/0x94
 handle_null_ptr_deref+0x1d4/0x228
 __ubsan_handle_type_mismatch_v1+0x188/0x1e0
 unflatten_dt_nodes+0xd40/0x1000
 __unflatten_device_tree+0x58/0x248
 unflatten_device_tree+0x38/0x4c
 setup_arch+0x3b0/0xcc4
 start_kernel+0xd8/0xb9c
================================================================================

In the dryrun pass we don't actually use the pprev value, so let's only
set it when !dryrun, and avoid the undefined behaviour.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org
---
 drivers/of/fdt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 6da20b9688f7..c1d0c348f2b3 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -187,7 +187,9 @@ static void populate_properties(const void *blob,
 	int cur;
 	bool has_name = false;
 
-	pprev = &np->properties;
+	if (!dryrun)
+		pprev = &np->properties;
+
 	for (cur = fdt_first_property_offset(blob, offset);
 	     cur >= 0;
 	     cur = fdt_next_property_offset(blob, cur)) {
-- 
2.11.0

