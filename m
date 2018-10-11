Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9AAC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610892085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:55:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610892085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbeJKQVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 12:21:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:36742 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726135AbeJKQVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 12:21:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A4D70AE6D;
        Thu, 11 Oct 2018 08:55:10 +0000 (UTC)
Date:   Thu, 11 Oct 2018 10:55:09 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Pasha Tatashin <pavel.tatashin@microsoft.com>,
        Dave Hansen <dave.hansen@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        rppt@linux.vnet.ibm.com, Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        yi.z.zhang@linux.intel.com
Subject: Re: [PATCH v5 4/4] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
Message-ID: <20181011085509.GS5873@dhcp22.suse.cz>
References: <20180925200551.3576.18755.stgit@localhost.localdomain>
 <20180925202053.3576.66039.stgit@localhost.localdomain>
 <20181009170051.GA40606@tiger-server>
 <CAPcyv4g99_rJJSn0kWv5YO0Mzj90q1LH1wC3XrjCh1=x6mo7BQ@mail.gmail.com>
 <25092df0-b7b4-d456-8409-9c004cb6e422@linux.intel.com>
 <20181010095838.GG5873@dhcp22.suse.cz>
 <f97de51c-67dd-99b2-754e-0685cac06699@linux.intel.com>
 <20181010172451.GK5873@dhcp22.suse.cz>
 <98c35e19-13b9-0913-87d9-b3f1ab738b61@linux.intel.com>
 <20181010185242.GP5873@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010185242.GP5873@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 10-10-18 20:52:42, Michal Hocko wrote:
[...]
> My recollection was that we do clear the reserved bit in
> move_pfn_range_to_zone and we indeed do in __init_single_page. But then
> we set the bit back right afterwards. This seems to be the case since
> d0dc12e86b319 which reorganized the code. I have to study this some more
> obviously.

so my recollection was wrong and d0dc12e86b319 hasn't really changed
much because __init_single_page wouldn't zero out the struct page for
the hotplug contex. A comment in move_pfn_range_to_zone explains that we
want the reserved bit because pfn walkers already do see the pfn range
and the page is not fully associated with the zone until it is onlined.

I am thinking that we might be overzealous here. With the full state
initialized we shouldn't actually care. pfn_to_online_page should return
NULL regardless of the reserved bit and normal pfn walkers shouldn't
touch pages they do not recognize and a plain page with ref. count 1
doesn't tell much to anybody. So I _suspect_ that we can simply drop the
reserved bit setting here.

Regarding the post initialization required by devm_memremap_pages and
potentially others. Can we update the altmap which is already a way how
to get alternative struct pages by a constructor which we could call
from memmap_init_zone and do the post initialization? This would reduce
the additional loop in the caller while it would still fit the overall
design of the altmap and the core hotplug doesn't have to know anything
about DAX or whatever needs a special treatment.

Does that make any sense?
-- 
Michal Hocko
SUSE Labs
