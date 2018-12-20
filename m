Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF5BC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0531D20989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="DJ9thbX4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389595AbeLTUcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:32:14 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43398 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732267AbeLTUcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:32:14 -0500
Received: by mail-qt1-f195.google.com with SMTP id i7so3302559qtj.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 12:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3KbUcF/61ap+Ec02cHiH+mAMooHTPMSIopsMW+QipbA=;
        b=DJ9thbX4dJu+ss6h9B0lnkIK7Fewk/C+ZdK+WW8jqjUwOdMHmXwgUI4Ie62OFdYYV5
         jC7GLEL+8nox3a+cq4Ki2dOToQIBzZcf7p20Qv8KbqdZtgsCLmwGFzJI61dAEdGA1Ty+
         ViRy0niaIwec5DC1yHFYaEKNtd3ryjQH7fxDbYVWB3z9Jwp4rDN7WPBo3ejwFvkE8wfZ
         zB02qONXvsWfX2nmNjTJOwG9uudLtL5ri5Ho0RSaGw5e2Nns0k0TixedJMtvUfNLNY7A
         MmP7Eb6akR+32tn6aqBuxKUNG+NouHS9bsw5PTsgN+x++XpSwgLTvK3y1FWF+aiAaJIf
         3Cww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3KbUcF/61ap+Ec02cHiH+mAMooHTPMSIopsMW+QipbA=;
        b=Q+nDrldDDXp8oUqJ34t+0hGYSZdOxPr3A7mdZqHxKZR6ydwnsyNBi2BGx/StGyNYCs
         2r1AAruolCNT/niyeUg09q1es23XncQ0VLaj4+drMH68vwXcZNdNpKMRhpJNFAKGYs1n
         qx/55z5NvLDJMgRHqS84h4jXSsmRkDYekz3ExORA/8bR5owfD8HWMVlH+foJ6uQGlbuF
         z2iJpAncLnKAbSt2d8VPr8irUZWbnJA+zy/wiD5uIEHBsoBkDSKI6SLiQFV9EpQTQvx6
         U82POiuJtx048L70LKd3OkeOmoGWVuqZZyrxF9Hpe4e5RZdJYeUqKm7l6owOMO0QsnrJ
         oYVw==
X-Gm-Message-State: AA+aEWbOMm62a22lzho3Yfn4sUP3t7RQghTwq6p2MeCARhBhAtjidnNZ
        KQ5PW3TO8teHxCBMVN5+35tqGw==
X-Google-Smtp-Source: AFSGD/UCarTPfH/DXw0wQohHHgM+PhqJB4pNNWO9W+wXszchfubFEMaJ6+5KDRtx7C2jbh2MsoscLA==
X-Received: by 2002:ac8:7153:: with SMTP id h19mr26501039qtp.92.1545337933063;
        Thu, 20 Dec 2018 12:32:13 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id e17sm4653345qte.12.2018.12.20.12.32.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 12:32:12 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, Pavel.Tatashin@microsoft.com, mingo@kernel.org,
        hpa@zytor.com, mgorman@techsingularity.net, iamjoonsoo.kim@lge.com,
        yang.shi@linaro.org, tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH v3] mm/page_owner: fix for deferred struct page init
Date:   Thu, 20 Dec 2018 15:31:56 -0500
Message-Id: <20181220203156.43441-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20181220185031.43146-1-cai@lca.pw>
References: <20181220185031.43146-1-cai@lca.pw>
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

However, it did not handle it well in init_pages_in_zone() which end up
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
start_kernel(), just move it after page_alloc_init_late() to ensure that
there is no deferred pages need to de dealt with. If deselected
DEFERRED_STRUCT_PAGE_INIT, it is still better to call page_ext_init()
earlier, so page owner could catch more early page allocation call
sites. This gives us a good compromise between catching good and bad
call sites (See the v1 patch [1]) in case of DEFERRED_STRUCT_PAGE_INIT.

[1] https://lore.kernel.org/lkml/20181220060303.38686-1-cai@lca.pw/

Fixes: fe53ca54270 (mm: use early_pfn_to_nid in page_ext_init)
Suggested-by: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Qian Cai <cai@lca.pw>
---

v3: still call page_ext_init() earlier if DEFERRED_STRUCT_PAGE_INIT=n.

v2: postpone page_ext_init() to after page_alloc_init_late().

 init/main.c   | 5 +++++
 mm/page_ext.c | 3 +--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/init/main.c b/init/main.c
index 2b7b7fe173c9..5d9904370f76 100644
--- a/init/main.c
+++ b/init/main.c
@@ -696,7 +696,9 @@ asmlinkage __visible void __init start_kernel(void)
 		initrd_start = 0;
 	}
 #endif
+#ifndef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 	page_ext_init();
+#endif
 	kmemleak_init();
 	setup_per_cpu_pageset();
 	numa_policy_init();
@@ -1147,6 +1149,9 @@ static noinline void __init kernel_init_freeable(void)
 	sched_init_smp();
 
 	page_alloc_init_late();
+#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
+	page_ext_init();
+#endif
 
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

