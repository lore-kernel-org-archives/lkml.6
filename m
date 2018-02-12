Return-Path: <kernel-hardening-return-11724-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x224dkeYp2xCy04Ic4F8pXZ7pYUDLufNK25CRNsNpIdAcV9Ri8P6L5cF4+2w/CGIbbOV9BG+6
ARC-Seal: i=1; a=rsa-sha256; t=1518452698; cv=none;
        d=google.com; s=arc-20160816;
        b=meASawSJcMNDZBlVjjBEPl73N3HvDVE7mHptbHm9FIVmUjGxegKjlvXAax9bNJHWOO
         jixu5IaTa9ImISQseX0WKsOPM9TPd+EeoMsRc+e8rpaO9e3s6dWHyPlVEI2S+peAXBpa
         V1alzkcG4dUymTGA19u0T9UbmxMsygzTobGzYF3uLNgrupxPDOESt/X1UkKqigXf9uPf
         /nYOoHjAZRmtO/OaDvXKlNDflOgV9LXifZDDRIZVMS1VsEMSoYc9uocq2vUs2obSlBbF
         6/tQMfSRih3m4mm597DLUMaMzBOtYcOIRjSo9lWwTRblcHU/igcHJK1nWE+XZr1WVG+g
         UN1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=mPXLQBw9Xzd2EluGDK+Ax01O17bfJX3ttLxVN7FLmA4=;
        b=F/qspL3E9xcJUo0tbrZdQIyK2ZStn/chsKfeSyYqaDezQHJckHeZ1lYa7TSbE990MV
         ACh0rc9d/FK0TZBDBMEXc6a4pBqnru98XnaH/NUhXGvfVbY5scgPGiktBHez7pCUjnZs
         ebkILQ32yo9qVB1TxfcvQgi7gCYw7sXveIxFUVgoEBBzMVr0vUwRpjlZlcdiZ881Z2qc
         5zufJRE4zh6xHxJkxJkl4WXy7na/Jj9Vz+eN5NyrNRxgz18nv6h/g5OZUUCtnhNLOR9S
         z/Klp9nSP8sb/jzPXYFNTWwimMF5UKZtwqfviIBsfFGi4rQMDHtXZD2/d0H9R3GmIrDm
         Ig5A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11724-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11724-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11724-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11724-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 3/6] struct page: add field for vm_struct
To: Matthew Wilcox <willy@infradead.org>
CC: <rdunlap@infradead.org>, <corbet@lwn.net>, <keescook@chromium.org>,
	<mhocko@kernel.org>, <labbott@redhat.com>, <jglisse@redhat.com>,
	<hch@infradead.org>, <cl@linux.com>, <linux-security-module@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kernel-hardening@lists.openwall.com>
References: <20180211031920.3424-1-igor.stoppa@huawei.com>
 <20180211031920.3424-4-igor.stoppa@huawei.com>
 <20180211211646.GC4680@bombadil.infradead.org>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <cef01110-dc23-4442-f277-88d1d3662e00@huawei.com>
Date: Mon, 12 Feb 2018 18:24:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180211211646.GC4680@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592073184128407406?=
X-GMAIL-MSGID: =?utf-8?q?1592213056462435755?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 11/02/18 23:16, Matthew Wilcox wrote:
> On Sun, Feb 11, 2018 at 05:19:17AM +0200, Igor Stoppa wrote:
>> The struct page has a "mapping" field, which can be re-used, to store a
>> pointer to the parent area. This will avoid more expensive searches.
>>
>> As example, the function find_vm_area is reimplemented, to take advantage
>> of the newly introduced field.
> 
> Umm.  Is it more efficient?  You're replacing an rb-tree search with a
> page-table walk.  You eliminate a spinlock, which is great, but is the
> page-table walk more efficient?  I suppose it'll depend on the depth of
> the rb-tree, and (at least on x86), the page tables should already be
> in cache.

I thought the tradeoff favorable. How to verify it?

> Unrelated to this patch, I'm working on a patch to give us page_type,
> and I think I'll allocate a bit to mark pages which are vmalloced.

pmalloced too?

--
igor
