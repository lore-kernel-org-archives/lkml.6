Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4C8C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B26120857
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548753149;
	bh=OPx29B2rl1Fq6RjDTAT/pxB2y+WOilUWwMOF0BDkxw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ArhOXQOkG0iMC6iS0lrUkPv4FBscU1DQr8rTUIEaaDUERr9QM33z7piMBMN6vQeFJ
	 093qJ8j5UIJ2HWzjdUO4olkVSZgcaxKt1BIIwLSTz21nlK4+IsypwS66RHWobTV2xe
	 YpSbtHy6apUSLIw1STM93TKlpu4kibtVYyt/eUPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfA2JM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:12:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:55084 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725298AbfA2JM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:12:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A5D9BAE89;
        Tue, 29 Jan 2019 09:12:25 +0000 (UTC)
Date:   Tue, 29 Jan 2019 10:12:24 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        gerald.schaefer@de.ibm.com, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm, memory_hotplug: is_mem_section_removable do not
 pass the end of a zone
Message-ID: <20190129091224.GG18811@dhcp22.suse.cz>
References: <20190128144506.15603-1-mhocko@kernel.org>
 <20190128144506.15603-2-mhocko@kernel.org>
 <20190129090605.lenisalq2zxtck3u@d104.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129090605.lenisalq2zxtck3u@d104.suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 29-01-19 10:06:05, Oscar Salvador wrote:
> On Mon, Jan 28, 2019 at 03:45:05PM +0100, Michal Hocko wrote:
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > Mikhail has reported the following VM_BUG_ON triggered when reading
> > sysfs removable state of a memory block:
> >  page:000003d082008000 is uninitialized and poisoned
> >  page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
> >  Call Trace:
> >  ([<0000000000385b26>] test_pages_in_a_zone+0xde/0x160)
> >   [<00000000008f15c4>] show_valid_zones+0x5c/0x190
> >   [<00000000008cf9c4>] dev_attr_show+0x34/0x70
> >   [<0000000000463ad0>] sysfs_kf_seq_show+0xc8/0x148
> >   [<00000000003e4194>] seq_read+0x204/0x480
> >   [<00000000003b53ea>] __vfs_read+0x32/0x178
> >   [<00000000003b55b2>] vfs_read+0x82/0x138
> >   [<00000000003b5be2>] ksys_read+0x5a/0xb0
> >   [<0000000000b86ba0>] system_call+0xdc/0x2d8
> >  Last Breaking-Event-Address:
> >   [<0000000000385b26>] test_pages_in_a_zone+0xde/0x160
> >  Kernel panic - not syncing: Fatal exception: panic_on_oops
> > 
> > The reason is that the memory block spans the zone boundary and we are
> > stumbling over an unitialized struct page. Fix this by enforcing zone
> > range in is_mem_section_removable so that we never run away from a
> > zone.
> 
> Does that mean that the remaining pages(escaping from the current zone) are not tied to
> any other zone? Why? Are these pages "holes" or how that came to be?

Yes, those pages should be unreachable because they are out of the zone.
Reasons might be various. The memory range is not mem section aligned,
or cut due to mem parameter etc.

-- 
Michal Hocko
SUSE Labs
