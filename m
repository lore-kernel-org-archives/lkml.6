Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94F4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E79206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731111AbeLNVjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 16:39:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47878 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730887AbeLNVjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 16:39:41 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E465540258;
        Fri, 14 Dec 2018 21:39:40 +0000 (UTC)
Received: from jlaw-desktop.bos.csb (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1859D608E0;
        Fri, 14 Dec 2018 21:39:40 +0000 (UTC)
Subject: Re: [PATCH 2/2] livepatch: check kzalloc return values
To:     Nicholas Mc Guire <hofrat@osadl.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1544806570-21299-1-git-send-email-hofrat@osadl.org>
 <1544806570-21299-2-git-send-email-hofrat@osadl.org>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Organization: Red Hat
Message-ID: <cc9d25f4-fc3b-f399-654b-9de09689acc5@redhat.com>
Date:   Fri, 14 Dec 2018 16:39:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1544806570-21299-2-git-send-email-hofrat@osadl.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 14 Dec 2018 21:39:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/2018 11:56 AM, Nicholas Mc Guire wrote:
> kzalloc() return should always be checked - notably in example code
> where this may be seen as reference. On failure of allocation in
> livepatch_fix1_dummy_alloc() respectively dummy_alloc() previous
> allocation is freed (thanks to Petr Mladek <pmladek@suse.com> for
> catching this) and NULL returned.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: 439e7271dc2b ("livepatch: introduce shadow variable API")
> ---
> 
> Problem located with an experimental coccinelle script
> 
> Patch was compile tested with: x86_64_defconfig + FTRACE=y
> FUNCTION_TRACER=y, EXPERT=y, LATENCYTOP=y, SAMPLES=y,
> SAMPLE_LIVEPATCH=y
> 
> Patch is against 4.20-rc6 (localversion-next is next-20181214)
> on top of 0001-livepatch-fix-non-static-warnings.patch 
> 
>  samples/livepatch/livepatch-shadow-fix1.c | 5 +++++
>  samples/livepatch/livepatch-shadow-mod.c  | 4 ++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/samples/livepatch/livepatch-shadow-fix1.c b/samples/livepatch/livepatch-shadow-fix1.c
> index eaab10f..1974eb5 100644
> --- a/samples/livepatch/livepatch-shadow-fix1.c
> +++ b/samples/livepatch/livepatch-shadow-fix1.c
> @@ -89,6 +89,11 @@ static __noclone struct dummy *livepatch_fix1_dummy_alloc(void)
>  	 * pointer to handle resource release.
>  	 */
>  	leak = kzalloc(sizeof(int), GFP_KERNEL);
> +	if (!leak) {
> +		kfree(d);
> +		return NULL;
> +	}
> +
>  	klp_shadow_alloc(d, SV_LEAK, sizeof(leak), GFP_KERNEL,
>  			 shadow_leak_ctor, leak);
>  
> diff --git a/samples/livepatch/livepatch-shadow-mod.c b/samples/livepatch/livepatch-shadow-mod.c
> index dc69da0..b4ece36 100644
> --- a/samples/livepatch/livepatch-shadow-mod.c
> +++ b/samples/livepatch/livepatch-shadow-mod.c
> @@ -123,6 +123,10 @@ static __noclone noinline struct dummy *dummy_alloc(void)
>  
>  	/* Oops, forgot to save leak! */
>  	leak = kzalloc(sizeof(int), GFP_KERNEL);
> +	if (!leak) {
> +		kfree(d);
> +		return NULL;
> +	}
>  
>  	pr_info("%s: dummy @ %p, expires @ %lx\n",
>  		__func__, d, d->jiffies_expire);
> 

Patch v2 2/2 looks good, thanks for combining.

Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

-- Joe
