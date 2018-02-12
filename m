Return-Path: <xieyisheng1@huawei.com>
X-Google-Smtp-Source: AH8x227aXjqVC0LIECwIH7+laVTqisiyFKCg3uX5iuP5PKtP38oOHwik6tQrAIwsN0oH3orpt7qE
ARC-Seal: i=1; a=rsa-sha256; t=1518433678; cv=none;
        d=google.com; s=arc-20160816;
        b=Z5SfpQ7kZq9OvenO/7ml55UlWpFODXDMre/8H4l6z0GJVqBEVyOnPtjJ0S7Ux/g8zw
         RCLz58866gv0VW/ppPsHq+prPreN8xgJr3RH5E/695wTns9NTLfBKx86uBpssescqDeE
         QZn8aIZqTaU5NZYAVo1Ap/qO0IBRXGgq8DISjOyWavbEd4TCdGcxNRt3j2TbqlK8QdWc
         fYpDn+0u+2gWJp5S+je+dSxrY4QNqaf18FpcvYNgqiApGukw4oLCP+myzgYCswhWjmx+
         3h5hey2U+Q+8RTtwBRCCF61tPV7WdKLVmmIIvZEaF/1vQIOXwbftal54K19WLi0fqAK7
         anyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=LOHDMFeStRVXidTasnNvqiyRFmNBR2fIJtWQmcqmo68=;
        b=A/Jy3u511k8c19PYKL0aRqzpLjZq0zKf259Dwf5dMkf0Ak6LvLSOq41k6GOz3eWgIz
         K0S7+DN5PoiPO6BSeBvc/jt18YB2OwFZqcbCBcniwPPS+5UOaKJi9WyEv1lVQ1qhGkLC
         mE6zpIRj3OaGtsGclBr7BbeomYkEduHtSZGKfrjGcuUzbDA/GheZnaA1o8qd+EYrKUyw
         EwN0pTjUBbmsZX/OP6kEXHp+/iSEXDTZxgJKemZ2lBcID0ZTLnD/q0pZ/H1a6+RzKtsK
         sv5sY1tDVn4TaJaNaHvAzal2d+hhGAbCTungHyYvRkWFx1O4NZ1Nk3wUdbipgcaOR/bL
         jccw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of xieyisheng1@huawei.com designates 45.249.212.190 as permitted sender) smtp.mailfrom=xieyisheng1@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of xieyisheng1@huawei.com designates 45.249.212.190 as permitted sender) smtp.mailfrom=xieyisheng1@huawei.com
Subject: Re: [PATCH v6] devres: combine function devm_ioremap*
To: <gregkh@linuxfoundation.org>
References: <1517226496-32324-1-git-send-email-xieyisheng1@huawei.com>
CC: <christophe.leroy@c-s.fr>, <thomas.lendacky@amd.com>,
	<linux-kernel@vger.kernel.org>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <db6ce14b-455f-034b-48a3-199cdc493479@huawei.com>
Date: Mon, 12 Feb 2018 19:07:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <1517226496-32324-1-git-send-email-xieyisheng1@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590927888769516575?=
X-GMAIL-MSGID: =?utf-8?q?1592193112719524775?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg, Christophe,

Any comment about this version?  And sorry to disturb  :)

Thanks
Yisheng

