Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2964BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A4121720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297152;
	bh=E4yBgzTr0FNhHVAuKAIfwOYC9dZuLvukemaTAFBsP3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZMuTGHGgArhZg7OitrH0Jj2TT3pTr0ZZLohiAAmdydq3t0hLigCbuTVTlzZUDTdIV
	 JhfDE4/pPSYtkV0nfIu7e5EEHKMjAqXP8ivq2sDex+xrsVyDMB2YHYddFDwPoD2ITn
	 33Ur/aHyDEhFeuaGHZYPGpRaCoopdAVE9amA1+hA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbeLTJMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:12:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:51058 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728172AbeLTJMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:12:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 86D8EB044;
        Thu, 20 Dec 2018 09:12:28 +0000 (UTC)
Date:   Thu, 20 Dec 2018 10:12:28 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        vbabka@suse.cz, pavel.tatashin@microsoft.com,
        rppt@linux.vnet.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm, page_alloc: Fix has_unmovable_pages for HugePages
Message-ID: <20181220091228.GB14234@dhcp22.suse.cz>
References: <20181217225113.17864-1-osalvador@suse.de>
 <20181219142528.yx6ravdyzcqp5wtd@master>
 <20181219233914.2fxe26pih26ifvmt@d104.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219233914.2fxe26pih26ifvmt@d104.suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 20-12-18 00:39:18, Oscar Salvador wrote:
> On Wed, Dec 19, 2018 at 02:25:28PM +0000, Wei Yang wrote:
> > >-			iter = round_up(iter + 1, 1<<compound_order(page)) - 1;
> > >+			skip_pages = (1 << compound_order(head)) - (page - head);
> > >+			iter = round_up(iter + 1, skip_pages) - 1;
> > 
> > The comment of round_up says round up to next specified power of 2.  And
> > second parameter must be a power of 2.
> > 
> > Look skip_pages not satisfy this.

Yes this is true but the resulting numbers should be correct even for
skips that are not power of 2 AFAIC. Or do you have any counter example?

> 
> At least alloc_gigantic_page() looks for 1GB range, aligned to that.
> But I see that in alloc_contig_range(), the boundaries can differ.
> 
> Anyway, unless I am missing something, I think that we could just
> get rid of the round_up() and do something like:
> 
> <--
> skip_pages = (1 << compound_order(head)) - (page - head);
> iter = skip_pages - 1;
> --
> 
> which looks more simple IMHO.

Agreed!

-- 
Michal Hocko
SUSE Labs
