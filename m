Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1330799-1519988556-2-14484860403082930442
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519988555; b=uXvSb87rjm/lTOXKoRm7KPe28QoZhWnBgLArcUh11ZAM95w
    5byFeRrtLVgljP0/XAkRGm77qrkA1HieOwX/v6+Xg+b6ve0rwPf66mvbfGoEp7Hn
    U84TrsXMfQBVeMNsAAYZih5VsaAkk+7/+6ZU9cezXMrJViZu+0Hi+K57939/sgoy
    gMM+7gcnO6eR5gWvFbatQt1uPx4dtJqcsUP8UHf/ZOdQ+R0VBJ6vIoTWNTY9xfdD
    xAIXjnREi2tvxts8t+4DLW/mnZvloFnNqVhDASW4Qg2+6A0pz/Fva0v7fGJ3JUY9
    WiyQXaV9q5+kVyKfF0bjrj1UbD4sGWGlkF0++pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519988555;
    bh=TLk4yNKmmAFKNB63rBTG0ljVSblW7ppoGECwZB204Bk=; b=R8ejeiRzlrRR
    G439ejv+EI3FwTVr0p9EAhewBhnYp5XYiqlUInsvszHyMSsc9wCaVcQ5AiAXBQ0I
    uXuYSjoxP10SRhzczWU/JcXpb5l+PFUsLwv9bWggkGem7s1TWVl/72/nl7YQvagw
    zNXsxTnnntlLE7kw0SbDEtnKvKaGu4uVaqzNUxovrvZsCBasCz9BDDy5wdnl+gBf
    uS+XoH0wmPL/sZMWLRrWIQQpPJ0yXhFW/eDDA3vGj4YsEXfbo5SqbACHJmjJumay
    G+C+pAqTCt6Tpx4wGp7wObF9K+iBRhXu/4yFnGbiZRUAfau6rnvAVK//BvBFR76U
    46YovAhX8g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423774AbeCBLBz (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 06:01:55 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41126 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1423770AbeCBLBt (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 2 Mar 2018 06:01:49 -0500
From: Daniel Vacek <neelx@redhat.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Daniel Vacek <neelx@redhat.com>, stable@vger.kernel.org
Subject: [PATCH v2] mm/page_alloc: fix memmap_init_zone pageblock alignment
Date: Fri,  2 Mar 2018 12:01:37 +0100
Message-Id: <1519988497-28941-1-git-send-email-neelx@redhat.com>
In-Reply-To: <1519908465-12328-1-git-send-email-neelx@redhat.com>
References: <1519908465-12328-1-git-send-email-neelx@redhat.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

BUG at mm/page_alloc.c:1913

>	VM_BUG_ON(page_zone(start_page) != page_zone(end_page));

Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
where possible") introduced a bug where move_freepages() triggers a
VM_BUG_ON() on uninitialized page structure due to pageblock alignment.
To fix this, simply align the skipped pfns in memmap_init_zone()
the same way as in move_freepages_block().

Fixes: b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns where possible")
Signed-off-by: Daniel Vacek <neelx@redhat.com>
Cc: stable@vger.kernel.org
---
 mm/memblock.c   | 13 ++++++-------
 mm/page_alloc.c |  9 +++++++--
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 5a9ca2a1751b..2a5facd236bb 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1101,13 +1101,12 @@ void __init_memblock __next_mem_pfn_range(int *idx, int nid,
 		*out_nid = r->nid;
 }
 
-unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn,
-						      unsigned long max_pfn)
+unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn)
 {
 	struct memblock_type *type = &memblock.memory;
 	unsigned int right = type->cnt;
 	unsigned int mid, left = 0;
-	phys_addr_t addr = PFN_PHYS(pfn + 1);
+	phys_addr_t addr = PFN_PHYS(++pfn);
 
 	do {
 		mid = (right + left) / 2;
@@ -1118,15 +1117,15 @@ unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn,
 				  type->regions[mid].size))
 			left = mid + 1;
 		else {
-			/* addr is within the region, so pfn + 1 is valid */
-			return min(pfn + 1, max_pfn);
+			/* addr is within the region, so pfn is valid */
+			return pfn;
 		}
 	} while (left < right);
 
 	if (right == type->cnt)
-		return max_pfn;
+		return -1UL;
 	else
-		return min(PHYS_PFN(type->regions[right].base), max_pfn);
+		return PHYS_PFN(type->regions[right].base);
 }
 
 /**
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cb416723538f..eb27ccb50928 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5359,9 +5359,14 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 			/*
 			 * Skip to the pfn preceding the next valid one (or
 			 * end_pfn), such that we hit a valid pfn (or end_pfn)
-			 * on our next iteration of the loop.
+			 * on our next iteration of the loop. Note that it needs
+			 * to be pageblock aligned even when the region itself
+			 * is not as move_freepages_block() can shift ahead of
+			 * the valid region but still depends on correct page
+			 * metadata.
 			 */
-			pfn = memblock_next_valid_pfn(pfn, end_pfn) - 1;
+			pfn = (memblock_next_valid_pfn(pfn) &
+					~(pageblock_nr_pages-1)) - 1;
 #endif
 			continue;
 		}
-- 
2.16.2
