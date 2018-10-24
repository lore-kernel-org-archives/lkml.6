Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5629ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 23:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A58207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 23:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90A58207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbeJYHr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 03:47:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49188 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbeJYHr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 03:47:58 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 97C6E1837;
        Wed, 24 Oct 2018 23:17:55 +0000 (UTC)
Date:   Wed, 24 Oct 2018 16:17:54 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Michal Hocko <mhocko@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mel Gorman <mgorman@suse.de>,
        David Rientjes <rientjes@google.com>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm, thp: consolidate THP gfp handling into
 alloc_hugepage_direct_gfpmask
Message-Id: <20181024161754.0d174e7c22113f4f8aad1940@linux-foundation.org>
In-Reply-To: <583b20e5-4925-e175-1533-5c2d2bab9192@suse.cz>
References: <20180925120326.24392-1-mhocko@kernel.org>
        <20180925120326.24392-3-mhocko@kernel.org>
        <20180926133039.y7o5x4nafovxzh2s@kshutemo-mobl1>
        <20180926141708.GX6278@dhcp22.suse.cz>
        <20180926142227.GZ6278@dhcp22.suse.cz>
        <20181018191147.33e8d5e1ebd785c06aab7b30@linux-foundation.org>
        <20181019080657.GJ18839@dhcp22.suse.cz>
        <583b20e5-4925-e175-1533-5c2d2bab9192@suse.cz>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2018 15:27:54 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

> > : Moreover the oriinal code allowed to trigger
> > : 	WARN_ON_ONCE(policy->mode == MPOL_BIND && (gfp & __GFP_THISNODE));
> > : in policy_node if the requested node (e.g. cpu local one) was outside of
> > : the mbind nodemask. This is not possible now. We haven't heard about any
> > : such warning yet so it is unlikely that it happens but still a signal of
> > : a wrong code layering.
> 
> Ah, as I said in the other mail, I think it's inaccurate, the warning
> was not possible to hit.
> 
> There's also a slight difference wrt MPOL_BIND. The previous code would
> avoid using __GFP_THISNODE if the local node was outside of
> policy_nodemask(). After your patch __GFP_THISNODE is avoided for all
> MPOL_BIND policies. So there's a difference that if local node is
> actually allowed by the bind policy's nodemask, previously
> __GFP_THISNODE would be added, but now it won't be. I don't think it
> matters that much though, but maybe the changelog could say that
> (instead of the inaccurate note about warning). Note the other policy
> where nodemask is relevant is MPOL_INTERLEAVE, and that's unchanged by
> this patch.

So the above could go into the changelog, yes?

> When that's addressed, you can add

What is it that you'd like to see addressed?  Purely changelog updates?

> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks.
