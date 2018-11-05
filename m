Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AECC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6ED2086A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD6ED2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbeKEWZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:25:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:43662 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728870AbeKEWZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:25:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 785A9ADED;
        Mon,  5 Nov 2018 13:05:44 +0000 (UTC)
Date:   Mon, 5 Nov 2018 14:05:44 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Kuo-Hsin Yang <vovoy@chromium.org>
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mm@kvack.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v4] mm, drm/i915: mark pinned shmemfs pages as unevictable
Message-ID: <20181105130544.GJ4361@dhcp22.suse.cz>
References: <20181105111348.182492-1-vovoy@chromium.org>
 <20181105130209.GI4361@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105130209.GI4361@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-11-18 14:02:09, Michal Hocko wrote:
> On Mon 05-11-18 19:13:48, Kuo-Hsin Yang wrote:
> > The i915 driver uses shmemfs to allocate backing storage for gem
> > objects. These shmemfs pages can be pinned (increased ref count) by
> > shmem_read_mapping_page_gfp(). When a lot of pages are pinned, vmscan
> > wastes a lot of time scanning these pinned pages. In some extreme case,
> > all pages in the inactive anon lru are pinned, and only the inactive
> > anon lru is scanned due to inactive_ratio, the system cannot swap and
> > invokes the oom-killer. Mark these pinned pages as unevictable to speed
> > up vmscan.
> > 
> > Export pagevec API check_move_unevictable_pages().
> 
> Thanks for reworking the patch. This looks much more to my taste. At
> least the mm part. I haven't really looked at the the drm part.

One side note. Longterm we probably want a better pinning API. It would
hide this LRU manipulation implementation detail + enforce some limiting
and provide a good way that the pin is longterm. People are working on
this already but it is a PITA and long time to get there.
-- 
Michal Hocko
SUSE Labs
