Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B3DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 117B22175B
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 117B22175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731807AbeKNJck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 04:32:40 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:52974 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbeKNJck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 04:32:40 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4168B412;
        Tue, 13 Nov 2018 23:32:05 +0000 (UTC)
Date:   Tue, 13 Nov 2018 15:32:04 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Michal Hocko <mhocko@kernel.org>, Kyungtae Kim <kt0755@gmail.com>,
        pavel.tatashin@microsoft.com, osalvador@suse.de,
        rppt@linux.vnet.ibm.com, aaron.lu@intel.com,
        iamjoonsoo.kim@lge.com, alexander.h.duyck@linux.intel.com,
        mgorman@techsingularity.net, lifeasageek@gmail.com,
        threeearcat@gmail.com, syzkaller@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: Re: UBSAN: Undefined behaviour in mm/page_alloc.c
Message-Id: <20181113153204.ea0c0895866838de9e3bc8d0@linux-foundation.org>
In-Reply-To: <d88fae5c-e12d-ca35-d200-587a2ff02ec9@suse.cz>
References: <CAEAjamseRRHu+TaTkd1TwpLNm8mtDGP=2K0WKLF0wH-3iLcW_w@mail.gmail.com>
        <20181109084353.GA5321@dhcp22.suse.cz>
        <20181113094305.GM15120@dhcp22.suse.cz>
        <20181113151503.fd370e28cb9df5a0933e9b04@linux-foundation.org>
        <d88fae5c-e12d-ca35-d200-587a2ff02ec9@suse.cz>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2018 00:23:28 +0100 Vlastimil Babka <vbabka@suse.cz> wrote:

> On 11/14/18 12:15 AM, Andrew Morton wrote:
> > On Tue, 13 Nov 2018 10:43:05 +0100 Michal Hocko <mhocko@kernel.org> wrote:
> > 
> >> --- a/mm/page_alloc.c
> >> +++ b/mm/page_alloc.c
> >> @@ -4364,6 +4353,15 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
> >>  	gfp_t alloc_mask; /* The gfp_t that was actually used for allocation */
> >>  	struct alloc_context ac = { };
> >>  
> >> +	/*
> >> +	 * There are several places where we assume that the order value is sane
> >> +	 * so bail out early if the request is out of bound.
> >> +	 */
> >> +	if (unlikely(order >= MAX_ORDER)) {
> >> +		WARN_ON_ONCE(!(gfp_mask & __GFP_NOWARN));
> >> +		return NULL;
> >> +	}
> >> +
> > 
> > I know "everybody enables CONFIG_DEBUG_VM", but given this is fastpath,
> > we could help those who choose not to enable it by using
> > 
> > #ifdef CONFIG_DEBUG_VM
> > 	if (WARN_ON_ONCE(order >= MAX_ORDER && !(gfp_mask & __GFP_NOWARN)))
> > 		return NULL;
> > #endif
> 
> Hmm, but that would mean there's still potential undefined behavior for
> !CONFIG_DEBUG_VM, so I would prefer not to do it like that.
> 

What does "potential undefined behavior" mean here?
