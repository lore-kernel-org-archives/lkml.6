Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED683C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 04:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4EE120659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 04:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pSG2KbTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfANEYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 23:24:03 -0500
Received: from merlin.infradead.org ([205.233.59.134]:43596 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfANEYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 23:24:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RapyoANsZEgq8wZEnWtYjth+DkWWgcnZXvMTubFWxUM=; b=pSG2KbTW/TfQozAj6wqgFmH78T
        /mlEwNT9ePEyUe07z8a8VUipT+IsVSsYfpfb+1+FaKPMDf0m0TL6hBTj7LgFBSSzo2KIx3D6PJNKh
        f0bzhJZvmi13admggRxYK7V/gDaIMWFNu1XACc5aLuTUJyIJWlSAW443OI75ewHv3DF5rHBbe9zlZ
        wYLH4SCAnXWINYqtPoQDfl8wsLUVIk6QpU3D/KN4sphpuJegjOfN0UtLKqhr4QFnklULcKgRnuwyK
        Z+szdwERRjjJAxj+LUYXqmIqTaiWvVynn1anshllEu5xnqBN5x6hwZFdafcRrx3EgkMIwrOc4tgmr
        syzLGylQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gitmx-0002HH-Vn; Mon, 14 Jan 2019 04:23:52 +0000
Subject: Re: [PATCHv6] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
To:     Pingfan Liu <kernelfans@gmail.com>, kexec@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, yinghai@kernel.org,
        vgoyal@redhat.com
References: <1547435711-5786-1-git-send-email-kernelfans@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8206281c-c4e6-278a-899b-27cf9affd0da@infradead.org>
Date:   Sun, 13 Jan 2019 20:23:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1547435711-5786-1-git-send-email-kernelfans@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just fix a few of the commit log comments...

On 1/13/19 7:15 PM, Pingfan Liu wrote:
> People reported a bug on a high end server with many pcie devices, where
> kernel bootup with crashkernel=384M, and kaslr is enabled. Even
> though we still see much memory under 896 MB, the finding still failed
> intermittently. Because currently we can only find region under 896 MB,
> if w/0 ',high' specified. Then KASLR breaks 896 MB into several parts

  if w/o
or preferably:
  if without

> randomly, and crashkernel reservation need be aligned to 128 MB, that's
> why failure is found. It raises confusion to the end user that sometimes
> crashkernel=X works while sometimes fails.
> If want to make it succeed, customer can change kernel option to
> "crashkernel=384M, high". Just this give "crashkernel=xx@yy" a very

no space?  just
  "crashkernel=384M,high"

> limited space to behave even though its grammer looks more generic.

                                          grammar

> And we can't answer questions raised from customer that confidently:
> 1) why it doesn't succeed to reserve 896 MB;
> 2) what's wrong with memory region under 4G;
> 3) why I have to add ',high', I only require 384 MB, not 3840 MB.
> This patch tries to get memory region from 896 MB firstly, then [896MB,4G],
> finally above 4G.
> Dave Young sent the original post, and I just re-post it with commit log
> improvement as his requirement.
> http://lists.infradead.org/pipermail/kexec/2017-October/019571.html
> There was an old discussion below (previously posted by Chao Wang):
> https://lkml.org/lkml/2013/10/15/601
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: yinghai@kernel.org,
> Cc: vgoyal@redhat.com
> ---
> v5 -> v6
>   discard bottom-up allocation, just repost dyoung's original patch with commit log improved
> ---
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
> 

ciao.
-- 
~Randy
