Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D768960767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753928AbeFFRr0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 13:47:26 -0400
Received: from outbound-smtp16.blacknight.com ([46.22.139.233]:47787 "EHLO
        outbound-smtp16.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752255AbeFFRrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 13:47:25 -0400
Date: Wed, 6 Jun 2018 18:47:23 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Nadav Amit <nadav.amit@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>, mhocko@kernel.org,
        vbabka@suse.cz, Aaron Lu <aaron.lu@intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mremap: Increase LATENCY_LIMIT of mremap to reduce the
 number of TLB shootdowns
Message-ID: <20180606174723.bag3o55fvqp6nbvc@techsingularity.net>
References: <20180606140255.br5ztpeqdmwfto47@techsingularity.net>
 <C86F5DE4-DAAE-4C12-B509-E5807ADA471E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <C86F5DE4-DAAE-4C12-B509-E5807ADA471E@gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 08:55:15AM -0700, Nadav Amit wrote:
> > -#define LATENCY_LIMIT	(64 * PAGE_SIZE)
> > +#define LATENCY_LIMIT	(PMD_SIZE)
> > 
> > unsigned long move_page_tables(struct vm_area_struct *vma,
> > 		unsigned long old_addr, struct vm_area_struct *new_vma,
> 
> This LATENCY_LIMIT is only used in move_page_tables() in the following
> manner:
> 
>   next = (new_addr + PMD_SIZE) & PMD_MASK;
>   if (extent > next - new_addr)
>       extent = next - new_addr;
>   if (extent > LATENCY_LIMIT)
>       extent = LATENCY_LIMIT;
>    
> If LATENCY_LIMIT is to be changed to PMD_SIZE, then IIUC the last condition
> is not required, and LATENCY_LIMIT can just be removed (assuming there is no
> underflow case that hides somewhere).
> 

I see no problem removing it other than we may forget that we ever limited
PTE lock hold times for any reason. I'm skeptical it will matter unless
mremap-intensive workloads are a lot more common than I believe.

-- 
Mel Gorman
SUSE Labs
