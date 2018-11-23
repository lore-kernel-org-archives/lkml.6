Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7955EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A0920861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:12:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49A0920861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504461AbeKWX4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:56:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:41492 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390867AbeKWX4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:56:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0F23DAF3F;
        Fri, 23 Nov 2018 13:12:40 +0000 (UTC)
Date:   Fri, 23 Nov 2018 14:12:37 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Oscar Salvador <osalvador@suse.com>, linux-mm@kvack.org,
        rppt@linux.vnet.ibm.com, akpm@linux-foundation.org,
        arunks@codeaurora.org, bhe@redhat.com, dan.j.williams@intel.com,
        Pavel.Tatashin@microsoft.com, Jonathan.Cameron@huawei.com,
        jglisse@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] mm, memory_hotplug: allocate memmap from
 hotadded memory
Message-ID: <20181123131237.GO8625@dhcp22.suse.cz>
References: <20181116101222.16581-1-osalvador@suse.com>
 <2571308d-0460-e8b9-ad40-75d6b13b2d09@redhat.com>
 <20181123115519.2dnzscmmgv63fdub@d104.suse.de>
 <20181123124228.GI8625@dhcp22.suse.cz>
 <4fd2e8fe-a85d-af96-ee04-8ddfd1fbe79d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fd2e8fe-a85d-af96-ee04-8ddfd1fbe79d@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 23-11-18 13:51:57, David Hildenbrand wrote:
> On 23.11.18 13:42, Michal Hocko wrote:
> > On Fri 23-11-18 12:55:41, Oscar Salvador wrote:
[...]
> >> It is not memory that the system can use.
> > 
> > same as bootmem ;)
> 
> Fair enough, just saying that it represents a change :)
> 
> (but people also already complained if their VM has XGB but they don't
> see actual XGB as total memory e.g. due to the crash kernel size)

I can imagine. I have seen many "where's my memory dude" questions... We
have so many unaccounted usages that it is simply impossible to see the
full picture of where the memory is consumed. The current implementation
would account memmaps in unreclaimable slabs but you still do not know
how much was spent for it...
 
> >> I also guess that if there is a strong opinion on this, we could create
> >> a counter, something like NR_VMEMMAP_PAGES, and show it under /proc/meminfo.
> > 
> > Do we really have to? Isn't the number quite obvious from the size of
> > the hotpluged memory?
> 
> At least the size of vmmaps cannot reliably calculated from "MemTotal" .
> But maybe based on something else. (there, it is indeed obvious)

Everybody knows the struct page size obviously :p and the rest is a
simple exercise. But more seriously, I see what you are saying. We do
not have a good counter now and the patch doesn't improve that. But I
guess this is a separate discussion.

-- 
Michal Hocko
SUSE Labs
