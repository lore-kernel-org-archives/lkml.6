Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7EFC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D658206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730887AbfAIOZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:25:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55466 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730163AbfAIOZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:25:29 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DBABD3DE03;
        Wed,  9 Jan 2019 14:25:27 +0000 (UTC)
Received: from localhost (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C692367149;
        Wed,  9 Jan 2019 14:25:19 +0000 (UTC)
Date:   Wed, 9 Jan 2019 22:25:16 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Pingfan Liu <kernelfans@gmail.com>, linux-mm@kvack.org,
        kexec@lists.infradead.org, Tang Chen <tangchen@cn.fujitsu.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Daniel Vacek <neelx@redhat.com>,
        Mathieu Malaterre <malat@debian.org>,
        Stefan Agner <stefan@agner.ch>, Dave Young <dyoung@redhat.com>,
        yinghai@kernel.org, vgoyal@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190109142516.GA14211@MiWiFi-R3L-srv>
References: <1546848299-23628-1-git-send-email-kernelfans@gmail.com>
 <20190108080538.GB4396@rapoport-lnx>
 <20190108090138.GB18718@MiWiFi-R3L-srv>
 <20190108154852.GC14063@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108154852.GC14063@rapoport-lnx>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 09 Jan 2019 14:25:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/19 at 05:48pm, Mike Rapoport wrote:
> On Tue, Jan 08, 2019 at 05:01:38PM +0800, Baoquan He wrote:
> > Hi Mike,
> > 
> > On 01/08/19 at 10:05am, Mike Rapoport wrote:
> > > I'm not thrilled by duplicating this code (yet again).
> > > I liked the v3 of this patch [1] more, assuming we allow bottom-up mode to
> > > allocate [0, kernel_start) unconditionally. 
> > > I'd just replace you first patch in v3 [2] with something like:
> > 
> > In initmem_init(), we will restore the top-down allocation style anyway.
> > While reserve_crashkernel() is called after initmem_init(), it's not
> > appropriate to adjust memblock_find_in_range_node(), and we really want
> > to find region bottom up for crashkernel reservation, no matter where
> > kernel is loaded, better call __memblock_find_range_bottom_up().
> > 
> > Create a wrapper to do the necessary handling, then call
> > __memblock_find_range_bottom_up() directly, looks better.
> 
> What bothers me is 'the necessary handling' which is already done in
> several places in memblock in a similar, but yet slightly different way.

The page aligning for start and the mirror flag setting, I suppose.
> 
> memblock_find_in_range() and memblock_phys_alloc_nid() retry with different
> MEMBLOCK_MIRROR, but memblock_phys_alloc_try_nid() does that only when
> allocating from the specified node and does not retry when it falls back to
> any node. And memblock_alloc_internal() has yet another set of fallbacks. 

Get what you mean, seems they are trying to allocate within mirrorred
memory region, if fail, try the non-mirrorred region. If kernel data
allocation failed, no need to care about if it's movable or not, it need
to live firstly. For the bottom-up allocation wrapper, maybe we need do
like this too?

> 
> So what should be the necessary handling in the wrapper for
> __memblock_find_range_bottom_up() ?
> 
> BTW, even without any memblock modifications, retrying allocation in
> reserve_crashkerenel() for different ranges, like the proposal at [1] would
> also work, wouldn't it?

Yes, it also looks good. This patch only calls once, seems a simpler
line adding. 

In fact, below one and this patch, both is fine to me, as long as it
fixes the problem customers are complaining about.

> 
> [1] http://lists.infradead.org/pipermail/kexec/2017-October/019571.html

Thanks
Baoquan
