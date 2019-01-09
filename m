Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A77C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55BAB20883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AkhXU0hx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ggo5OvHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbfAIF65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 00:58:57 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:42198 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbfAIF65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 00:58:57 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1FB0460907; Wed,  9 Jan 2019 05:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547013536;
        bh=77Ok9Dvzp9t7jBiP1bmDOBkahoOkN2/K66/dFUp9g/M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AkhXU0hxN0UsWSF/i7MQ1SP8qzZLLTfjRjdAELaykn7NZBUWR6K12d3Nnlxhw9Io2
         5yFI2fEUoKsR/sdsf4BdFBuY+a6JideptwwA1/pfI5Pipx9LpQ4wayyvGpdcJ9g/Fs
         R2JkaedokVzoLaFqIhxd5dAQveddCaZfULCovCTg=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id E671C6089D;
        Wed,  9 Jan 2019 05:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547013533;
        bh=77Ok9Dvzp9t7jBiP1bmDOBkahoOkN2/K66/dFUp9g/M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ggo5OvHDmfvpN549Lhkyyc1N4LiKBsrUQFYt/Q0tYboHnVFyZvBD9LLtqGERUpPj4
         O0Sn76EmHX/ZoiSghU9D0TQtcAzkvhBGICeFdNthxv502uBHG+taDI41F0SU+rUTRQ
         hHzdGUMzIByglUu+MecTJD8NMwpa9J+HLa607iAQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 09 Jan 2019 11:28:52 +0530
From:   Arun KS <arunks@codeaurora.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        arunks.linux@gmail.com, akpm@linux-foundation.org, vbabka@suse.cz,
        osalvador@suse.de, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, getarunks@gmail.com
Subject: Re: [PATCH v7] mm/page_alloc.c: memory_hotplug: free pages as higher
 order
In-Reply-To: <20190108181352.GI31793@dhcp22.suse.cz>
References: <1546578076-31716-1-git-send-email-arunks@codeaurora.org>
 <fb6465c99b3ada2c6af587a7eb00016d96d56f77.camel@linux.intel.com>
 <20190108181352.GI31793@dhcp22.suse.cz>
Message-ID: <bfb543b6e343c21c3e263a110f234e08@codeaurora.org>
X-Sender: arunks@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-08 23:43, Michal Hocko wrote:
> On Tue 08-01-19 09:56:09, Alexander Duyck wrote:
>> On Fri, 2019-01-04 at 10:31 +0530, Arun KS wrote:
> [...]
>> >  static int online_pages_range(unsigned long start_pfn, unsigned long nr_pages,
>> >  			void *arg)
>> >  {
>> > -	unsigned long i;
>> >  	unsigned long onlined_pages = *(unsigned long *)arg;
>> > -	struct page *page;
>> >
>> >  	if (PageReserved(pfn_to_page(start_pfn)))
>> > -		for (i = 0; i < nr_pages; i++) {
>> > -			page = pfn_to_page(start_pfn + i);
>> > -			(*online_page_callback)(page);
>> > -			onlined_pages++;
>> > -		}
>> > +		onlined_pages = online_pages_blocks(start_pfn, nr_pages);
>> 
>> Shouldn't this be a "+=" instead of an "="? It seems like you are 
>> going
>> to lose your count otherwise.
> 
> You are right of course. I should have noticed during the review.
> Thanks!

I think we don't need to. The caller function is setting onlined_pages = 
0 before calling online_pages_range().
And there are no other reference to online_pages_range other than from 
online_pages().

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/memory_hotplug.c?h=v5.0-rc1#n845

int __ref online_pages(unsigned long pfn, unsigned long nr_pages, int 
online_type)
{
         unsigned long flags;
         unsigned long onlined_pages = 0;

Regards,
Arun
