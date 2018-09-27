Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FFDC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4741321580
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4741321580
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbeI0VJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:09:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51711 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbeI0VJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:09:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id y25-v6so6208638wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 07:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rY+qrcEtEnxngSBZOuhD9J/F/B10fBI5n6K1z1dPuKY=;
        b=Bbo4UOxC02QETgRK0VGAnaI9GrQBkkiHNCm7kbZnANbD8V6DJtXhPJUBVWtBixF+Qc
         Ju6+8oSh+qDhybx88c3COuYAs49N6NhJ6yVYNdn0mlAfkMskpWamz7Y0oWQfb3ZR2E3v
         Nl5Ocr3aLJR9LNOSVOr9hcCi5ibQhbWTpI6Hsbu0zZ+THJDO9W2coxVoseflDPGqNvDD
         0PvrR3v0c6Ssn+RsAxdMF3UA/cJFiM8P688x4mXMNiDJP4GTOEhweLMo/B8sEEjHBfO+
         dWoQY86Vz0EU1oAHd7+J51NOzNlr2dtlrb0EWZ1MM/3BiilK5lr9mQqoVZLQhc+BVbnj
         Iq1Q==
X-Gm-Message-State: ABuFfohNm11fc8MmTAAuo0xTvpAWGn6cCF3jvd6uEUJ01a+QIzCfGIuS
        ZgpNyYc18bny1wvWyQ6nu/Y=
X-Google-Smtp-Source: ACcGV61Vg2tO1IRZ7jaCJcVzK8YeVuRvYeOCjwm7NZMmt+5+N1tcqlJvWuAAU3Cq9dhkdL87IQ202A==
X-Received: by 2002:a1c:2dc5:: with SMTP id t188-v6mr3248277wmt.94.1538059837188;
        Thu, 27 Sep 2018 07:50:37 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id n4-v6sm2485787wrr.21.2018.09.27.07.50.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 07:50:36 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id C09BB125626; Thu, 27 Sep 2018 16:50:35 +0200 (CEST)
Date:   Thu, 27 Sep 2018 16:50:35 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        pavel.tatashin@microsoft.com, dave.jiang@intel.com,
        dave.hansen@intel.com, jglisse@redhat.com, rppt@linux.vnet.ibm.com,
        dan.j.williams@intel.com, logang@deltatee.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com, david@redhat.com
Subject: Re: [PATCH v5 4/4] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
Message-ID: <20180927145035.GA21373@techadventures.net>
References: <20180925200551.3576.18755.stgit@localhost.localdomain>
 <20180925202053.3576.66039.stgit@localhost.localdomain>
 <20180926075540.GD6278@dhcp22.suse.cz>
 <6f87a5d7-05e2-00f4-8568-bb3521869cea@linux.intel.com>
 <20180927110926.GE6278@dhcp22.suse.cz>
 <20180927122537.GA20378@techadventures.net>
 <20180927131329.GI6278@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927131329.GI6278@dhcp22.suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 03:13:29PM +0200, Michal Hocko wrote:
> On Thu 27-09-18 14:25:37, Oscar Salvador wrote:
> > On Thu, Sep 27, 2018 at 01:09:26PM +0200, Michal Hocko wrote:
> > > > So there were a few things I wasn't sure we could pull outside of the
> > > > hotplug lock. One specific example is the bits related to resizing the pgdat
> > > > and zone. I wanted to avoid pulling those bits outside of the hotplug lock.
> > > 
> > > Why would that be a problem. There are dedicated locks for resizing.
> > 
> > True is that move_pfn_range_to_zone() manages the locks for pgdat/zone resizing,
> > but it also takes care of calling init_currently_empty_zone() in case the zone is empty.
> > Could not that be a problem if we take move_pfn_range_to_zone() out of the lock?
> 
> I would have to double check but is the hotplug lock really serializing
> access to the state initialized by init_currently_empty_zone? E.g.
> zone_start_pfn is a nice example of a state that is used outside of the
> lock. zone's free lists are similar. So do we really need the hoptlug
> lock? And more broadly, what does the hotplug lock is supposed to
> serialize in general. A proper documentation would surely help to answer
> these questions. There is way too much of "do not touch this code and
> just make my particular hack" mindset which made the whole memory
> hotplug a giant pile of mess. We really should start with some proper
> engineering here finally.

CC David

David has been looking into this lately, he even has updated memory-hotplug.txt
with some more documentation about the locking aspect [1].
And with this change [2], the hotplug lock has been moved
to the online/offline_pages.

From what I see (I might be wrong), the hotplug lock is there
to serialize the online/offline operations.

In online_pages, we do (among other things):

a) initialize the zone and its pages, and link them to the zone
b) re-adjust zone/pgdat nr of pages (present, spanned, managed)
b) check if the node changes in regard of N_MEMORY, N_HIGH_MEMORY or N_NORMAL_MEMORY.
c) fire notifiers
d) rebuild the zonelists in case we got a new zone
e) online memory sections and free the pages to the buddy allocator
f) wake up kswapd/kcompactd in case we got a new node

while in offline_pages we do the opposite.

Hotplug lock here serializes the operations as a whole, online and offline memory,
so they do not step on each other's feet.

Having said that, we might be able to move some of those operations out of the hotplug lock.
The device_hotplug_lock coming from every memblock (which is taken in device_online/device_offline) should protect
us against some operations being made on the same memblock (e.g: touching the same pages).

For the given case about move_pfn_range_to_zone() I have my doubts.
The resizing of the pgdat/zone is already serialized, so no discussion there.

Then we have memmap_init_zone. I __think__ that that should not worry us because those pages
belong to a memblock, and device_online/device_offline is serialized.
HMM/devm is different here as they do not handle memblocks.

And then we have init_currently_empty_zone.
Assuming that the shrinking of pages/removal of the zone is finally brought to
the offline stage (where it should be), I am not sure if we can somehow
race with an offline operation there if we do not hold the hotplug lock.

[1] https://patchwork.kernel.org/patch/10617715/
[2] https://patchwork.kernel.org/patch/10617705/
-- 
Oscar Salvador
SUSE L3
