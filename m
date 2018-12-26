Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A4CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 03:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6806421720
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 03:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbeLZD7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 22:59:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbeLZD7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 22:59:53 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 707465F74C;
        Wed, 26 Dec 2018 03:59:53 +0000 (UTC)
Received: from [10.72.12.31] (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DA386101E5A5;
        Wed, 26 Dec 2018 03:59:48 +0000 (UTC)
Subject: Re: [PATCH net-next 0/3] vhost: accelerate metadata access through
 vmap()
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181213101022.12475-1-jasowang@redhat.com>
 <20181213102315-mutt-send-email-mst@kernel.org>
 <9459e227-a943-8553-732b-d7f5225a0f22@redhat.com>
 <20181214072334-mutt-send-email-mst@kernel.org>
 <b10c99a2-a9c3-595f-983e-2547325e64ad@redhat.com>
 <20181224131040-mutt-send-email-mst@kernel.org>
 <51fa034d-99ae-3820-c3a4-d9e6f2eefe34@redhat.com>
 <20181225075054-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <12c6ef6b-e0f8-6018-709e-ab290bc6eaa0@redhat.com>
Date:   Wed, 26 Dec 2018 11:59:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181225075054-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 26 Dec 2018 03:59:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/12/25 下午8:52, Michael S. Tsirkin wrote:
> On Tue, Dec 25, 2018 at 06:09:19PM +0800, Jason Wang wrote:
>> On 2018/12/25 上午2:12, Michael S. Tsirkin wrote:
>>> On Mon, Dec 24, 2018 at 04:32:39PM +0800, Jason Wang wrote:
>>>> On 2018/12/14 下午8:33, Michael S. Tsirkin wrote:
>>>>> On Fri, Dec 14, 2018 at 11:42:18AM +0800, Jason Wang wrote:
>>>>>> On 2018/12/13 下午11:27, Michael S. Tsirkin wrote:
>>>>>>> On Thu, Dec 13, 2018 at 06:10:19PM +0800, Jason Wang wrote:
>>>>>>>> Hi:
>>>>>>>>
>>>>>>>> This series tries to access virtqueue metadata through kernel virtual
>>>>>>>> address instead of copy_user() friends since they had too much
>>>>>>>> overheads like checks, spec barriers or even hardware feature
>>>>>>>> toggling.
>>>>>>> Userspace accesses through remapping tricks and next time there's a need
>>>>>>> for a new barrier we are left to figure it out by ourselves.
>>>>>> I don't get here, do you mean spec barriers?
>>>>> I mean the next barrier people decide to put into userspace
>>>>> memory accesses.
>>>>>
>>>>>> It's completely unnecessary for
>>>>>> vhost which is kernel thread.
>>>>> It's defence in depth. Take a look at the commit that added them.
>>>>> And yes quite possibly in most cases we actually have a spec
>>>>> barrier in the validation phase. If we do let's use the
>>>>> unsafe variants so they can be found.
>>>> unsafe variants can only work if you can batch userspace access. This is not
>>>> necessarily the case for light load.
>>> Do we care a lot about the light load? How would you benchmark it?
>>>
>> If we can reduce the latency that's will be more than what we expect.
>>
>> 1 byte TCP_RR shows 1.5%-2% improvement.
> It's nice but not great. E.g. adaptive polling would be
> a better approach to work on latency imho.


Actually this is another advantages of vmap():

For split ring, we will poll avail idx

For packed ring, we will poll wrap counter

Either of which can not be batched.


>
>>>>>> And even if you're right, vhost is not the
>>>>>> only place, there's lots of vmap() based accessing in kernel.
>>>>> For sure. But if one can get by without get user pages, one
>>>>> really should. Witness recently uncovered mess with file
>>>>> backed storage.
>>>> We only pin metadata pages, I don't believe they will be used by any DMA.
>>> It doesn't matter really, if you dirty pages behind the MM back
>>> the problem is there.
>>
>> Ok, but the usual case is anonymous pages, do we use file backed pages for
>> user of vhost?
> Some people use file backed pages for vms.
> Nothing prevents them from using vhost as well.


Ok.


>
>> And even if we use sometime, according to the pointer it's
>> not something that can fix, RFC has been posted to solve this issue.
>>
>> Thanks
> Except it's not broken if we don't to gup + write.
> So yea, wait for rfc to be merged.
>

Yes.

Thanks

