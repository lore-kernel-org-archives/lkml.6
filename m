Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CDFC0044B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14CFE222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vk+9afpc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436686AbfBMUmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 15:42:36 -0500
Received: from mail-yw1-f74.google.com ([209.85.161.74]:35267 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387655AbfBMUmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 15:42:36 -0500
Received: by mail-yw1-f74.google.com with SMTP id d18so2236191ywb.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 12:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=qNCR0xN3839y7VMAmcBdO2qZgWS8pHFZK1yfc/zYXzk=;
        b=vk+9afpcYaiUM95aJA3YpkniHaAPKIKCIB0/xfPAYsnuF7/YNMPbNb4k5yafb8q/hg
         dVvuTWNKWxUYfWb8F6n2t+L5vbcXbDUy3v0W2SR65b+SIBSo/aW1YG0v4KZnPP49Yw8i
         4RdXH8htDGSG2dUmswH0gKObCDVSIPoaKTXzxGC2+quA8rx4wmm1VU1/SPLn6lViG2bR
         YnuQuZSJVMNhR4T6L/wKH9RF32kEWhfaJ6A0OACNv8zBV3ni012T46sxjKfCeLhRCLy3
         B9ecidL7VHAcArqfULSdG2dD3UjWr73rgCyOjB4szjIgotWbzRazwSg1rn3un1gjiHA8
         R3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qNCR0xN3839y7VMAmcBdO2qZgWS8pHFZK1yfc/zYXzk=;
        b=MZwmaSoZ+L1/XZl9BuOvYL8lQIRJ/xCMQif0gFJaF4OfZ9vRAZYdllKZEWyo4TQne8
         WoLrLRyuJiWJdUeRRVBucX2qQVsh4+ujUYEXY9LZgIVmzZK+uLj6sKQ+LR+FhcpIqNby
         cayE3ftsK4jdFTyYm5iZRml33VkyY7CcLKIRCaNkfPilbvWHtW5E90zE0GaqJ4v/Rcnx
         DWsJ8mOkFuW/dgCvaaDk/6SKWY/tWa6DF1yCYSMQj3/ncBFG/GT2jzOe/b/9nn41X/Gu
         jeEC28II7ryDCPG/AjWTuiQo5UofNbKYZkBaPz1IANyXWndNaLZwG4drCs3S6tWCWJoa
         iTKw==
X-Gm-Message-State: AHQUAuYCmoC470eGSFFwtYPt3dmLy5FE9xiO5Va4ZRgLN1qrnWzfvtoD
        gOAKAjRcPPkSBFRIzgdiXWRrRwQRUQ==
X-Google-Smtp-Source: AHgI3IYGHa4+7qE44erSpdyH7XPkwQLF/QTlE5/7wNbNcq+pC/rZo8F6iVN+yBzCSGsts8+B5GUGhLRnOw==
X-Received: by 2002:a81:e50:: with SMTP id 77mr19924ywo.20.1550090555029; Wed,
 13 Feb 2019 12:42:35 -0800 (PST)
Date:   Wed, 13 Feb 2019 21:41:57 +0100
Message-Id: <20190213204157.12570-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
Subject: [PATCH] mm: page_alloc: fix ref bias in page_frag_alloc() for 1-byte allocs
From:   Jann Horn <jannh@google.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        jannh@google.com
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Aaron Lu <aaron.lu@intel.com>, netdev@vger.kernel.org,
        Alexander Duyck <alexander.h.duyck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The basic idea behind ->pagecnt_bias is: If we pre-allocate the maximum
number of references that we might need to create in the fastpath later,
the bump-allocation fastpath only has to modify the non-atomic bias value
that tracks the number of extra references we hold instead of the atomic
refcount. The maximum number of allocations we can serve (under the
assumption that no allocation is made with size 0) is nc->size, so that's
the bias used.

However, even when all memory in the allocation has been given away, a
reference to the page is still held; and in the `offset < 0` slowpath, the
page may be reused if everyone else has dropped their references.
This means that the necessary number of references is actually
`nc->size+1`.

Luckily, from a quick grep, it looks like the only path that can call
page_frag_alloc(fragsz=1) is TAP with the IFF_NAPI_FRAGS flag, which
requires CAP_NET_ADMIN in the init namespace and is only intended to be
used for kernel testing and fuzzing.

To test for this issue, put a `WARN_ON(page_ref_count(page) == 0)` in the
`offset < 0` path, below the virt_to_page() call, and then repeatedly call
writev() on a TAP device with IFF_TAP|IFF_NO_PI|IFF_NAPI_FRAGS|IFF_NAPI,
with a vector consisting of 15 elements containing 1 byte each.

Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 mm/page_alloc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 35fdde041f5c..46285d28e43b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4675,11 +4675,11 @@ void *page_frag_alloc(struct page_frag_cache *nc,
 		/* Even if we own the page, we do not use atomic_set().
 		 * This would break get_page_unless_zero() users.
 		 */
-		page_ref_add(page, size - 1);
+		page_ref_add(page, size);
 
 		/* reset page count bias and offset to start of new frag */
 		nc->pfmemalloc = page_is_pfmemalloc(page);
-		nc->pagecnt_bias = size;
+		nc->pagecnt_bias = size + 1;
 		nc->offset = size;
 	}
 
@@ -4695,10 +4695,10 @@ void *page_frag_alloc(struct page_frag_cache *nc,
 		size = nc->size;
 #endif
 		/* OK, page count is 0, we can safely set it */
-		set_page_count(page, size);
+		set_page_count(page, size + 1);
 
 		/* reset page count bias and offset to start of new frag */
-		nc->pagecnt_bias = size;
+		nc->pagecnt_bias = size + 1;
 		offset = size - fragsz;
 	}
 
-- 
2.20.1.791.gb4d0f1c61a-goog

