Return-Path: <kernel-hardening-return-11550-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226PL7bfykIrYNyjohbXhbBGOozAZf+Eo/mUR8hU7uik7OQ4+YaafBQe2ASR9JRjQxHVV8Ba
ARC-Seal: i=1; a=rsa-sha256; t=1517488974; cv=none;
        d=google.com; s=arc-20160816;
        b=cMHoGMxjGFvIUuDr8m1UKkadAHccQ6061O9GsScKL5klq6M9Gb9wennnT6KMnhbtj4
         4BO/lD722EoKZblGz5ZBTyOLuIdLT0eFo1ASvaAs0dt2pXZX1NcBpkvHWRzWhjqo7W8R
         u2Hpxs4O7dpuENKQvzQWNM3VTQvDN83ktwpgAr6cjTqZp68+BF4oJJVhtJUwJ4of+Lzb
         qbbR1MgK/zn/QBP3Krt79DDK2T7Ung4POpEX2IsQYYLUqQcZwfgBL0EJuEZdq5y+v0ml
         K9fQFnYMWTF8AIeX/cQuZKaO83D+AHAZW14WsaEMamDAiSZGLYnIco5oObMx06yW4bzu
         OQ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=QeuhxojymB60ACPVIgg0sTKmoG3+8bKcCMR0ZC+sJkw=;
        b=evtdOOo79d0WUueAbiXP94MFL4jV/P37qN1x5/hPLVeoVkG5mlRrW2WAMStOHY3/3/
         OxF2WygUN8GdJs9CPLCLCTXAvxtBRdn4XVj5YO7HLRIjYGKVJDpgoX7mmGJu6lPorNC0
         qeT5wNcXvH86qTY5D7Tzoxci4iEd0x/cifv39mMPdW6932zfJvK59/V7dMlkh+6yFByI
         vyQsaKbnBNx5lHccIT15xtGnra5eNeSIc9DODKN4rI5gluxWI0atbB4e1ugIZkHpPiYp
         yW9CROqQJt40qGaBL1ZER6CLUd94znhG1MY+zi3zZbhOIEn3FOcVfSKDRdEDWcILZ6L8
         iFTw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11550-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11550-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11550-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11550-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 3/6] struct page: add field for vm_struct
To: Christopher Lameter <cl@linux.com>
CC: <jglisse@redhat.com>, <keescook@chromium.org>, <mhocko@kernel.org>,
	<labbott@redhat.com>, <hch@infradead.org>, <willy@infradead.org>,
	<linux-security-module@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kernel-hardening@lists.openwall.com>
References: <20180130151446.24698-1-igor.stoppa@huawei.com>
 <20180130151446.24698-4-igor.stoppa@huawei.com>
 <alpine.DEB.2.20.1801311758340.21272@nuc-kabylake>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <48fde114-d063-cfbf-e1b6-262411fcd963@huawei.com>
Date: Thu, 1 Feb 2018 14:42:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1801311758340.21272@nuc-kabylake>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591031026595146297?=
X-GMAIL-MSGID: =?utf-8?q?1591202519519471825?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 01/02/18 02:00, Christopher Lameter wrote:
> On Tue, 30 Jan 2018, Igor Stoppa wrote:
> 
>> @@ -1769,6 +1774,9 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>>
>>  	kmemleak_vmalloc(area, size, gfp_mask);
>>
>> +	for (page_counter = 0; page_counter < area->nr_pages; page_counter++)
>> +		area->pages[page_counter]->area = area;
>> +
>>  	return addr;
> 
> Well this introduces significant overhead for large sized allocation. Does
> this not matter because the areas are small?

Relatively significant?
I do not object to your comment, but in practice i see that:

- vmalloc is used relatively little
- allocations do not seem to be huge
- there seem to be way larger overheads in the handling of virtual pages
  (see my proposal for the LFS/m summit, about collapsing struct
   vm_struct and struct vmap_area)


> Would it not be better to use compound page allocations here?
> page_head(whatever) gets you the head page where you can store all sorts
> of information about the chunk of memory.

Can you please point me to this function/macro? I don't seem to be able
to find it, at least not in 4.15

During hardened user copy permission check, I need to confirm if the
memory range that would be exposed to userspace is a legitimate
sub-range of a pmalloc allocation.


So, I start with the pair (address, size) and I must end up to something
I can compare it against.
The idea here is to pass through struct_page and then the related
vm_struct/vmap_area, which already has the information about the
specific chunk of virtual memory.

I cannot comment on your proposal because I do not know where to find
the reference you made, or maybe I do not understand what you mean :-(

--
igor
