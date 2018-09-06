Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F40C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F14A2083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F14A2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbeIFVkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:40:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:52378 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727847AbeIFVkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:40:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AAB22AEF2;
        Thu,  6 Sep 2018 17:03:36 +0000 (UTC)
Date:   Thu, 6 Sep 2018 19:03:34 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        pavel.tatashin@microsoft.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2 1/2] mm: Move page struct poisoning to
 CONFIG_DEBUG_VM_PAGE_INIT_POISON
Message-ID: <20180906170334.GE14951@dhcp22.suse.cz>
References: <20180905211041.3286.19083.stgit@localhost.localdomain>
 <20180905211328.3286.71674.stgit@localhost.localdomain>
 <20180906054735.GJ14951@dhcp22.suse.cz>
 <0c1c36f7-f45a-8fe9-dd52-0f60b42064a9@intel.com>
 <20180906151336.GD14951@dhcp22.suse.cz>
 <CAKgT0UfiKWZO6hyjc1RpRTgD+CvM=KnbYokSueLFi7X5h+GMKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UfiKWZO6hyjc1RpRTgD+CvM=KnbYokSueLFi7X5h+GMKQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06-09-18 08:41:52, Alexander Duyck wrote:
> On Thu, Sep 6, 2018 at 8:13 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Thu 06-09-18 07:59:03, Dave Hansen wrote:
> > > On 09/05/2018 10:47 PM, Michal Hocko wrote:
> > > > why do you have to keep DEBUG_VM enabled for workloads where the boot
> > > > time matters so much that few seconds matter?
> > >
> > > There are a number of distributions that run with it enabled in the
> > > default build.  Fedora, for one.  We've basically assumed for a while
> > > that we have to live with it in production environments.
> > >
> > > So, where does leave us?  I think we either need a _generic_ debug
> > > option like:
> > >
> > >       CONFIG_DEBUG_VM_SLOW_AS_HECK
> > >
> > > under which we can put this an other really slow VM debugging.  Or, we
> > > need some kind of boot-time parameter to trigger the extra checking
> > > instead of a new CONFIG option.
> >
> > I strongly suspect nobody will ever enable such a scary looking config
> > TBH. Besides I am not sure what should go under that config option.
> > Something that takes few cycles but it is called often or one time stuff
> > that takes quite a long but less than aggregated overhead of the former?
> >
> > Just consider this particular case. It basically re-adds an overhead
> > that has always been there before the struct page init optimization
> > went it. The poisoning just returns it in a different form to catch
> > potential left overs. And we would like to have as many people willing
> > to running in debug mode to test for those paths because they are
> > basically impossible to review by the code inspection. More importantnly
> > the major overhead is boot time so my question still stands. Is this
> > worth a separate config option almost nobody is going to enable?
> >
> > Enabling DEBUG_VM by Fedora and others serves us a very good testing
> > coverage and I appreciate that because it has generated some useful bug
> > reports. Those people are paying quite a lot of overhead in runtime
> > which can aggregate over time is it so much to ask about one time boot
> > overhead?
> 
> The kind of boot time add-on I saw as a result of this was about 170
> seconds, or 2 minutes and 50 seconds on a 12TB system.

Just curious. How long does it take to get from power on to even reaach
boot loader on that machine... ;)

> I spent a
> couple minutes wondering if I had built a bad kernel or not as I was
> staring at a dead console the entire time after the grub prompt since
> I hit this so early in the boot. That is the reason why I am so eager
> to slice this off and make it something separate. I could easily see
> this as something that would get in the way of other debugging that is
> going on in a system.

But you would get the same overhead a kernel release ago when the
memmap init optimization was merged. So you are basically back to what
we used to have for years. Unless I misremember.

> If we don't want to do a config option, then what about adding a
> kernel parameter to put a limit on how much memory we will initialize
> like this before we just start skipping it. We could put a default
> limit on it like 256GB and then once we cross that threshold we just
> don't bother poisoning any more memory. With that we would probably be
> able to at least cover most of the early memory init, and that value
> should cover most systems without getting into delays on the order of
> minutes.

No, this will defeat the purpose of the check.
-- 
Michal Hocko
SUSE Labs
