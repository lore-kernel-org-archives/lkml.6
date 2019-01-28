Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D69C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA8D2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbfA1R2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:28:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:41742 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730549AbfA1R2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 12:28:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5DB63AF0D;
        Mon, 28 Jan 2019 17:28:15 +0000 (UTC)
Date:   Mon, 28 Jan 2019 18:28:14 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Sasha Levin <sashal@kernel.org>
cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Jiri Kosina <jkosina@suse.cz>, live-patching@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.19 174/258] livepatch: check kzalloc return
 values
In-Reply-To: <20190128155924.51521-174-sashal@kernel.org>
Message-ID: <alpine.LSU.2.21.1901281826230.9332@pobox.suse.cz>
References: <20190128155924.51521-1-sashal@kernel.org> <20190128155924.51521-174-sashal@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2019, Sasha Levin wrote:

> From: Nicholas Mc Guire <hofrat@osadl.org>
> 
> [ Upstream commit 5f30b2e823484ce6a79f2b59901b6351c15effa6 ]
> 
> kzalloc() return should always be checked - notably in example code
> where this may be seen as reference. On failure of allocation in
> livepatch_fix1_dummy_alloc() respectively dummy_alloc() previous
> allocation is freed (thanks to Petr Mladek <pmladek@suse.com> for
> catching this) and NULL returned.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: 439e7271dc2b ("livepatch: introduce shadow variable API")
> Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Acked-by: Miroslav Benes <mbenes@suse.cz>
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Hi Sasha,

I am not sure what stable policy is, but the patch is for samples/ 
directory and I do not think it is something which should necessarily go 
to stable. It is your call though.

Regards,
Miroslav

> ---
>  samples/livepatch/livepatch-shadow-fix1.c | 5 +++++
>  samples/livepatch/livepatch-shadow-mod.c  | 4 ++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/samples/livepatch/livepatch-shadow-fix1.c b/samples/livepatch/livepatch-shadow-fix1.c
> index 49b13553eaae..e8f1bd6b29b1 100644
> --- a/samples/livepatch/livepatch-shadow-fix1.c
> +++ b/samples/livepatch/livepatch-shadow-fix1.c
> @@ -89,6 +89,11 @@ struct dummy *livepatch_fix1_dummy_alloc(void)
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
> index 4c54b250332d..4aa8a88d3cd6 100644
> --- a/samples/livepatch/livepatch-shadow-mod.c
> +++ b/samples/livepatch/livepatch-shadow-mod.c
> @@ -118,6 +118,10 @@ noinline struct dummy *dummy_alloc(void)
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
> -- 
> 2.19.1
> 

