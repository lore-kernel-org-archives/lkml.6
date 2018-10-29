Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BBBC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45B62082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45B62082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbeJ3AqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 20:46:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:33370 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727085AbeJ3AqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 20:46:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D8063AD33;
        Mon, 29 Oct 2018 15:56:57 +0000 (UTC)
Date:   Mon, 29 Oct 2018 16:56:56 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     alexander.h.duyck@linux.intel.com, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Pasha Tatashin <pavel.tatashin@microsoft.com>,
        Dave Hansen <dave.hansen@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        rppt@linux.vnet.ibm.com, Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zhang Yi <yi.z.zhang@linux.intel.com>
Subject: Re: [PATCH v5 4/4] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
Message-ID: <20181029155656.GK32673@dhcp22.suse.cz>
References: <20181010095838.GG5873@dhcp22.suse.cz>
 <f97de51c-67dd-99b2-754e-0685cac06699@linux.intel.com>
 <20181010172451.GK5873@dhcp22.suse.cz>
 <98c35e19-13b9-0913-87d9-b3f1ab738b61@linux.intel.com>
 <20181010185242.GP5873@dhcp22.suse.cz>
 <20181011085509.GS5873@dhcp22.suse.cz>
 <6f32f23c-c21c-9d42-7dda-a1d18613cd3c@linux.intel.com>
 <20181017075257.GF18839@dhcp22.suse.cz>
 <971729e6-bcfe-a386-361b-d662951e69a7@linux.intel.com>
 <CAPcyv4gZZcuWFLzRpyJcAxtGEPTDkpwkG3J0Z4Q1u790+7W2Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gZZcuWFLzRpyJcAxtGEPTDkpwkG3J0Z4Q1u790+7W2Ag@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 29-10-18 08:49:46, Dan Williams wrote:
> On Wed, Oct 17, 2018 at 8:02 AM Alexander Duyck
> <alexander.h.duyck@linux.intel.com> wrote:
> >
> > On 10/17/2018 12:52 AM, Michal Hocko wrote:
> > > On Thu 11-10-18 10:38:39, Alexander Duyck wrote:
> > >> On 10/11/2018 1:55 AM, Michal Hocko wrote:
> > >>> On Wed 10-10-18 20:52:42, Michal Hocko wrote:
> > >>> [...]
> > >>>> My recollection was that we do clear the reserved bit in
> > >>>> move_pfn_range_to_zone and we indeed do in __init_single_page. But then
> > >>>> we set the bit back right afterwards. This seems to be the case since
> > >>>> d0dc12e86b319 which reorganized the code. I have to study this some more
> > >>>> obviously.
> > >>>
> > >>> so my recollection was wrong and d0dc12e86b319 hasn't really changed
> > >>> much because __init_single_page wouldn't zero out the struct page for
> > >>> the hotplug contex. A comment in move_pfn_range_to_zone explains that we
> > >>> want the reserved bit because pfn walkers already do see the pfn range
> > >>> and the page is not fully associated with the zone until it is onlined.
> > >>>
> > >>> I am thinking that we might be overzealous here. With the full state
> > >>> initialized we shouldn't actually care. pfn_to_online_page should return
> > >>> NULL regardless of the reserved bit and normal pfn walkers shouldn't
> > >>> touch pages they do not recognize and a plain page with ref. count 1
> > >>> doesn't tell much to anybody. So I _suspect_ that we can simply drop the
> > >>> reserved bit setting here.
> > >>
> > >> So this has me a bit hesitant to want to just drop the bit entirely. If
> > >> nothing else I think I may wan to make that a patch onto itself so that if
> > >> we aren't going to set it we just drop it there. That way if it does cause
> > >> issues we can bisect it to that patch and pinpoint the cause.
> > >
> > > Yes a patch on its own make sense for bisectability.
> >
> > For now I think I am going to back off of this. There is a bunch of
> > other changes that need to happen in order for us to make this work. As
> > far as I can tell there are several places that are relying on this
> > reserved bit.
> 
> When David Hildebrand and I looked it was only the hibernation code
> that we thought needed changing.

More details please?

-- 
Michal Hocko
SUSE Labs
