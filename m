Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A66DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 03:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A6420873
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 03:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfARDnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 22:43:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52074 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbfARDne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 22:43:34 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0E3F1C075BEB;
        Fri, 18 Jan 2019 03:43:34 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-21.pek2.redhat.com [10.72.12.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 32EA51974D;
        Fri, 18 Jan 2019 03:43:27 +0000 (UTC)
Date:   Fri, 18 Jan 2019 11:43:24 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, yinghai@kernel.org,
        vgoyal@redhat.com, Randy Dunlap <rdunlap@infradead.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190118034324.GA3512@dhcp-128-65.nay.redhat.com>
References: <1547539623-18201-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547539623-18201-1-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 18 Jan 2019 03:43:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pingfan, thanks for the post.

On 01/15/19 at 04:07pm, Pingfan Liu wrote:
> People reported a bug on a high end server with many pcie devices, where
> kernel bootup with crashkernel=384M, and kaslr is enabled. Even
> though we still see much memory under 896 MB, the finding still failed
> intermittently. Because currently we can only find region under 896 MB,
> if without ',high' specified. Then KASLR breaks 896 MB into several parts
> randomly, and crashkernel reservation need be aligned to 128 MB, that's
> why failure is found. It raises confusion to the end user that sometimes
> crashkernel=X works while sometimes fails.
> If want to make it succeed, customer can change kernel option to
> "crashkernel=384M,high". Just this give "crashkernel=xx@yy" a very
> limited space to behave even though its grammar looks more generic.
> And we can't answer questions raised from customer that confidently:
> 1) why it doesn't succeed to reserve 896 MB;
> 2) what's wrong with memory region under 4G;
> 3) why I have to add ',high', I only require 384 MB, not 3840 MB.
> This patch tries to get memory region from 896 MB firstly, then [896MB,4G],
> finally above 4G.

The patch log still looks not very good.  It needs some cleanup like
paragraph line breaks to make it more readable.

For example you can take like below:
--
People reported crashkernel=384M reservation failed on a high end server
with KASLR enabled.  In that case there is enough free memory under 896M
but crashkernel reservation still fails intermittently.

The situation is crashkernel reservation code only finds free region under
896 MB with 128M aligned in case no ',high' being used.  And KASLR could
break the first 896M into several parts randomly thus the failure happens.
User has no way to predict and make sure crashkernel=xM working unless
he/she use 'crashkernel=xM,high'.  Since 'crashkernel=xM' is the most
common use case this issue is a serious bug.

And we can't answer questions raised from customer:
1) why it doesn't succeed to reserve 896 MB;
2) what's wrong with memory region under 4G;
3) why I have to add ',high', I only require 384 MB, not 3840 MB.

This patch tries to get memory region from 896 MB firstly, then [896MB,4G],
finally above 4G.

> Dave Young sent the original post, and I just re-post it with commit log
> improvement as his requirement.
> http://lists.infradead.org/pipermail/kexec/2017-October/019571.html
> There was an old discussion below (previously posted by Chao Wang):
> https://lkml.org/lkml/2013/10/15/601

I hope someone else can provide review because I posted it previously.

But I think previously when I posted it is a good to have improvement,
but now it is a real serious bug which need to be fixed.  I can review
and ack if you can repost with a better log.

> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: yinghai@kernel.org,
> Cc: vgoyal@redhat.com
> Cc: Randy Dunlap <rdunlap@infradead.org>
> ---
> v6 -> v7: fix spelling mistake pointed out by Randy
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
>  		if (!crash_base) {
>  			pr_info("crashkernel reservation failed - No suitable area found.\n");
>  			return;
> -- 
> 2.7.4
> 

Thanks
Dave
