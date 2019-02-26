Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59E3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65931217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551186488;
	bh=4mOXQh/uLsJwIymo3YDHAyCmEhtE2FPuGDbYUzlgRgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=duFNLh82bK9/JN19C1x3ZNEXbD9dkbcM4etTpst6CL9keElHFM932sA+wOa3ykQcl
	 sMxHD4H86z28VwpXsnG0kaHwrLya5FRnuvw2OEd2pdrHmhgiwQRcOgAXa7GHo/E+Zt
	 BlN376B0VVo+DkFqqsMfeJ8kbqwJCao/kGDF+XEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfBZNIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 08:08:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:38686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbfBZNIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 08:08:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB50E20651;
        Tue, 26 Feb 2019 13:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551186486;
        bh=4mOXQh/uLsJwIymo3YDHAyCmEhtE2FPuGDbYUzlgRgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z40kjWuD97EvUTIONZL4khF50jZEIyD0nnXb3Q17+yg/jesh10BaqVs2N/Vj3INMi
         snYa00SMRwtKILUeGkondPOo6PuV9GP1V/O4hejEniNUyx64bHnB0wmXthb8GWQ5bS
         n0CiG3JUjcQC8y14iALojZN+uP2j+VYZE0Jz8Fzc=
Date:   Tue, 26 Feb 2019 14:08:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        luto@kernel.org, Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Xu Yu <xuyu@linux.alibaba.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org
Subject: Re: [bug report][stable] perf probe: failed to add events
Message-ID: <20190226130802.GA10343@kroah.com>
References: <1a4240a8-288b-45d0-073d-d5cb8f0c63eb@linux.alibaba.com>
 <20190226090505.GA24409@kroah.com>
 <c7ccd9cb-3a66-98a9-faa1-7ee5ed20ff88@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7ccd9cb-3a66-98a9-faa1-7ee5ed20ff88@linux.alibaba.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 08:32:34PM +0800, Joseph Qi wrote:
> 
> 
> On 19/2/26 17:05, Greg KH wrote:
> > On Tue, Feb 26, 2019 at 03:31:14PM +0800, Joseph Qi wrote:
> >> Hi,
> >>
> >> I'm using kernel v4.19.24 and have found that there is an issue when
> >> using perf probe to define a new dynamic tracepoint.
> >>
> >> $ perf probe -a handle_mm_fault
> >> Failed to write event: Numerical result out of range
> >>   Error: Failed to add events.
> >>
> >> I've also tried kernel v4.20, and it can pass.
> > 
> > Ick, has this ever worked on the 4.19 stable tree?  If so, any chance
> > you can run 'git bisect' to find the offending commit?
> > 
> >From my test, v4.19.0 also has this issue.
> Bisect locates that it is introduced by commit bf904d2762ee
> "x86/pti/64: Remove the SYSCALL64 entry trampoline".

But that commit was in 4.20, not 4.19.  So if this never worked, it's
not a regression?

confused,

greg k-h
