Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D8FC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7161420837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7161420837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbeLGGO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 01:14:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:55054 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725948AbeLGGO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 01:14:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7CD73AE80;
        Fri,  7 Dec 2018 06:14:27 +0000 (UTC)
Message-ID: <1544163250.3008.7.camel@suse.de>
Subject: Re: [PATCH] mm, kmemleak: Little optimization while scanning
From:   Oscar Salvador <osalvador@suse.de>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com
Date:   Fri, 07 Dec 2018 07:14:10 +0100
In-Reply-To: <20181207041528.xs4xnw6vpsbu5csx@master>
References: <20181206131918.25099-1-osalvador@suse.de>
         <20181207041528.xs4xnw6vpsbu5csx@master>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > +
> 
> This one maybe not necessary.

Yeah, that is a remind of an include file I used for time measurement.
I hope Andrew can drop that if this is taken.

> > /*
> >  * Kmemleak configuration and common defines.
> >  */
> > @@ -1547,11 +1548,14 @@ static void kmemleak_scan(void)
> > 		unsigned long pfn;
> > 
> > 		for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> > -			struct page *page;
> > +			struct page *page =
> > pfn_to_online_page(pfn);
> > +
> > +			if (!page)
> > +				continue;
> > 
> > -			if (!pfn_valid(pfn))
> > +			/* only scan pages belonging to this node
> > */
> > +			if (page_to_nid(page) != i)
> > 				continue;
> 
> Not farmiliar with this situation. Is this often?
Well, hard to tell how often that happens because that mostly depends
on the Hardware in case of baremetal.
Virtual systems can also have it though.

> 
> > -			page = pfn_to_page(pfn);
> > 			/* only scan if page is in use */
> > 			if (page_count(page) == 0)
> > 				continue;
> > -- 
> > 2.13.7
> 
> 
-- 
Oscar Salvador
SUSE L3
