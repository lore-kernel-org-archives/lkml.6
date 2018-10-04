Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D54C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E22F21470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E22F21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbeJDOkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:40:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:39256 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727319AbeJDOkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:40:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8969CAE0B;
        Thu,  4 Oct 2018 07:48:39 +0000 (UTC)
Date:   Thu, 4 Oct 2018 09:48:38 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm: Shuffle initial free memory
Message-ID: <20181004074838.GE22173@dhcp22.suse.cz>
References: <153861931865.2863953.11185006931458762795.stgit@dwillia2-desk3.amr.corp.intel.com>
 <153861932401.2863953.11364943845583542894.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153861932401.2863953.11364943845583542894.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 03-10-18 19:15:24, Dan Williams wrote:
> Some data exfiltration and return-oriented-programming attacks rely on
> the ability to infer the location of sensitive data objects. The kernel
> page allocator, especially early in system boot, has predictable
> first-in-first out behavior for physical pages. Pages are freed in
> physical address order when first onlined.
> 
> Introduce shuffle_free_memory(), and its helper shuffle_zone(), to
> perform a Fisher-Yates shuffle of the page allocator 'free_area' lists
> when they are initially populated with free memory at boot and at
> hotplug time.
> 
> Quoting Kees:
>     "While we already have a base-address randomization
>      (CONFIG_RANDOMIZE_MEMORY), attacks against the same hardware and
>      memory layouts would certainly be using the predictability of
>      allocation ordering (i.e. for attacks where the base address isn't
>      important: only the relative positions between allocated memory).
>      This is common in lots of heap-style attacks. They try to gain
>      control over ordering by spraying allocations, etc.
> 
>      I'd really like to see this because it gives us something similar
>      to CONFIG_SLAB_FREELIST_RANDOM but for the page allocator."
> 
> Another motivation for this change is performance in the presence of a
> memory-side cache. In the future, memory-side-cache technology will be
> available on generally available server platforms. The proposed
> randomization approach has been measured to improve the cache conflict
> rate by a factor of 2.5X on a well-known Java benchmark. It avoids
> performance peaks and valleys to provide more predictable performance.
> 
> While SLAB_FREELIST_RANDOM reduces the predictability of some local slab
> caches it leaves vast bulk of memory to be predictably in order
> allocated. That ordering can be detected by a memory side-cache.
> 
> The shuffling is done in terms of 'shuffle_page_order' sized free pages
> where the default shuffle_page_order is MAX_ORDER-1 i.e. 10, 4MB this
> trades off randomization granularity for time spent shuffling.
> MAX_ORDER-1 was chosen to be minimally invasive to the page allocator
> while still showing memory-side cache behavior improvements.
> 
> The performance impact of the shuffling appears to be in the noise
> compared to other memory initialization work. Also the bulk of the work
> is done in the background as a part of deferred_init_memmap().

This is the biggest portion of the series and I am wondering why do we
need it at all. Why it isn't sufficient to rely on the patch 3 here?
Pages freed from the bootmem allocator go via the same path so they
might be shuffled at that time. Or is there any problem with that?
Not enough entropy at the time when this is called or the final result
is not randomized enough (some numbers would be helpful).
-- 
Michal Hocko
SUSE Labs
