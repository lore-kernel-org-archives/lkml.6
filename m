Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5EEC169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 00:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C27B20881
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 00:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548807859;
	bh=uRNu24/8CQ88tUh3cvXgGy7RgmiCGkf93XVlmmgKdmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cH64w96MN741i635RvczTdGXodeiQPey9F8IwL8VC/Wym0Ci5ijPgw379PclWpveN
	 ld4HdXWqlIDsD3Fxcm7a5WhtTrn500gJ/vXZlfrDOT2ybfQa3vf9EdI/THNMDYXBLj
	 sWM4HZM5didA7NIkRRs6TizvsHCW80zwpyT/RA/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfA3AX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 19:23:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:39544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727148AbfA3AX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 19:23:58 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A7F820881;
        Wed, 30 Jan 2019 00:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548807837;
        bh=uRNu24/8CQ88tUh3cvXgGy7RgmiCGkf93XVlmmgKdmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jmp5v6ODdLkL2P+d3BycB5vJN3owR2gpeSZqp35VIljUJF93dAhsvh5wR3Erknh5f
         zwvgdhA+nsU8OnQk1o3ic48FpbqlBJ6s0g+SKea2oZ4qHUnYkNIg7PqOvpPJZ7Bhes
         +C6MmCrgjD7Fwq7JfXiKNxxPzINlwiJ9cr0ao9u8=
Date:   Tue, 29 Jan 2019 19:23:56 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Greg KH <greg@kroah.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>
Subject: Re: Will the recent memory leak fixes be backported to longterm
 kernels?
Message-ID: <20190130002356.GQ3973@sasha-vm>
References: <20181102073009.GP23921@dhcp22.suse.cz>
 <20181102154844.GA17619@tower.DHCP.thefacebook.com>
 <20181102161314.GF28039@dhcp22.suse.cz>
 <20181102162237.GB17619@tower.DHCP.thefacebook.com>
 <20181102165147.GG28039@dhcp22.suse.cz>
 <20181102172547.GA19042@tower.DHCP.thefacebook.com>
 <20181102174823.GI28039@dhcp22.suse.cz>
 <20181102193827.GA18024@castle.DHCP.thefacebook.com>
 <20181105092053.GC4361@dhcp22.suse.cz>
 <20181228105008.GB15967@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181228105008.GB15967@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 11:50:08AM +0100, Greg KH wrote:
>On Mon, Nov 05, 2018 at 10:21:23AM +0100, Michal Hocko wrote:
>> On Fri 02-11-18 19:38:35, Roman Gushchin wrote:
>> > On Fri, Nov 02, 2018 at 06:48:23PM +0100, Michal Hocko wrote:
>> > > On Fri 02-11-18 17:25:58, Roman Gushchin wrote:
>> > > > On Fri, Nov 02, 2018 at 05:51:47PM +0100, Michal Hocko wrote:
>> > > > > On Fri 02-11-18 16:22:41, Roman Gushchin wrote:
>> > > [...]
>> > > > > > 2) We do forget to scan the last page in the LRU list. So if we ended up with
>> > > > > > 1-page long LRU, it can stay there basically forever.
>> > > > >
>> > > > > Why
>> > > > > 		/*
>> > > > > 		 * If the cgroup's already been deleted, make sure to
>> > > > > 		 * scrape out the remaining cache.
>> > > > > 		 */
>> > > > > 		if (!scan && !mem_cgroup_online(memcg))
>> > > > > 			scan = min(size, SWAP_CLUSTER_MAX);
>> > > > >
>> > > > > in get_scan_count doesn't work for that case?
>> > > >
>> > > > No, it doesn't. Let's look at the whole picture:
>> > > >
>> > > > 		size = lruvec_lru_size(lruvec, lru, sc->reclaim_idx);
>> > > > 		scan = size >> sc->priority;
>> > > > 		/*
>> > > > 		 * If the cgroup's already been deleted, make sure to
>> > > > 		 * scrape out the remaining cache.
>> > > > 		 */
>> > > > 		if (!scan && !mem_cgroup_online(memcg))
>> > > > 			scan = min(size, SWAP_CLUSTER_MAX);
>> > > >
>> > > > If size == 1, scan == 0 => scan = min(1, 32) == 1.
>> > > > And after proportional adjustment we'll have 0.
>> > >
>> > > My friday brain hurst when looking at this but if it doesn't work as
>> > > advertized then it should be fixed. I do not see any of your patches to
>> > > touch this logic so how come it would work after them applied?
>> >
>> > This part works as expected. But the following
>> > 	scan = div64_u64(scan * fraction[file], denominator);
>> > reliable turns 1 page to scan to 0 pages to scan.
>>
>> OK, 68600f623d69 ("mm: don't miss the last page because of round-off
>> error") sounds like a good and safe stable backport material.
>
>Thanks for this, now queued up.
>
>greg k-h

It seems that 172b06c32b949 ("mm: slowly shrink slabs with a relatively
small number of objects") and a76cf1a474d ("mm: don't reclaim inodes
with many attached pages") cause a regression reported against the 4.19
stable tree: https://bugzilla.kernel.org/show_bug.cgi?id=202441 .

Given the history and complexity of these (and other patches from that
series) it would be nice to understand if this is something that will be
fixed soon or should we look into reverting the series for now?

--
Thanks,
Sasha
