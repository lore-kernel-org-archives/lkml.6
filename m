Return-Path: <kernel-hardening-return-11628-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226AXa+F3k+28pUmK2kPv0Fy5vDn0f+SoBXGWGC+LyCuABgfGd0irq4Q5XsHP8HRCV7N64WX
ARC-Seal: i=1; a=rsa-sha256; t=1517920680; cv=none;
        d=google.com; s=arc-20160816;
        b=qylfxjZmXIBPE5BbZru8nW4/yBAhzIaLHnlba+SmSL4HgP5LQzU0SEWDZs5u5SPlpz
         rHzirN9wLTIu9BM4fWoI+1VkXWXkZ6QEIq9i+DAuqF82pdDf0US/Dtk8vM2Q/mjG+EPp
         7JpTLY0dbAk+GT3HVObhrz42yVpk3Li/NFCR3MvleZJPUzdsEel7O6L3pgUpwBMeX2BQ
         xbhsn1sbeIt5mgTq9zLo3XJ6a/LB1bcMoFHM7D/0+lkt4Jy2JWj0Uoet3fAUi611xE94
         pCXTcr46sUwYvSATHHfndIqWTyYdGdHEi7weTd6X7eqM/4Y8PkueDmymn73siI58/698
         pWdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=atjfp5JR0cRASKvKmF9XjbENSYkPVRFBL1h1ugyZxI0=;
        b=N/TA2AKHqM4zMUxAC411U2YEQOWh2b+RkU+Cp5EaBJRnSkEI2q/njO7/Y9xRcurkOM
         cWuNw+Ktq8V++NQzYYhvHXEPEa9988oZpoWJCa9At/xwdL0sHEFez9W8V8c8iiROvFlb
         t64G7L7kxDdW5OvN2XN6BcM7+b5o+6J6tu7WnBaa52lHDn+Hq1qT2g0nusvdw+4Pjpec
         +gO/eSTnYb4qrWxG71L+aTkiwKSxWWa0HAg6fSHYEbxE3UaiXZE57NU+guBZlA76DkhQ
         /Xq5BhFr9LWb2wO2kDCpFTGR3aoChrcd1CaBX+F0YPjXrE7buxIKIzZZJUGIit5GY2dp
         v/Rg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=Kfr/IWxz;
       spf=pass (google.com: domain of kernel-hardening-return-11628-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11628-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=Kfr/IWxz;
       spf=pass (google.com: domain of kernel-hardening-return-11628-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11628-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Tue, 6 Feb 2018 04:37:35 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: jglisse@redhat.com, keescook@chromium.org, mhocko@kernel.org,
	labbott@redhat.com, hch@infradead.org, cl@linux.com,
	linux-security-module@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 3/6] struct page: add field for vm_struct
Message-ID: <20180206123735.GA6151@bombadil.infradead.org>
References: <20180130151446.24698-1-igor.stoppa@huawei.com>
 <20180130151446.24698-4-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130151446.24698-4-igor.stoppa@huawei.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591031026595146297?=
X-GMAIL-MSGID: =?utf-8?q?1591655195641676944?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Jan 30, 2018 at 05:14:43PM +0200, Igor Stoppa wrote:
> @@ -1744,6 +1748,7 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>  			const void *caller)
>  {
>  	struct vm_struct *area;
> +	unsigned int page_counter;
>  	void *addr;
>  	unsigned long real_size = size;
>  
> @@ -1769,6 +1774,9 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>  
>  	kmemleak_vmalloc(area, size, gfp_mask);
>  
> +	for (page_counter = 0; page_counter < area->nr_pages; page_counter++)
> +		area->pages[page_counter]->area = area;
> +
>  	return addr;
>  

LOCAL variable names should be short, and to the point.  If you have
some random integer loop counter, it should probably be called ``i``.
Calling it ``loop_counter`` is non-productive, if there is no chance of it
being mis-understood.  Similarly, ``tmp`` can be just about any type of
variable that is used to hold a temporary value.

(Documentation/process/coding-style.rst)
