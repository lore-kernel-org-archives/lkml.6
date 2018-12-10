Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59148C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235B42081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544465972;
	bh=kfiG3E+Ret1IPfA6Go5d4DjWNjhNqN6msivj2nxfM7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HY/sH/LYFbFZ3lLe9aa7GgHxKfEG53fq5ljTJWGy9wG6Z0gsFILPnPj1/bXgELkrP
	 BummNLJ5Qptx8pv/5YB88KabQXJmWWtAnFH46RhtL4KKj4dLrnRGpIZ5TJnTkwImnH
	 /quqqOyTDzKIjli1bWBtv6h1i46lx1NIGAB6W+nU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 235B42081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbeLJSTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 13:19:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:37126 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726699AbeLJSTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 13:19:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 719EFAD6B;
        Mon, 10 Dec 2018 18:19:28 +0000 (UTC)
Date:   Mon, 10 Dec 2018 19:19:26 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Zaslonko Mikhail <zaslonko@linux.ibm.com>
Cc:     Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Pavel.Tatashin@microsoft.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        gerald.schaefer@de.ibm.com
Subject: Re: [PATCH 1/1] mm, memory_hotplug: Initialize struct pages for the
 full memory section
Message-ID: <20181210162410.GT1286@dhcp22.suse.cz>
References: <20181210130712.30148-1-zaslonko@linux.ibm.com>
 <20181210130712.30148-2-zaslonko@linux.ibm.com>
 <20181210132451.GO1286@dhcp22.suse.cz>
 <bcf681ea-7944-0a16-fbd4-c79ab176e638@linux.bm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcf681ea-7944-0a16-fbd4-c79ab176e638@linux.bm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 10-12-18 16:45:37, Zaslonko Mikhail wrote:
> Hello,
> 
> On 10.12.2018 14:24, Michal Hocko wrote:
[...]
> > Why do we need to restrict this to the highest zone? In other words, why
> > cannot we do what I was suggesting earlier [1]. What does prevent other
> > zones to have an incomplete section boundary?
> 
> Well, as you were also suggesting earlier: 'If we do not have a zone which
> spans the rest of the section'. I'm not sure how else we should verify that.

I am not sure I follow here. Why cannot we simply drop end_pfn check and
keep the rest?

> Moreover, I was able to recreate the problem only with the highest zone
> (memory end is not on the section boundary).

What exactly prevents exactmap memmap to generate these unfinished zones?

> > [1] http://lkml.kernel.org/r/20181105183533.GQ4361@dhcp22.suse.cz
> > 
> >> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> >> Reviewed-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> >> Cc: <stable@vger.kernel.org>
> >> ---
> >>  mm/page_alloc.c | 15 +++++++++++++++
> >>  1 file changed, 15 insertions(+)
> >>
> >> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >> index 2ec9cc407216..41ef5508e5f1 100644
> >> --- a/mm/page_alloc.c
> >> +++ b/mm/page_alloc.c
> >> @@ -5542,6 +5542,21 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
> >>  			cond_resched();
> >>  		}
> >>  	}
> >> +#ifdef CONFIG_SPARSEMEM
> >> +	/*
> >> +	 * If there is no zone spanning the rest of the section
> >> +	 * then we should at least initialize those pages. Otherwise we
> >> +	 * could blow up on a poisoned page in some paths which depend
> >> +	 * on full sections being initialized (e.g. memory hotplug).
> >> +	 */
> >> +	if (end_pfn == max_pfn) {
> >> +		while (end_pfn % PAGES_PER_SECTION) {
> >> +			__init_single_page(pfn_to_page(end_pfn), end_pfn, zone,
> >> +					   nid);
> >> +			end_pfn++;
> >> +		}
> >> +	}
> >> +#endif
> >>  }
> >>  
> >>  #ifdef CONFIG_ZONE_DEVICE
> >> -- 
> >> 2.16.4
> > 
> 
> Thanks,
> Mikhail Zaslonko

-- 
Michal Hocko
SUSE Labs
