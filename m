Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3EAC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326DC20863
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 326DC20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394547AbeKWX0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:26:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:37900 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388147AbeKWX0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:26:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B6362AD6B;
        Fri, 23 Nov 2018 12:42:29 +0000 (UTC)
Date:   Fri, 23 Nov 2018 13:42:28 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@d104.suse.de>
Cc:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.com>, linux-mm@kvack.org,
        rppt@linux.vnet.ibm.com, akpm@linux-foundation.org,
        arunks@codeaurora.org, bhe@redhat.com, dan.j.williams@intel.com,
        Pavel.Tatashin@microsoft.com, Jonathan.Cameron@huawei.com,
        jglisse@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] mm, memory_hotplug: allocate memmap from
 hotadded memory
Message-ID: <20181123124228.GI8625@dhcp22.suse.cz>
References: <20181116101222.16581-1-osalvador@suse.com>
 <2571308d-0460-e8b9-ad40-75d6b13b2d09@redhat.com>
 <20181123115519.2dnzscmmgv63fdub@d104.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123115519.2dnzscmmgv63fdub@d104.suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 23-11-18 12:55:41, Oscar Salvador wrote:
> On Thu, Nov 22, 2018 at 10:21:24AM +0100, David Hildenbrand wrote:
> > 1. How are we going to present such memory to the system statistics?
> > 
> > In my opinion, this vmemmap memory should
> > a) still account to total memory
> > b) show up as allocated
> > 
> > So just like before.
> 
> No, it does not show up under total memory and neither as allocated memory.
> This memory is not for use for anything but for creating the pagetables
> for the memmap array for the section/s.

I haven't read through your patches yet but wanted to clarfify few
points here.

This should essentially follow the bootmem allocated memory pattern. So
it is present and accounted to spanned pages but it is not managed.

> It is not memory that the system can use.

same as bootmem ;)
 
> I also guess that if there is a strong opinion on this, we could create
> a counter, something like NR_VMEMMAP_PAGES, and show it under /proc/meminfo.

Do we really have to? Isn't the number quite obvious from the size of
the hotpluged memory?

> 
> > 2. Is this optional, in other words, can a device driver decide to not
> > to it like that?
> 
> Right now, is a per arch setup.
> For example, x86_64/powerpc/arm64 will do it inconditionally.
> 
> If we want to restrict this a per device-driver thing, I guess that we could
> allow to pass a flag to add_memory()->add_memory_resource(), and there
> unset MHP_MEMMAP_FROM_RANGE in case that flag is enabled.

I believe we will need to make this opt-in. There are some usecases
which hotplug an expensive (per size) memory via hotplug and it would be
too wasteful to use it for struct pages. I haven't bothered to address
that with my previous patches because I just wanted to make the damn
thing work first.
-- 
Michal Hocko
SUSE Labs
