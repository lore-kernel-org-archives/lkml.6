Return-Path: <kernel-hardening-return-12108-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvIgNYgY2DtmxkhPx7qcGd31E++IF9Ws93y+741Q26VYu7ckthfU4WuPT1GMCMN0tZvrpvz
ARC-Seal: i=1; a=rsa-sha256; t=1520276439; cv=none;
        d=google.com; s=arc-20160816;
        b=oDY4WSFj7OfF7c0f3AtvcXMnIl1SdQdwk13o2o5O0MarwW2QFCGOkJo0Kat52mbmfr
         akPy41clfsH2bWyqBLSXjjjNK940yFvuUSM9cyW3IYjH8s8Kt0kL+B2F0O/yTOglsiYp
         qAamJCRSOpcPsXn5ojJ0ijoOdBpLcQ0eODu+PE2ld7nYyL+VtE2/vzp5VOWewLgdMYn1
         3PzlsC6Yli7Qr1D7VHnRyv41ssJBSBysqm9W0rhVFR/g1f1eH1dsNYnKU+mej+gZKGpB
         0GzQTLsy7fRzGQeM2dupZ5u4ws3LvhttHcBjDj8LhKRh765xezd8Q2hyEQbyQpfVazXF
         gBwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=49bpFsR4huWIYzQJ2AykurKnAUr4JOSqgVr0n9HMoxE=;
        b=1IILWXuALpiSXorjVDycIGlRXNWiM81+g4+rH4NPHIwpOGiYiitQO+OlLW1w82gxn8
         SH4+pIGNLVbRvzuFi1WPVdgatLwZvryyZ2YfKIobWlv+Cris6rWJzuQ6+Db9ikDRIdKF
         nCo/P+pjhl6SgXcjuWBpu3P2E0fmzgeXvVI7gXrUzFVCWXUuXdfqAPc5Cds56bXjzDdS
         S8h/I5EtxMSx5Gx5QW3A5uRxP+IOYAY1g1+LefcrLmDFo5IEzecD5B0YReliAREtOTJO
         AsxK/fqzmmte4HrDv7YVis/SsN7nsZJ1VeDDouWXUjTrykNZ+5TKxPn93Te0wWITdgjv
         S7iQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=f+n0heH4;
       spf=pass (google.com: domain of kernel-hardening-return-12108-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12108-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=f+n0heH4;
       spf=pass (google.com: domain of kernel-hardening-return-12108-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12108-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 1/7] genalloc: track beginning of allocations
To: Igor Stoppa <igor.stoppa@huawei.com>, david@fromorbit.com,
 willy@infradead.org, keescook@chromium.org, mhocko@kernel.org
Cc: labbott@redhat.com, linux-security-module@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com
References: <20180228200620.30026-1-igor.stoppa@huawei.com>
 <20180228200620.30026-2-igor.stoppa@huawei.com>
From: J Freyensee <why2jjj.linux@gmail.com>
Message-ID: <6a31164a-af3f-91ea-d385-7c6d1888b28c@gmail.com>
Date: Mon, 5 Mar 2018 11:00:08 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228200620.30026-2-igor.stoppa@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676614912638441?=
X-GMAIL-MSGID: =?utf-8?q?1594125387932659579?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

.
.


On 2/28/18 12:06 PM, Igor Stoppa wrote:
> +
> +/**
> + * gen_pool_dma_alloc() - allocate special memory from the pool for DMA usage
> + * @pool: pool to allocate from
> + * @size: number of bytes to allocate from the pool
> + * @dma: dma-view physical address return value.  Use NULL if unneeded.
> + *
> + * Allocate the requested number of bytes from the specified pool.
> + * Uses the pool allocation function (with first-fit algorithm by default).
> + * Can not be used in NMI handler on architectures without
> + * NMI-safe cmpxchg implementation.
> + *
> + * Return:
> + * * address of the memory allocated	- success
> + * * NULL				- error
> + */
> +void *gen_pool_dma_alloc(struct gen_pool *pool, size_t size, dma_addr_t *dma);
> +

OK, so gen_pool_dma_alloc() is defined here, which believe is the API 
line being drawn for this series.

so,
.
.
.
>
>   
>   /**
> - * gen_pool_dma_alloc - allocate special memory from the pool for DMA usage
> + * gen_pool_dma_alloc() - allocate special memory from the pool for DMA usage
>    * @pool: pool to allocate from
>    * @size: number of bytes to allocate from the pool
>    * @dma: dma-view physical address return value.  Use NULL if unneeded.
> @@ -342,14 +566,15 @@ EXPORT_SYMBOL(gen_pool_alloc_algo);
>    * Uses the pool allocation function (with first-fit algorithm by default).
>    * Can not be used in NMI handler on architectures without
>    * NMI-safe cmpxchg implementation.
> + *
> + * Return:
> + * * address of the memory allocated	- success
> + * * NULL				- error
>    */
>   void *gen_pool_dma_alloc(struct gen_pool *pool, size_t size, dma_addr_t *dma)
>   {
>   	unsigned long vaddr;
>   
> -	if (!pool)
> -		return NULL;
> -
why is this being removed?  I don't believe this code was getting 
removed from your v17 series patches.
>   	vaddr = gen_pool_alloc(pool, size);
>   	if (!vaddr)
>   		return NULL;
> @@ -362,10 +587,10 @@ void *gen_pool_dma_alloc(struct gen_pool *pool, size_t size, dma_addr_t *dma)
>   EXPORT_SYMBOL(gen_pool_dma_alloc);
>   
>
Otherwise, looks good,

Reviewed-by: Jay Freyensee <why2jjj.linux@gmail.com>
