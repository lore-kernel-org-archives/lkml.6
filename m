Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B0CC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1AA2151D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1AA2151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbeIZVw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:52:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:49200 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726937AbeIZVw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:52:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F3953ACEF;
        Wed, 26 Sep 2018 15:39:23 +0000 (UTC)
Date:   Wed, 26 Sep 2018 17:39:21 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        pavel.tatashin@microsoft.com, dave.jiang@intel.com,
        dave.hansen@intel.com, jglisse@redhat.com, rppt@linux.vnet.ibm.com,
        dan.j.williams@intel.com, logang@deltatee.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v5 2/4] mm: Provide kernel parameter to allow disabling
 page init poisoning
Message-ID: <20180926153921.GC6278@dhcp22.suse.cz>
References: <20180925200551.3576.18755.stgit@localhost.localdomain>
 <20180925201921.3576.84239.stgit@localhost.localdomain>
 <20180926073831.GC6278@dhcp22.suse.cz>
 <c57da51a-009a-9500-4dc5-1d9912e78abd@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c57da51a-009a-9500-4dc5-1d9912e78abd@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 26-09-18 08:24:56, Alexander Duyck wrote:
> On 9/26/2018 12:38 AM, Michal Hocko wrote:
> > On Tue 25-09-18 13:20:12, Alexander Duyck wrote:
> > [...]
> > > +	vm_debug[=options]	[KNL] Available with CONFIG_DEBUG_VM=y.
> > > +			May slow down system boot speed, especially when
> > > +			enabled on systems with a large amount of memory.
> > > +			All options are enabled by default, and this
> > > +			interface is meant to allow for selectively
> > > +			enabling or disabling specific virtual memory
> > > +			debugging features.
> > > +
> > > +			Available options are:
> > > +			  P	Enable page structure init time poisoning
> > > +			  -	Disable all of the above options
> > 
> > I agree with Dave that this is confusing as hell. So what does vm_debug
> > (without any options means). I assume it's NOP and all debugging is
> > enabled and that is the default. What if I want to disable _only_ the
> > page struct poisoning. The weird lookcing `-' will disable all other
> > options that we might gather in the future.
> 
> With no options it works just like slub_debug and enables all available
> options. So in our case it is a NOP since we wanted the debugging enabled by
> default.

But isn't slub_debug more about _adding_ debugging features? While you
want to effectively disbale some debugging features here? So if you want
to follow that pattern then it would be something like
vm_debug_disable=page_poisoning,$OTHER_FUTURE_DEBUG_OPTIONS

why would you want to enable something when CONFIG_DEBUG_VM=y just
enables everything?

> > Why cannot you simply go with [no]vm_page_poison[=on/off]?
> 
> That is what I had to begin with, but Dave Hansen and Dan Williams suggested
> that I go with a slub_debug style interface so we could extend it in the
> future.

Please let's not over-engineer this. If you really need an umbrella
parameter then make a list of things to disable.
-- 
Michal Hocko
SUSE Labs
