Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD820C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81289222D9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vZ28FmUx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387739AbfBOUwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 15:52:25 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49396 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfBOUwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 15:52:24 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1FKorbP037442;
        Fri, 15 Feb 2019 14:50:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550263853;
        bh=VUig7V8UrXaQb08bBtcxSkheC2gh59csCkNt6HjvHgQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=vZ28FmUx5P1M1gyRIzTh8ysFl1qHyrFkfEM5KW2nMEj/O3cbcGmL/uB2HmHwXNf/9
         H1v+hMfnzofC2Y/EhPYuJHvmZN6tM+XlhNg3q5X09U9xitMGKD9E3R4iVUy1IxKFjA
         Ab9ONcgoXz4ivAk3Ilm7k36ac7Z/edkRURh0J1b4=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1FKor0Z070577
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Feb 2019 14:50:53 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 15
 Feb 2019 14:50:53 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 15 Feb 2019 14:50:53 -0600
Received: from [172.22.98.110] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1FKoqg5003180;
        Fri, 15 Feb 2019 14:50:52 -0600
Subject: Re: [PATCH v2] staging: android: ion: Allocate from heap ID directly
 without mask
To:     John Stultz <john.stultz@linaro.org>
CC:     Brian Starkey <Brian.Starkey@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        Christoph Hellwig <hch@infradead.org>,
        Liam Mark <lmark@codeaurora.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, nd <nd@arm.com>
References: <20190128214408.25442-1-afd@ti.com>
 <CALAqxLXb53nsBJtb958sMzpr-fnXxqFE0s2B6YJzoGcswv50wg@mail.gmail.com>
 <20190215105057.jujgm4k77rhkvmo7@DESKTOP-E1NTVVP.localdomain>
 <CALAqxLU=L3Y7KJEo9c-Nu1rS3EquofGf1UGWBWqAO+Qke72Ekw@mail.gmail.com>
 <0cc81357-034b-9c74-8172-2a7a26e77804@ti.com>
 <CALAqxLXe8KHvx_ce10_W_0uxBsLBsyWw+B9J-fzZU5vTY8VC+Q@mail.gmail.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <bbfb51f3-c703-7bb7-db83-311945ef2be9@ti.com>
Date:   Fri, 15 Feb 2019 14:50:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CALAqxLXe8KHvx_ce10_W_0uxBsLBsyWw+B9J-fzZU5vTY8VC+Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/19 1:58 PM, John Stultz wrote:
> On Fri, Feb 15, 2019 at 11:22 AM Andrew F. Davis <afd@ti.com> wrote:
>>
>> On 2/15/19 1:01 PM, John Stultz wrote:
>>> On Fri, Feb 15, 2019 at 2:51 AM Brian Starkey <Brian.Starkey@arm.com> wrote:
>>>> On Thu, Feb 14, 2019 at 09:38:29AM -0800, John Stultz wrote:
>>>>> 2) For patches that cause ABI breaks, it might be good to make it
>>>>> clear in the commit what the userland impact looks like in userspace,
>>>>> possibly with an example, so the poor folks who bisect down the change
>>>>> as breaking their system in a year or so have a clear example as to
>>>>> what they need to change in their code.
>>>>>
>>>>> 3) Also, its not clear how a given userland should distinguish between
>>>>> the different ABIs.  We already have logic in libion to distinguish
>>>>> between pre-4.12 legacy and post-4.12 implementations (using implicit
>>>>> ion_free() behavior). I don't see any such check we can make with this
>>>>> code. Adding another ABI version may require we provide an actual
>>>>> interface version ioctl.
>>>>>
>>>>
>>>> A slightly fragile/ugly approach might be to attempt a small
>>>> allocation with a heap_mask of 0xffffffff. On an "old" implementation,
>>>> you'd expect that to succeed, whereas it would/could be made to fail
>>>> in the "new" one.
>>>
>>> Yea I think having a proper ION_IOC_VERSION is going to be necessary.
>>>
>>
>> I think that will be helpful to have ready the future just looking at
>> the way libdrm does things, but not right now as backwards compatibility
>> with staging code is not a reasonable thing to do.
> 
> I'm not sure I'm following what you mean here?  While we don't have
> any commitment to userland for interfaces in staging, the reality is
> that there are a fair number of users affected, and we probably should
> avoid causing any needless pain if possible.
> 
> Further, as part of my work, I try to keep the hikey boards with an
> array of kernels (4.4, 4.9, 4.14, 4.19 and mainline) running with AOSP
> master. Having hard build breaks so AOSP has to have build time
> dependencies on newer or older kernels is a big pain, and the 4.12 ABI
> break was not easy.
> 
> So yea, I don't think we should tie our hands in reworking the
> interfaces, but it would be nice to avoid having subtle ABI changes
> that don't have clear ways for userland to detect which interface
> version its using.
> 

