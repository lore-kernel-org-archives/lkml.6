Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A84C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3543621B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VCiYF5ZR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbfBOTW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:22:56 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:48098 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfBOTWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:22:55 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1FJMXB5002046;
        Fri, 15 Feb 2019 13:22:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550258553;
        bh=Wz062inumZg+GMp1aWcO8D5uT8CL/zet1HCrakkQ+m4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=VCiYF5ZRD7QSkqKWZ/ENpzNZlFePqtXkKBGC6N5kzoEHpem92ON8fYxuZC+HGB4jc
         JmDPxgyqquiLIpDRRuoxYjQBLpZSfXrsAWonGJzod3qVCxtmShzckQ1yA4skdWNdhv
         p4pj6wN0vOVeUB7OW6RmGzGLQ8qdXoyZddIvXjBA=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1FJMXxw096210
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Feb 2019 13:22:33 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 15
 Feb 2019 13:22:32 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 15 Feb 2019 13:22:32 -0600
Received: from [172.22.98.110] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1FJMVgs016336;
        Fri, 15 Feb 2019 13:22:31 -0600
Subject: Re: [PATCH v2] staging: android: ion: Allocate from heap ID directly
 without mask
To:     John Stultz <john.stultz@linaro.org>,
        Brian Starkey <Brian.Starkey@arm.com>
CC:     Laura Abbott <labbott@redhat.com>,
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
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <0cc81357-034b-9c74-8172-2a7a26e77804@ti.com>
Date:   Fri, 15 Feb 2019 13:22:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CALAqxLU=L3Y7KJEo9c-Nu1rS3EquofGf1UGWBWqAO+Qke72Ekw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/19 1:01 PM, John Stultz wrote:
> On Fri, Feb 15, 2019 at 2:51 AM Brian Starkey <Brian.Starkey@arm.com> wrote:
>>
>> Hi John,
>>
>> On Thu, Feb 14, 2019 at 09:38:29AM -0800, John Stultz wrote:
>>>
>> [snip]
>>
>>> Some thoughts, as this ABI break has the potential to be pretty painful.
>>>
>>> 1) Unfortunately, this ABI is exposed *through* libion via
>>> ion_alloc/ion_alloc_fd out to gralloc implementations. Which means it
>>> will have a wider impact to vendor userland code.
>>
>> I figured libion could fairly easily loop through all the set bits in
>> heap_mask and call the ioctl for each until it succeeds. That
>> preserves the old behaviour from the libion clients' perspective.
> 
> Potentially, though that implicitly still caps the heaps to 32.  So
> I'm not sure what the net benefit would be.
> 

That is a libion problem, libion can expose an un-capped API and users
can migrate.

> 
>>> 2) For patches that cause ABI breaks, it might be good to make it
>>> clear in the commit what the userland impact looks like in userspace,
>>> possibly with an example, so the poor folks who bisect down the change
>>> as breaking their system in a year or so have a clear example as to
>>> what they need to change in their code.
>>>
>>> 3) Also, its not clear how a given userland should distinguish between
>>> the different ABIs.  We already have logic in libion to distinguish
>>> between pre-4.12 legacy and post-4.12 implementations (using implicit
>>> ion_free() behavior). I don't see any such check we can make with this
>>> code. Adding another ABI version may require we provide an actual
>>> interface version ioctl.
>>>
>>
>> A slightly fragile/ugly approach might be to attempt a small
>> allocation with a heap_mask of 0xffffffff. On an "old" implementation,
>> you'd expect that to succeed, whereas it would/could be made to fail
>> in the "new" one.
> 
> Yea I think having a proper ION_IOC_VERSION is going to be necessary.
> 

I think that will be helpful to have ready the future just looking at
the way libdrm does things, but not right now as backwards compatibility
with staging code is not a reasonable thing to do.

> I'm hoping to send out an ugly first stab at the kernel side for
> switching to per-heap devices (with a config for keeping /dev/ion for
> legacy compat), which I hope will address the core issue this patch
> does (moving away from heap masks to specifically requested heaps).
> 

Yes, that would remove the need for what this patch does.
Question though, what does the user side look like for this? With the
old /dev/ion we would:

ion_fd = open("/dev/ion")
ask for a list of heaps (ioctl on ion_fd)
iterate over the details of each heap
pick the best heap for the job
request allocation from that heap (ioctl on ion_fd)

with per-heap devs we need some way to iterate all over heap devices in
a system, and extract details from each heap device. Maybe we leave
/dev/ion but it's only job is to service ION_IOC_HEAP_QUERY requests but
instead of heap numbers it returns heap names, then device files just
match those names. Then we go allocate() from those.

If all that is addressed in your patch-set then feel free to ignore this
question :)

Andrew

> thanks
> -john
> 
