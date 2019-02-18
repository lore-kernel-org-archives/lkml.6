Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB30C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B836C2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XaKaNOye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391657AbfBRR53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:57:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60028 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389053AbfBRR52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:57:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+Plq0e0BG0Zenzxpp1loEbirrQRhIFIHE6Uh3NdBTOU=; b=XaKaNOyelEJ3LS2EGOgFm5tvo
        TOj+pO6qm3IO4tsX5n6FTnzhLPojb3Ksjfn9BYX5TrTysdFk6Hz5iFg8Ow7+vCfV68CeSQs+YkRzA
        +9yGx7VFINhjJrk4hg1LoOEnuemS4tK6b71Ruc0vRUY8eUOULvSgFZKRILcxIEqm2OqbCLE58GG7T
        g/qByk2T8ha16EHt6REkmnm+aeWMhdFAZyvRiF2mKiIggOtBwDYT3W3O9fAvS57LHsrQ5L7JnOr/0
        ysN9bT3l7tcwRceG2q9VO3ZrcR7+ZzfDP7xab0hj5JECFHNCwNDn1NpO+sJjDarK8BX0hqTkZ6Hex
        5Yrky4LLg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gvnAU-00028C-Cp; Mon, 18 Feb 2019 17:57:26 +0000
Date:   Mon, 18 Feb 2019 09:57:26 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Rong Chen <rong.a.chen@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>, LKP <lkp@01.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [LKP] efad4e475c [ 40.308255] Oops: 0000 [#1] PREEMPT SMP PTI
Message-ID: <20190218175726.GU12668@bombadil.infradead.org>
References: <20190218052823.GH29177@shao2-debian>
 <20190218070844.GC4525@dhcp22.suse.cz>
 <20190218085510.GC7251@dhcp22.suse.cz>
 <4c75d424-2c51-0d7d-5c28-78c15600e93c@intel.com>
 <20190218103013.GK4525@dhcp22.suse.cz>
 <20190218140515.GF25446@rapoport-lnx>
 <20190218152050.GS4525@dhcp22.suse.cz>
 <20190218152213.GT4525@dhcp22.suse.cz>
 <20190218164813.GG25446@rapoport-lnx>
 <20190218170558.GV4525@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218170558.GV4525@dhcp22.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 06:05:58PM +0100, Michal Hocko wrote:
> +	end_pfn = min(start_pfn + nr_pages,
> +			zone_end_pfn(page_zone(pfn_to_page(start_pfn))));
>  
>  	/* Check the starting page of each pageblock within the range */
> -	for (; page < end_page; page = next_active_pageblock(page)) {
> -		if (!is_pageblock_removable_nolock(page))
> +	for (; start_pfn < end_pfn; start_pfn = next_active_pageblock(start_pfn)) {
> +		if (!is_pageblock_removable_nolock(start_pfn))

If you have a zone which contains pfns that run from ULONG_MAX-n to ULONG_MAX,
end_pfn is going to wrap around to 0 and this loop won't execute.  I think
you should use:

	max_pfn = min(start_pfn + nr_pages,
			zone_end_pfn(page_zone(pfn_to_page(start_pfn)))) - 1;

	for (; start_pfn <= max_pfn; ...)