Let me preference this by pointing out I've dealt with the same pain
internally with our Android and soon to also in AOSP for the Beagle x15
boards[0].. But my stance matches Christoph's in the other ION thread:

https://lkml.org/lkml/2019/1/19/53

The more freely we can make ABI changes here in staging the quicker we
can get this out of staging where the ABI can be locked down.
ION_IOC_VERSION should solve this anyway.

>>> I'm hoping to send out an ugly first stab at the kernel side for
>>> switching to per-heap devices (with a config for keeping /dev/ion for
>>> legacy compat), which I hope will address the core issue this patch
>>> does (moving away from heap masks to specifically requested heaps).
>>>
>>
>> Yes, that would remove the need for what this patch does.
>> Question though, what does the user side look like for this? With the
>> old /dev/ion we would:
>>
>> ion_fd = open("/dev/ion")
>> ask for a list of heaps (ioctl on ion_fd)
>> iterate over the details of each heap
>> pick the best heap for the job
>> request allocation from that heap (ioctl on ion_fd)
>>
>> with per-heap devs we need some way to iterate all over heap devices in
>> a system, and extract details from each heap device. Maybe we leave
>> /dev/ion but it's only job is to service ION_IOC_HEAP_QUERY requests but
>> instead of heap numbers it returns heap names, then device files just
>> match those names. Then we go allocate() from those.
>>
> 
> 
> So my initial thought is we simply use a /dev/ion_heaps/ dir which has
> a list of heap devicenodes. /dev/ion goes away.
> 
> Currently ION_IOC_HEAP_QUERY returns:
>   char name[MAX_HEAP_NAME];
>   __u32 type;
>   __u32 heap_id;
> 
> The names are discoverable via "ls /dev/ion_heaps/"
> 
> The heap_id is really only useful as a handle, and after opening the
> heap device, we'll have the fd to use.
> 

So why have heap_id at all then?

> The only detail we're missing is the type. I'm a little skeptical how
> useful type is, but worse case we provide a QUERY ioctl on the heap
> device to provide type info.
> 
> Most likely, I expect users to:
> 1) Open "/dev/ion_heaps/<heapname>" for the heap they want (since they
> probably already know)
> 2) make a HEAP_ALLOCATE ioctl on the fd to allocate
> 
> But to match the use case you describe:
> 1) ls /dev/ion_heaps/ for a list of heaps

Yuk, dirent.h and friends :(

> 2) For each heap name, open the heap and make a QUERY ioctl to get
> type info (for what its worth)
> 3) Pick best heap for the job (*handwaving magic!*)
> 4) Do an ALLOC ioctl on the heap's fd to allocate
> 
> 
> Does that sound reasonable?  And I don't really mean to dismiss the
> dynamic picking of the best heap part, and having something like a
> opaque constraints bitfield that each device and each heap export so
> userland can match things up would be great.  But since we don't have
> any real solutions there yet(still!), it seems like most gralloc
> implementations are likely to be fully knowing which heap they want at
> allocation time.
> 

I think you already touched on my main issue with this, the dynamic
picking not supported. Well, like you said it doesn't really exist now
either. And this doesn't look to stop one from adding it as some ioctl
extensions..

Okay, looks like you posted an RFC, lets move the discussion over to
that thread.

Andrew

[0] https://android.googlesource.com/device/ti/beagle-x15/

> thanks
> -john
> 
