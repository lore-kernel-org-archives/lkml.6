Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4103C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF340218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Smrr3Ing"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfAYKjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:39:33 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48850 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbfAYKjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 05:39:32 -0500
Received: from zn.tnic (p200300EC2BCAC50020F76939FF7A14C4.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:c500:20f7:6939:ff7a:14c4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7718F1EC0229;
        Fri, 25 Jan 2019 11:39:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548412770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2znsdx9+pZYUGj6EpcgBnXfawDOt6tHyViNnmSTtcaY=;
        b=Smrr3IngQDo2YyJ5PfEhWXp0kSUcMto6XVgrzjY1/09e+wqmddtwul08WjvINZ9YE8zPQW
        dL+9NbM+y4BeMkvkeNWIOPVtJ8WHNRyPoGmHQf8/09oqGkALLtWDmsNJ/noDyiG9TkxUcY
        WGO7pY3nl39CLZASn09ryqIbFVBUiJ8=
Date:   Fri, 25 Jan 2019 11:39:24 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, yinghai@kernel.org,
        vgoyal@redhat.com, Randy Dunlap <rdunlap@infradead.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190125103924.GB27998@zn.tnic>
References: <1548047768-7656-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1548047768-7656-1-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>  Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X

s/bugfix, //

On Mon, Jan 21, 2019 at 01:16:08PM +0800, Pingfan Liu wrote:
> People reported crashkernel=384M reservation failed on a high end server
> with KASLR enabled.  In that case there is enough free memory under 896M
> but crashkernel reservation still fails intermittently.
> 
> The situation is crashkernel reservation code only finds free region under
> 896 MB with 128M aligned in case no ',high' being used.  And KASLR could
> break the first 896M into several parts randomly thus the failure happens.

This reads very strange.

> User has no way to predict and make sure crashkernel=xM working unless
> he/she use 'crashkernel=xM,high'.  Since 'crashkernel=xM' is the most
> common use case this issue is a serious bug.
> 
> And we can't answer questions raised from customer:
> 1) why it doesn't succeed to reserve 896 MB;
> 2) what's wrong with memory region under 4G;
> 3) why I have to add ',high', I only require 384 MB, not 3840 MB.

Errr, this looks like communication issue. Sounds to me like the text
around crashkernel= in

Documentation/admin-guide/kernel-parameters.txt

needs improving?

> This patch tries to get memory region from 896 MB firstly, then [896MB,4G],

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

> finally above 4G.
> 
> Dave Young sent the original post, and I just re-post it with commit log

If he sent it, he should be the author I guess.

> improvement as his requirement.
> http://lists.infradead.org/pipermail/kexec/2017-October/019571.html
> There was an old discussion below (previously posted by Chao Wang):
> https://lkml.org/lkml/2013/10/15/601

All that changelog info doesn't belong in the commit message ...

> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: yinghai@kernel.org,
> Cc: vgoyal@redhat.com
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---

.... but here.

> v6 -> v7: commit log improvement
>  arch/x86/kernel/setup.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 3d872a5..fa62c81 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -551,6 +551,22 @@ static void __init reserve_crashkernel(void)
>  						    high ? CRASH_ADDR_HIGH_MAX
>  							 : CRASH_ADDR_LOW_MAX,
>  						    crash_size, CRASH_ALIGN);
> +#ifdef CONFIG_X86_64
> +		/*
> +		 * crashkernel=X reserve below 896M fails? Try below 4G
> +		 */
> +		if (!high && !crash_base)
> +			crash_base = memblock_find_in_range(CRASH_ALIGN,
> +						(1ULL << 32),
> +						crash_size, CRASH_ALIGN);
> +		/*
> +		 * crashkernel=X reserve below 4G fails? Try MAXMEM
> +		 */
> +		if (!high && !crash_base)
> +			crash_base = memblock_find_in_range(CRASH_ALIGN,
> +						CRASH_ADDR_HIGH_MAX,
> +						crash_size, CRASH_ALIGN);
> +#endif

Ok, so this is silly: we know at which physical address KASLR allocated
the kernel so why aren't we querying that and seeing if there's enough
room before it or after it to call memblock_find_in_range() on the
bigger range?

Also, why is "high" dealt with separately and why isn't the code
enforcing "high" if the normal reservation fails?

The presence of high is requiring from our users to pay attention what
to use when the kernel can do all that automatically. Looks like a UI
fail to me.

And look at all the flavors of crashkernel= :

        crashkernel=size[KMG][@offset[KMG]]
        crashkernel=range1:size1[,range2:size2,...][@offset]
        crashkernel=size[KMG],high
        crashkernel=size[KMG],low

We couldn't do one so we made 4?!?!

What for?

Nowhere in that help text does it explain why a user would care about
high or low or range or offset or the planets alignment...

So what's up?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
