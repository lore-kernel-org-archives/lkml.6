Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDEAC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C54216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84C54216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbeI0XMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:12:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:48168 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727437AbeI0XMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:12:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BED1FAFF2;
        Thu, 27 Sep 2018 16:53:23 +0000 (UTC)
Date:   Thu, 27 Sep 2018 18:53:23 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, thomas.lendacky@amd.com,
        bhelgaas@google.com, baiyaowei@cmss.chinamobile.com, tiwai@suse.de,
        brijesh.singh@amd.com, dyoung@redhat.com, bhe@redhat.com,
        jroedel@suse.de
Subject: Re: [PATCH v7 RESEND 2/4] kexec: allocate unencrypted control pages
 for kdump in case SME is enabled
Message-ID: <20180927165323.GC19779@zn.tnic>
References: <20180927071954.29615-1-lijiang@redhat.com>
 <20180927071954.29615-3-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180927071954.29615-3-lijiang@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 03:19:52PM +0800, Lianbo Jiang wrote:
> When SME is enabled in the first kernel, we will allocate unencrypted pages
> for kdump in order to be able to boot the kdump kernel like kexec.

This is not what the commit does - it marks the control pages as
decrypted when SME. Why doesn't the commit message state that and why is
this being done?

> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  kernel/kexec_core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 23a83a4da38a..e7efcd1a977b 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -471,6 +471,16 @@ static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
>  		}
>  	}
>  
> +	if (pages) {
> +		/*
> +		 * For kdump, we need to ensure that these pages are
> +		 * unencrypted pages if SME is enabled.

Remember to always call unencrypted pages "decrypted" - this is the
convention we agreed upon and it should keep the confusion level at
minimum to others staring at this code.

> +		 * By the way, it is unnecessary to call the arch_
> +		 * kexec_pre_free_pages(), which will make the code
> +		 * become more simple.
> +		 */

This second sentence I don't understand...

> +		arch_kexec_post_alloc_pages(page_address(pages), 1 << order, 0);
> +	}
>  	return pages;
>  }
>  
> @@ -867,6 +877,7 @@ static int kimage_load_crash_segment(struct kimage *image,
>  			result  = -ENOMEM;
>  			goto out;
>  		}
> +		arch_kexec_post_alloc_pages(page_address(page), 1, 0);
>  		ptr = kmap(page);
>  		ptr += maddr & ~PAGE_MASK;
>  		mchunk = min_t(size_t, mbytes,
> @@ -884,6 +895,7 @@ static int kimage_load_crash_segment(struct kimage *image,
>  			result = copy_from_user(ptr, buf, uchunk);
>  		kexec_flush_icache_page(page);
>  		kunmap(page);
> +		arch_kexec_pre_free_pages(page_address(page), 1);
>  		if (result) {
>  			result = -EFAULT;
>  			goto out;
> -- 
> 2.17.1
> 

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
