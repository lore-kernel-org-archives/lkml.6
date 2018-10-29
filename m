Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BB9C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC762084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC762084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbeJ2Udn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 16:33:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60346 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728043AbeJ2Udm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 16:33:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 62232307EA9E;
        Mon, 29 Oct 2018 11:45:22 +0000 (UTC)
Received: from crecklin.bos.csb (dhcp-17-195.bos.redhat.com [10.18.17.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E71465EE1D;
        Mon, 29 Oct 2018 11:45:15 +0000 (UTC)
Reply-To: crecklin@redhat.com
Subject: Re: [PATCH 09/17] prmem: hardened usercopy
To:     Igor Stoppa <igor.stoppa@gmail.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     igor.stoppa@huawei.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-10-igor.stoppa@huawei.com>
From:   Chris von Recklinghausen <crecklin@redhat.com>
Organization: Red Hat
Message-ID: <cd768a99-5afa-999c-989a-efee66fa0ddb@redhat.com>
Date:   Mon, 29 Oct 2018 07:45:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181023213504.28905-10-igor.stoppa@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 29 Oct 2018 11:45:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/2018 05:34 PM, Igor Stoppa wrote:
> Prevent leaks of protected memory to userspace.
> The protection from overwrited from userspace is already available, once
> the memory is write protected.
>
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
> CC: Kees Cook <keescook@chromium.org>
> CC: Chris von Recklinghausen <crecklin@redhat.com>
> CC: linux-mm@kvack.org
> CC: linux-kernel@vger.kernel.org
> ---
>  include/linux/prmem.h | 24 ++++++++++++++++++++++++
>  mm/usercopy.c         |  5 +++++
>  2 files changed, 29 insertions(+)
>
> diff --git a/include/linux/prmem.h b/include/linux/prmem.h
> index cf713fc1c8bb..919d853ddc15 100644
> --- a/include/linux/prmem.h
> +++ b/include/linux/prmem.h
> @@ -273,6 +273,30 @@ struct pmalloc_pool {
>  	uint8_t mode;
>  };
>  
> +void __noreturn usercopy_abort(const char *name, const char *detail,
> +			       bool to_user, unsigned long offset,
> +			       unsigned long len);
> +
> +/**
> + * check_pmalloc_object() - helper for hardened usercopy
> + * @ptr: the beginning of the memory to check
> + * @n: the size of the memory to check
> + * @to_user: copy to userspace or from userspace
> + *
> + * If the check is ok, it will fall-through, otherwise it will abort.
> + * The function is inlined, to minimize the performance impact of the
> + * extra check that can end up on a hot path.
> + * Non-exhaustive micro benchmarking with QEMU x86_64 shows a reduction of
> + * the time spent in this fragment by 60%, when inlined.
> + */
> +static inline
> +void check_pmalloc_object(const void *ptr, unsigned long n, bool to_user)
> +{
> +	if (unlikely(__is_wr_after_init(ptr, n) || __is_wr_pool(ptr, n)))
> +		usercopy_abort("pmalloc", "accessing pmalloc obj", to_user,
> +			       (const unsigned long)ptr, n);
> +}
> +
>  /*
>   * The write rare functionality is fully implemented as __always_inline,
>   * to prevent having an internal function call that is capable of modifying
> diff --git a/mm/usercopy.c b/mm/usercopy.c
> index 852eb4e53f06..a080dd37b684 100644
> --- a/mm/usercopy.c
> +++ b/mm/usercopy.c
> @@ -22,8 +22,10 @@
>  #include <linux/thread_info.h>
>  #include <linux/atomic.h>
>  #include <linux/jump_label.h>
> +#include <linux/prmem.h>
>  #include <asm/sections.h>
>  
> +
>  /*
>   * Checks if a given pointer and length is contained by the current
>   * stack frame (if possible).
> @@ -284,6 +286,9 @@ void __check_object_size(const void *ptr, unsigned long n, bool to_user)
>  
>  	/* Check for object in kernel to avoid text exposure. */
>  	check_kernel_text_object((const unsigned long)ptr, n, to_user);
> +
> +	/* Check if object is from a pmalloc chunk. */
> +	check_pmalloc_object(ptr, n, to_user);
>  }
>  EXPORT_SYMBOL(__check_object_size);
>  

Could you add code somewhere (lkdtm driver if possible) to demonstrate
the issue and verify the code change?

Thanks,

Chris

