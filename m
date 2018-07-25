Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38300C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E253A20893
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E253A20893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbeGYNnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 09:43:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728492AbeGYNnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 09:43:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DAD0840216E3;
        Wed, 25 Jul 2018 12:31:43 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-82.pek2.redhat.com [10.72.12.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CD7F2026D68;
        Wed, 25 Jul 2018 12:31:34 +0000 (UTC)
Date:   Wed, 25 Jul 2018 20:31:29 +0800
From:   Dave Young <dyoung@redhat.com>
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, bhe@redhat.com, arnd@arndb.de,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v12 04/16] powerpc, kexec_file: factor out memblock-based
 arch_kexec_walk_mem()
Message-ID: <20180725123129.GA2361@dhcp-128-65.nay.redhat.com>
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
 <20180724065759.19186-5-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724065759.19186-5-takahiro.akashi@linaro.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 25 Jul 2018 12:31:44 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 25 Jul 2018 12:31:44 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dyoung@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24/18 at 03:57pm, AKASHI Takahiro wrote:
> Memblock list is another source for usable system memory layout.
> So move powerpc's arch_kexec_walk_mem() to common code so that other
> memblock-based architectures, particularly arm64, can also utilise it.
> A moved function is now renamed to kexec_walk_memblock() and integrated
> into kexec_locate_mem_hole(), which will now be usable for all
> architectures with no need for overriding arch_kexec_walk_mem().
> 
> kexec_walk_memblock() will not work for kdump in this form, this will be
> fixed in the next patch.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Acked-by: James Morse <james.morse@arm.com>
> ---
>  arch/powerpc/kernel/machine_kexec_file_64.c | 54 -------------------
>  include/linux/kexec.h                       |  2 -
>  kernel/kexec_file.c                         | 58 ++++++++++++++++++++-
>  3 files changed, 56 insertions(+), 58 deletions(-)
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
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 49ab758f4d91..c196bfd11bee 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -184,8 +184,6 @@ int __weak arch_kexec_apply_relocations(struct purgatory_info *pi,
>  					const Elf_Shdr *relsec,
>  					const Elf_Shdr *symtab);
>  
> -int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
> -			       int (*func)(struct resource *, void *));
>  extern int kexec_add_buffer(struct kexec_buf *kbuf);
>  int kexec_locate_mem_hole(struct kexec_buf *kbuf);
>  
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index bf39df5e5bb9..2f0691b0f8ad 100644
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
> @@ -510,7 +560,7 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
>   * and that value will be returned. If all free regions are visited without
>   * func returning non-zero, then zero will be returned.
>   */
> -int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
> +static int arch_kexec_walk_mem(struct kexec_buf *kbuf,
>  			       int (*func)(struct resource *, void *))
>  {
>  	if (kbuf->image->type == KEXEC_TYPE_CRASH)
> @@ -538,7 +588,11 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
>  	if (kbuf->mem)
>  		return 0;
>  
> -	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
> +	if (IS_ENABLED(CONFIG_HAVE_MEMBLOCK) &&
> +			!IS_ENABLED(CONFIG_ARCH_DISCARD_MEMBLOCK))
> +		ret = kexec_walk_memblock(kbuf, locate_mem_hole_callback);
> +	else
> +		ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);

AKASHI, since it is not weak function now, it would be better to rename
the function for example name it as kexec_walk_resource()

Other than this,

Acked-by: Dave Young <dyoung@redhat.com>

>  
>  	return ret == 1 ? 0 : -EADDRNOTAVAIL;
>  }
> -- 
> 2.18.0
> 

Thanks
Dave
