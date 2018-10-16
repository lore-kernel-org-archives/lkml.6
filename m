Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71C0C5ACCA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D21B20645
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:32:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D21B20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chris-wilson.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeJQCXp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 22:23:45 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:58045 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727006AbeJQCXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 22:23:45 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 14126165-1500050 
        for multiple; Tue, 16 Oct 2018 19:31:07 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Kuo-Hsin Yang <vovoy@chromium.org>,
        Michal Hocko <mhocko@kernel.org>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20181016182155.GW18839@dhcp22.suse.cz>
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        peterz@infradead.org, dave.hansen@intel.com, corbet@lwn.net,
        hughd@google.com, joonas.lahtinen@linux.intel.com,
        marcheu@chromium.org, hoegsberg@chromium.org
References: <20181016174300.197906-1-vovoy@chromium.org>
 <20181016174300.197906-3-vovoy@chromium.org>
 <20181016182155.GW18839@dhcp22.suse.cz>
Message-ID: <153971466599.22931.16793398326492316920@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH 2/2] drm/i915: Mark pinned shmemfs pages as unevictable
Date:   Tue, 16 Oct 2018 19:31:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Michal Hocko (2018-10-16 19:21:55)
> On Wed 17-10-18 01:43:00, Kuo-Hsin Yang wrote:
> > The i915 driver use shmemfs to allocate backing storage for gem objects.
> > These shmemfs pages can be pinned (increased ref count) by
> > shmem_read_mapping_page_gfp(). When a lot of pages are pinned, vmscan
> > wastes a lot of time scanning these pinned pages. Mark these pinned
> > pages as unevictable to speed up vmscan.
> 
> I would squash the two patches into the single one. One more thing
> though. One more thing to be careful about here. Unless I miss something
> such a page is not migrateable so it shouldn't be allocated from a
> movable zone. Does mapping_gfp_constraint contains __GFP_MOVABLE? If
> yes, we want to drop it as well. Other than that the patch makes sense
> with my very limited knowlege of the i915 code of course.

They are not migrateable today. But we have proposed hooking up
.migratepage and setting __GFP_MOVABLE which would then include unlocking
the mapping at migrate time.

Fwiw, the shmem_unlock_mapping() call feels quite expensive, almost
nullifying the advantage gained from not walking the lists in reclaim.
I'll have better numbers in a couple of days.
-Chris
