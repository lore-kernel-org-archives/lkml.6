Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20586C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E6A214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E6A214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbeIZN2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 09:28:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:48354 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727335AbeIZN2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 09:28:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 033FAB019;
        Wed, 26 Sep 2018 07:17:11 +0000 (UTC)
Date:   Wed, 26 Sep 2018 09:17:08 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: Re: [patch v3] mm, thp: always specify disabled vmas as nh in smaps
Message-ID: <20180926071708.GB6278@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1809241054050.224429@chino.kir.corp.google.com>
 <e2f159f3-5373-dda4-5904-ed24d029de3c@suse.cz>
 <alpine.DEB.2.21.1809241215170.239142@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1809241227370.241621@chino.kir.corp.google.com>
 <20180924195603.GJ18685@dhcp22.suse.cz>
 <20180924200258.GK18685@dhcp22.suse.cz>
 <0aa3eb55-82c0-eba3-b12c-2ba22e052a8e@suse.cz>
 <alpine.DEB.2.21.1809251248450.50347@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1809251449060.96762@chino.kir.corp.google.com>
 <20180926061247.GB18685@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926061247.GB18685@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 26-09-18 08:12:47, Michal Hocko wrote:
> On Tue 25-09-18 14:50:52, David Rientjes wrote:
> [...]
> Let's put my general disagreement with the approach asside for a while.
> If this is really the best way forward the is the implementation really
> correct?
> 
> > +	/*
> > +	 * Disabling thp is possible through both MADV_NOHUGEPAGE and
> > +	 * PR_SET_THP_DISABLE.  Both historically used VM_NOHUGEPAGE.  Since
> > +	 * the introduction of MMF_DISABLE_THP, however, userspace needs the
> > +	 * ability to detect vmas where thp is not eligible in the same manner.
> > +	 */
> > +	if (vma->vm_mm && test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags)) {
> > +		flags &= ~VM_HUGEPAGE;
> > +		flags |= VM_NOHUGEPAGE;
> > +	}
> 
> Do we want to report all vmas nh? Shouldn't we limit that to THP-able
> mappings? It seems quite strange that an application started without
> PR_SET_THP_DISABLE wouldn't report nh for most mappings while it would
> otherwise. Also when can we have vma->vm_mm == NULL?

Hmm, after re-reading your documentation update to "A process mapping
may be advised to not be backed by transparent hugepages by either
madvise(MADV_NOHUGEPAGE) or prctl(PR_SET_THP_DISABLE)." the
implementation matches so scratch my comment.

As I've said, I am not happy about this approach but if there is a
general agreement this is really the best we can do I will not stand in
the way.
-- 
Michal Hocko
SUSE Labs
