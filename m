Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EC7ECE568
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FDFF20C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:03:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FDFF20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbeIYCGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 22:06:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:58456 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725824AbeIYCGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 22:06:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1BE3CAF71;
        Mon, 24 Sep 2018 20:02:59 +0000 (UTC)
Date:   Mon, 24 Sep 2018 22:02:58 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: Re: [patch v2] mm, thp: always specify ineligible vmas as nh in smaps
Message-ID: <20180924200258.GK18685@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1809241054050.224429@chino.kir.corp.google.com>
 <e2f159f3-5373-dda4-5904-ed24d029de3c@suse.cz>
 <alpine.DEB.2.21.1809241215170.239142@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1809241227370.241621@chino.kir.corp.google.com>
 <20180924195603.GJ18685@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924195603.GJ18685@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 24-09-18 21:56:03, Michal Hocko wrote:
> On Mon 24-09-18 12:30:07, David Rientjes wrote:
> > Commit 1860033237d4 ("mm: make PR_SET_THP_DISABLE immediately active")
> > introduced a regression in that userspace cannot always determine the set
> > of vmas where thp is ineligible.
> > 
> > Userspace relies on the "nh" flag being emitted as part of /proc/pid/smaps
> > to determine if a vma is eligible to be backed by hugepages.
> 
> I was under impression that nh resp hg flags only tell about the madvise
> status. How do you exactly use these flags in an application?
> 
> Your eligible rules as defined here:
> 
> > + [*] A process mapping is eligible to be backed by transparent hugepages (thp)
> > +     depending on system-wide settings and the mapping itself.  See
> > +     Documentation/admin-guide/mm/transhuge.rst for default behavior.  If a
> > +     mapping has a flag of "nh", it is not eligible to be backed by hugepages
> > +     in any condition, either because of prctl(PR_SET_THP_DISABLE) or
> > +     madvise(MADV_NOHUGEPAGE).  PR_SET_THP_DISABLE takes precedence over any
> > +     MADV_HUGEPAGE.
> 
> doesn't seem to match the reality. I do not see all the file backed
> mappings to be nh marked. So is this really about eligibility rather
> than the madvise status? Maybe it is just the above documentation that
> needs to be updated.
> 
> That being said, I do not object to the patch, I am just trying to
> understand what is the intended usage for the flag that does try to say
> more than the madvise status.

And moreover, how is the PR_SET_THP_DISABLE any different from the
global THP disabled case. Do we want to set all vmas to nh as well?
-- 
Michal Hocko
SUSE Labs
