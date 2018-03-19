Return-Path: <kernel-hardening-return-12704-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsfKyxuc1fnrApwdLfeoiklCHNpLq7AnmN2fXqbCez1H0RupNMKEyKB6tBcxU42H0UJY2I5
ARC-Seal: i=1; a=rsa-sha256; t=1521482762; cv=none;
        d=google.com; s=arc-20160816;
        b=wQbQJnF6i7VIyLFqVvnGWYfCleS5EBLtjMpnuusoFMZcbKZwIieTgmyT4cLzGT3Y1n
         zSbHuqB6rEG7z2OQkmsrhAGx5tPKW2Oya+tktkAS0UVq1dAxIdcP6TWTvGpIb68940cR
         J6l8IbJDbHL0aMkMPbbMzbH26JgCPrkBR7hEKlzaFTiUfo+wAvE4McRm8Z8Q1skpEZ6i
         PPQtKexowkphoXX4RfhmEDqel4Qz0siwgcnb/axWRgIR8ea23PAKhxRqYb/X8Vbr/Tl7
         GaHVV4asbB6xAqJ5K4mwq9yD2WQkm/4CWCIm/5VmUb3qG/mNctiEfcsLsIOZivq9XFtb
         2Gkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=d3/LlTIvMI8/ZY3VaCmuadgqq7MUCJhz2Uan9Czz9h4=;
        b=UJYojv59cuZp/fa9V2ytcNTLx5E7jrsIIfwuZfL0puiWNoDNVWe8VXyVgkHAcpAVR+
         toOGcs4oQyEWeYJXKKENxSnpIGRCGRIMdJC/O81Ux5s/M0KOHQgSM58Qz1kPuZlRew4j
         tZ0LTywOHkpqED+rbm7t3GM8OI7M9GSOr4hIlKOXwodY2/xMrTlEgrsJVjgERGpZgmlj
         jDLtLGnAajMdlYaPfKTXkjkmC9C1U4d64XcG010h9Zjf/+nWNIR91gbzF5AwJarG4oAC
         DusTU/NTPmHmEqJJ1+lt9DyqYsPuTtK+6+qUlgqWrDeluM1+gHqGRjJfIHBFqCG5ZtQx
         FlAA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12704-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12704-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12704-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12704-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [RFC PATCH v19 0/8] mm: security: ro protection for dynamic data
To: Matthew Wilcox <willy@infradead.org>
CC: <keescook@chromium.org>, <david@fromorbit.com>, <rppt@linux.vnet.ibm.com>,
	<mhocko@kernel.org>, <labbott@redhat.com>,
	<linux-security-module@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kernel-hardening@lists.openwall.com>
References: <20180313214554.28521-1-igor.stoppa@huawei.com>
 <a9bfc57f-1591-21b6-1676-b60341a2fadd@huawei.com>
 <20180314115653.GD29631@bombadil.infradead.org>
 <8623382b-cdbe-8862-8c2f-fa5bc6a1213a@huawei.com>
 <20180314130418.GG29631@bombadil.infradead.org>
 <9623b0d1-4ace-b3e7-b861-edba03b8a8cd@huawei.com>
 <20180314173343.GJ29631@bombadil.infradead.org>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <242fd8a2-2b80-3aa3-4b11-27f49c021a1d@huawei.com>
Date: Mon, 19 Mar 2018 20:04:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314173343.GJ29631@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594860649725336168?=
X-GMAIL-MSGID: =?utf-8?q?1595390309947891962?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 14/03/18 19:33, Matthew Wilcox wrote:
> I think an implementation of
> pmalloc which used a page_frag-style allocator would be larger than
> 100 lines, but I don't think it would have to be significantly larger
> than that.

I have some doubt about what is the best way to implement it using
vmalloced memory.

1. Since I can allocate an arbitrary number of pages, I think allocating
a rounded up amount of memory, so that it's multiple of PAGE_SIZE should
be enough.

But maybe I could do better than that:
a) support pre-allocation of x pages

b) define, as pool parameter, the minimum number of pages to allocate
every time there is a refill

c) both a and b


----


2. the flavor of page_frag from page_alloc relies on page->_refcount,
however neither vmap_area, nor vm_struct seem to have anything like
that. (My reasoning is that I should do the accounting not on page
level, but based on the virtual area that I get when I allocate new
memory) What would be the best way to do refcounting for the area?

a) use the the page->_refcount from the first page that belongs to the area

b) add the _refcount to either vm_struct or vmap_area (I am not really
sure of why these two structures exist as separate entities, rather than
a single one - cache optimization?)


----

3. I will have to add a list of chunks (in genalloc lingo, or areas, if
we refer to the new implementation), because I will still need to
iterate over all the memory that belongs to a pool, for either write
protecting it or for destroying the pool. I have two options:

a) handle the chunks within the pmalloc pool

b) create an intermediate type of pool (vfrag_pool?) and then include it
in the pmalloc pool structure.

I'd lean toward option a, but I thought I might as well ask for advice
before I implement the less desirable option (whatever it might be).

--
thanks, igor
