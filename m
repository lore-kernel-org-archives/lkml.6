Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2DFC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A64C2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A64C2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbeLMOOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:14:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57192 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727707AbeLMOOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:14:19 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 83AFCC04BE30;
        Thu, 13 Dec 2018 14:14:19 +0000 (UTC)
Received: from jlaw-desktop.bos.csb (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9B3D600C5;
        Thu, 13 Dec 2018 14:14:18 +0000 (UTC)
Subject: Re: [PATCH 2/2 V2] livepatch: handle kzalloc failure properly
To:     Nicholas Mc Guire <hofrat@osadl.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1544709956-16701-1-git-send-email-hofrat@osadl.org>
 <1544709956-16701-2-git-send-email-hofrat@osadl.org>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Organization: Red Hat
Message-ID: <daf5bf66-3bcc-476c-6237-0e46028cb269@redhat.com>
Date:   Thu, 13 Dec 2018 09:14:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1544709956-16701-2-git-send-email-hofrat@osadl.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 13 Dec 2018 14:14:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/2018 09:05 AM, Nicholas Mc Guire wrote:
> kzalloc() return should be checked. On dummy_alloc() failing
> in kzalloc() NULL should be returned.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> ---
> 
> Problem was located with an experimental coccinelle script
> 
> V2: returning NULL is ok but not without cleanup - thanks to
>     Petr Mladek <pmladek@suse.com> for catching this.
> 
> Patch was compile tested with: x86_64_defconfig + FTRACE=y
> FUNCTION_TRACER=y, EXPERT=y, LATENCYTOP=y, SAMPLES=y, SAMPLE_LIVEPATCH=y
> (with a number of unrelated sparse warnings on symbols not being static)
> 
> Patch is against 4.20-rc6 (localversion-next is next-20181213)
> 
>  samples/livepatch/livepatch-shadow-mod.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/samples/livepatch/livepatch-shadow-mod.c b/samples/livepatch/livepatch-shadow-mod.c
> index 4c54b25..4aa8a88 100644
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
> 

Hi Nicholas,

Thanks for finding and fixing these up... can we either squash these two
patches into a single commit or give them unique subject lines?  Code
looks good (including Petr's suggested fix) otherwise.

-- Joe
