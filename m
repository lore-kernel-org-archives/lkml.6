Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6606BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111BE206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111BE206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbeK2BAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:00:50 -0500
Received: from p3plsmtpa06-07.prod.phx3.secureserver.net ([173.201.192.108]:44231
        "EHLO p3plsmtpa06-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727982AbeK2BAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:00:49 -0500
Received: from [192.168.0.67] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id S0MngfZg7ni8jS0MoghsbC; Wed, 28 Nov 2018 06:59:03 -0700
Subject: Re: [PATCH v2 0/6] RFC: gup+dma: tracking dma-pinned pages
To:     John Hubbard <jhubbard@nvidia.com>, john.hubbard@gmail.com,
        linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
References: <20181110085041.10071-1-jhubbard@nvidia.com>
 <942cb823-9b18-69e7-84aa-557a68f9d7e9@talpey.com>
 <97934904-2754-77e0-5fcb-83f2311362ee@nvidia.com>
 <5159e02f-17f8-df8b-600c-1b09356e46a9@talpey.com>
 <c1ba07d6-ebfa-ddb9-c25e-e5c1bfbecf74@nvidia.com>
 <15e4a0c0-cadd-e549-962f-8d9aa9fc033a@talpey.com>
 <313bf82d-cdeb-8c75-3772-7a124ecdfbd5@nvidia.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <2aa422df-d5df-5ddb-a2e4-c5e5283653b5@talpey.com>
Date:   Wed, 28 Nov 2018 08:59:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <313bf82d-cdeb-8c75-3772-7a124ecdfbd5@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfEUOUA/Dtx5D4bHWTOFfzCY1RsRK6VifvlxARI47AoJKAzVMXEUQ4Vl1HxCBF1B0woh6lnnWRFhkGDKkfwOt8NS1z6yuhZNAQCYd+124NVsmZUVD7S9B
 iUE5j7vblWAAwYAGVq+ghmcNBjIy6RHJUdDLyhmhaPSne/QHauM2wgxq3webM5exIFmtF5e4bC/8o8k8mTFWK2yU2ofEy27uTb/69fEHyQFGkzePh0d5Ir7a
 ZzmB+5YoI2AbOszGAFitesw8vkofkbYmPHaC6Q1LUMxTK5PNqL5r/7yxcjMmFgnS9+sFENh/nDLKDMvslPuJ1carheHRQYRQC4j8KpkOUDFVNRu4offVeS9x
 /WeflB1aSBGSfPXBLWWs7rrlVIxHIeBD/zX7meQ73WdQU6VcXmA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/2018 9:52 PM, John Hubbard wrote:
> On 11/27/18 5:21 PM, Tom Talpey wrote:
>> On 11/21/2018 5:06 PM, John Hubbard wrote:
>>> On 11/21/18 8:49 AM, Tom Talpey wrote:
>>>> On 11/21/2018 1:09 AM, John Hubbard wrote:
>>>>> On 11/19/18 10:57 AM, Tom Talpey wrote:
> [...]
>>>>
>>>> What I'd really like to see is to go back to the original fio parameters
>>>> (1 thread, 64 iodepth) and try to get a result that gets at least close
>>>> to the speced 200K IOPS of the NVMe device. There seems to be something
>>>> wrong with yours, currently.
>>>
>>> I'll dig into what has gone wrong with the test. I see fio putting data files
>>> in the right place, so the obvious "using the wrong drive" is (probably)
>>> not it. Even though it really feels like that sort of thing. We'll see.
>>>
>>>>
>>>> Then of course, the result with the patched get_user_pages, and
>>>> compare whichever of IOPS or CPU% changes, and how much.
>>>>
>>>> If these are within a few percent, I agree it's good to go. If it's
>>>> roughly 25% like the result just above, that's a rocky road.
>>>>
>>>> I can try this after the holiday on some basic hardware and might
>>>> be able to scrounge up better. Can you post that github link?
>>>>
>>>
>>> Here:
>>>
>>>      git@github.com:johnhubbard/linux (branch: gup_dma_testing)
>>
>> I'm super-limited here this week hardware-wise and have not been able
>> to try testing with the patched kernel.
>>
>> I was able to compare my earlier quick test with a Bionic 4.15 kernel
>> (400K IOPS) against a similar 4.20rc3 kernel, and the rate dropped to
>> ~_375K_ IOPS. Which I found perhaps troubling. But it was only a quick
>> test, and without your change.
>>
> 
> So just to double check (again): you are running fio with these parameters,
> right?
> 
> [reader]
> direct=1
> ioengine=libaio
> blocksize=4096
> size=1g
> numjobs=1
> rw=read
> iodepth=64

Correct, I copy/pasted these directly. I also ran with size=10g because
the 1g provides a really small sample set.

There was one other difference, your results indicated fio 3.3 was used.
My Bionic install has fio 3.1. I don't find that relevant because our
goal is to compare before/after, which I haven't done yet.

Tom.

> 
> 
> 
>> Say, that branch reports it has not had a commit since June 30. Is that
>> the right one? What about gup_dma_for_lpc_2018?
>>
> 
> That's the right branch, but the AuthorDate for the head commit (only) somehow
> got stuck in the past. I just now amended that patch with a new date and pushed
> it, so the head commit now shows Nov 27:
> 
>     https://github.com/johnhubbard/linux/commits/gup_dma_testing
> 
> 
> The actual code is the same, though. (It is still based on Nov 19th's f2ce1065e767
> commit.)
> 
> 
> thanks,
> 
