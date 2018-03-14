Return-Path: <kernel-hardening-return-12604-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtbMcIQ2zxYJaiKXZYPQJ5Oh0WqhwJfzraI+thxgY7+0SAyG5bt1bjSOvGblw8dZOKR/9oQ
ARC-Seal: i=1; a=rsa-sha256; t=1521043948; cv=none;
        d=google.com; s=arc-20160816;
        b=j7S6f+5xjUccuQvxr1aVTeLJNaPw5oWL6Bpk2YDsdHokO5kXhwJ+cNOCeR44Cg/O8w
         IFbcbx3cYFUU6m2pOS02vm3AO6XR2MmgPdw9Vnr6lYk9pQLF33VR/q3HFhafpEv/cOfT
         K9O3OK0d7FbSr4uNgble/6SJDSPNRQc4YUGpSzPO6Hz8Ml4NO60+eirkwVTa4+rQyrxP
         Z01g6kLVHPwIWABe6P5H3yqkAvQAUioGnQaLeVhXl90by8keU7WwVEQY0YW7bHoyoIhk
         RYuAgmkERSy06z1nt9afP4pIJNFDwI4Cc9bmgROEzYr8nU5u+c6WyPXhnHy4FlkxT0xi
         jpWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=zmyx8qHAsyzN34GJnI1jbVzmiFkMaGU5HgMd2q+5UVI=;
        b=vFOQuUdkAHCGbW5cjM+hL0psNGBydzCJq9BHFi1JRqEbh3i4MQa94db1uB9x6sO2Qc
         ZdJbQ197FEOVUTlCEeE0lhvzi5sc008McY/C5DTI9hx78JASi/Z2AI7M2t1B0GFOgyOG
         CYjKlnj59quOptLv7IctiaVBklJ8R91EkmBitdEeGb1XjeEHN7OpSi2hSZmRJFDM56tc
         lVfPYSNhhK5fjb/LP2HMnmLCHkryf/7mAnOtT8hTu9Fe3CuUdK0Otiduk9km1re2hyj0
         KKto62+2Kwy89ehgx0MY+K2ytkRFjxSTJAt7V4aNUEFZ72FiPllKTxhUVmlIVOsrTErY
         2+Sg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12604-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12604-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12604-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12604-gregkh=linuxfoundation.org@lists.openwall.com
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
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <9623b0d1-4ace-b3e7-b861-edba03b8a8cd@huawei.com>
Date: Wed, 14 Mar 2018 18:11:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314130418.GG29631@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594860649725336168?=
X-GMAIL-MSGID: =?utf-8?q?1594930178993319203?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 14/03/18 15:04, Matthew Wilcox wrote:

> I don't necessarily think you should use it as-is,

I think I simply cannot use it as-is, because it seems to use linear
memory, while I need virtual. This reason alone would require a rewrite
of several parts.

> but the principle it uses
> seems like a better match to me than the rather complex genalloc.

It uses meta data in a different way than genalloc.
There is probably a tipping point where one implementation becomes more
space-efficient than the other.

Probably page_frag does well with relatively large allocations, while
genalloc seems to be better for small (few allocation units) allocations.

Also, in case of high variance in the size of the allocations, genalloc
requires the allocation unit to be small enough to fit the smallest
request (otherwise one must accept some slack), while page_frag doesn't
care if the allocation is small or large.

page_frag otoh, seems to not support the reuse of space that was freed,
since there is only

But could you please explain to what you are referring to, when you say
that page_frag has "significantly lower overhead" ?

Is it because it doesn't try to reclaim space that was freed, until the
whole page is empty?

I see different trade-offs, but I am probably either missing or
underestimating the main reason why you think this is better.

And probably I am missing the capability of judging what is acceptable
in certain cases.

Ex: if the pfree is called only on error paths, is it ok to not claim
back the memory released, if it's less than one page?

To be clear: I do not want to hold to genalloc just because I have
already implemented it. I can at least sketch a version with page_frag,
but I would like to understand why its trade-offs are better :-)

> Just allocate some pages and track the offset within those pages that 

> is the current allocation point.


> It's less than 100 lines of code!

Strictly speaking it is true, but it all relies on other functions,
which must be rewritten, because they use linear address, while this
must work with virtual (vmalloc) addresses.

Also, I see that the code relies a lot on order of allocation.
I think we had similar discussion wrt compound pages.

It seems to me wasteful, if I have a request of, say, 5 pages, and I end
up allocating 8.

I do not recall anyone giving a justification like:
"yeah, it uses extra pages, but it's preferable, for reasons X, Y and Z,
so it's a good trade-off"

Could it be that it's normal RAM is considered less precious than the
special memory genalloc is written for, so normal RAM is not really
proactively reused, while special memory is treated as a more valuable
resource that should not be wasted?


--
igor
