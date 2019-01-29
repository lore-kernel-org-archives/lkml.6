Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B6DC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 875B620880
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548793486;
	bh=+ciIrXZeW1+Y/CSQkTTPO9u050N6ssuVfUcyMfLjOZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k5twztJ55b11FCdBVNaNz/rqnF+9yZf425t5VUnvVcABRgVPq3YyaWb5rxe2Twk6I
	 UTeq1Keb7rkwLJ6jA8OxRgcay3q2g459u7hIOm8kmx2mkR8hgVekopASvsamqPXXdN
	 ho9xv0zD+7VPvHnbpOSOsykOPIrAaMaZBYjoCDGs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbfA2UYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:24:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:42280 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727473AbfA2UYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 15:24:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 60854AA71;
        Tue, 29 Jan 2019 20:24:42 +0000 (UTC)
Date:   Tue, 29 Jan 2019 21:24:40 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] mm, memory_hotplug: fix uninitialized pages fallouts.
Message-ID: <20190129202440.GP18811@dhcp22.suse.cz>
References: <20190128144506.15603-1-mhocko@kernel.org>
 <20190129141447.34aa9d0c@thinkpad>
 <20190129134920.GM18811@dhcp22.suse.cz>
 <CABXGCsPM-JrdxN9t-HjkWxJJzdGHiJZOYD5p-CsjGEFSQ=+DwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXGCsPM-JrdxN9t-HjkWxJJzdGHiJZOYD5p-CsjGEFSQ=+DwQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 29-01-19 22:38:19, Mikhail Gavrilov wrote:
> On Tue, 29 Jan 2019 at 18:49, Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Tue 29-01-19 14:14:47, Gerald Schaefer wrote:
> > > On Mon, 28 Jan 2019 15:45:04 +0100
> > > Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > > Hi,
> > > > Mikhail has posted fixes for the two bugs quite some time ago [1]. I
> > > > have pushed back on those fixes because I believed that it is much
> > > > better to plug the problem at the initialization time rather than play
> > > > whack-a-mole all over the hotplug code and find all the places which
> > > > expect the full memory section to be initialized. We have ended up with
> > > > 2830bf6f05fb ("mm, memory_hotplug: initialize struct pages for the full
> > > > memory section") merged and cause a regression [2][3]. The reason is
> > > > that there might be memory layouts when two NUMA nodes share the same
> > > > memory section so the merged fix is simply incorrect.
> > > >
> > > > In order to plug this hole we really have to be zone range aware in
> > > > those handlers. I have split up the original patch into two. One is
> > > > unchanged (patch 2) and I took a different approach for `removable'
> > > > crash. It would be great if Mikhail could test it still works for his
> > > > memory layout.
> > > >
> > > > [1] http://lkml.kernel.org/r/20181105150401.97287-2-zaslonko@linux.ibm.com
> > > > [2] https://bugzilla.redhat.com/show_bug.cgi?id=1666948
> > > > [3] http://lkml.kernel.org/r/20190125163938.GA20411@dhcp22.suse.cz
> > >
> > > I verified that both patches fix the issues we had with valid_zones
> > > (with mem=2050M) and removable (with mem=3075M).
> > >
> > > However, the call trace in the description of your patch 1 is wrong.
> > > You basically have the same call trace for test_pages_in_a_zone in
> > > both patches. The "removable" patch should have the call trace for
> > > is_mem_section_removable from Mikhails original patches:
> >
> > Thanks for testing. Can I use you Tested-by?
> >
> > >  CONFIG_DEBUG_VM_PGFLAGS=y
> > >  kernel parameter mem=3075M
> > >  --------------------------
> > >  page:000003d08300c000 is uninitialized and poisoned
> > >  page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
> > >  Call Trace:
> > >  ([<000000000038596c>] is_mem_section_removable+0xb4/0x190)
> > >   [<00000000008f12fa>] show_mem_removable+0x9a/0xd8
> > >   [<00000000008cf9c4>] dev_attr_show+0x34/0x70
> > >   [<0000000000463ad0>] sysfs_kf_seq_show+0xc8/0x148
> > >   [<00000000003e4194>] seq_read+0x204/0x480
> > >   [<00000000003b53ea>] __vfs_read+0x32/0x178
> > >   [<00000000003b55b2>] vfs_read+0x82/0x138
> > >   [<00000000003b5be2>] ksys_read+0x5a/0xb0
> > >   [<0000000000b86ba0>] system_call+0xdc/0x2d8
> > >  Last Breaking-Event-Address:
> > >   [<000000000038596c>] is_mem_section_removable+0xb4/0x190
> > >  Kernel panic - not syncing: Fatal exception: panic_on_oops
> >
> > Yeah, this is c&p mistake on my end. I will use this trace instead.
> > Thanks for spotting.
> 
> 
> Michal, I am late?

I do not think so. I plan to repost tomorrow with the updated changelog
and gathered review and tested-by tags. Can I assume yours as well?

> I am also tested these patches and can confirm that issue fixed again
> with new approach.
> I also attach two dmesg first when issue was reproduced and second
> with applied patch (problem not reproduced).

Thanks!
-- 
Michal Hocko
SUSE Labs
