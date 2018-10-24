Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7266DC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 05:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E80F20652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 05:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HqwSbkqc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GIPgykqY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E80F20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbeJXNoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 09:44:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42364 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeJXNoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 09:44:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C2DDD60CF4; Wed, 24 Oct 2018 05:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540358273;
        bh=k2XzIJ8xP7LHyzG7BFJ9Nngz3Uj+nENz4QOyNXYBC4g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HqwSbkqcGgOETyB94BE+UvH7XTsiwAQDHdwnCnNQCAYPNLlJ50tlctdmQE5hXWpGN
         9sVErzMGTjhoBZdbB8w4ZujzUGmA64XTv1NFa73y2tUbu9yjhv57y2neBztaw6CDIJ
         moR2yJqDq2Zv8letfPfXrDBQtZeaXK1lZ0ZONcIo=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id BB54D606DC;
        Wed, 24 Oct 2018 05:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540358272;
        bh=k2XzIJ8xP7LHyzG7BFJ9Nngz3Uj+nENz4QOyNXYBC4g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GIPgykqYp5YRXlgswVcCw6Zueyu4Jpl/p0IZtTUbGXfkE3mHT5ukzH2Vqh72lC8Hp
         /ZfHO28x3vWGlv2L6HCSsf8P9XtWTNq8Scxh3FsP9XwgxIEAEfJs3HKEXQk9hdoG3d
         dZWOjHWKEA/7sq5Efril+dkB6MQBvqblCfNovD7A=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 24 Oct 2018 10:47:52 +0530
From:   Arun KS <arunks@codeaurora.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Joe Perches <joe@perches.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Arun Sudhilal <getarunks@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: convert totalram_pages, totalhigh_pages and
 managed_pages to atomic.
In-Reply-To: <CAGXu5j+NsDHRWA5PKAKeJCO_oiGkFAUeWE8O-1fEBQX80MDu1A@mail.gmail.com>
References: <1540229092-25207-1-git-send-email-arunks@codeaurora.org>
 <c57bcc584b3700c483b0311881ec3ae8786f88b1.camel@perches.com>
 <15247f54-53f3-83d4-6706-e9264b90ca7a@yandex-team.ru>
 <CAGXu5j+NsDHRWA5PKAKeJCO_oiGkFAUeWE8O-1fEBQX80MDu1A@mail.gmail.com>
Message-ID: <7a4fcbaee7efb71d2a3c6b403c090db4@codeaurora.org>
X-Sender: arunks@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-24 01:34, Kees Cook wrote:
> On Mon, Oct 22, 2018 at 10:11 PM, Konstantin Khlebnikov
> <khlebnikov@yandex-team.ru> wrote:
>> On 23.10.2018 7:15, Joe Perches wrote:> On Mon, 2018-10-22 at 22:53 
>> +0530,
>> Arun KS wrote:
>>>> Remove managed_page_count_lock spinlock and instead use atomic
>>>> variables.
>>> 
>>> Perhaps better to define and use macros for the accesses
>>> instead of specific uses of atomic_long_<inc/dec/read>
>>> 
>>> Something like:
>>> 
>>> #define totalram_pages()      (unsigned
>>> long)atomic_long_read(&_totalram_pages)
>> 
>> or proper static inline
>> this code isn't so low level for breaking include dependencies with 
>> macro
> 
> BTW, I noticed a few places in the patch that did multiple evaluations
> of totalram_pages. It might be worth fixing those prior to doing the
> conversion, too. e.g.:
> 
> if (totalram_pages > something)
>    foobar(totalram_pages); <- value may have changed here
> 
> should, instead, be:
> 
> var = totalram_pages; <- get stable view of the value
> if (var > something)
>     foobar(var);

Thanks for reviewing. Point taken.
> 
> -Kees
> 
>> [dropped bloated cc - my server rejects this mess]
> 
> Thank you -- I was struggling to figure out the best way to reply to 
> this. :)
I'm sorry for the trouble caused. Sent the email using,
git send-email  --to-cmd="scripts/get_maintainer.pl -i" 
0001-convert-totalram_pages-totalhigh_pages-and-managed_p.patch

Is this not a recommended approach?

Regards,
Arun

> 
> -Kees
