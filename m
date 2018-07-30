Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBBE13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F320B20892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F320B20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbeG3NFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 09:05:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:36296 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727018AbeG3NFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 09:05:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D2CECADFA;
        Mon, 30 Jul 2018 11:30:31 +0000 (UTC)
Date:   Mon, 30 Jul 2018 13:30:29 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@techadventures.net>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Mathieu Malaterre <malat@debian.org>,
        Mel Gorman <mgorman@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v1] mm: inititalize struct pages when adding a section
Message-ID: <20180730113029.GM24267@dhcp22.suse.cz>
References: <20180727165454.27292-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727165454.27292-1-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 27-07-18 18:54:54, David Hildenbrand wrote:
> Right now, struct pages are inititalized when memory is onlined, not
> when it is added (since commit d0dc12e86b31 ("mm/memory_hotplug: optimize
> memory hotplug")).
> 
> remove_memory() will call arch_remove_memory(). Here, we usually access
> the struct page to get the zone of the pages.
> 
> So effectively, we access stale struct pages in case we remove memory that
> was never onlined. So let's simply inititalize them earlier, when the
> memory is added. We only have to take care of updating the zone once we
> know it. We can use a dummy zone for that purpose.

I have considered something like this when I was reworking memory
hotplug to not associate struct pages with zone before onlining and I
considered this to be rather fragile. I would really not like to get
back to that again if possible.

> So effectively, all pages will already be initialized and set to
> reserved after memory was added but before it was onlined (and even the
> memblock is added). We only inititalize pages once, to not degrade
> performance.

To be honest, I would rather see d0dc12e86b31 reverted. It is late in
the release cycle and if the patch is buggy then it should be reverted
rather than worked around. I found the optimization not really
convincing back then and this is still the case TBH.
-- 
Michal Hocko
SUSE Labs
