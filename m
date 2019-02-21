Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22EBC00319
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776512084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550765343;
	bh=rl5xboU1d67euJXaVDLtlQ6tGv17029gB53Or/y7ZoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LuFx3K+lUFpdI77Bn4KuxOX2yc1j+unT2BW9vg/vJvLe9H2kjIPpDgU6rydl2rUfe
	 xrgRRT9IbQBFrMLqVhOptqbNrIiA/oed3LQNyJdLtXZA8eZW7DIH41mPjw9N9hUxTJ
	 j6oAP/H1qUH4ozZWCgjxYFOhFOfjmJXs6/j2M8JQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbfBUQJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:09:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:58412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbfBUQJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:09:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4B972083E;
        Thu, 21 Feb 2019 16:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550765341;
        bh=rl5xboU1d67euJXaVDLtlQ6tGv17029gB53Or/y7ZoA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KCFv6eoFlgpGZW8jrpAK8mD2ez77K9Me5rTj8pGVSYWd2WRBvmXZmvc9M657hK5/8
         JMjEDXeU+68WD6lAtvQX/CQss+Rt7PB/WT9gshuomxBqXPRU24hoVESYMWYlweE4f4
         G912y1kqBmE9/2glh2aVNIvxqOornbiuFl7O0IPc=
Date:   Thu, 21 Feb 2019 17:08:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Qian Cai <cai@lca.pw>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4.19 23/30] x86_64: increase stack size for KASAN_EXTRA
Message-ID: <20190221160858.GB25800@kroah.com>
References: <20190221125250.543158526@linuxfoundation.org>
 <20190221125251.864751477@linuxfoundation.org>
 <953de00c-82df-3ac2-8dd7-a023c511cbb9@virtuozzo.com>
 <20190221152642.GA23121@kroah.com>
 <f3ce6a5a-8923-dcbb-516f-8c291b33a63d@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3ce6a5a-8923-dcbb-516f-8c291b33a63d@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 06:30:08PM +0300, Andrey Ryabinin wrote:
> 
> 
> On 2/21/19 6:26 PM, Greg Kroah-Hartman wrote:
> > On Thu, Feb 21, 2019 at 06:00:06PM +0300, Andrey Ryabinin wrote:
> >> On 2/21/19 5:36 PM, Greg Kroah-Hartman wrote:
> >>> 4.19-stable review patch.  If anyone has any objections, please let me know.
> >>>
> >>
> >> Drop it please. It increases kernel stack up to 4-order which is above PAGE_ALLOC_COSTLY_ORDER.
> >> This changes behavior of the fork() by making it fail with -ENOMEM due of high memory fragmentation.
> >>
> >> The patch that removes KASAN_EXTRA (not in Linus's tree yet) would be a better fix for the problem.
> > 
> > Ok, should this also be dropped from 4.20.y?
> > 
> 
> Yes.

Great, now dropped from both.

thanks,

greg k-h
