Return-Path: <kernel-hardening-return-13158-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZrUc9fb+kjZahXILtedbsS007gRIYtXVDkJZmFhDdOjP34Z1E1dhEIzkisLM8pOKhrGS4a5
ARC-Seal: i=1; a=rsa-sha256; t=1525019993; cv=none;
        d=google.com; s=arc-20160816;
        b=nwubpxLry0addPPgIgTovu7vrt9AB1IbL+3ChgUh8tbk2CwnAu/FiZk1xLuXGv7DWb
         z7yT3/8NH/WkxtPDYVZ4tv/oUuPpLnHVUvogObRAcnbSp1J4ivgmJXbUtydFL1R6gD2b
         t/MYmf/a+S7d5DKHApVYiJsDlZ4yocGj+WUnI8Yc4E67+9/sQx1phN3G50csirFjSYIo
         VAsIDNLpa9SfO6I84cWrIBhcPkoYLj64clP1ifqHsCOiUyRIQje4mUFAzaVnDaIxkaTR
         OBeuZtIuk7gV+j/PstaZ7vtuEHGjecjISoCetVMWjMLLlxCRr9RYRiJEpQUcW2Wu8YOs
         h0dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=WNBDxtUkg2UNDYE0VeW0icICbWwAj7trkJ/Dd+U97Rg=;
        b=pHA2AzCj6F6wnvhS/L3zqufqQKszQpd4kEp+hqvNcj/AOdtvDFdvPFkodeFOFILaQN
         cGxXvBVySp3O33RrHwmoZlTJ8Sp4746QbNHAGi2tncN9alGAVqmD94yyi0/by8JoGglx
         tiEYXdw4I/9szD7St4YpnvsARhh0MBz4fszjST/zRmA+1xsUBFw/pKbeSjOCFDyJOzdv
         /C5lj7of1UsHaIjtRRxndHll8/3VM167UbUFMZ9QSeN9FmdPb49Mq2dJUG5U2ee9WSm2
         VmwloYRBHlnalE9jhW68neCQK/8cZw99jfsJ25Zv6xhN+bKWAfh8qH78jqPbM4uakbdO
         6JYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gKzUVp/E;
       spf=pass (google.com: domain of kernel-hardening-return-13158-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13158-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gKzUVp/E;
       spf=pass (google.com: domain of kernel-hardening-return-13158-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13158-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 0/3] linux-next: mm: hardening: Track genalloc allocations
To: Matthew Wilcox <willy@infradead.org>
Cc: mhocko@kernel.org, akpm@linux-foundation.org, keescook@chromium.org,
 linux-mm@kvack.org, kernel-hardening@lists.openwall.com,
 linux-security-module@vger.kernel.org, labbott@redhat.com,
 linux-kernel@vger.kernel.org, igor.stoppa@huawei.com
References: <20180429024542.19475-1-igor.stoppa@huawei.com>
 <20180429030940.GA2541@bombadil.infradead.org>
From: Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <3b4fc557-eba9-cd37-1ca4-dd9d09efc945@gmail.com>
Date: Sun, 29 Apr 2018 20:39:30 +0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180429030940.GA2541@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599046930013437561?=
X-GMAIL-MSGID: =?utf-8?q?1599099364569538806?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 29/04/18 07:09, Matthew Wilcox wrote:
> On Sun, Apr 29, 2018 at 06:45:39AM +0400, Igor Stoppa wrote:
>> This patchset was created as part of an older version of pmalloc, however
>> it has value per-se, as it hardens the memory management for the generic
>> allocator genalloc.
>>
>> Genalloc does not currently track the size of the allocations it hands out.
>>
>> Either by mistake, or due to an attack, it is possible that more memory
>> than what was initially allocated is freed, leaving behind dangling
>> pointers, ready for an use-after-free attack.
> 
> This is a good point.  It is worth hardening genalloc.
> But I still don't like the cost of the bitmap.  I've been
> reading about allocators and I found Bonwick's paper from 2001:
> https://www.usenix.org/legacy/event/usenix01/full_papers/bonwick/bonwick.pdf
> Section 4 describes the vmem allocator which would seem to have superior
> performance and lower memory overhead than the current genalloc allocator,
> never mind the hardened allocator.
> 
> Maybe there's been an advnace in resource allocator technology since
> then that someone more familiar with CS research can point out.

A quick search on google shows that there have been tons of improvements.

I found various implementation of vmem, not all with GPLv2 compatible 
license.

The most interesting one seems to be a libvmem from Intel[1], made to 
use jemalloc[2], for persistent memory.

jemalloc is, apaprently, the coolest kid on the block, when it comes to 
modern memory management.

But this is clearly a very large lump of work.

First of all, it should be assessed if jemalloc is really what the 
kernel could benefit from (my guess is yes, but it's just a guess), then 
if the license is compatible or if it can be relicensed for use in the 
kernel.

And, last, but not least, how to integrate the ongoing work in a way 
that doesn't require lots of effort to upgrade to new releases.

Even if it looks very interesting, I simply do not have time to do this, 
not for the next 5-6 months, for sure.

What I *can* offer to do, is the cleanup of the users of genalloc, by 
working with the various maintainers to remove the "size" parameter in 
the calls to gen_pool_free(), iff the patch I submitted can be merged.

This is work that has to be done anyway and does not preclude, later on, 
to phase out genalloc in favor of jemalloc or whatever is deemed to be 
the most effective solution.

There are 2 goals here:
1) plug potential security holes in the use of genalloc
2) see if some new allocator can improve the performance (and it might 
well be that the improvement can be extended also to other allocators 
used in kernel)

We seem to agree that 1) is a real need.
Regarding 2), I think it should have a separate life.

going back to 1), your objections so far, as far as I can tell are:

a) it will use more memory for the bitmap
b) it will be slower, because the bitmap is doubled
c) the "ends" or "starts" bitmaps should be separate

I think I have already answered them, but I'll recap my replies:

a) yes, it will double it, but if it was ok to "waste" some memory when 
I was asked to rewrite the pmalloc allocator to not use genalloc, in 
favor of speed, I think the same criteria applies here: on average it 
will probably take at most one more page per pool. It doesn't seem a 
huge loss.

b) the bitmap size is doubled, that much is true, however interleaving 
the "busy" and "start" bitmaps will ensure locality of the meta data and 
between the cache prefetch algorithm and the hints give to the compiler, 
it shouldn't make a huge difference, compared to the pre-patch case.
Oh, and the size of a bitmap seems to be overall negligible, from what 
users I saw.

c) "busy" and "start" are interleaved, to avoid having to do explicit 
locking, instead of relying on the intrinsic atomicity of accessing 
bitfields coming from the same word, as it is now.

And I'm anyway proposing to merge this into linux-next, so that there 
are more eyeballs looking for problems. I'm not proposing to merge it 
straight in the next kernel release.
Removing the size parameter from the various gen_pool_free() will impact 
not only the direct callers, but also their callers and so on, which 
means that it will take some time to purge all the layers of calls from 
"size".

During this time, it's likely that issues will surface, if there is any 
lurking.

And the removal of the parameter will require getting ACK from each 
user, so it should be enough to ensure that everyone is happy about the 
overall performance.

But I would start addressing the security issue, since I think the cost 
of doubling the bitmap will not be noticeable.

I'd like to hear if you disagree with my reasoning.

And did I overlook some other objection?

--
igor
