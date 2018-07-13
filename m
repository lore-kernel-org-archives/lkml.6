Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79091ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388CE2089F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388CE2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731555AbeGMQ1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:27:11 -0400
Received: from nautica.notk.org ([91.121.71.147]:36771 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729736AbeGMQ1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:27:11 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id BBEC6C009; Fri, 13 Jul 2018 18:11:53 +0200 (CEST)
Date:   Fri, 13 Jul 2018 18:11:38 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Himanshu Jha <himanshujha199640@gmail.com>,
        Julia Lawall <julia.lawall@lip6.fr>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        yamada.masahiro@socionext.com
Subject: Re: [Cocci] [PATCH 01/18] coccinelle: change strncpy+truncation to
 strlcpy
Message-ID: <20180713161138.GA17418@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1807130647460.3063@hadrien>
 <20180713091412.GA11250@himanshu-Vostro-3559>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Himanshu Jha wrote on Fri, Jul 13, 2018:
> Try this:
> 
> $ spatch -D patch --sp-file strlcopy.cocci --very-quiet drivers/net/wireless/ti/wl1251/acx.c
> 
> ---------------------------------------------------------------------
> virtual patch
> 
> @depends on patch@
> expression dest, src, sz; 
> identifier f;
> @@
> 
> (
> - strncpy(
> + strlcpy(
>   dest, src, sizeof(sz));
> - dest[sizeof(sz) - 1] = '\0';
> |
> - strncpy(
> + strlcpy(
>   dest, src, f); 
> - dest[f - 1] = '\0';
> )
> ---------------------------------------------------------------------
> 
> This eliminates that case because expression is generic metavariable and
> it somehow matched whole "min(len, sizeof(...)..", so it better to
> divide the rules as done above to be more specific about the matching
> pattern.
> 
> I thought to replace "identifier f" with "constant F" but that misses
> few cases.

My first test started with 'constant sz' as well and I found expression
to be better.
If I understand this correctly, it just makes sure not to match the
'min(...)' expression so the problem doesn't arise, but it's not really
a solution as it is really a chance that this comment comes here for
this more complex expression.
I'd rather just advise to pay attention to comments and drop the
confidence level

> Also, it is advised to put a space affer '+/-'

Ok, thanks

Julia Lawall wrote on Fri, Jul 13, 2018:
> For the file drivers/net/wireless/ti/wl1251/acx.c, the following keeps the
> comment before the buf update and moves the strlcpy call below it.  It
> does however drop the comment just before the original call to strncpy.

Nice, doing it in two passes does the trick; it even keeps the comment
before strncpy if there was no comment in between.

I'm sorry to write that after being provided with such a nice
work-around though, now that I'm a bit less tired I've had a look at the
comments again and it does not make sense to keep the second comment as
is -- the whole point of using strlcpy (or now strscpy as per feedback
elsewhere) is that the string will be null terminated properly after the
call, so I'll stick to the original version.


I also see the position does not seem to be useful for the patch phase,
spatch automatically only applies only to what was matched earlier in
report mode?

>>> +-strncpy@p
>>> ++strlcpy
>>> +        (dest, src, sz);
>>
>> This also came from the example I picked, but if this does not make a
>> difference as it sounds like I will update to that.
>
> Probably not removing something just to add it back would be a good
> idea.

Actually playing with your example made me realize that removing and
re-adding argument does fix the indentation issue in the original code I
had noticed for mptctl, so it might actually unexpectedly be a good idea
to go in the opposite direction and make coccinelle remove/add arguments
in the general case (e.g. if strncpy and strlcpy hadn't been the same
length)

The jury is still out for this one :)


Thanks for all the feedbacks,
-- 
Dominique Martinet
