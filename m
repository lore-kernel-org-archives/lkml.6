Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D72C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 02:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1003720644
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 02:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1003720644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbeJKJZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 05:25:33 -0400
Received: from mga11.intel.com ([192.55.52.93]:48933 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbeJKJZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 05:25:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2018 19:00:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,366,1534834800"; 
   d="scan'208";a="264686554"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 10 Oct 2018 19:00:36 -0700
Received: from tiger-server (unknown [10.239.48.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 97BC258015C;
        Wed, 10 Oct 2018 19:00:33 -0700 (PDT)
Date:   Thu, 11 Oct 2018 16:39:54 +0800
From:   Yi Zhang <yi.z.zhang@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        alexander.h.duyck@linux.intel.com, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Pasha Tatashin <pavel.tatashin@microsoft.com>,
        Dave Hansen <dave.hansen@intel.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        rppt@linux.vnet.ibm.com, Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v5 4/4] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
Message-ID: <20181011083953.GB51021@tiger-server>
Mail-Followup-To: Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@kernel.org>, alexander.h.duyck@linux.intel.com,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Pasha Tatashin <pavel.tatashin@microsoft.com>,
        Dave Hansen <dave.hansen@intel.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        rppt@linux.vnet.ibm.com, Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20180925200551.3576.18755.stgit@localhost.localdomain>
 <20180925202053.3576.66039.stgit@localhost.localdomain>
 <20181009170051.GA40606@tiger-server>
 <CAPcyv4g99_rJJSn0kWv5YO0Mzj90q1LH1wC3XrjCh1=x6mo7BQ@mail.gmail.com>
 <25092df0-b7b4-d456-8409-9c004cb6e422@linux.intel.com>
 <20181010095838.GG5873@dhcp22.suse.cz>
 <f97de51c-67dd-99b2-754e-0685cac06699@linux.intel.com>
 <20181010172451.GK5873@dhcp22.suse.cz>
 <CAPcyv4inUwyYEEQ_qh5GTRxUo+JLt+caz_3mtg79DpfQSUdG5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPcyv4inUwyYEEQ_qh5GTRxUo+JLt+caz_3mtg79DpfQSUdG5Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-10 at 11:18:49 -0700, Dan Williams wrote:
> On Wed, Oct 10, 2018 at 10:30 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Wed 10-10-18 09:39:08, Alexander Duyck wrote:
> > > On 10/10/2018 2:58 AM, Michal Hocko wrote:
> > > > On Tue 09-10-18 13:26:41, Alexander Duyck wrote:
> > > > [...]
> > > > > I would think with that being the case we still probably need the call to
> > > > > __SetPageReserved to set the bit with the expectation that it will not be
> > > > > cleared for device-pages since the pages are not onlined. Removing the call
> > > > > to __SetPageReserved would probably introduce a number of regressions as
> > > > > there are multiple spots that use the reserved bit to determine if a page
> > > > > can be swapped out to disk, mapped as system memory, or migrated.
> > > >
> > > > PageReserved is meant to tell any potential pfn walkers that might get
> > > > to this struct page to back off and not touch it. Even though
> > > > ZONE_DEVICE doesn't online pages in traditional sense it makes those
> > > > pages available for further use so the page reserved bit should be
> > > > cleared.
> > >
> > > So from what I can tell that isn't necessarily the case. Specifically if the
> > > pagemap type is MEMORY_DEVICE_PRIVATE or MEMORY_DEVICE_PUBLIC both are
> > > special cases where the memory may not be accessible to the CPU or cannot be
> > > pinned in order to allow for eviction.
> >
> > Could you give me an example please?
> >
> > > The specific case that Dan and Yi are referring to is for the type
> > > MEMORY_DEVICE_FS_DAX. For that type I could probably look at not setting the
> > > reserved bit. Part of me wants to say that we should wait and clear the bit
> > > later, but that would end up just adding time back to initialization. At
> > > this point I would consider the change more of a follow-up optimization
> > > rather than a fix though since this is tailoring things specifically for DAX
> > > versus the other ZONE_DEVICE types.
> >
> > I thought I have already made it clear that these zone device hacks are
> > not acceptable to the generic hotplug code. If the current reserve bit
> > handling is not correct then give us a specific reason for that and we
> > can start thinking about the proper fix.
> >
> 
> Right, so we're in a situation where a hack is needed for KVM's
> current interpretation of the Reserved flag relative to dax mapped
> pages. I'm arguing to push that knowledge / handling as deep as
> possible into the core rather than hack the leaf implementations like
> KVM, i.e. disable the Reserved flag for all non-MEMORY_DEVICE_*
> ZONE_DEVICE types.
> 
> Here is the KVM thread about why they need a change:
> 
>     https://lkml.org/lkml/2018/9/7/552
> 
> ...and where I pushed back on a KVM-local hack:
> 
>     https://lkml.org/lkml/2018/9/19/154
Yeah, Thank Dan, I think I can going on with something like this:

@@ -5589,6 +5589,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 		struct page *page = pfn_to_page(pfn);
 
 		__init_single_page(page, pfn, zone_idx, nid);
+		/* Could we move this a little bit earlier as I can
+		 * direct use is_dax_page(page), or something else?
+		 */
+		page->pgmap = pgmap;
 
 		/*
 		 * Mark page reserved as it will need to wait for onlining
@@ -5597,14 +5598,14 @@ void __ref memmap_init_zone_device(struct zone *zone,
 		 * We can use the non-atomic __set_bit operation for setting
 		 * the flag as we are still initializing the pages.
 		 */
-		__SetPageReserved(page);
+		 if(!is_dax_page(page))
+			__SetPageReserved(page);
 
 		/*
 		 * ZONE_DEVICE pages union ->lru with a ->pgmap back
 		 * pointer and hmm_data.  It is a bug if a ZONE_DEVICE
 		 * page is ever freed or placed on a driver-private list.
 		 */
-		page->pgmap = pgmap;
 		page->hmm_data = 0;


After Alex's patch merged.
