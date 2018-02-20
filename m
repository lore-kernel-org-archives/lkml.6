Return-Path: <kernel-hardening-return-11834-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x224WIe9vJLAbckZXVXN1pbj4mQB/+9jEKSmYTncM0KTx0jKuJPhLX6GqvLVRm8N+SAXf32cd
ARC-Seal: i=1; a=rsa-sha256; t=1519156461; cv=none;
        d=google.com; s=arc-20160816;
        b=ETq+5dd+BFebMYJj0XeiRA2lhUaS7gLgyfhIqIFYR9t/DIa0f+CknTkWZvFjKyTBwX
         0C/fGnSgm8rEJSLIpT22JW8fmj8KmQzJNt7SZVBNIqlG5DaMe72iqKz8yv+y41zH018S
         baJrO6Hi6VQbU4GKns4lgkzKlaOK3m0TYuTjKsCtCcND5kTjceGJsLGd+cOD1n/Ab7OM
         g5owSoOdAHl7mmCD4plojcSRShj+GZbufV/HKM0lDMQuBzN87JfOLt5LBymOlIPMDBaO
         M7536l4CQWKrQut7ovu9CoPZejFlKnbm2JobWJ6L+SyFlEgvTYHCavdETz1MlmorzJiK
         S43w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=0GRIHCJnV5n1crTNIQgxVdgsfy1NIVPAbku/Zm/MXPo=;
        b=j1kKGvnHUHKgkkjfIYsFazay3RRh3Kl38jlUKu6Xctt2TRHhzyNqOzEySseh1TFnCK
         Y7dSuKqzjfdK//WFVVLiAJxtrWOgLEfzPVpJSj80j2+R+/tQXgf5r3nV2TDNU4alDP6q
         20gDI4nMuXYSEhVdziN0GWHcybB9a4PMkGozQv2rG22l1W+3BBu6N4Hl0FHwB43KJHas
         4KOudUPWbTh27usO4GV5/3em7uR1QdPqQPiqa2Hxluo1cyws74ZSgVqHZ5GvcI4easEJ
         ZogGyeaEIpZjl5Vtbj8ZKMw8kGO3EI9igByrjiqZM5xaharfDT7cjRjdpnytMssrWWaB
         hJ5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11834-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11834-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11834-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11834-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 3/6] struct page: add field for vm_struct
From: Igor Stoppa <igor.stoppa@huawei.com>
To: Matthew Wilcox <willy@infradead.org>
CC: <rdunlap@infradead.org>, <corbet@lwn.net>, <keescook@chromium.org>,
	<mhocko@kernel.org>, <labbott@redhat.com>, <jglisse@redhat.com>,
	<hch@infradead.org>, <cl@linux.com>, <linux-security-module@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kernel-hardening@lists.openwall.com>
References: <20180211031920.3424-1-igor.stoppa@huawei.com>
 <20180211031920.3424-4-igor.stoppa@huawei.com>
 <20180211211646.GC4680@bombadil.infradead.org>
 <cef01110-dc23-4442-f277-88d1d3662e00@huawei.com>
Message-ID: <b59546a4-5a5b-ca48-3b51-09440b6a5493@huawei.com>
Date: Tue, 20 Feb 2018 21:53:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <cef01110-dc23-4442-f277-88d1d3662e00@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592073184128407406?=
X-GMAIL-MSGID: =?utf-8?q?1592951005618299278?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 12/02/18 18:24, Igor Stoppa wrote:
> 
> 
> On 11/02/18 23:16, Matthew Wilcox wrote:
>> On Sun, Feb 11, 2018 at 05:19:17AM +0200, Igor Stoppa wrote:
>>> The struct page has a "mapping" field, which can be re-used, to store a
>>> pointer to the parent area. This will avoid more expensive searches.
>>>
>>> As example, the function find_vm_area is reimplemented, to take advantage
>>> of the newly introduced field.
>>
>> Umm.  Is it more efficient?  You're replacing an rb-tree search with a
>> page-table walk.  You eliminate a spinlock, which is great, but is the
>> page-table walk more efficient?  I suppose it'll depend on the depth of
>> the rb-tree, and (at least on x86), the page tables should already be
>> in cache.
> 
> I thought the tradeoff favorable.

It turns out that it's probably not so favorable.
The patch relies on the function vmalloc_to_page ... which will return
NULL when applied to huge mappings, while the original implementation
will still work.

It was found while testing on a configuration with framebuffer.

So it seems unlikely that there is any gain to be had, from this
perspective.

The use of the field still makes sense from the perspective of adding
pmalloc support to hardened usercopy, but there is no more need for the
field to exist as separate patch.

This patch can be simplified and merged with the pmalloc patch.

--
igor
