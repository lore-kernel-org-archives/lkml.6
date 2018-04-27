Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757409AbeD0GSE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 02:18:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43994 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757286AbeD0GSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 02:18:03 -0400
Subject: Re: [RFC v3 0/5] virtio: support packed ring
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Tiwei Bie <tiwei.bie@intel.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, wexu@redhat.com,
        jfreimann@redhat.com
References: <20180425051550.24342-1-tiwei.bie@intel.com>
 <5ad1ca01-1e5c-7105-f303-7e8d42f6a068@redhat.com>
 <20180427071725-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5c712aa2-f00e-b472-cdfc-48175aea790d@redhat.com>
Date: Fri, 27 Apr 2018 14:17:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427071725-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年04月27日 12:18, Michael S. Tsirkin wrote:
> On Fri, Apr 27, 2018 at 11:56:05AM +0800, Jason Wang wrote:
>> On 2018年04月25日 13:15, Tiwei Bie wrote:
>>> Hello everyone,
>>>
>>> This RFC implements packed ring support in virtio driver.
>>>
>>> Some simple functional tests have been done with Jason's
>>> packed ring implementation in vhost:
>>>
>>> https://lkml.org/lkml/2018/4/23/12
>>>
>>> Both of ping and netperf worked as expected (with EVENT_IDX
>>> disabled). But there are below known issues:
>>>
>>> 1. Reloading the guest driver will break the Tx/Rx;
>> Will have a look at this issue.
>>
>>> 2. Zeroing the flags when detaching a used desc will
>>>      break the guest -> host path.
>> I still think zeroing flags is unnecessary or even a bug. At host, I track
>> last observed avail wrap counter and detect avail like (what is suggested in
>> the example code in the spec):
>>
>> static bool desc_is_avail(struct vhost_virtqueue *vq, __virtio16 flags)
>> {
>>         bool avail = flags & cpu_to_vhost16(vq, DESC_AVAIL);
>>
>>         return avail == vq->avail_wrap_counter;
>> }
>>
>> So zeroing wrap can not work with this obviously.
>>
>> Thanks
> I agree. I think what one should do is flip the available bit.
>

But is this flipping a must?

Thanks
