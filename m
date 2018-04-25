Return-Path: <kernel-hardening-return-13142-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZrn8hFGorehXR2n7lT7PCDWa97T0MbDnedjmcy1wNqL/7b8mS2VVW3qnaPzLr+LFf4X1zIk
ARC-Seal: i=1; a=rsa-sha256; t=1524689943; cv=none;
        d=google.com; s=arc-20160816;
        b=gHr3F8mAmkbr7rHySh1vkvvrzV8jOf+IuGIo5EjwaAzoBz8MSLXfH2tLhvcoAtMyxQ
         KEVowWW1uOoiaBZrGogj/x6BxnIHZgWeqgbukqA2omIq4DlBBV/fv8sX+2EoiCrlyIkX
         iMcDoTIVMNZaGakSW5UFFoJzzwykGTcV7VgzBOYMbnV4bfxM42d682/61xrLxYMTNpZ8
         1YYwkJMYSqinZnfG7VAv2s222a9cgKbR1qFl09e2T204JbokjtqLKicm80NDCtBJOBMv
         O7HsxOt1+5X8+BukhZ7tPL9nL+Bt5fR60ieMtBD9lGFnfHYbBJqw8GzmkSmNEvBez8l0
         PAUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=l8IuNgEo4XM4P/ddXFIAn0Ycwcq3V+YmX3q2bvr0Vcc=;
        b=pislMPSooC9bV7QH4fJIZVhkDEECtOnCuUeQ7PSKc28iwn4+PZtj9FEAjApjR7ZNZh
         6q4ZU+ejBuQOXoN22o5I20wBOx2q66ziAAm/2DZ0cUgQq0ICbv0Kwb09G8/FyXiublYY
         yHatqgDOotz6GNMEtXPD0qTSUsZPS7ZYUilUGKw5B3jQD/GSxI1qULx/cT3GGLVmby6v
         /5hNdrTLx0a3/mXtP2+WRjx6dn9PanpGVZQXgfgvo/UoWPL25UjHIWaGRPrOOtgEvOsO
         8Od/kqJlyBlFoiAS0whXH21WLqfxI9d+5KJIVb2MnPW7BFN6BPQhYXz8GTgf9oOw2wk8
         duTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=N67t/zfc;
       spf=pass (google.com: domain of kernel-hardening-return-13142-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13142-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=N67t/zfc;
       spf=pass (google.com: domain of kernel-hardening-return-13142-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13142-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 7/9] Pmalloc Rare Write: modify selected pools
To: Matthew Wilcox <willy@infradead.org>, lazytyped <lazytyped@gmail.com>,
 dave.hansen@linux.intel.com
Cc: keescook@chromium.org, paul@paul-moore.com, sds@tycho.nsa.gov,
 mhocko@kernel.org, corbet@lwn.net, labbott@redhat.com, david@fromorbit.com,
 rppt@linux.vnet.ibm.com, linux-security-module@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com, Igor Stoppa <igor.stoppa@huawei.com>,
 Carlos Chinea Perez <carlos.chinea.perez@huawei.com>,
 Remi Denis Courmont <remi.denis.courmont@huawei.com>
References: <20180423125458.5338-1-igor.stoppa@huawei.com>
 <20180423125458.5338-8-igor.stoppa@huawei.com>
 <20180424115050.GD26636@bombadil.infradead.org>
 <eb23fbd9-1b9e-8633-b0eb-241b8ad24d95@gmail.com>
 <20180424144404.GF26636@bombadil.infradead.org>
From: Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <6a28fa46-a6b4-2803-0f15-8c278811ec2f@gmail.com>
Date: Thu, 26 Apr 2018 00:58:39 +0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424144404.GF26636@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598541768538376919?=
X-GMAIL-MSGID: =?utf-8?q?1598753281176524795?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 24/04/18 18:44, Matthew Wilcox wrote:
> On Tue, Apr 24, 2018 at 02:32:36PM +0200, lazytyped wrote:
>> On 4/24/18 1:50 PM, Matthew Wilcox wrote:
>>> struct modifiable_data {
>>> 	struct immutable_data *d;
>>> 	...
>>> };
>>>
>>> Then allocate a new pool, change d and destroy the old pool.
>>
>> With the above, you have just shifted the target of the arbitrary write
>> from the immutable data itself to the pointer to the immutable data, so
>> got no security benefit.
> 
> There's always a pointer to the immutable data.  How do you currently
> get to the selinux context?  file->f_security.  You can't make 'file'
> immutable, so file->f_security is the target of the arbitrary write.
> All you can do is make life harder, and reduce the size of the target.

In the patch that shows how to secure the selinux initialized state,
there is a static _ro_after_init handle (the 'file' in your example), 
which is immutable, after init has completed.
It is as immutable as any const data that is not optimized away.

That is what the code uses to refer to the pmalloc data.

Since the reference is static, I expect the code will use it through 
some offset, which will be in the code segment, which is also read-only, 
as much as the rest.

Where is the writable pointer in this scenario?


>> The goal of the patch is to reduce the window when stuff is writeable,
>> so that an arbitrary write is likely to hit the time when data is read-only.
> 
> Yes, reducing the size of the target in time as well as bytes.  This patch
> gives attackers a great roadmap (maybe even gadget) to unprotecting
> a pool.

Gadgets can be removed by inlining the function calls.

Dave Hansen suggested I could do COW and replace the old page with the 
new one. I could implement that, if it is preferable, although I think 
it would be less efficient, for small writes, but it would not leave the 
current page mapped as writable, so there is certainly value in it.

---
igor
