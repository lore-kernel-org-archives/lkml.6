Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BC1C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C129520685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C129520685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chris-wilson.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeJaSkE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:40:04 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:63556 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727436AbeJaSkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:40:03 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 14296867-1500050 
        for multiple; Wed, 31 Oct 2018 09:41:55 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Kuo-Hsin Yang <vovoy@chromium.org>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20181031081945.207709-1-vovoy@chromium.org>
Cc:     Kuo-Hsin Yang <vovoy@chromium.org>, Michal Hocko <mhocko@suse.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>
References: <20181031081945.207709-1-vovoy@chromium.org>
Message-ID: <154097891543.4007.9898414288875202246@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH v3] mm, drm/i915: mark pinned shmemfs pages as unevictable
Date:   Wed, 31 Oct 2018 09:41:55 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuo-Hsin Yang (2018-10-31 08:19:45)
> The i915 driver uses shmemfs to allocate backing storage for gem
> objects. These shmemfs pages can be pinned (increased ref count) by
> shmem_read_mapping_page_gfp(). When a lot of pages are pinned, vmscan
> wastes a lot of time scanning these pinned pages. In some extreme case,
> all pages in the inactive anon lru are pinned, and only the inactive
> anon lru is scanned due to inactive_ratio, the system cannot swap and
> invokes the oom-killer. Mark these pinned pages as unevictable to speed
> up vmscan.
> 
> Add check_move_lru_page() to move page to appropriate lru list.
> 
> This patch was inspired by Chris Wilson's change [1].
> 
> [1]: https://patchwork.kernel.org/patch/9768741/
> 
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Signed-off-by: Kuo-Hsin Yang <vovoy@chromium.org>
> ---
> The previous mapping_set_unevictable patch is worse on gem_syslatency
> because it defers to vmscan to move these pages to the unevictable list
> and the test measures latency to allocate 2MiB pages. This performance
> impact can be solved by explicit moving pages to the unevictable list in
> the i915 function.
> 
> Chris, can you help to run the "igt/benchmarks/gem_syslatency -t 120 -b -m"
> test with this patch on your testing machine? I tried to run the test on
> a Celeron N4000, 4GB Ram machine. The mean value with this patch is
> similar to that with the mlock patch.

Will do. As you are confident, I'll try a few different machines. :)
-Chris
