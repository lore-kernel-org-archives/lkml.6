Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8271CC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579BC20870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfAWO6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:58:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:37026 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725896AbfAWO6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:58:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E61DAAFDF;
        Wed, 23 Jan 2019 14:58:22 +0000 (UTC)
Date:   Wed, 23 Jan 2019 15:58:21 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Nicholas Mc Guire <hofrat@osadl.org>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] livepatch: fix size mismatch
In-Reply-To: <1548239476-21110-1-git-send-email-hofrat@osadl.org>
Message-ID: <alpine.LSU.2.21.1901231555270.31908@pobox.suse.cz>
References: <1548239476-21110-1-git-send-email-hofrat@osadl.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2019, Nicholas Mc Guire wrote:

> kzalloc(sizeof(int)) is called for an int object but then
> passed into klp_shadow_alloc() using the size of the pointer.
> This probably is not a problem as it will fit - but it should
> be cleaned (after all this is reference code). 
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> ---
> 
> Reported by coccicheck
> samples/livepatch//livepatch-shadow-fix1.c:97:30-36: ERROR: application of sizeof to pointer
> 
> Patch was compile tested with: x86_64_defconfig + FTRACE=y,
> FUNCTION_TRACER=y, SAMPLES=y, LIVEPATCH=y SAMPLE_LIVEPATCH=m 
> 
> Patch is against 5.0-rc3 (localversion-next is next-20190123)
> 
>  samples/livepatch/livepatch-shadow-fix1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/samples/livepatch/livepatch-shadow-fix1.c b/samples/livepatch/livepatch-shadow-fix1.c
> index a5a5cac..643ffd5 100644
> --- a/samples/livepatch/livepatch-shadow-fix1.c
> +++ b/samples/livepatch/livepatch-shadow-fix1.c
> @@ -94,7 +94,7 @@ struct dummy *livepatch_fix1_dummy_alloc(void)
>  		return NULL;
>  	}
>  
> -	klp_shadow_alloc(d, SV_LEAK, sizeof(leak), GFP_KERNEL,
> +	klp_shadow_alloc(d, SV_LEAK, sizeof(*leak), GFP_KERNEL,
>  			 shadow_leak_ctor, leak);

I think it is actually fine. We allocate something sizeof(int), but it is 
not important much. The leaked pointer is important. We attach the pointer 
as a shadow variable, so we can free it later. Thus, the size of the 
pointer is important.

Moreover, you're introducing this with the change:

samples/livepatch/livepatch-shadow-fix1.c:97:38: warning: expression using sizeof(void)

Miroslav
