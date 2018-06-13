Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3AC15C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E682D208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E682D208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934884AbeFMJOB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 05:14:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:50057 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934115AbeFMJN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 05:13:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 14E21ABF1;
        Wed, 13 Jun 2018 09:13:58 +0000 (UTC)
Date:   Wed, 13 Jun 2018 11:13:55 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jason Baron <jbaron@akamai.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-api@vger.kernel.org, emunson@mgebm.net
Subject: Re: [PATCH] mm/madvise: allow MADV_DONTNEED to free memory that is
 MLOCK_ONFAULT
Message-ID: <20180613091355.GI13364@dhcp22.suse.cz>
References: <1528484212-7199-1-git-send-email-jbaron@akamai.com>
 <20180611072005.GC13364@dhcp22.suse.cz>
 <4c4de46d-c55a-99a8-469f-e1e634fb8525@akamai.com>
 <20180611150330.GQ13364@dhcp22.suse.cz>
 <775adf2d-140c-1460-857f-2de7b24bafe7@akamai.com>
 <20180612074646.GS13364@dhcp22.suse.cz>
 <5a9398f4-453c-5cb5-6bbc-f20c3affc96a@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a9398f4-453c-5cb5-6bbc-f20c3affc96a@akamai.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12-06-18 10:11:33, Jason Baron wrote:
[...]
> Ok, I share the concern that there is a chance that userspace is relying
> on MADV_DONTNEED not free'ing locked memory. In that case, what if we
> introduce a MADV_DONTNEED_FORCE, which does everything that
> MADV_DONTNEED currently does but in addition will also free mlock areas.

What about other types of vmas that are not allowed to MADV_DONTNEED?
_FORCE suggests that the user of the API know what he is doing so why
shouldn't we allow unmapping hugetlb pages or special PFNMAPS? Or do we
want to add MADV_DONTNEED_FORCE_FOR_REAL when somebody comes with
another usecase?

I agree with Vlastimil that adding new madvise mode for niche case
sounds like a bad idea so we should better be sure that a new flag has
a reasonable semantic. Just allow mlocked pages is more of a tweak than
a proper semantic. So making it force for real requires to analyze what
that would mean for other vmas which are excluded now.
-- 
Michal Hocko
SUSE Labs
