Return-Path: <kernel-hardening-return-12125-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvY1UGUSVeDT4FhX2aJcg1qH5WtdS2+InjsP/sI1u8G+zlOCC+86XJMTJ9y+P4bo+rR/BH/
ARC-Seal: i=1; a=rsa-sha256; t=1520281898; cv=none;
        d=google.com; s=arc-20160816;
        b=jORwr+p+Z0QB+/GjlMEqOycTCKyXqgLiKmkjImp6z1UQjk1KewXKV3FbKSbnGRXrMT
         QhzsKVPNtStzcvLA7o1rYb66pvvSfyAytFBonXEeG0F56cafKSooM2+Lk3MsOtsNjMmA
         XhzHyGENzNaIqBLEdyvgh5Ye+xdSUOTrfEg7dMNLqv3gmyn93fVz6Hj6lUXQZU/7WLz0
         xCMfb4ZcGc/l1gbnpjKzFnu9dCVONb9D05Q/0vt84lT1yhoaJEIN4zsxJ7Tc8vKnmPMm
         eF1RfDWJdB41i74sn57Q4VbbkjXr/Ri6y35pTuzh2wwaF1tksp38vB3/DOvjZZY3Y5yU
         JyLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=VUrp/5iGo6Jn/cQLlgfCcg/sOhCebej0/Rk4FaO8zkU=;
        b=foWnAlooZEyfwokJNlqIRa+5zccVnAf7zLbrXch27zusDlyPSDcVXDWBTK9qk0UH9Q
         vk6kZg78yPnZiYVyfFCAKXU2Serlyg8WGXgJ+pHfAPnHKWw+R3SA4ByV8TptmIAjNjv+
         WwTqjshr1FLVbwwDA3p281vt14kICmOKJGLAT01eaGk+qMsdLHuFnmKxhaigq9Q6Xlfe
         C89wbK0vYXZDY8FLJIA0Yph+RPVaMcWRLdnYhXT2KJWQjQO/RgDQy+xdztxJpR1P/eR3
         IRAtltkuHifF4rjgfuXh1G2i0SsqepptNYhX5iXBOii0su1tbz1/R4Ifjrh6ZPb6sxC6
         4m0A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=iogGuQcV;
       spf=pass (google.com: domain of kernel-hardening-return-12125-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12125-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=iogGuQcV;
       spf=pass (google.com: domain of kernel-hardening-return-12125-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12125-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 3/7] struct page: add field for vm_struct
To: Igor Stoppa <igor.stoppa@huawei.com>, david@fromorbit.com,
 willy@infradead.org, keescook@chromium.org, mhocko@kernel.org
Cc: labbott@redhat.com, linux-security-module@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com
References: <20180228200620.30026-1-igor.stoppa@huawei.com>
 <20180228200620.30026-4-igor.stoppa@huawei.com>
From: J Freyensee <why2jjj.linux@gmail.com>
Message-ID: <2985e90a-5937-9432-c53e-f594b27e7afa@gmail.com>
Date: Mon, 5 Mar 2018 12:31:14 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228200620.30026-4-igor.stoppa@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676685422778336?=
X-GMAIL-MSGID: =?utf-8?q?1594131111486443129?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Reviewed-by: Jay Freyensee <why2jjj.linux@gmail.com>

On 2/28/18 12:06 PM, Igor Stoppa wrote:
> When a page is used for virtual memory, it is often necessary to obtain
> a handler to the corresponding vm_struct, which refers to the virtually
> continuous area generated when invoking vmalloc.
>
> The struct page has a "mapping" field, which can be re-used, to store a
> pointer to the parent area.
>
> This will avoid more expensive searches, later on.
>
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
> ---
>   include/linux/mm_types.h | 1 +
>   mm/vmalloc.c             | 2 ++
>   2 files changed, 3 insertions(+)
>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index fd1af6b9591d..c3a4825e10c0 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -84,6 +84,7 @@ struct page {
>   		void *s_mem;			/* slab first object */
>   		atomic_t compound_mapcount;	/* first tail page */
>   		/* page_deferred_list().next	 -- second tail page */
> +		struct vm_struct *area;
>   	};
>   
>   	/* Second double word */
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index ebff729cc956..61a1ca22b0f6 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1536,6 +1536,7 @@ static void __vunmap(const void *addr, int deallocate_pages)
>   			struct page *page = area->pages[i];
>   
>   			BUG_ON(!page);
> +			page->area = NULL;
>   			__free_pages(page, 0);
>   		}
>   
> @@ -1705,6 +1706,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>   			area->nr_pages = i;
>   			goto fail;
>   		}
> +		page->area = area;
>   		area->pages[i] = page;
>   		if (gfpflags_allow_blocking(gfp_mask|highmem_mask))
>   			cond_resched();
