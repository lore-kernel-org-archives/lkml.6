Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD14C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3091F2064D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3091F2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbeGZJqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 05:46:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:60854 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728749AbeGZJq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 05:46:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3C070AEDA;
        Thu, 26 Jul 2018 08:30:43 +0000 (UTC)
Date:   Thu, 26 Jul 2018 10:30:42 +0200
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
Message-ID: <20180726083042.GC28386@dhcp22.suse.cz>
References: <20180720123422.10127-1-david@redhat.com>
 <9f46f0ed-e34c-73be-60ca-c892fb19ed08@suse.cz>
 <f8d7b5f9-e5ee-0625-f53d-50d1841e1388@redhat.com>
 <20180724072237.GA28386@dhcp22.suse.cz>
 <e5264f8e-2bb5-7a9b-6352-ad18f04d49c2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5264f8e-2bb5-7a9b-6352-ad18f04d49c2@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26-07-18 10:22:41, David Hildenbrand wrote:
> On 24.07.2018 09:22, Michal Hocko wrote:
> > On Mon 23-07-18 19:12:58, David Hildenbrand wrote:
> >> On 23.07.2018 13:45, Vlastimil Babka wrote:
> >>> On 07/20/2018 02:34 PM, David Hildenbrand wrote:
> >>>> Dumping tools (like makedumpfile) right now don't exclude reserved pages.
> >>>> So reserved pages might be access by dump tools although nobody except
> >>>> the owner should touch them.
> >>>
> >>> Are you sure about that? Or maybe I understand wrong. Maybe it changed
> >>> recently, but IIRC pages that are backing memmap (struct pages) are also
> >>> PG_reserved. And you definitely do want those in the dump.
> >>
> >> I proposed a new flag/value to mask pages that are logically offline but
> >> Michal wanted me to go into this direction.
> >>
> >> While we can special case struct pages in dump tools ("we have to
> >> read/interpret them either way, so we can also dump them"), it smells
> >> like my original attempt was cleaner. Michal?
> > 
> > But we do not have many page flags spare and even if we have one or two
> > this doesn't look like the use for them. So I still think we should try
> > the PageReserved way.
> > 
> 
> So as a summary, the only real approach that would be acceptable is
> using PageReserved + some other identifier to mark pages as "logically
> offline".
> 
> I wonder what identifier could be used, as this has to be consistent for
> all reserved pages (to avoid false positives).
> 
> Using other pageflags in combination might be possible, but then we have
> to make assumptions about all users of PageReserved right now.
> 
> As far as I can see (and as has been discussed), page_type could be
> used. If we don't want to consume a new bit, we could overload/reuse the
> "PG_balloon" bit.
> 
> 
> E.g. "PG_balloon" set -> exclude page from dump

Does each user of PG_balloon check for PG_reserved? If this is the case
then yes this would be OK.
-- 
Michal Hocko
SUSE Labs
