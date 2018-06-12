Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 97917C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 490F820693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 490F820693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933504AbeFLHqx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:46:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:39280 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933183AbeFLHqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:46:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 405ACADBA;
        Tue, 12 Jun 2018 07:46:48 +0000 (UTC)
Date:   Tue, 12 Jun 2018 09:46:46 +0200
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
Message-ID: <20180612074646.GS13364@dhcp22.suse.cz>
References: <1528484212-7199-1-git-send-email-jbaron@akamai.com>
 <20180611072005.GC13364@dhcp22.suse.cz>
 <4c4de46d-c55a-99a8-469f-e1e634fb8525@akamai.com>
 <20180611150330.GQ13364@dhcp22.suse.cz>
 <775adf2d-140c-1460-857f-2de7b24bafe7@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <775adf2d-140c-1460-857f-2de7b24bafe7@akamai.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11-06-18 12:23:58, Jason Baron wrote:
> On 06/11/2018 11:03 AM, Michal Hocko wrote:
> > So can we start discussing whether we want to allow MADV_DONTNEED on
> > mlocked areas and what downsides it might have? Sure it would turn the
> > strong mlock guarantee to have the whole vma resident but is this
> > acceptable for something that is an explicit request from the owner of
> > the memory?
> > 
> 
> If its being explicity requested by the owner it makes sense to me. I
> guess there could be a concern about this breaking some userspace that
> relied on MADV_DONTNEED not freeing locked memory?

Yes, this is always the fear when changing user visible behavior.  I can
imagine that a userspace allocator calling MADV_DONTNEED on free could
break. The same would apply to MLOCK_ONFAULT/MCL_ONFAULT though. We
have the new flag much shorter so the probability is smaller but the
problem is very same. So I _think_ we should treat both the same because
semantically they are indistinguishable from the MADV_DONTNEED POV. Both
remove faulted and mlocked pages. Mlock, once applied, should guarantee
no later major fault and MADV_DONTNEED breaks that obviously.

So the more I think about it the more I am worried about this but I am
more and more convinced that making ONFAULT special is just a wrong way
around this.
-- 
Michal Hocko
SUSE Labs
