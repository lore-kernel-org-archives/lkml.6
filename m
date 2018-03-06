Return-Path: <kernel-hardening-return-12154-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsmtkaPHwMG5DqoAbIK3frQogYtyOxTWPO3B9e8KLpZe4WjwJdBVSv1GrPmWJVGacclHUtq
ARC-Seal: i=1; a=rsa-sha256; t=1520356829; cv=none;
        d=google.com; s=arc-20160816;
        b=IEm6lO1BRmF9x9rSO4b+1qSW6MU+kYit9QT6v8L0jhh+OSezp7DAbJ/X45XbOzKH2o
         TdqNIUnAKkBV3R9zbBpmGscm62y2eTDY1l6fvlyDYjfe3z5b1u5OpLwVNjisb1+orkk2
         jmDOu3X5mkeBD2pmYz5ZmI00rmbPTsAM8wF7DaVcBDefoGr+DunkdkbmrxaG8ebaYVRG
         SPK0Uw8c0lqQ7MZ3x8DYrhXFKA8k553VBWDnjhYp18cq+Ve5ajN+/0C4RsFY142C8VrN
         b/cnQ41bY7RQFibozdvjWFl+KqPK1mVD2zOYFcw8IK9u0qdZC9AAjPD93Fy9HuatuI/F
         LrrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=4ZownzUDtrY97MLskUPQVnSjwTn4V6B6F7ArBGM/nUM=;
        b=gU7BuLqMTpXICeRCdICAFaHR5zTJJhM1Xm/jLiPeSdZ9s8y3wVkP3pklA4KMLMZLWP
         rF1/gZCp1F1hXCewNYv/bDIgm9VCaF8qcJQENc4UKLAGxvaokDsG03EqiAbTjfOs0OPz
         tW2LxDaefEoY2OYfNDEVNCKfysZipXmRbLRDVNUnNcu44Y/cjGXwMf3/QyKMzsVP6ZX9
         8r9BWdJIcYAPPHUAFPdLfZeCdX/GEpnUjqjub5YqXyaXxN+FN/5kXPBawWegKep7tjjn
         /9dRGX4CgBzlUDSDcsL38rHnLBhZ5sDUHLwlcyEjfmA6t28iBD+hSy2e/5ziTMH7SZ/1
         Zq6w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=jTDB8pEL;
       spf=pass (google.com: domain of kernel-hardening-return-12154-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12154-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=jTDB8pEL;
       spf=pass (google.com: domain of kernel-hardening-return-12154-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12154-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 6/7] lkdtm: crash on overwriting protected pmalloc var
To: Igor Stoppa <igor.stoppa@huawei.com>, david@fromorbit.com,
 willy@infradead.org, keescook@chromium.org, mhocko@kernel.org
Cc: labbott@redhat.com, linux-security-module@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com
References: <20180228200620.30026-1-igor.stoppa@huawei.com>
 <20180228200620.30026-7-igor.stoppa@huawei.com>
From: J Freyensee <why2jjj.linux@gmail.com>
Message-ID: <1723ee8d-c89e-0704-c2c3-254eda39dc8b@gmail.com>
Date: Tue, 6 Mar 2018 09:20:04 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228200620.30026-7-igor.stoppa@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676876599291388?=
X-GMAIL-MSGID: =?utf-8?q?1594209682165483415?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 2/28/18 12:06 PM, Igor Stoppa wrote:
> Verify that pmalloc read-only protection is in place: trying to
> overwrite a protected variable will crash the kernel.
>
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
> ---
>   drivers/misc/lkdtm.h       |  1 +
>   drivers/misc/lkdtm_core.c  |  3 +++
>   drivers/misc/lkdtm_perms.c | 28 ++++++++++++++++++++++++++++
>   3 files changed, 32 insertions(+)
>
> diff --git a/drivers/misc/lkdtm.h b/drivers/misc/lkdtm.h
> index 9e513dcfd809..dcda3ae76ceb 100644
> --- a/drivers/misc/lkdtm.h
> +++ b/drivers/misc/lkdtm.h
> @@ -38,6 +38,7 @@ void lkdtm_READ_BUDDY_AFTER_FREE(void);
>   void __init lkdtm_perms_init(void);
>   void lkdtm_WRITE_RO(void);
>   void lkdtm_WRITE_RO_AFTER_INIT(void);
> +void lkdtm_WRITE_RO_PMALLOC(void);

Does this need some sort of #ifdef too?

>   void lkdtm_WRITE_KERN(void);
>   void lkdtm_EXEC_DATA(void);
>   void lkdtm_EXEC_STACK(void);
> diff --git a/drivers/misc/lkdtm_core.c b/drivers/misc/lkdtm_core.c
> index 2154d1bfd18b..c9fd42bda6ee 100644
> --- a/drivers/misc/lkdtm_core.c
> +++ b/drivers/misc/lkdtm_core.c
> @@ -155,6 +155,9 @@ static const struct crashtype crashtypes[] = {
>   	CRASHTYPE(ACCESS_USERSPACE),
>   	CRASHTYPE(WRITE_RO),
>   	CRASHTYPE(WRITE_RO_AFTER_INIT),
> +#ifdef CONFIG_PROTECTABLE_MEMORY
> +	CRASHTYPE(WRITE_RO_PMALLOC),
> +#endif
>   	CRASHTYPE(WRITE_KERN),
>   	CRASHTYPE(REFCOUNT_INC_OVERFLOW),
>   	CRASHTYPE(REFCOUNT_ADD_OVERFLOW),
> diff --git a/drivers/misc/lkdtm_perms.c b/drivers/misc/lkdtm_perms.c
> index 53b85c9d16b8..0ac9023fd2b0 100644
> --- a/drivers/misc/lkdtm_perms.c
> +++ b/drivers/misc/lkdtm_perms.c
> @@ -9,6 +9,7 @@
>   #include <linux/vmalloc.h>
>   #include <linux/mman.h>
>   #include <linux/uaccess.h>
> +#include <linux/pmalloc.h>
>   #include <asm/cacheflush.h>
>   
>   /* Whether or not to fill the target memory area with do_nothing(). */
> @@ -104,6 +105,33 @@ void lkdtm_WRITE_RO_AFTER_INIT(void)
>   	*ptr ^= 0xabcd1234;
>   }
>   
> +#ifdef CONFIG_PROTECTABLE_MEMORY
> +void lkdtm_WRITE_RO_PMALLOC(void)
> +{
> +	struct gen_pool *pool;
> +	int *i;
> +
> +	pool = pmalloc_create_pool("pool", 0);
> +	if (unlikely(!pool)) {
> +		pr_info("Failed preparing pool for pmalloc test.");
> +		return;
> +	}
> +
> +	i = (int *)pmalloc(pool, sizeof(int), GFP_KERNEL);
> +	if (unlikely(!i)) {
> +		pr_info("Failed allocating memory for pmalloc test.");
> +		pmalloc_destroy_pool(pool);
> +		return;
> +	}
> +
> +	*i = INT_MAX;
> +	pmalloc_protect_pool(pool);
> +
> +	pr_info("attempting bad pmalloc write at %p\n", i);
> +	*i = 0;

OK, now I'm on the right version of this patch series, same comment 
applies.  I don't get the local *i assignment at the end of the 
function, but seems harmless.

Except the two minor comments, otherwise,
Reviewed-by: Jay Freyensee <why2jjj.linux@gmail.com>

> +}
> +#endif
> +
>   void lkdtm_WRITE_KERN(void)
>   {
>   	size_t size;
