Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9795C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 780772082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q2J+KboZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 780772082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbeJCTW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 15:22:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37542 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbeJCTW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 15:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=A/D1CDsONpRQQhnK63WF15F/T/n+88uH9hlOUIdjVxY=; b=Q2J+KboZ1ANP8po5E2EXDzNzN
        7TreRYqp5jYIiE+UMG87bXGm5RZ5/brM4uS7uDPQIzn3tghl6GfTWbb2BKQwg0XxWPok1auZWluti
        b99TpuVYD1qaADLf2pAIH/+8RcKu2zhKiGYeSg2pUuhW+XaE1C6U2wOUCQB0MXGfT+4nZRZN4h4Sb
        zndtkFgHkuvrdwHpW9BRnUK2P1LNEpeP7b1sA4zp1IRH7zW0rmoqje+ElTtjRaXUcTJPXg4ZblAvi
        1irUMQl6jhzBAHyZE1vBmoLgUwXG7Kk6O6IgZf+GJlHSJBUi88u7JyeIbd9ptK1EdDZpM4ew5cfFp
        KNkCzAcsQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7gLt-0002jf-RF; Wed, 03 Oct 2018 12:34:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F1FDB202C1A14; Wed,  3 Oct 2018 14:34:02 +0200 (CEST)
Date:   Wed, 3 Oct 2018 14:34:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     m.mizuma@jp.fujitsu.com, bhe@redhat.com, bp@alien8.de,
        torvalds@linux-foundation.org, msys.mizuma@gmail.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@kernel.org,
        hpa@zytor.com
Cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/boot] ACPI/NUMA: Add warning message if the padding
 size for KASLR is not enough
Message-ID: <20181003123402.GA15494@hirez.programming.kicks-ass.net>
References: <20181001140843.26137-3-msys.mizuma@gmail.com>
 <tip-3b054ca88c4f4dd5f516a12d4b6d6bd0ae826f41@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-3b054ca88c4f4dd5f516a12d4b6d6bd0ae826f41@git.kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Subject: ACPI/NUMA: Fix KASLR build error

There is no point in trying to compile KASLR specific code when there is
no KASLR.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 3d69834c692f..5767733976b3 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -436,7 +436,6 @@ acpi_table_parse_srat(enum acpi_srat_type id,
 int __init acpi_numa_init(void)
 {
 	int cnt = 0;
-	u64 max_possible_phys, max_actual_phys, threshold;
 
 	if (acpi_disabled)
 		return -EINVAL;
@@ -466,8 +465,11 @@ int __init acpi_numa_init(void)
 		cnt = acpi_table_parse_srat(ACPI_SRAT_TYPE_MEMORY_AFFINITY,
 					    acpi_parse_memory_affinity, 0);
 
+#ifdef CONFIG_RANDOMIZE_MEMORY
 		/* check the padding size for KASLR is enough. */
 		if (parsed_numa_memblks && kaslr_enabled()) {
+			u64 max_possible_phys, max_actual_phys, threshold;
+
 			max_actual_phys = roundup(PFN_PHYS(max_pfn), 1ULL << 40);
 			max_possible_phys = roundup(PFN_PHYS(max_possible_pfn), 1ULL << 40);
 			threshold = max_actual_phys + ((u64)rand_mem_physical_padding << 40);
@@ -477,6 +479,7 @@ int __init acpi_numa_init(void)
 				  (max_possible_phys - max_actual_phys) >> 40);
 			}
 		}
+#endif
 	}
 
 	/* SLIT: System Locality Information Table */
