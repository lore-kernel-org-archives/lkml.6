Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334C0C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CFC6222CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732825AbfBMPPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:15:52 -0500
Received: from nat.nue.novell.com ([195.135.221.2]:1639 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729139AbfBMPPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:15:52 -0500
Received: by suse.de (Postfix, from userid 1000)
        id A041F4278; Wed, 13 Feb 2019 16:15:50 +0100 (CET)
Date:   Wed, 13 Feb 2019 16:15:50 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, akpm@linux-foundation.org,
        david@redhat.com, anthony.yznaga@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,memory_hotplug: Explicitly pass the head to
 isolate_huge_page
Message-ID: <20190213151547.cwaqptreai43s65j@d104.suse.de>
References: <20190208090604.975-1-osalvador@suse.de>
 <20190212083329.GN15609@dhcp22.suse.cz>
 <20190212134546.gubfir6zzwrvmunr@d104.suse.de>
 <20190212144026.GY15609@dhcp22.suse.cz>
 <52f7a47c-4a8b-c06d-04c0-48d9bb43823b@oracle.com>
 <20190213081310.zfxwb3svoqsxnuyc@d104.suse.de>
 <20190213123339.GG4525@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213123339.GG4525@dhcp22.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 01:33:39PM +0100, Michal Hocko wrote:
> Why isn't our check in has_unmovable_pages sufficient?

Taking a closer look, it should be enough.
I was mainly confused by the fact that if the zone is ZONE_MOVABLE,
we do not keep checking in has_unmovable_pages():

if (zone_idx(zone) == ZONE_MOVABLE)
	continue;

But I overlooked that htlb_alloc_mask() checks whether the allocation
cand end up in a movable zone.
hugepage_movable_supported() checks that and if the hstate does not
support migration at all, we skip __GFP_MOVABLE.

So I think that the check in has_unmovable_pages() should be more than enough,
so we could strip the checks from do_migrate_ranges() and
scan_movable_pages() regarding hugepage migratability.

I will run some tests just to make sure this holds and then
I will send a patch.

Thanks
-- 
Oscar Salvador
SUSE L3
