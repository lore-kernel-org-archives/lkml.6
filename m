Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7CCC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C38720880
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C38720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbeIJTgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:36:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:33232 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728110AbeIJTgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:36:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 61346AEF3;
        Mon, 10 Sep 2018 14:41:52 +0000 (UTC)
Date:   Mon, 10 Sep 2018 16:41:52 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pasha Tatashin <Pavel.Tatashin@microsoft.com>
Cc:     "zaslonko@linux.ibm.com" <zaslonko@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "gerald.schaefer@de.ibm.com" <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH] memory_hotplug: fix the panic when memory end is not on
 the section boundary
Message-ID: <20180910144152.GL10951@dhcp22.suse.cz>
References: <20180910123527.71209-1-zaslonko@linux.ibm.com>
 <20180910131754.GG10951@dhcp22.suse.cz>
 <e8d75768-9122-332b-3b16-cad032aeb27f@microsoft.com>
 <20180910135959.GI10951@dhcp22.suse.cz>
 <CAGM2reZuGAPmfO8x0TnHnqHci_Hsga3-CfM9+udJs=gUQCw-1g@mail.gmail.com>
 <20180910141946.GJ10951@dhcp22.suse.cz>
 <CAGM2reZ5OD9SRW8j9iaQAk9jpr86pF2NqpBjv-dxH+1vJZs0=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGM2reZ5OD9SRW8j9iaQAk9jpr86pF2NqpBjv-dxH+1vJZs0=g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 10-09-18 14:32:16, Pavel Tatashin wrote:
> On Mon, Sep 10, 2018 at 10:19 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Mon 10-09-18 14:11:45, Pavel Tatashin wrote:
> > > Hi Michal,
> > >
> > > It is tricky, but probably can be done. Either change
> > > memmap_init_zone() or its caller to also cover the ends and starts of
> > > unaligned sections to initialize and reserve pages.
> > >
> > > The same thing would also need to be done in deferred_init_memmap() to
> > > cover the deferred init case.
> >
> > Well, I am not sure TBH. I have to think about that much more. Maybe it
> > would be much more simple to make sure that we will never add incomplete
> > memblocks and simply refuse them during the discovery. At least for now.
> 
> On x86 memblocks can be upto 2G on machines with over 64G of RAM.

sorry I meant pageblock_nr_pages rather than memblocks.

> Also, memory size is way to easy too change via qemu arguments when VM
> starts. If we simply disable unaligned trailing memblocks, I am sure
> we would get tons of noise of missing memory.
> 
> I think, adding check_hotplug_memory_range() would work to fix the
> immediate problem. But, we do need to figure out  a better solution.
> 
> memblock design is based on archaic assumption that hotplug units are
> physical dimms. VMs and hypervisors changed all of that, and we can
> have much finer hotplug requests on machines with huge DIMMs. Yet, we
> do not want to pollute sysfs with millions of tiny memory devices. I
> am not sure what a long term proper solution for this problem should
> be, but I see that linux hotplug/hotremove subsystems must be
> redesigned based on the new requirements.

Not an easy task though. Anyway, sparse memory modely is highly based on
memory sections so it makes some sense to have hotplug section based as
well. Memblocks as a higher logical unit on top of that is kinda hack.
The userspace API has never been properly thought through I am afraid.
-- 
Michal Hocko
SUSE Labs
