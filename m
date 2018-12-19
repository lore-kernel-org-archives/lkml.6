Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50405C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 154EE2084A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="C9joJGAX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbeLSQQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:16:36 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:40432 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbeLSQQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:16:35 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 447FF10C1DC3;
        Wed, 19 Dec 2018 08:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1545236195; bh=7LE4Y0kl6NhqEVYvVOZ2QDN3PQMCheUaIYmiZZU/1kw=;
        h=From:To:Cc:Subject:Date:From;
        b=C9joJGAXZIEP5+qnZkAtjKK7XOWwWlhILUYXx5RMUg0OwYCY4QpFhALYQBAyc7qU4
         7P3DB0X4F1JgFqT48iJNpvZJdIiANSR63JjYM0Tp5/S8/uU8vOS/9THWppIWO9WP20
         zjm0MJljSnIpk0ll1+dWECpsKpCxGlDeCd7/em69/z8OhH737/9L4R6Vef2WVAQNv2
         K0RmMsWA3HnFuAHJfpn285hcgdZxx4CjlVtJil4YL/vGfkVEmusXBr5nE9g/YLlbOS
         RowtosTgwvNlsfX55fis/zIQTCLUyN29Fpue1HNKXgCf44gHYMFVH8hGmMLi75nd56
         5ZurYJY1Qizkw==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.66])
        by mailhost.synopsys.com (Postfix) with ESMTP id 58E453800;
        Wed, 19 Dec 2018 08:16:33 -0800 (PST)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        stable@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH] ARC: adjust memblock_reserve of kernel memory
Date:   Wed, 19 Dec 2018 19:16:16 +0300
Message-Id: <20181219161616.10422-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In setup_arch_memory we reserve the memory area wherein the kernel
is located. Current implementation may reserve more memory than
it actually required in case of CONFIG_LINUX_LINK_BASE is not
equal to CONFIG_LINUX_RAM_BASE. This happens because we calculate
start of the reserved region relatively to the CONFIG_LINUX_RAM_BASE
and end of the region relatively to the CONFIG_LINUX_RAM_BASE.

For example in case of HSDK board we wasted 256MiB of physical memory:
------------------->8------------------------------
Memory: 770416K/1048576K available (5496K kernel code,
    240K rwdata, 1064K rodata, 2200K init, 275K bss,
    278160K reserved, 0K cma-reserved)
------------------->8------------------------------

Fix that.

Cc: stable@vger.kernel.org
Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/mm/init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
index f8fe5668b30f..a56e6a8ed259 100644
--- a/arch/arc/mm/init.c
+++ b/arch/arc/mm/init.c
@@ -137,7 +137,8 @@ void __init setup_arch_memory(void)
 	 */
 
 	memblock_add_node(low_mem_start, low_mem_sz, 0);
-	memblock_reserve(low_mem_start, __pa(_end) - low_mem_start);
+	memblock_reserve(CONFIG_LINUX_LINK_BASE,
+			 __pa(_end) - CONFIG_LINUX_LINK_BASE);
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start)
-- 
2.14.5

