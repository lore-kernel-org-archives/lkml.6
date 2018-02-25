Return-Path: <kernel-hardening-return-11944-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvn5c3a+s42ChCalPHradSgnZmUnhtoaH6Xq/lQxTayJtTBy2klSxkRByM7pvoqi6kcG4YR
ARC-Seal: i=1; a=rsa-sha256; t=1519529916; cv=none;
        d=google.com; s=arc-20160816;
        b=ylXHZXgh7UCXm5oq3hHaLoSf2+yWKXNYEceerG0QYulmqWnpVLo10VbWe4poE108Rw
         ZKrXj4VxjktBytZQspTQbmmzo6WVbIAbtQ9yPdJDNDsTF7PvQf5JWjbJIuKknIeR0zz5
         3GX5oOvsRt6gvjCUo6P3FSwMcM5feUcG2EJU7tDvASsiEcRHXcXBzDCkEeLYSTa03Zyl
         3r2gHnSe+Jmc9ZJHI9GmE6c00NLKaPcgtnX33yqW1wNySjZEUxUGm2ahcYnxptQ4S4zK
         ozb0xYVTTs39iXP7Wp4lnVJYyGpuK4/QSYUDu5RXk+UnDTnYUfo9SiBt3SWOkksOUP7/
         HCtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=4/dtwn+Flq13QVge5PlFOxh6BEBmhSdtgjeSlxz0pNw=;
        b=UYXssfHs1br+IqCql2iNXoLrHau9IGmfdpbyW5m8KNEsILrW7jOZs5dOeg6iek49Kn
         KGP1pTEVB7AM8u+ciKIZXPPC6b++BlC6rwQnyXUDUHy7RKlYDyikMMtnDja/rOlkYj/R
         6wP0FdI7L47bHLiomVVwc/7YjDPDNJAVh2x5gzic0/aLSkkFT9/5wEfXg4Sz43VrxRmw
         gLTAgV9phetBGhi1cVKHbDbjaiFyuQZtyG1Liaqt7jveSBsII90fQrHBk/zGbW/sej0X
         vds9QWJSYL9zNWi1nrOuvhhzqem+kqkUAD0GjeOtPSItQMV7HwITLqzpSubgsyE7r5tK
         xxrA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=q1BCobp9;
       spf=pass (google.com: domain of kernel-hardening-return-11944-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11944-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=q1BCobp9;
       spf=pass (google.com: domain of kernel-hardening-return-11944-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11944-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Sat, 24 Feb 2018 19:38:08 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: david@fromorbit.com, keescook@chromium.org, mhocko@kernel.org,
	labbott@redhat.com, linux-security-module@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 3/7] struct page: add field for vm_struct
Message-ID: <20180225033808.GB15796@bombadil.infradead.org>
References: <20180223144807.1180-1-igor.stoppa@huawei.com>
 <20180223144807.1180-4-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223144807.1180-4-igor.stoppa@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593203701882872070?=
X-GMAIL-MSGID: =?utf-8?q?1593342601709805020?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 04:48:03PM +0200, Igor Stoppa wrote:
> @@ -1769,6 +1771,9 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>  
>  	kmemleak_vmalloc(area, size, gfp_mask);
>  
> +	for (i = 0; i < area->nr_pages; i++)
> +		area->pages[i]->area = area;
> +
>  	return addr;
>  
>  fail:

IMO, this is the wrong place to initialise the page->area.  It should be
done in __vmalloc_area_node() like so:

                        area->nr_pages = i;
                        goto fail;
                }
+		page->area = area;
                area->pages[i] = page;
                if (gfpflags_allow_blocking(gfp_mask))
                        cond_resched();
