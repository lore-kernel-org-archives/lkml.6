Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EA0C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 03:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B257205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 03:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B257205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=interlog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbeIDIBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 04:01:33 -0400
Received: from smtp.infotech.no ([82.134.31.41]:58589 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbeIDIBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 04:01:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 1661B2041E3;
        Tue,  4 Sep 2018 05:38:25 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oCJqh9IzGCMh; Tue,  4 Sep 2018 05:38:23 +0200 (CEST)
Received: from [192.168.16.56] (unknown [195.69.32.11])
        by smtp.infotech.no (Postfix) with ESMTPA id 5B6E3204179;
        Tue,  4 Sep 2018 05:38:22 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: Recent removal of bsg read/write support
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        drorl@infinidat.com, LKML <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>
References: <CAOuWhkaGjX8Q_xghkFVTqzZkDrUv-sdH=VbS7hvnqFWrT+3eOQ@mail.gmail.com>
 <CAFLxGvxX8QW4wUJKommXVMpGBj7G_H3=SOwQGjGuyPZZrhCzKw@mail.gmail.com>
 <6b907fed-d83f-de75-bde4-11270a0b1b0b@interlog.com>
 <20180903122804.GA15074@dhcp22.suse.cz>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <731941f0-c80d-605a-2750-01c8d5ec4dd9@interlog.com>
Date:   Tue, 4 Sep 2018 05:38:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180903122804.GA15074@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-03 02:28 PM, Michal Hocko wrote:
> On Sun 02-09-18 21:16:10, Douglas Gilbert wrote:
>> On 2018-09-02 01:44 PM, Richard Weinberger wrote:
>>> CC'ing relevant people. Otherwise your mail might get lost.
>>>
>>> On Sun, Sep 2, 2018 at 1:37 PM Dror Levin <drorl@infinidat.com> wrote:
>>>>
>>>> Note: I am not subscribed to LKML so please CC replies to this email.
>>>>
>>>> Hi,
>>>>
>>>> We have an internal tool that uses the bsg read/write interface to
>>>> issue SCSI commands as part of a test suite for a storage device.
>>>>
>>>> After recently reading on LWN that this interface is to be removed we
>>>> tried porting our code to use sg instead. However, that raises new
>>>> issues - mainly getting ENOMEM over iSCSI for unknown reasons.
>>>>
>>>> Because of this we would like to continue using the bsg interface,
>>>> even if some changes are required to meet security concerns.
>>>>
>>>> Is there any chance for this removal to be reverted? I saw it was
>>>> already included in 4.19-rc1.
>>
>> Hi,
>> Both bsg and sg are relatively thin shims over the same block layer
>> pass-through calls. And neither driver will themselves generate ENOMEM
>> unless the CPU is running low of memory.
>>
>> In my experience, the main reason for unexpected ENOMEMs *** is from
>> blk_rq_map_user_iov() in block/blk_map.c called from both drivers.
>> That is a particular resource shortage rather than memory in general.
>> I do notice the blk_rq_map_user_iov() is/was called with GFP_KERNEL
>> in bsg and GFP_ATOMIC by sg. That suggests when you call write() on
>> a sg device and get ENOMEM, then wait a little (depends on your app)
>> and try again.
> 
> Well, what is the reason to use GFP_ATOMIC in the first place? I am not
> familiar with the code so I might be easily wrong but sg_start_req which
> calls blk_rq_map_user_iov resp. blk_rq_map_user with GFP_ATOMIC uses
> mutex. It is a conditional usage so the sleeping context might depend
> on the caller. But I guess it would be better to double check. It looks
> suspicious to me.

Of the hundreds of 'hacks' on the sg driver over the years, the most
common is an expert arguing that GFP_ATOMIC should be changed to GFP_KERNEL.
They usually get their way. That is followed around 6 to 9 months later by
a sg user complaining about an unexpected broken app. So back it goes to
GFP_ATOMIC.

Welcome to the merry-go-round.

Doug Gilbert

