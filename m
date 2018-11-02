Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1CFC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66AEA2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66AEA2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbeKCDe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:34:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:43674 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727465AbeKCDe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:34:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 75E6FAD82;
        Fri,  2 Nov 2018 18:26:17 +0000 (UTC)
Date:   Fri, 2 Nov 2018 19:26:16 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Vovo Yang <vovoy@chromium.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-mm@kvack.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] mm, drm/i915: mark pinned shmemfs pages as unevictable
Message-ID: <20181102182616.GJ28039@dhcp22.suse.cz>
References: <20181031081945.207709-1-vovoy@chromium.org>
 <20181031142458.GP32673@dhcp22.suse.cz>
 <cc44aa53-8705-02ea-6c59-f311427d93af@intel.com>
 <20181031164231.GQ32673@dhcp22.suse.cz>
 <CAEHM+4pSkv_fD3Yb2KX1xFrOmRHU1e=+wCBrCyLAAMBG3zP75w@mail.gmail.com>
 <20181101130910.GI23921@dhcp22.suse.cz>
 <CAEHM+4rvBmFWhzPXZrwxXvMEmVdkpsgRg26wVNYSA8HKF_8AwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEHM+4rvBmFWhzPXZrwxXvMEmVdkpsgRg26wVNYSA8HKF_8AwQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 02-11-18 20:35:11, Vovo Yang wrote:
> On Thu, Nov 1, 2018 at 9:10 PM Michal Hocko <mhocko@kernel.org> wrote:
> > OK, so that explain my question about the test case. Even though you
> > generate a lot of page cache, the amount is still too small to trigger
> > pagecache mostly reclaim and anon LRUs are scanned as well.
> >
> > Now to the difference with the previous version which simply set the
> > UNEVICTABLE flag on mapping. Am I right assuming that pages are already
> > at LRU at the time? Is there any reason the mapping cannot have the flag
> > set before they are added to the LRU?
> 
> I checked again. When I run gem_syslatency, it sets unevictable flag
> first and then adds pages to LRU, so my explanation to the previous
> test result is wrong. It should not be necessary to explicitly move
> these pages to unevictable list for this test case.

OK, that starts to make sense finally.

> The performance
> improvement of this patch on kbl might be due to not calling
> shmem_unlock_mapping.

Yes that one can get quite expensive. find_get_entries is really
pointless here because you already do have your pages. Abstracting
check_move_unevictable_pages into a pagevec api sounds like a reasonable
compromise between the code duplication and relatively low-level api to
export.

> The perf result of a shmem lock test shows find_get_entries is the
> most expensive part of shmem_unlock_mapping.
> 85.32%--ksys_shmctl
>         shmctl_do_lock
>          --85.29%--shmem_unlock_mapping
>                    |--45.98%--find_get_entries
>                    |           --10.16%--radix_tree_next_chunk
>                    |--16.78%--check_move_unevictable_pages
>                    |--16.07%--__pagevec_release
>                    |           --15.67%--release_pages
>                    |                      --4.82%--free_unref_page_list
>                    |--4.38%--pagevec_remove_exceptionals
>                     --0.59%--_cond_resched

-- 
Michal Hocko
SUSE Labs
