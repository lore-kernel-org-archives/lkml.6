Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71219C41518
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B01220854
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548140304;
	bh=SpD9MLuRuZrYRFGlhQ0SQ1DyF5BUfOzvZsNEMS7parw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1/Vpr07eHRljHmDGavp4M8aLoTVq6QzAD8F1ivMYaixuZWouhWNENe52O4Fu0ZqE4
	 rkGeNy2dy3lovznpSXZKBYe7eEC44/gB/CeSuVtbHm4pPIDaHTGEebHHqlYuvD3STW
	 H6Tq117YLJJLDxcRj5RDmifQgHYEsiVz+i4pIuhU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfAVG6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 01:58:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:40780 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbfAVG6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 01:58:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9DFD8ACC0;
        Tue, 22 Jan 2019 06:58:20 +0000 (UTC)
Date:   Tue, 22 Jan 2019 07:58:18 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, osalvador@suse.de,
        catalin.marinas@arm.com, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/hotplug: invalid PFNs from pfn_to_online_page()
Message-ID: <20190122065818.GA4087@dhcp22.suse.cz>
References: <20190121212747.23029-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121212747.23029-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21-01-19 16:27:47, Qian Cai wrote:
[...]

Sorry to miss this before but you want to

> +#define pfn_to_online_page(pfn)					   \
> +({								   \
> +	struct page *___page = NULL;				   \
	unsigned long ___pfn = pfn;
> +	unsigned long ___nr = pfn_to_section_nr(pfn);		   \
			      pfn_to_section_nr(___pfn);
> +								   \
> +	if (___nr < NR_MEM_SECTIONS && online_section_nr(___nr) && \
> +	    pfn_valid_within(pfn))				   \
	    pfn_valid_within(___pfn))
	
> +		___page = pfn_to_page(pfn);			   \
> +	___page;						   \
>  })

to prevent from issues when pfn expression has side effects.
-- 
Michal Hocko
SUSE Labs