On 2018/1/29 19:48, Yisheng Xie wrote:
> When I tried to use devm_ioremap function and review related
> code, I found devm_ioremap_* almost have the similar realize
> with each other, which can be combined.
> 
> In the former version, I have tried to kill ioremap_cache to
> reduce the size of devres, which can not work for ioremap is
> not the same as ioremap_nocache in some ARCHs likes ia64.
> Therefore, as the suggestion of Christophe, I introduce a help
> function __devm_ioremap, let devm_ioremap* inline and call
> __devm_ioremap with different devm_ioremap_type.
> 
> After apply the patch, the size of devres.o can be reduce from
> 8216 Bytes to 8052 Bytes in my compile environment.
> 
> Suggested-by: Greg KH <gregkh@linuxfoundation.org>
> Suggested-by: Christophe LEROY <christophe.leroy@c-s.fr>
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
> v2:
>  - use MARCO for ioremap
> v3:
>  - kill dev_ioremap_nocache
> v4:
>  - combine function devm_ioremap*       - per Christophe
> v5:
>  - fix code style.                      - per Christophe
> v6:
>  - just put the cleanup in the devres.c - per Greg
> 
>  lib/devres.c | 78 +++++++++++++++++++++++++++++-------------------------------
>  1 file changed, 38 insertions(+), 40 deletions(-)
> 
> diff --git a/lib/devres.c b/lib/devres.c
> index 5f2aedd..5bec112 100644
> --- a/lib/devres.c
> +++ b/lib/devres.c
> @@ -5,6 +5,12 @@
>  #include <linux/gfp.h>
>  #include <linux/export.h>
>  
> +enum devm_ioremap_type {
> +	DEVM_IOREMAP = 0,
> +	DEVM_IOREMAP_NC,
> +	DEVM_IOREMAP_WC,
> +};
> +
>  void devm_ioremap_release(struct device *dev, void *res)
>  {
>  	iounmap(*(void __iomem **)res);
> @@ -15,24 +21,28 @@ static int devm_ioremap_match(struct device *dev, void *res, void *match_data)
>  	return *(void **)res == match_data;
>  }
>  
> -/**
> - * devm_ioremap - Managed ioremap()
> - * @dev: Generic device to remap IO address for
> - * @offset: Resource address to map
> - * @size: Size of map
> - *
> - * Managed ioremap().  Map is automatically unmapped on driver detach.
> - */
> -void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
> -			   resource_size_t size)
> +static void __iomem *__devm_ioremap(struct device *dev, resource_size_t offset,
> +				    resource_size_t size,
> +				    enum devm_ioremap_type type)
>  {
> -	void __iomem **ptr, *addr;
> +	void __iomem **ptr, *addr = NULL;
>  
>  	ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
>  	if (!ptr)
>  		return NULL;
>  
> -	addr = ioremap(offset, size);
> +	switch (type) {
> +	case DEVM_IOREMAP:
> +		addr = ioremap(offset, size);
> +		break;
> +	case DEVM_IOREMAP_NC:
> +		addr = ioremap_nocache(offset, size);
> +		break;
> +	case DEVM_IOREMAP_WC:
> +		addr = ioremap_wc(offset, size);
> +		break;
> +	}
> +
>  	if (addr) {
>  		*ptr = addr;
>  		devres_add(dev, ptr);
> @@ -41,6 +51,20 @@ void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
>  
>  	return addr;
>  }
> +
> +/**
> + * devm_ioremap - Managed ioremap()
> + * @dev: Generic device to remap IO address for
> + * @offset: Resource address to map
> + * @size: Size of map
> + *
> + * Managed ioremap().  Map is automatically unmapped on driver detach.
> + */
> +void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
> +			   resource_size_t size)
> +{
> +	return __devm_ioremap(dev, offset, size, DEVM_IOREMAP);
> +}
>  EXPORT_SYMBOL(devm_ioremap);
>  
>  /**
> @@ -55,20 +79,7 @@ void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
>  void __iomem *devm_ioremap_nocache(struct device *dev, resource_size_t offset,
>  				   resource_size_t size)
>  {
> -	void __iomem **ptr, *addr;
> -
> -	ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
> -	if (!ptr)
> -		return NULL;
> -
> -	addr = ioremap_nocache(offset, size);
> -	if (addr) {
> -		*ptr = addr;
> -		devres_add(dev, ptr);
> -	} else
> -		devres_free(ptr);
> -
> -	return addr;
> +	return __devm_ioremap(dev, offset, size, DEVM_IOREMAP_NC);
>  }
>  EXPORT_SYMBOL(devm_ioremap_nocache);
>  
> @@ -83,20 +94,7 @@ void __iomem *devm_ioremap_nocache(struct device *dev, resource_size_t offset,
>  void __iomem *devm_ioremap_wc(struct device *dev, resource_size_t offset,
>  			      resource_size_t size)
>  {
> -	void __iomem **ptr, *addr;
> -
> -	ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
> -	if (!ptr)
> -		return NULL;
> -
> -	addr = ioremap_wc(offset, size);
> -	if (addr) {
> -		*ptr = addr;
> -		devres_add(dev, ptr);
> -	} else
> -		devres_free(ptr);
> -
> -	return addr;
> +	return __devm_ioremap(dev, offset, size, DEVM_IOREMAP_WC);
>  }
>  EXPORT_SYMBOL(devm_ioremap_wc);
>  
> 
