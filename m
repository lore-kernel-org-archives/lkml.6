Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5A4ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 01:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F2D2089F
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 01:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71F2D2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731946AbeGNCJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 22:09:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731042AbeGNCJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 22:09:57 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D0381402332F;
        Sat, 14 Jul 2018 01:52:44 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-52.pek2.redhat.com [10.72.12.52])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D02F810FFE54;
        Sat, 14 Jul 2018 01:52:33 +0000 (UTC)
Date:   Sat, 14 Jul 2018 09:52:23 +0800
From:   Dave Young <dyoung@redhat.com>
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, bhe@redhat.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v11 03/15] powerpc, kexec_file: factor out memblock-based
 arch_kexec_walk_mem()
Message-ID: <20180714015223.GA2745@dhcp-128-65.nay.redhat.com>
References: <20180711074203.3019-1-takahiro.akashi@linaro.org>
 <20180711074203.3019-4-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711074203.3019-4-takahiro.akashi@linaro.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Sat, 14 Jul 2018 01:52:44 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Sat, 14 Jul 2018 01:52:44 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dyoung@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/18 at 04:41pm, AKASHI Takahiro wrote:
> Memblock list is another source for usable system memory layout.
> So powerpc's arch_kexec_walk_mem() is moved to kexec_file.c so that
> other memblock-based architectures, particularly arm64, can also utilise
> it. A moved function is now renamed to kexec_walk_memblock() and merged
> into the existing arch_kexec_walk_mem() for general use, either resource
> list or memblock list.
> 
> A consequent function will not work for kdump with memblock list, but
> this will be fixed in the next patch.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Acked-by: James Morse <james.morse@arm.com>
> ---
>  arch/powerpc/kernel/machine_kexec_file_64.c | 54 ---------------------
>  kernel/kexec_file.c                         | 54 +++++++++++++++++++++
>  2 files changed, 54 insertions(+), 54 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/machine_kexec_file_64.c b/arch/powerpc/kernel/machine_kexec_file_64.c
> index 0bd23dc789a4..5357b09902c5 100644
> --- a/arch/powerpc/kernel/machine_kexec_file_64.c
> +++ b/arch/powerpc/kernel/machine_kexec_file_64.c
> @@ -24,7 +24,6 @@
>  
>  #include <linux/slab.h>
>  #include <linux/kexec.h>
> -#include <linux/memblock.h>
>  #include <linux/of_fdt.h>
>  #include <linux/libfdt.h>
>  #include <asm/ima.h>
> @@ -46,59 +45,6 @@ int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
>  	return kexec_image_probe_default(image, buf, buf_len);
>  }
>  
> -/**
> - * arch_kexec_walk_mem - call func(data) for each unreserved memory block
> - * @kbuf:	Context info for the search. Also passed to @func.
> - * @func:	Function to call for each memory block.
> - *
> - * This function is used by kexec_add_buffer and kexec_locate_mem_hole
> - * to find unreserved memory to load kexec segments into.
> - *
> - * Return: The memory walk will stop when func returns a non-zero value
> - * and that value will be returned. If all free regions are visited without
> - * func returning non-zero, then zero will be returned.
> - */
> -int arch_kexec_walk_mem(struct kexec_buf *kbuf,
> -			int (*func)(struct resource *, void *))
> -{
> -	int ret = 0;
> -	u64 i;
> -	phys_addr_t mstart, mend;
> -	struct resource res = { };
> -
> -	if (kbuf->top_down) {
> -		for_each_free_mem_range_reverse(i, NUMA_NO_NODE, 0,
> -						&mstart, &mend, NULL) {
> -			/*
> -			 * In memblock, end points to the first byte after the
> -			 * range while in kexec, end points to the last byte
> -			 * in the range.
> -			 */
> -			res.start = mstart;
> -			res.end = mend - 1;
> -			ret = func(&res, kbuf);
> -			if (ret)
> -				break;
> -		}
> -	} else {
> -		for_each_free_mem_range(i, NUMA_NO_NODE, 0, &mstart, &mend,
> -					NULL) {
> -			/*
> -			 * In memblock, end points to the first byte after the
> -			 * range while in kexec, end points to the last byte
> -			 * in the range.
> -			 */
> -			res.start = mstart;
> -			res.end = mend - 1;
> -			ret = func(&res, kbuf);
> -			if (ret)
> -				break;
> -		}
> -	}
> -
> -	return ret;
> -}
> -
>  /**
>   * setup_purgatory - initialize the purgatory's global variables
>   * @image:		kexec image.
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 63c7ce1c0c3e..b088324fb3ad 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -16,6 +16,7 @@
>  #include <linux/file.h>
>  #include <linux/slab.h>
>  #include <linux/kexec.h>
> +#include <linux/memblock.h>
>  #include <linux/mutex.h>
>  #include <linux/list.h>
>  #include <linux/fs.h>
> @@ -501,6 +502,55 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
>  	return locate_mem_hole_bottom_up(start, end, kbuf);
>  }
>  
> +#if defined(CONFIG_HAVE_MEMBLOCK) && !defined(CONFIG_ARCH_DISCARD_MEMBLOCK)
> +static int kexec_walk_memblock(struct kexec_buf *kbuf,
> +			       int (*func)(struct resource *, void *))
> +{
> +	int ret = 0;
> +	u64 i;
> +	phys_addr_t mstart, mend;
> +	struct resource res = { };
> +
> +	if (kbuf->top_down) {
> +		for_each_free_mem_range_reverse(i, NUMA_NO_NODE, 0,
> +						&mstart, &mend, NULL) {
> +			/*
> +			 * In memblock, end points to the first byte after the
> +			 * range while in kexec, end points to the last byte
> +			 * in the range.
> +			 */
> +			res.start = mstart;
> +			res.end = mend - 1;
> +			ret = func(&res, kbuf);
> +			if (ret)
> +				break;
> +		}
> +	} else {
> +		for_each_free_mem_range(i, NUMA_NO_NODE, 0, &mstart, &mend,
> +					NULL) {
> +			/*
> +			 * In memblock, end points to the first byte after the
> +			 * range while in kexec, end points to the last byte
> +			 * in the range.
> +			 */
> +			res.start = mstart;
> +			res.end = mend - 1;
> +			ret = func(&res, kbuf);
> +			if (ret)
> +				break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +#else
> +static int kexec_walk_memblock(struct kexec_buf *kbuf,
> +			       int (*func)(struct resource *, void *))
> +{
> +	return 0;
> +}
> +#endif
> +
>  /**
>   * arch_kexec_walk_mem - call func(data) on free memory regions
>   * @kbuf:	Context info for the search. Also passed to @func.
> @@ -513,6 +563,10 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
>  int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
>  			       int (*func)(struct resource *, void *))
>  {
> +	if (IS_ENABLED(CONFIG_HAVE_MEMBLOCK) &&
> +			!IS_ENABLED(CONFIG_ARCH_DISCARD_MEMBLOCK))
> +		return kexec_walk_memblock(kbuf, func);

AKASHI, I'm not sure if this works on all arches, for example I chekced
the .config on my Nokia N900 kernel tree, there is HAVE_MEMBLOCK=y and
no CONFIG_ARCH_DISCARD_MEMBLOCK,  in 32bit arm code no
arch_kexec_walk_mem() 

> +
>  	if (kbuf->image->type == KEXEC_TYPE_CRASH)
>  		return walk_iomem_res_desc(crashk_res.desc,
>  					   IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> -- 
> 2.17.0
> 

Thanks
Dave
