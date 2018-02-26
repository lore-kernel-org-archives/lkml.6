Return-Path: <kernel-hardening-return-11960-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuHewL8c4ZQyTsgCVt77ZgRkyFAQ8Z9i5sKiWpHwqjoGNKr/D/woT3wR8LCHkDbKjgN8UxA
ARC-Seal: i=1; a=rsa-sha256; t=1519663106; cv=none;
        d=google.com; s=arc-20160816;
        b=PXqxyMts0fZSuczKBp5Upo630t2H0pYCnT6C8Ie/dFg05NeSuK0BBoOBwOKIeJMprC
         9OXue8tdxAXLGhRGaEqWb7d2vK2kmwaiR0lsUhybYguzF3Jf/NDRbSQKVM520+sp3KJK
         XbxfyScKQMoQmfG8lMCxfs+wiFSuLtUVk0XbylZeKrgAsYJQXxWSkHFU0eqCE+krM75h
         s3u0ArYzO7aRAXHltIPY/e0Oo+JmBe16l9iwiKlebjJfGD6zH1DoTNDjqNOvVKL9dilD
         Ys7tcN5O9DCw0VwQyj7VakDNohiyMK5TEp6C9WLxhHSqZuFS4I/3LnOFMpk/3L2Q+Wto
         Gi+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=wtntiyUxUB/Nd4ERwl2lsXiArKg+mu8Lhi8mF8SfEOM=;
        b=ar8rkurJ3d+uMsfmpee7KRyI3O7q8LBN6GSTuREREFwKCJrxk6JMdeguoXOEj00GmD
         aTK2Giq7NKuktZzJGY9b/GZPOUw6l4N8qCPMkE/d6cXNX/HlutBfKkTYuL2o4yoZDurr
         SfYRKlTN6bxqEiDTYfv4Ch8rdU5oulQ8mjul+V8OsLWNUQZo1aEX6Q8ztOphacQ5h+UZ
         89y+2NobsZH4mkoJ+29Qp9G6NtzXwtp3jwnU2aPYnTX5G6K2E5aEo2n7KBGt6wjdfa24
         Q/Ivwo1iusOMjAenstBWrN6x/iEUWgNcb7YIoYAlaMpunuyaTzpfLQ3FgYxa8AKkFEzP
         03xw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11960-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11960-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11960-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11960-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 3/7] struct page: add field for vm_struct
To: Matthew Wilcox <willy@infradead.org>
CC: <david@fromorbit.com>, <keescook@chromium.org>, <mhocko@kernel.org>,
	<labbott@redhat.com>, <linux-security-module@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kernel-hardening@lists.openwall.com>
References: <20180223144807.1180-1-igor.stoppa@huawei.com>
 <20180223144807.1180-4-igor.stoppa@huawei.com>
 <20180225033808.GB15796@bombadil.infradead.org>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <5ec5d25a-dbf2-5be4-b449-3704254f8117@huawei.com>
Date: Mon, 26 Feb 2018 18:37:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180225033808.GB15796@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593203701882872070?=
X-GMAIL-MSGID: =?utf-8?q?1593482261797516840?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 25/02/18 05:38, Matthew Wilcox wrote:
> On Fri, Feb 23, 2018 at 04:48:03PM +0200, Igor Stoppa wrote:
>> @@ -1769,6 +1771,9 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>>  
>>  	kmemleak_vmalloc(area, size, gfp_mask);
>>  
>> +	for (i = 0; i < area->nr_pages; i++)
>> +		area->pages[i]->area = area;
>> +
>>  	return addr;
>>  
>>  fail:
> 
> IMO, this is the wrong place to initialise the page->area.  It should be
> done in __vmalloc_area_node() like so:
> 
>                         area->nr_pages = i;
>                         goto fail;
>                 }
> +		page->area = area;
>                 area->pages[i] = page;
>                 if (gfpflags_allow_blocking(gfp_mask))
>                         cond_resched();
> 


ok

--
igor
