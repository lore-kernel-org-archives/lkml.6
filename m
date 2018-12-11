Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE97C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D192084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D192084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbeLKUrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 15:47:22 -0500
Received: from mga12.intel.com ([192.55.52.136]:36258 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbeLKUrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 15:47:22 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2018 12:47:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,343,1539673200"; 
   d="scan'208";a="97976642"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga007.jf.intel.com with ESMTP; 11 Dec 2018 12:47:21 -0800
Date:   Tue, 11 Dec 2018 13:44:51 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv2 02/12] acpi/hmat: Parse and report heterogeneous memory
Message-ID: <20181211204451.GD8101@localhost.localdomain>
References: <20181211010310.8551-1-keith.busch@intel.com>
 <20181211010310.8551-3-keith.busch@intel.com>
 <CAPcyv4gEpxigPqc0PgDE0YCL3Ot+wPfvChAZqUTtdYR2WDxaJg@mail.gmail.com>
 <20181211165518.GB8101@localhost.localdomain>
 <CAPcyv4id0mgjdBPPw8Y26rodOEQ=EHfaTrgasU5g4X7u=dS2xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4id0mgjdBPPw8Y26rodOEQ=EHfaTrgasU5g4X7u=dS2xw@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 12:29:45PM -0800, Dan Williams wrote:
> On Tue, Dec 11, 2018 at 8:58 AM Keith Busch <keith.busch@intel.com> wrote:
> > +static int __init
> > +acpi_parse_cache(union acpi_subtable_headers *header, const unsigned long end)
> > +{
> > +       struct acpi_hmat_cache *cache = (void *)header;
> > +       u32 attrs;
> > +
> > +       attrs = cache->cache_attributes;
> > +       if (((attrs & ACPI_HMAT_CACHE_ASSOCIATIVITY) >> 8) ==
> > +                                               ACPI_HMAT_CA_DIRECT_MAPPED)
> > +               set_bit(cache->memory_PD, node_side_cached);
> 
> I'm not sure I see a use case for 'node_side_cached'. Instead I need
> to know if a cache intercepts a "System RAM" resource, because a cache
> in front of a reserved address range would not be impacted by page
> allocator randomization. Or, are you saying have memblock generically
> describes this capability and move the responsibility of acting on
> that data to a higher level?

The "node_side_cached" array isn't intended to be used directly. It's
just holding the PXM's that HMAT says have a side cache so we know which
PXM's have that attribute before parsing SRAT's memory affinity.

The intention was that this is just another attribute of a memory range
similiar to hotpluggable. Whoever needs to use it may query it from
the memblock, if that makes sense.

> The other detail to consider is the cache ratio size, but that would
> be a follow on feature. The use case is to automatically determine the
> ratio to pass to numa_emulation:
> 
>     cc9aec03e58f x86/numa_emulation: Introduce uniform split capability

Will look into that.
 
> > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> > index aee299a6aa76..a24c918a4496 100644
> > --- a/include/linux/memblock.h
> > +++ b/include/linux/memblock.h
> > @@ -44,6 +44,7 @@ enum memblock_flags {
> >         MEMBLOCK_HOTPLUG        = 0x1,  /* hotpluggable region */
> >         MEMBLOCK_MIRROR         = 0x2,  /* mirrored region */
> >         MEMBLOCK_NOMAP          = 0x4,  /* don't add to kernel direct mapping */
> > +       MEMBLOCK_SIDECACHED     = 0x8,  /* System side caches memory access */
> 
> I'm concerned that we may be stretching memblock past its intended use
> case especially for just this randomization case. For example, I think
> memblock_find_in_range() gets confused in the presence of
> MEMBLOCK_SIDECACHED memblocks.

Ok, I see. Is there a better structure or interface that you may recommend
for your use case to identify which memory ranges contain this attribute?
