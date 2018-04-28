Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759527AbeD1CqA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 22:46:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43578 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1759215AbeD1Cp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 22:45:59 -0400
Subject: Re: [RFC v3 0/5] virtio: support packed ring
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, wexu@redhat.com,
        jfreimann@redhat.com
References: <20180425051550.24342-1-tiwei.bie@intel.com>
 <5ad1ca01-1e5c-7105-f303-7e8d42f6a068@redhat.com>
 <20180427071725-mutt-send-email-mst@kernel.org>
 <5c712aa2-f00e-b472-cdfc-48175aea790d@redhat.com>
 <20180427091234.n6vr3wcnbnqxd3so@debian>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e6629eba-3bfc-cbb7-8f74-9ffd8e178b57@redhat.com>
Date: Sat, 28 Apr 2018 10:45:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427091234.n6vr3wcnbnqxd3so@debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年04月27日 17:12, Tiwei Bie wrote:
> On Fri, Apr 27, 2018 at 02:17:51PM +0800, Jason Wang wrote:
>> On 2018年04月27日 12:18, Michael S. Tsirkin wrote:
>>> On Fri, Apr 27, 2018 at 11:56:05AM +0800, Jason Wang wrote:
>>>> On 2018年04月25日 13:15, Tiwei Bie wrote:
>>>>> Hello everyone,
>>>>>
>>>>> This RFC implements packed ring support in virtio driver.
>>>>>
>>>>> Some simple functional tests have been done with Jason's
>>>>> packed ring implementation in vhost:
>>>>>
>>>>> https://lkml.org/lkml/2018/4/23/12
>>>>>
>>>>> Both of ping and netperf worked as expected (with EVENT_IDX
>>>>> disabled). But there are below known issues:
>>>>>
>>>>> 1. Reloading the guest driver will break the Tx/Rx;
>>>> Will have a look at this issue.
>>>>
>>>>> 2. Zeroing the flags when detaching a used desc will
>>>>>       break the guest -> host path.
>>>> I still think zeroing flags is unnecessary or even a bug. At host, I track
>>>> last observed avail wrap counter and detect avail like (what is suggested in
>>>> the example code in the spec):
>>>>
>>>> static bool desc_is_avail(struct vhost_virtqueue *vq, __virtio16 flags)
>>>> {
>>>>          bool avail = flags & cpu_to_vhost16(vq, DESC_AVAIL);
>>>>
>>>>          return avail == vq->avail_wrap_counter;
>>>> }
>>>>
>>>> So zeroing wrap can not work with this obviously.
>>>>
>>>> Thanks
>>> I agree. I think what one should do is flip the available bit.
>>>
>> But is this flipping a must?
>>
>> Thanks
> Yeah, that's my question too. It seems to be a requirement
> for driver that, the only change to the desc status that a
> driver can do during running is to mark the desc as avail,
> and any other changes to the desc status are not allowed.
> Similarly, the device can only mark the desc as used, and
> any other changes to the desc status are also not allowed.
> So the question is, are there such requirements?

Looks not, but I think we need clarify this in the spec.

Thanks

>
> Based on below contents in the spec:
>
> """
> Thus VIRTQ_DESC_F_AVAIL and VIRTQ_DESC_F_USED bits are different
> for an available descriptor and equal for a used descriptor.
>
> Note that this observation is mostly useful for sanity-checking
> as these are necessary but not sufficient conditions
> """
>
> It seems that, it's necessary for devices to check whether
> the AVAIL bit and USED bit are different.
>
> Best regards,
> Tiwei Bie
