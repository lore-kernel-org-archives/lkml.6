Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B1CECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B7D20647
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B7D20647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388097AbeGWJfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 05:35:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:56872 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387977AbeGWJfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 05:35:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8C7DAAC9C;
        Mon, 23 Jul 2018 08:35:19 +0000 (UTC)
Date:   Mon, 23 Jul 2018 10:35:19 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@techadventures.net>
Cc:     akpm@linux-foundation.org, pasha.tatashin@oracle.com,
        vbabka@suse.cz, aaron.lu@intel.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 3/5] mm/page_alloc: Optimize free_area_init_core
Message-ID: <20180723083519.GG17905@dhcp22.suse.cz>
References: <20180719132740.32743-1-osalvador@techadventures.net>
 <20180719132740.32743-4-osalvador@techadventures.net>
 <20180719134417.GC7193@dhcp22.suse.cz>
 <20180719140327.GB10988@techadventures.net>
 <20180719151555.GH7193@dhcp22.suse.cz>
 <20180719205235.GA14010@techadventures.net>
 <20180720100327.GA19478@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720100327.GA19478@techadventures.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 20-07-18 12:03:27, Oscar Salvador wrote:
> On Thu, Jul 19, 2018 at 10:52:35PM +0200, Oscar Salvador wrote:
> > On Thu, Jul 19, 2018 at 05:15:55PM +0200, Michal Hocko wrote:
> > > Your changelog doesn't really explain the motivation. Does the change
> > > help performance? Is this a pure cleanup?
> > 
> > Hi Michal,
> > 
> > Sorry to not have explained this better from the very beginning.
> > 
> > It should help a bit in performance terms as we would be skipping those
> > condition checks and assignations for zones that do not have any pages.
> > It is not a huge win, but I think that skipping code we do not really need to run
> > is worh to have.
> > 
> > > The function is certainly not an example of beauty. It is more an
> > > example of changes done on top of older ones without much thinking. But
> > > I do not see your change would make it so much better. I would consider
> > > it a much nicer cleanup if it was split into logical units each doing
> > > one specific thing.
> > 
> > About the cleanup, I thought that moving that block of code to a separate function
> > would make the code easier to follow.
> > If you think that this is still not enough, I can try to split it and see the outcome.
> 
> I tried to split it innto three logical blocks:
> 
> - Substract memmap pages
> - Substract dma reserves
> - Account kernel pages (nr_kernel_pages and nr_total_pages)

No, I do not think this is much better. Why do we need to separate those
functions out? I think you are too focused on the current function
without a broader context. Think about it. We have two code paths.
Early initialization and the hotplug. The two are subtly different in
some aspects. Maybe reusing free_area_init_core is the wrong thing and
we should have a dedicated subset of this function. This would make the
code more clear probably. You wouldn't have to think which part of
free_area_init_core is special and what has to be done if this function
was to be used in a different context. See my point?
-- 
Michal Hocko
SUSE Labs
