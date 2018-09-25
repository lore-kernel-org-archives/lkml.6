Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29D9C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D57E20896
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D57E20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbeIZCjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:39:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:54992 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726026AbeIZCjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:39:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DD959ACA7;
        Tue, 25 Sep 2018 20:30:01 +0000 (UTC)
Date:   Tue, 25 Sep 2018 22:29:59 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: Re: [patch v2] mm, thp: always specify ineligible vmas as nh in smaps
Message-ID: <20180925202959.GY18685@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1809241054050.224429@chino.kir.corp.google.com>
 <e2f159f3-5373-dda4-5904-ed24d029de3c@suse.cz>
 <alpine.DEB.2.21.1809241215170.239142@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1809241227370.241621@chino.kir.corp.google.com>
 <20180924195603.GJ18685@dhcp22.suse.cz>
 <20180924200258.GK18685@dhcp22.suse.cz>
 <0aa3eb55-82c0-eba3-b12c-2ba22e052a8e@suse.cz>
 <alpine.DEB.2.21.1809251248450.50347@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809251248450.50347@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 25-09-18 12:52:09, David Rientjes wrote:
> On Mon, 24 Sep 2018, Vlastimil Babka wrote:
> 
> > On 9/24/18 10:02 PM, Michal Hocko wrote:
> > > On Mon 24-09-18 21:56:03, Michal Hocko wrote:
> > >> On Mon 24-09-18 12:30:07, David Rientjes wrote:
> > >>> Commit 1860033237d4 ("mm: make PR_SET_THP_DISABLE immediately active")
> > >>> introduced a regression in that userspace cannot always determine the set
> > >>> of vmas where thp is ineligible.
> > >>>
> > >>> Userspace relies on the "nh" flag being emitted as part of /proc/pid/smaps
> > >>> to determine if a vma is eligible to be backed by hugepages.
> > >>
> > >> I was under impression that nh resp hg flags only tell about the madvise
> > >> status. How do you exactly use these flags in an application?
> > >>
> 
> This is used to identify heap mappings that should be able to fault thp 
> but do not, and they normally point to a low-on-memory or fragmentation 
> issue.  After commit 1860033237d4, our users of PR_SET_THP_DISABLE no 
> longer show "nh" for their heap mappings so they get reported as having a 
> low thp ratio when in reality it is disabled.  

I am still not sure I understand the issue completely. How are PR_SET_THP_DISABLE
users any different from the global THP disabled case? Is this only
about the scope? E.g the one who checks for the state cannot check the
PR_SET_THP_DISABLE state? Besides that what are consequences of the
low ratio? Is this an example of somebody using the prctl and still
complaining or an external observer trying to do something useful which
ends up doing contrary?

> It is also used in 
> automated testing to ensure that vmas get disabled for thp appropriately 
> and we used "nh" since that is how PR_SET_THP_DISABLE previously enforced 
> this, and those tests now break.

This sounds like a bit of an abuse to me. It shows how an internal
implementation detail leaks out to the userspace which is something we
should try to avoid.

> > >> Your eligible rules as defined here:
> > >>
> > >>> + [*] A process mapping is eligible to be backed by transparent hugepages (thp)
> > >>> +     depending on system-wide settings and the mapping itself.  See
> > >>> +     Documentation/admin-guide/mm/transhuge.rst for default behavior.  If a
> > >>> +     mapping has a flag of "nh", it is not eligible to be backed by hugepages
> > >>> +     in any condition, either because of prctl(PR_SET_THP_DISABLE) or
> > >>> +     madvise(MADV_NOHUGEPAGE).  PR_SET_THP_DISABLE takes precedence over any
> > >>> +     MADV_HUGEPAGE.
> > >>
> > >> doesn't seem to match the reality. I do not see all the file backed
> > >> mappings to be nh marked. So is this really about eligibility rather
> > >> than the madvise status? Maybe it is just the above documentation that
> > >> needs to be updated.
> > 
> > Yeah the change from madvise to eligibility in the doc seems to go too far.
> > 
> 
> I'll reword this to explicitly state that "hg" and "nh" mappings either 
> allow or disallow thp backing.

How are you going to distinguish a regular THP-able mapping then? I am
still not sure how this is supposed to work. Could you be more specific.
Let's say I have a THP-able mapping (shmem resp. anon for the current
implementation). What is the the matrix for hg/nh wrt. madvice/nomadvise
PR_SET_THP_DISABLE and global THP enabled/disable.

-- 
Michal Hocko
SUSE Labs
