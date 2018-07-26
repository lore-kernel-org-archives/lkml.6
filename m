Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A8AC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E1D20673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E1D20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbeGZJnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 05:43:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:59522 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728688AbeGZJnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 05:43:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9C666ACA9;
        Thu, 26 Jul 2018 08:27:25 +0000 (UTC)
Date:   Thu, 26 Jul 2018 10:27:23 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Huang Ying <ying.huang@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?iso-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH v1 0/2] mm/kdump: exclude reserved pages in dumps
Message-ID: <20180726082723.GB28386@dhcp22.suse.cz>
References: <20180723123043.GD31229@dhcp22.suse.cz>
 <8daae80c-871e-49b6-1cf1-1f0886d3935d@redhat.com>
 <20180724072536.GB28386@dhcp22.suse.cz>
 <8eb22489-fa6b-9825-bc63-07867a40d59b@redhat.com>
 <20180724131343.GK28386@dhcp22.suse.cz>
 <af5353ee-319e-17ec-3a39-df997a5adf43@redhat.com>
 <20180724133530.GN28386@dhcp22.suse.cz>
 <6c753cae-f8b6-5563-e5ba-7c1fefdeb74e@redhat.com>
 <20180725135147.GN28386@dhcp22.suse.cz>
 <344d5f15-c621-9973-561e-6ed96b29ea88@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <344d5f15-c621-9973-561e-6ed96b29ea88@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 25-07-18 16:20:41, David Hildenbrand wrote:
> On 25.07.2018 15:51, Michal Hocko wrote:
> > On Tue 24-07-18 16:13:09, David Hildenbrand wrote:
> > [...]
> >> So I see right now:
> >>
> >> - Pg_reserved + e.g. new page type (or some other unique identifier in
> >>   combination with Pg_reserved)
> >>  -> Avoid reads of pages we know are offline
> >> - extend is_ram_page()
> >>  -> Fake zero memory for pages we know are offline
> >>
> >> Or even both (avoid reading and don't crash the kernel if it is being done).
> > 
> > I really fail to see how that can work without kernel being aware of
> > PageOffline. What will/should happen if you run an old kdump tool on a
> > kernel with this partially offline memory?
> > 
> 
> New kernel with old dump tool:
> 
> a) we have not fixed up is_ram_page()
> 
> -> crash, as we access memory we shouldn't

this is not acceptable, right? You do not want to crash your crash
kernel ;)

> b) we have fixed up is_ram_page()
> 
> -> We have a callback to check for applicable memory in the hypervisor
> whether the parts are accessible / online or not accessible / offline.
> (e.g. via a device driver that controls a certain memory region)
> 
> -> Don't read, but fake a page full of 0
> 
> 
> So instead of the kernel being aware of it, it asks via is_ram_page()
> the hypervisor.

I am still confused why do we even care about hypervisor. What if
somebody wants to have partial memory hotplug on native OS?
 
> I don't think a) is a problem. AFAICS, we have to update makedumpfile
> for every new kernel. We can perform changes and update makedumpfile
> to be compatible with new dump tools.

Not really. You simply do not crash the kernel just because you are
trying to dump the already crashed kernel.

> E.g. remember SECTION_IS_ONLINE you introduced ? It broke dump
> tools and required

But has it crashed the kernel when reading the dump? If yes then the
whole dumping is fragile as hell...
-- 
Michal Hocko
SUSE Labs
