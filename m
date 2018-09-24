Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157AEECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DDB20867
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6DDB20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731111AbeIXTal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 15:30:41 -0400
Received: from foss.arm.com ([217.140.101.70]:35760 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729307AbeIXTal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 15:30:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6199E18A;
        Mon, 24 Sep 2018 06:28:30 -0700 (PDT)
Received: from [10.1.35.70] (e110479-lin.cambridge.arm.com [10.1.35.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9448D3F5BD;
        Mon, 24 Sep 2018 06:28:28 -0700 (PDT)
Subject: Re: [Xen-devel] [PATCH] drivers/block/xen-blkback/common.h: use
 DIV_ROUND_UP instead of reimplementing its function
To:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc:     Jan Beulich <JBeulich@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        xen-devel <xen-devel@lists.xenproject.org>,
        zhong jiang <zhongjiang@huawei.com>
References: <1536731100-56054-1-git-send-email-zhongjiang@huawei.com>
 <5B98CAE202000078001E79CC@prv1-mh.provo.novell.com>
 <20180912091350.6wuvt2jkvzg6wruo@mac.bytemobile.com>
 <20180912091639.oynlvdo6pghnqfvt@mac.bytemobile.com>
 <364bad2c-708e-6406-7b52-7bfef9d5dbe1@arm.com>
 <20180912102908.4ls7vts55n2zfkdz@mac.bytemobile.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <58794c01-16f4-b124-46fe-cdcb386235de@arm.com>
Date:   Mon, 24 Sep 2018 14:28:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180912102908.4ls7vts55n2zfkdz@mac.bytemobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

On 09/12/2018 11:29 AM, Roger Pau Monné wrote:
> On Wed, Sep 12, 2018 at 10:48:42AM +0100, Julien Grall wrote:
>> Hi,
>>
>> On 09/12/2018 10:16 AM, Roger Pau Monné wrote:
>>> On Wed, Sep 12, 2018 at 11:13:50AM +0200, Roger Pau Monné wrote:
>>>> Adding Julien how did the work to support XEN_PAGE_SIZE != PAGE_SIZE.
>>>>
>>>> On Wed, Sep 12, 2018 at 02:14:26AM -0600, Jan Beulich wrote:
>>>>>>>> On 12.09.18 at 07:45, <zhongjiang@huawei.com> wrote:
>>>>>> --- a/drivers/block/xen-blkback/common.h
>>>>>> +++ b/drivers/block/xen-blkback/common.h
>>>>>> @@ -65,7 +65,7 @@
>>>>>>    	(XEN_PAGES_PER_INDIRECT_FRAME / XEN_PAGES_PER_SEGMENT)
>>>>>>    #define MAX_INDIRECT_PAGES \
>>>>>> -	((MAX_INDIRECT_SEGMENTS + SEGS_PER_INDIRECT_FRAME - 1)/SEGS_PER_INDIRECT_FRAME)
>>>>>> +		DIV_ROUND_UP(MAX_INDIRECT_SEGMENTS, SEGS_PER_INDIRECT_FRAME)
>>>>>>    #define INDIRECT_PAGES(_segs) DIV_ROUND_UP(_segs, XEN_PAGES_PER_INDIRECT_FRAME)
>>>>>
>>>>> My first reaction was to suggest
>>>>>
>>>>> #define MAX_INDIRECT_PAGES INDIRECT_PAGES(MAX_INDIRECT_SEGMENTS)
>>>>>
>>>>> but that wouldn't match what's there currently (note the two different
>>>>> divisors). I can't really decide whether that's just unfortunate naming
>>>>> of the two macros, or an actual bug.
>>>>
>>>> I think there's indeed a bug here.
>>>>
>>>> AFAICT, MAX_INDIRECT_PAGES should use XEN_PAGES_PER_INDIRECT_FRAME and
>>>> then it could be changed as Jan suggested.
>>
>> The problem is SEGS_PER_INDIRECT_FRAME has been miscalculated. So I think it
>> would be fine to use XEN_PAGES_PER_INDIRECT_FRAME in MAX_INDIRECT_PAGES.
>>
>> However the naming for XEN_PAGES_PER_INDIRECT_FRAME is misnamed. We return
>> number of a for segments per indirect frame. So I would rename to
>> SEGS_PER_INDIRECT_FRAME.
> 
> I don't think I agree with this last part, SEGS_PER_INDIRECT_FRAME
> would have to take into account XEN_PAGES_PER_SEGMENT, and
> XEN_PAGES_PER_INDIRECT_FRAME doesn't.
> 
> XEN_PAGES_PER_INDIRECT_FRAME currently returns the number of grant
> references per indirect page, but as I understand it a segment can use
> more than one grant reference, if for example the guest page size is
> 64KB.

I am a bit confused. By segment, do you refer to the backend or frontend 
segment?

In any case, it would be possible to remove SEGS_PER_INDIRECT_FRAME if 
we rework MAX_INDIRECT_PAGES(...). This should improve the readability 
as well.

Cheers,

-- 
Julien Grall
