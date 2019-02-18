Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C49C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A62092184E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550478821;
	bh=CmXX9u5peyTA7EY0dDdEIb7WHNenqZvfOqTAvpjVwXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E5pgr+gDOLVZT/ESd7KQuKIYFwbBJ98X0FAbGU3j9Oh78Vti12g0bYTs5/fkmfeYv
	 VfT9P4rXUm3yOa1FDbavH0H4dth1x5faTqVKye3XfpnQniEv6GxCpeZMDbLGuvouED
	 ZmrkXk20f6x1Fhazc+1HhqUrpwZHaRW0XpPASS8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbfBRIdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:33:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:32852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729234AbfBRIdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:33:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1236218C3;
        Mon, 18 Feb 2019 08:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550478818;
        bh=CmXX9u5peyTA7EY0dDdEIb7WHNenqZvfOqTAvpjVwXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RLafrqVV4dLMbhPYz/kTnY+LblV/jWBtX4hceg81/BRLQ74bMnsXMFmKQzCNEp5ke
         s/lqMq8imyrGvUkQQ5VX1UvQFM6YDLhPnOHB778K3tKIReBmdKfxg3ayWJQGDArhUs
         3h1ivAwjIOHWWoAA0p0MKnmbolS/ysLOra+r+2hg=
Date:   Mon, 18 Feb 2019 09:33:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Liu Bo <bo.liu@linux.alibaba.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm: Fix the pgtable leak
Message-ID: <20190218083335.GB20069@kroah.com>
References: <20190213112900.33963-1-minchan@kernel.org>
 <20190213133624.GB9460@kroah.com>
 <20190214072352.GA15820@google.com>
 <20190218082026.GA88360@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218082026.GA88360@google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 05:20:26PM +0900, Minchan Kim wrote:
> On Thu, Feb 14, 2019 at 04:23:52PM +0900, Minchan Kim wrote:
> > On Wed, Feb 13, 2019 at 02:36:24PM +0100, Greg KH wrote:
> > > On Wed, Feb 13, 2019 at 08:29:00PM +0900, Minchan Kim wrote:
> > > > [1] was backported to v4.9 stable tree but it introduces pgtable
> > > > memory leak because with fault retrial, preallocated pagetable
> > > > could be leaked in second iteration.
> > > > To fix the problem, this patch backport [2].
> > > > 
> > > > [1] 5cf3e5ff95876, mm, memcg: fix reclaim deadlock with writeback
> > > 
> > > This is really commit 63f3655f9501 ("mm, memcg: fix reclaim deadlock
> > > with writeback") which was in 4.9.152, 4.14.94, 4.19.16, and 4.20.3 as
> > > well as 5.0-rc2.
> > 
> > Since 4.10, we has [2] so it should be okay other (tree > 4.10)
> > 
> > > 
> > > > [2] b0b9b3df27d10, mm: stop leaking PageTables
> > > 
> > > This commit was in 4.10, so I am guessing that this really is just a
> > > backport of that commit?
> > 
> > Yub.
> > 
> > > 
> > > If so, it's not the full backport, why not take the whole thing?  Why
> > > only cherry-pick one chunk of it?  Why do we not need the other parts?
> > 
> > Because [2] actually aims for fixing [3] which was introduced at 4.10.
> > Since then, [1] relies on the chunk I sent. Thus we don't need other part
> > for 4.9.
> > 
> > [3] 953c66c2b22a ("mm: THP page cache support for ppc64")
> 
> Hi Greg,
> 
> Any chance to look into this patch?

You sent it on Thursday, it is Monday, I tried to actually take the
weekend off :)

It's in my queue, relax, it has good company with a few other hundred
stable patches being requested...

greg k-h
