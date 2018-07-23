Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCE6ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49B520846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C49B520846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388073AbeGWJau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 05:30:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:56146 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387908AbeGWJat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 05:30:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C12EFAE7B;
        Mon, 23 Jul 2018 08:30:44 +0000 (UTC)
Date:   Mon, 23 Jul 2018 10:30:43 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@techadventures.net>
Cc:     akpm@linux-foundation.org, pasha.tatashin@oracle.com,
        vbabka@suse.cz, aaron.lu@intel.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 3/5] mm/page_alloc: Optimize free_area_init_core
Message-ID: <20180723083043.GF17905@dhcp22.suse.cz>
References: <20180719132740.32743-1-osalvador@techadventures.net>
 <20180719132740.32743-4-osalvador@techadventures.net>
 <20180719134417.GC7193@dhcp22.suse.cz>
 <20180719140327.GB10988@techadventures.net>
 <20180719151555.GH7193@dhcp22.suse.cz>
 <20180719205235.GA14010@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719205235.GA14010@techadventures.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19-07-18 22:52:35, Oscar Salvador wrote:
> On Thu, Jul 19, 2018 at 05:15:55PM +0200, Michal Hocko wrote:
> > Your changelog doesn't really explain the motivation. Does the change
> > help performance? Is this a pure cleanup?
> 
> Hi Michal,
> 
> Sorry to not have explained this better from the very beginning.
> 
> It should help a bit in performance terms as we would be skipping those
> condition checks and assignations for zones that do not have any pages.
> It is not a huge win, but I think that skipping code we do not really need to run
> is worh to have.

It is always preferable to have numbers when you are claiming
performance benefits.

> 
> > The function is certainly not an example of beauty. It is more an
> > example of changes done on top of older ones without much thinking. But
> > I do not see your change would make it so much better. I would consider
> > it a much nicer cleanup if it was split into logical units each doing
> > one specific thing.
> 
> About the cleanup, I thought that moving that block of code to a separate function
> would make the code easier to follow.
> If you think that this is still not enough, I can try to split it and see the outcome.

Well, on the other hand, is the change really worth it? Moving code
around is not free either. Any git blame tracking to understand why the
code is done this way will be harder.

But just to make it clear, I do not want to discourage you from touching
this area. I just believe that if you really want to do that then the
result shouldn't just tweak one specific case and tweak it. It would be
much more appreciated if the new code had much better structure and less
hacks.
-- 
Michal Hocko
SUSE Labs
