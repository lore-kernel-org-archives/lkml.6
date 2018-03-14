Return-Path: <kernel-hardening-return-12581-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvv2WATlfdrMEtrRxYgjNQlsOPF8LtyQPfcaesrKGsob6bW0J5keJA0kTrc2xTOZ2CIyrhn
ARC-Seal: i=1; a=rsa-sha256; t=1521026581; cv=none;
        d=google.com; s=arc-20160816;
        b=UID36AsRSqlZBCLJxPU4tnP4DorJ7jFHYRQEPHAVZarss8OahquUvvMfHylVccDC1O
         DCtHs2yaKdvAh8DdtqKX500XtP2HMnTovc7/ncC/ZOVmqK6K3/O88StPjlPvVpFsPSiQ
         bJx8SGEl4wcWwepMJudbN+hPjBGtGAJdrr4Uj9HaIpjYbHTAvbdIDh2ziJ5qd1eJw3IN
         tc1zI+BaajR6u5tM82Re5YmkVNNcYXmmcW+G+O5YSheDuZ0C0ACxs93GXTBFg3l5AvlP
         bZYFQjGON8Pxn4R8wkSkjiMkyCJZnRBIYQkPgNprAYi23OD+KfCNZibH/jwbQfcA/Gtf
         fJbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=pKBLWECLFOdJT8TcnI43il2j5id38rPAAP496rsd99o=;
        b=Ofw87r2Pi0QxHLMf0321/XcHu871HkM+to7zajQkf6aZ2LTxvtH5TBGMV6GAJVGq29
         wusFOvfMexcoXI2zozm34zjQUwUrgXJdGOxTc/uyqDAsUfTmrK+PlwR6hY0n4zzN7/ry
         gP3WeWyyfW4BItzd4ciqDN3PQrcYE6j6QW0v4yvdmJyv8CRL7dWA6yxbp4Ge4inG7Csm
         3JrQXen97dDbsL5+7Wbw/imyn8qaa8wnCg/1WBW8nAkUIkLk+3rCO7v5bFWoh+zQC8U3
         mt/2juwV2j/PHL3iEpMDW3HyEDuFnzs/a8ZM7KiMP56I9OCyRd7/82f199w10myEYBhS
         RVDA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12581-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12581-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12581-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12581-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [RFC PATCH v19 0/8] mm: security: ro protection for dynamic data
To: <willy@infradead.org>, <keescook@chromium.org>
CC: <david@fromorbit.com>, <rppt@linux.vnet.ibm.com>, <mhocko@kernel.org>,
	<labbott@redhat.com>, <linux-security-module@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kernel-hardening@lists.openwall.com>
References: <20180313214554.28521-1-igor.stoppa@huawei.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <a9bfc57f-1591-21b6-1676-b60341a2fadd@huawei.com>
Date: Wed, 14 Mar 2018 13:21:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180313214554.28521-1-igor.stoppa@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594860649725336168?=
X-GMAIL-MSGID: =?utf-8?q?1594911968484549252?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 13/03/18 23:45, Igor Stoppa wrote:

[...]

Some more thoughts about the open topics:

> Discussion topics that are unclear if they are closed and would need
> comment from those who initiated them, if my answers are accepted or not:
> 
> * @Kees Cook proposed to have first self testing for genalloc, to
>   validate the following patch, adding tracing of allocations
>   My answer was that such tests would also need patching, therefore they 
>   could not certify that the functionality is corect both before and
>   after the genalloc bitmap modification.

This is the only one where I still couldn't find a solution.
If Matthew Wilcox's proposal about implementing the the genalloc bitmap
would work, then this too could be done, but I think this alternate
bitmap proposed has problems. More on it below.

> * @Kees Cook proposed to turn the self testing into modules.
>   My answer was that the functionality is intentionally tested very early
>   in the boot phase, to prevent unexplainable errors, should the feature
>   really fail.

This could be workable, if it's acceptable that the early testing is
performed only when the module is compiled in.
I do not expect the module-based testing to bring much value, but it
doesn't do harm. Is this acceptable?

> * @Matthew Wilcox proposed to use a different mechanism for the genalloc
>   bitmap: 2 bitmaps, one for occupation and one for start.
>   And possibly use an rbtree for the starts.
>   My answer was that this solution is less optimized, because it scatters
>   the data of one allocation across multiple words/pages, plus is not
>   a transaction anymore. And the particular distribution of sizes of
>   allocation is likely to eat up much more memory than the bitmap.

I think I can describe a scenario where the split bitmaps would not work
(based on my understanding of the proposal), but I would appreciate a
review. Here it is:

* One allocation (let's call it allocation A) is already present in both
bitmaps:
  - its units of allocation are marked in the "space" bitmap
  - its starting bit is marked in the "starts" bitmap

* Another allocation (let's call it allocation B) is undergoing:
  - some of its units of allocation (starting from the beginning) are
    marked in the "space" bitmap
  - the starting bit is *not* yet marked in the "starts" bitmap

* B occupies the space immediately after A

* While B is being written, A is freed

* Having to determine the length of A, the "space" bitmap will be
  searched, then the "starts" bitmap


The space initially allocated for B will be wrongly accounted for A,
because there is no empty gap in-between and the beginning of B is not
yet marked.

The implementation which interleaves "space" and "start" does not suffer
from this sort of races, because the alteration of the interleaved
bitmaps is atomic.

However, at the very least, some more explanation is needed in the
documentation/code, because this scenario is not exactly obvious.

Does this justification for the use of interleaved bitmaps (iow the
current implementation) make sense?

--
igor
