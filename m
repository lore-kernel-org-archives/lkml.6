Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17A2C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793362084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbfAUHn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:43:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39024 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728477AbfAUHnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:43:55 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 23DAF811D3;
        Mon, 21 Jan 2019 06:24:42 +0000 (UTC)
Received: from localhost (ovpn-12-168.pek2.redhat.com [10.72.12.168])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E70C5D6AA;
        Mon, 21 Jan 2019 06:24:38 +0000 (UTC)
Date:   Mon, 21 Jan 2019 14:24:35 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, yinghai@kernel.org,
        vgoyal@redhat.com, Randy Dunlap <rdunlap@infradead.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190121062435.GA23371@MiWiFi-R3L-srv>
References: <1548047768-7656-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548047768-7656-1-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 21 Jan 2019 06:24:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/21/19 at 01:16pm, Pingfan Liu wrote:
> People reported crashkernel=384M reservation failed on a high end server
> with KASLR enabled.  In that case there is enough free memory under 896M
> but crashkernel reservation still fails intermittently.
> 
> The situation is crashkernel reservation code only finds free region under
> 896 MB with 128M aligned in case no ',high' being used.  And KASLR could
> break the first 896M into several parts randomly thus the failure happens.
> User has no way to predict and make sure crashkernel=xM working unless
> he/she use 'crashkernel=xM,high'.  Since 'crashkernel=xM' is the most
> common use case this issue is a serious bug.
> 
> And we can't answer questions raised from customer:
> 1) why it doesn't succeed to reserve 896 MB;
> 2) what's wrong with memory region under 4G;
> 3) why I have to add ',high', I only require 384 MB, not 3840 MB.
> 
> This patch tries to get memory region from 896 MB firstly, then [896MB,4G],
> finally above 4G.
> 
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
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org

Looks good, ack.

Acked-by: Baoquan He <bhe@redhat.com>

Thanks
Baoquan

> ---
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
>  		if (!crash_base) {
>  			pr_info("crashkernel reservation failed - No suitable area found.\n");
>  			return;
> -- 
> 2.7.4
> 
