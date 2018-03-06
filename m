Return-Path: <kernel-hardening-return-12151-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELssxelsP3HjNatlGXUIDIYh+mEAwvPBlLYZwOLG4oPh3NWpR85/hN7vvUuluN7v5kEWH25A
ARC-Seal: i=1; a=rsa-sha256; t=1520355925; cv=none;
        d=google.com; s=arc-20160816;
        b=Fx/7Jce+CzaNkG4cxTJtrs/AfMn08oszjlq4QGF7+V/dLgijhm7gOcNvamDTyq10nh
         E7ewQLazJd9ytFtB6kAU+RETm/4K5wlux36xAg360Bsb8PXbJ7OvPgDgUx/pGBWzLoB+
         64rUPIk2fPqhezIfxtwHvXXWK1fyqj9GQvUQ8mLWFHigiFYOKUq660Pv0lwsfaV+x9Bl
         bvND91YZlVOyxoGqcpHkXsiS3Sed49q37iLYk0N/rZbJ+mz8gfXiRf9fjqxl/Bet0NdB
         r4Io0LmLCnS9Nv8M73WCLEKWgAg5w0CgF6CyvI4Hd/lDRn/xTD0vfyyQi5uIEYY0a6J6
         sv7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=SuH60IXKqWHwDnkZajtnxLO/0O+jnZKf+3QEkx/nyPk=;
        b=d6Wbz3q/wlAS6+nboIcbGVPomQyAH/0kLF/1K7BgxOdq7MSu81bEeGrDg0L2vmX8m2
         xkncC0rxTjkQCxat4+tHs0C4Yv9IAajA2e7YsU4401tpgw/1JGK5j68QrYXMgKLwSWtF
         FL9CjRCqEC3HsUNO1NZPnD3Uowd1bGQu3eTImdLEhHxn5gycb+yovX4TyTJ73PB8efPw
         Pj01BSrtYdwTPVwmFv76IrdreQTPcLI9MsZVXiLBR67ApUoFwgmGYgQ2+2KFR8VbcoAF
         yJN/ADvIe3wIIgww1vc4QJxJTYo7QcUJqzmv2fkCeTjg/QYBVKf17mUuFxlhjzkLj97Z
         qFhw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=aXLfW22G;
       spf=pass (google.com: domain of kernel-hardening-return-12151-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12151-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=aXLfW22G;
       spf=pass (google.com: domain of kernel-hardening-return-12151-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12151-gregkh=linuxfoundation.org@lists.openwall.com;
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
References: <20180223144807.1180-1-igor.stoppa@huawei.com>
 <20180223144807.1180-7-igor.stoppa@huawei.com>
From: J Freyensee <why2jjj.linux@gmail.com>
Message-ID: <1120e8fd-2f48-5b1f-7072-9bd8e2b82fbf@gmail.com>
Date: Tue, 6 Mar 2018 09:05:00 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180223144807.1180-7-igor.stoppa@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593203814128727346?=
X-GMAIL-MSGID: =?utf-8?q?1594208735229027191?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


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

Seems harmless, but I don't get why *i local variable needs to be set to 
0 at the end of this function.


Otherwise,

Reviewed-by: Jay Freyensee <why2jjj.linux@gmail.com>
