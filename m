Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07B3C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 943DB20871
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DybZWRef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 943DB20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754157AbeGFJCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 05:02:43 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43551 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754123AbeGFJCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 05:02:40 -0400
Received: by mail-pf0-f193.google.com with SMTP id y8-v6so7891504pfm.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 02:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rtdc9EBZDt/OvCySy+SZxp4b3kXttIQe6tLhXTYwvQ4=;
        b=DybZWRefHd8feD3InBNrJ8fiVAEN2N3lBwFabNSZI+ME6XZChaJ70PBBQSS+laghIn
         mp5OcpXmPvZNztETIeNjnHzEwsd/M9qpgZSsBR28IA/15OTeHmpktjSpcfvRf/iBtJRz
         HQps64EKg3yahvKKdwQV/komJvcrfEFBW/bbiY0n4BSrl+zC9FPbL6FUTRlPGpKK1sLf
         n9OaP/aFNy9NkXuX6Epjbo8aXqLEuOSD48dconuus86BzAhi6nt6/6ZJxE01ekHOis1h
         lrYAtY1jeGvdhml43tZHCKeeW8vOSdcbI089c2jo4V/G7X8P9zJitlZ9JGFwuI9iBGKx
         hQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rtdc9EBZDt/OvCySy+SZxp4b3kXttIQe6tLhXTYwvQ4=;
        b=FNVN+7X/moNbHiYrBgCTXMgn+WLlyr/nExoQ+8QYHhmPccdbsZfFDYhieEGTb8l0s6
         9n125UsDKmlTjDeZNK31VIBtFZ9ASyvu31yxRummiw6hzhW6Fen6lVMAjUywhGMCJt28
         jUCM0TZ5MBAfUXRtIpk8yHJETAnkTOw+1gofM2XBy2LnkJbiKIouOzprg88Oqhc8MOuu
         d3VM0w5wLjloHXLSJ2v5eDmJ1LYnH0w3p4cqsjHgeJo7sd2sUnL8rXyDtjxdHmlQfz1U
         smrrbsIMojYK8D/hIGB1ZWC0UjgmR849qstazUAqUgzWhsa2XLqerl5EawXSi7KDGJaf
         vJGQ==
X-Gm-Message-State: APt69E0TC5H6hWPNVk3nM8mjM4orcxTnbYj1XlfSsgXG9EJid/mp8NHn
        4TUKwzxQs8F1WiAi118byOk=
X-Google-Smtp-Source: AAOMgpcocswtgjtHNdjqffq9MrloIRC3jLxZtQNd6r+gQ5OYDodQ1JD30tPWt+mweNwr/QsbWObb6Q==
X-Received: by 2002:a62:20d8:: with SMTP id m85-v6mr2833555pfj.74.1530867760292;
        Fri, 06 Jul 2018 02:02:40 -0700 (PDT)
Received: from ct7host.localdomain ([38.106.11.25])
        by smtp.gmail.com with ESMTPSA id e5-v6sm10837092pgs.59.2018.07.06.02.02.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 02:02:39 -0700 (PDT)
From:   Jia He <hejianet@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Philip Derrin <philip@cog.systems>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kemi Wang <kemi.wang@intel.com>,
        Petr Tesarik <ptesarik@suse.com>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Daniel Vacek <neelx@redhat.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jia He <jia.he@hxt-semitech.com>
Subject: [RESEND PATCH v10 5/6] mm/memblock: introduce pfn_valid_region()
Date:   Fri,  6 Jul 2018 17:01:14 +0800
Message-Id: <1530867675-9018-6-git-send-email-hejianet@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1530867675-9018-1-git-send-email-hejianet@gmail.com>
References: <1530867675-9018-1-git-send-email-hejianet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia He <jia.he@hxt-semitech.com>

Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
where possible") optimized the loop in memmap_init_zone(). But there is
still some room for improvement.
E.g. in early_pfn_valid(), we can record the last returned memblock region.
If current pfn and last pfn are in the same memory region, we needn't do
the unnecessary binary searches because memblock_is_nomap is the same
result for whole memory region.

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 mm/memblock.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/mm/memblock.c b/mm/memblock.c
index c783b1a..274bd9f 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1188,6 +1188,30 @@ ulong __init_memblock memblock_next_valid_pfn(ulong pfn)
 	return PHYS_PFN(regions[early_region_idx].base);
 }
 EXPORT_SYMBOL(memblock_next_valid_pfn);
+
+int pfn_valid_region(ulong pfn)
+{
+	ulong start_pfn, end_pfn;
+	struct memblock_type *type = &memblock.memory;
+	struct memblock_region *regions = type->regions;
+
+	if (early_region_idx != -1) {
+		start_pfn = PFN_DOWN(regions[early_region_idx].base);
+		end_pfn = PFN_DOWN(regions[early_region_idx].base +
+					regions[early_region_idx].size);
+
+		if (pfn >= start_pfn && pfn < end_pfn)
+			return !memblock_is_nomap(
+					&regions[early_region_idx]);
+	}
+
+	early_region_idx = memblock_search_pfn_regions(pfn);
+	if (early_region_idx == -1)
+		return false;
+
+	return !memblock_is_nomap(&regions[early_region_idx]);
+}
+EXPORT_SYMBOL(pfn_valid_region);
 #endif /*CONFIG_HAVE_MEMBLOCK_PFN_VALID*/
 
 static phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
-- 
1.8.3.1

