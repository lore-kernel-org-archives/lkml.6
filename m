Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E57C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA68D2156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA68D2156D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbeI0Tbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 15:31:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:56010 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727326AbeI0Tbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 15:31:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1C472AD8D;
        Thu, 27 Sep 2018 13:13:32 +0000 (UTC)
Date:   Thu, 27 Sep 2018 15:13:29 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@techadventures.net>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        pavel.tatashin@microsoft.com, dave.jiang@intel.com,
        dave.hansen@intel.com, jglisse@redhat.com, rppt@linux.vnet.ibm.com,
        dan.j.williams@intel.com, logang@deltatee.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v5 4/4] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
Message-ID: <20180927131329.GI6278@dhcp22.suse.cz>
References: <20180925200551.3576.18755.stgit@localhost.localdomain>
 <20180925202053.3576.66039.stgit@localhost.localdomain>
 <20180926075540.GD6278@dhcp22.suse.cz>
 <6f87a5d7-05e2-00f4-8568-bb3521869cea@linux.intel.com>
 <20180927110926.GE6278@dhcp22.suse.cz>
 <20180927122537.GA20378@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927122537.GA20378@techadventures.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 27-09-18 14:25:37, Oscar Salvador wrote:
> On Thu, Sep 27, 2018 at 01:09:26PM +0200, Michal Hocko wrote:
> > > So there were a few things I wasn't sure we could pull outside of the
> > > hotplug lock. One specific example is the bits related to resizing the pgdat
> > > and zone. I wanted to avoid pulling those bits outside of the hotplug lock.
> > 
> > Why would that be a problem. There are dedicated locks for resizing.
> 
> True is that move_pfn_range_to_zone() manages the locks for pgdat/zone resizing,
> but it also takes care of calling init_currently_empty_zone() in case the zone is empty.
> Could not that be a problem if we take move_pfn_range_to_zone() out of the lock?

I would have to double check but is the hotplug lock really serializing
access to the state initialized by init_currently_empty_zone? E.g.
zone_start_pfn is a nice example of a state that is used outside of the
lock. zone's free lists are similar. So do we really need the hoptlug
lock? And more broadly, what does the hotplug lock is supposed to
serialize in general. A proper documentation would surely help to answer
these questions. There is way too much of "do not touch this code and
just make my particular hack" mindset which made the whole memory
hotplug a giant pile of mess. We really should start with some proper
engineering here finally.
-- 
Michal Hocko
SUSE Labs
