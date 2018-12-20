Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26986C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B37218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="HZ3RnyoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730928AbeLTSus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:50:48 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45482 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbeLTSus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:50:48 -0500
Received: by mail-qt1-f194.google.com with SMTP id e5so2945858qtr.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 10:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yq3ZTpArJ65xR7vS5wrDTyHhQPaJMh6dRpk8JU+kLhI=;
        b=HZ3RnyoZNMY522zSp+KvJeNvFAbnkoBvV/STbY1JVwgxqfObTw6doYEoRFV71G5Nj1
         Z9z3BA2oRfpjVsRwORk8NasgatBYjl11tXnbsa8OtRuxPeVduwEV/2pJ9jSwVvvLYVaV
         ojQ2bvmCJhGKtyKsxWxLArAA0YnRfIP4DO4AljsqqY3bdK4f0FYygzo7xylYaBzF9VHS
         k41nTz/yYTAMtHG9jJDQgNaM17w6IENllMH6NsRLx7bxtW5K4GPyThADeQEjeggqsHCA
         zcsXaHLR2bZasQ2H4QGi/ifnyS+n9zdPhvWuGyy6ngjK5wKIHP4NxkNkI+o+rJz8ko3l
         +1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yq3ZTpArJ65xR7vS5wrDTyHhQPaJMh6dRpk8JU+kLhI=;
        b=L6J2KpC1pYcRiQGstphOcb82rTdUmEOGQ7IxoRDiFO9cG6LWBlL6iWL3maboG2F1iK
         EclPAL3DYKDb0lMuEZLhNCbQ5ku4xe+2M9V/jnEvR/NuWxQYdQo3SjWrdJkcwwkfaTd7
         7OqQC8mQlUfWovMpZ3NycLFowbiY1Xp9GCbpNebfsaFmIzh+NzfwbO+yjxuJ/p3IAfd9
         phA55FBOLAgSCjWoK0GQKKj1iAQ/8UgiEbqsYxq/wrAk7JHRCDJIMXamTqMGADoSEv68
         IQPv3qum7tbYVwkzWCNaUKeWvXkMhm9akMvgH7b2XfWRcIOCC7pMgvkWMJ0Z3dK9Rt7p
         FuDQ==
X-Gm-Message-State: AA+aEWbpCK6jj8LXPtN74FEx0roPVbOEjDGCp8KH0676cWBeG14MWP+B
        Ti2AsiDqNNqkW4hHoGzGWfR1XA==
X-Google-Smtp-Source: AFSGD/UUZQ+L2tM6RsHMVVOTnr7egfA7T30tyafFfjmccIjIdQ9b94Q51cnQbFjN67cp6omFQObPQw==
X-Received: by 2002:a0c:c138:: with SMTP id f53mr27296546qvh.225.1545331847044;
        Thu, 20 Dec 2018 10:50:47 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id x41sm5039029qth.92.2018.12.20.10.50.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 10:50:46 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, Pavel.Tatashin@microsoft.com, mingo@kernel.org,
        hpa@zytor.com, mgorman@techsingularity.net, tglx@linutronix.de,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v2] mm/page_owner: fix for deferred struct page init
Date:   Thu, 20 Dec 2018 13:50:31 -0500
Message-Id: <20181220185031.43146-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20181220092202.GD14234@dhcp22.suse.cz>
References: <20181220092202.GD14234@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When booting a system with "page_owner=on",

start_kernel
  page_ext_init
    invoke_init_callbacks
      init_section_page_ext
        init_page_owner
          init_early_allocated_pages
            init_zones_in_node
              init_pages_in_zone
                lookup_page_ext
                  page_to_nid

The issue here is that page_to_nid() will not work since some page
flags have no node information until later in page_alloc_init_late() due
to DEFERRED_STRUCT_PAGE_INIT. Hence, it could trigger an out-of-bounds
access with an invalid nid.

[    8.666047] UBSAN: Undefined behaviour in ./include/linux/mm.h:1104:50
[    8.672603] index 7 is out of range for type 'zone [5]'

Also, kernel will panic since flags were poisoned earlier with,

CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_NODE_NOT_IN_PAGE_FLAGS=n

start_kernel
  setup_arch
    pagetable_init
      paging_init
        sparse_init
          sparse_init_nid
            memblock_alloc_try_nid_raw

Although later it tries to set page flags for pages in reserved bootmem
regions,

mm_init
  mem_init
    memblock_free_all
      free_low_memory_core_early
        reserve_bootmem_region

there could still have some freed pages from the page allocator but yet
to be initialized due to DEFERRED_STRUCT_PAGE_INIT. It have already been
dealt with a bit in page_ext_init().

* Take into account DEFERRED_STRUCT_PAGE_INIT.
*/
if (early_pfn_to_nid(pfn) != nid)
	continue;

However it did not handle it well in init_pages_in_zone() which end up
calling page_to_nid().

[   11.917212] page:ffffea0004200000 is uninitialized and poisoned
[   11.917220] raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff
ffffffffffffffff
[   11.921745] raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff
ffffffffffffffff
[   11.924523] page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
[   11.926498] page_owner info is not active (free page?)
[   12.329560] kernel BUG at include/linux/mm.h:990!
[   12.337632] RIP: 0010:init_page_owner+0x486/0x520

Since there is no other routines depend on page_ext_init() in
start_kernel() and no real benefit to call it so early, just move it
after page_alloc_init_late() to ensure that there is no deferred pages
need to de dealt with.

Suggested-by: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: postpone init_page_ext() to after page_alloc_init_late().

 init/main.c   | 2 +-
 mm/page_ext.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/init/main.c b/init/main.c
index 2b7b7fe173c9..1aeb062b2cb7 100644
--- a/init/main.c
+++ b/init/main.c
@@ -696,7 +696,6 @@ asmlinkage __visible void __init start_kernel(void)
 		initrd_start = 0;
 	}
 #endif
-	page_ext_init();
 	kmemleak_init();
 	setup_per_cpu_pageset();
 	numa_policy_init();
@@ -1147,6 +1146,7 @@ static noinline void __init kernel_init_freeable(void)
 	sched_init_smp();
 
 	page_alloc_init_late();
+	page_ext_init();
 
 	do_basic_setup();
 
diff --git a/mm/page_ext.c b/mm/page_ext.c
index ae44f7adbe07..d76fd51e312a 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -399,9 +399,8 @@ void __init page_ext_init(void)
 			 * -------------pfn-------------->
 			 * N0 | N1 | N2 | N0 | N1 | N2|....
 			 *
-			 * Take into account DEFERRED_STRUCT_PAGE_INIT.
 			 */
-			if (early_pfn_to_nid(pfn) != nid)
+			if (pfn_to_nid(pfn) != nid)
 				continue;
 			if (init_section_page_ext(pfn, nid))
 				goto oom;
-- 
2.17.2 (Apple Git-113)

