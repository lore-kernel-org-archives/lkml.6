Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B317FC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C7020846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C7020846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbeFTFIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 01:08:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:47200 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750821AbeFTFIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 01:08:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 91955ABBD;
        Wed, 20 Jun 2018 05:08:24 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 40B40A1081; Wed, 20 Jun 2018 07:08:24 +0200 (CEST)
Date:   Wed, 20 Jun 2018 07:08:24 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] proc: add missing '\0' back to /proc/$pid/cmdline
Message-ID: <20180620050824.hwijqfhzuu3ip4wo@unicorn.suse.cz>
References: <20180619092254.kmww3fpqjqcsjrna@unicorn.suse.cz>
 <20180619162411.B2B7AA1081@unicorn.suse.cz>
 <CA+55aFwa-mxOFKGiLmbxyJ+LyEjOG07fuYOmcWaYf-SJntneuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwa-mxOFKGiLmbxyJ+LyEjOG07fuYOmcWaYf-SJntneuw@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 06:56:04AM +0900, Linus Torvalds wrote:
> On Wed, Jun 20, 2018 at 1:24 AM Michal Kubecek <mkubecek@suse.cz> wrote:
> >
> > Recent rewrite introduced a regression, /proc/$pid/cmdline is missing the
> > trailing null character:
> >
> > mike@lion:/tmp> cat /proc/self/cmdline | od -t c
> > 0000000   c   a   t  \0   /   p   r   o   c   /   s   e   l   f   /   c
> > 0000020   m   d   l   i   n   e
> > 0000026
> 
> Thanks, and obviously right you are.
> 
> That said, I'm not a fan of your patch. I'd much rather just tweak the
> "strnlen()" logic a bit instead, and make the rule be that when we go
> into the "slop" area, we always include the last byte of the "real"
> argv area.
> 
> That limits the slop to a page (well, one byte less, since we want the
> one byte of non-slop), but honestly, a page for *everything* was what
> we used to do originally, so..

Yes, that should be enough for real life applications.

> How does the attached patch work for you?

I haven't tested it yet but it looks good except this:

> @@ -254,10 +258,19 @@ static ssize_t get_mm_cmdline(struct mm_struct *mm, char __user *buf,
>  	while (count) {
>  		int got;
>  		size_t size = min_t(size_t, PAGE_SIZE, count);

We limit size to be at most PAGE_SIZE here.

> +		long offset;
>  
> -		got = access_remote_vm(mm, pos, page, size, FOLL_ANON);
> -		if (got <= 0)
> +		/*
> +		 * Are we already starting past the official end?
> +		 * We always include the last byte that is *supposed*
> +		 * to be NUL
> +		 */
> +		offset = (pos >= arg_end) ? pos - arg_end + 1 : 0;
> +
> +		got = access_remote_vm(mm, pos - offset, page, size + offset, FOLL_ANON);

But here we read (size + offset) bytes which may be more than PAGE_SIZE.
I guess it should rather be

	size_t size;
...
	offset = (pos >= arg_end) ? pos - arg_end + 1 : 0;
	size = min_t(size_t, PAGE_SIZE - offset, count);

We already made sure that offset < PAGE_SIZE so that size will be at
least 1.

Michal Kubecek
