Return-Path: <labbott@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517957352; cv=none;
        d=google.com; s=arc-20160816;
        b=WxvMzTBzXrGT3+9P9zQd8HP6GpmQ/AwGt04x3bSMa+zUMOn9FJYwkdOWSdoLEMIUW9
         C7CST3k3IF581yTNjcebHOw10R1cTNBwYyhgn3mfDQ6BCm6hmhMs95Lefkm70S86bHeF
         c7+7YMHXyEJx/tpclOsvUu4v1YBOzIfa1YImTo+IFJ+/AgpERKljiTCOxlNGlr6AsxGe
         HNAjdZDHp35qCXfL2kHHraUtSGv7CgcCHms0aw6sG8QXpu8I/z6MfIogN633mBTnbIyA
         hfYayhLkJWewJJ6Er35fMk0BOlkDKgTWOm4a/OHnDo2fKXFScrE9RN312+12VMENzDtt
         HxyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=XPB6dNZ8A+YPFr5lUMgHAE8B/Nk+PyGmYhmEkIXCMZQ=;
        b=KxxkMdM+DNXfVOh70l2b1dtILg9UJTuhd+6Qhv0f93YIXcn+Bcoz2T2BCgMOZF8kmq
         UuGcm4m7soFrz8W70dAvlEZ/nFpmyLrhXcUT6NTCPXthwlvFZU/b615kd8Px45g91sLS
         +rUsU9QXyFusf00om338XSomcXE8C1xVUVPv33Q89wqaPvtey/HxZFpE3zS/ETta0WNn
         3qzzN0EXL2t2WmYwtqoxdwnAFbz+OZE0vJjN/SajVBo8znw6Bc+ns/6BvfAtij1wiGSV
         x/A5hkMso1J61gHkB+0GHBqf5Q5xtFmJq3C8HB/D7kZyLl6+h7kAORrhpBYzbGVaq3lK
         DkkQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of labbott@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=labbott@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of labbott@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=labbott@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AH8x2254cjpWaLOklsjcH2tolfx299FqI641ey5jyoQg/2jljorQN04iOwunBDKWxI03rJgf+lIJvw==
Subject: Re: [PATCH v3] staging: android: ion: Zero CMA allocated memory
To: Liam Mark <lmark@codeaurora.org>, Sumit Semwal <sumit.semwal@linaro.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
 Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 devel@driverdev.osuosl.org, linaro-mm-sig@lists.linaro.org
References: <alpine.DEB.2.02.1801260942330.13788@lmark-linux.qualcomm.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <b7a28b0f-7f00-13a8-388a-e8802ba5dfc4@redhat.com>
Date: Tue, 6 Feb 2018 14:49:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1801260942330.13788@lmark-linux.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590678153366118365?=
X-GMAIL-MSGID: =?utf-8?q?1591693648791350091?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 01/26/2018 09:48 AM, Liam Mark wrote:
> Since commit 204f672255c2 ("staging: android: ion: Use CMA APIs directly")
> the CMA API is now used directly and therefore the allocated memory is no
> longer automatically zeroed.
> 
> Explicitly zero CMA allocated memory to ensure that no data is exposed to
> userspace.
> 

Acked-by: Laura Abbott <labbott@redhat.com>

> Fixes: 204f672255c2 ("staging: android: ion: Use CMA APIs directly")
> Signed-off-by: Liam Mark <lmark@codeaurora.org>
> ---
> Changes in v2:
>    - Clean up the commit message.
>    - Add 'Fixes:'
> 
> Changes in v3:
>   - Add support for highmem pages
> 
>   drivers/staging/android/ion/ion_cma_heap.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/staging/android/ion/ion_cma_heap.c b/drivers/staging/android/ion/ion_cma_heap.c
> index 86196ffd2faf..fa3e4b7e0c9f 100644
> --- a/drivers/staging/android/ion/ion_cma_heap.c
> +++ b/drivers/staging/android/ion/ion_cma_heap.c
> @@ -21,6 +21,7 @@
>   #include <linux/err.h>
>   #include <linux/cma.h>
>   #include <linux/scatterlist.h>
> +#include <linux/highmem.h>
>   
>   #include "ion.h"
>   
> @@ -51,6 +52,22 @@ static int ion_cma_allocate(struct ion_heap *heap, struct ion_buffer *buffer,
>   	if (!pages)
>   		return -ENOMEM;
>   
> +	if (PageHighMem(pages)) {
> +		unsigned long nr_clear_pages = nr_pages;
> +		struct page *page = pages;
> +
> +		while (nr_clear_pages > 0) {
> +			void *vaddr = kmap_atomic(page);
> +
> +			memset(vaddr, 0, PAGE_SIZE);
> +			kunmap_atomic(vaddr);
> +			page++;
> +			nr_clear_pages--;
> +		}
> +	} else {
> +		memset(page_address(pages), 0, size);
> +	}
> +
>   	table = kmalloc(sizeof(*table), GFP_KERNEL);
>   	if (!table)
>   		goto err;
> 
