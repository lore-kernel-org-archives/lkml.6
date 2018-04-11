Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752857AbeDKCSY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 22:18:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49662 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752298AbeDKCSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 22:18:22 -0400
Subject: Re: [virtio-dev] Re: [RFC] vhost: introduce mdev based hardware vhost
 backend
To: "Liang, Cunming" <cunming.liang@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        "Bie, Tiwei" <tiwei.bie@intel.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "ddutile@redhat.com" <ddutile@redhat.com>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org"
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Daly, Dan" <dan.daly@intel.com>,
        "Wang, Zhihong" <zhihong.wang@intel.com>,
        "Tan, Jianfeng" <jianfeng.tan@intel.com>,
        "Wang, Xiao W" <xiao.w.wang@intel.com>
References: <20180402152330.4158-1-tiwei.bie@intel.com>
 <622f4bd7-1249-5545-dc5a-5a92b64f5c26@redhat.com>
 <20180410045723.rftsb7l4l3ip2ioi@debian>
 <7ee31a12-a370-fc43-82a6-2235f598e970@redhat.com>
 <D0158A423229094DA7ABF71CF2FA0DA34E9222F4@SHSMSX104.ccr.corp.intel.com>
 <20180410163105-mutt-send-email-mst@kernel.org>
 <D0158A423229094DA7ABF71CF2FA0DA34E9226AF@SHSMSX104.ccr.corp.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <cb784844-9305-839a-3291-0e37ebfefbc7@redhat.com>
Date: Wed, 11 Apr 2018 10:18:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <D0158A423229094DA7ABF71CF2FA0DA34E9226AF@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年04月10日 22:23, Liang, Cunming wrote:
>> -----Original Message-----
>> From: Michael S. Tsirkin [mailto:mst@redhat.com]
>> Sent: Tuesday, April 10, 2018 9:36 PM
>> To: Liang, Cunming<cunming.liang@intel.com>
>> Cc: Paolo Bonzini<pbonzini@redhat.com>; Bie, Tiwei<tiwei.bie@intel.com>;
>> Jason Wang<jasowang@redhat.com>;alex.williamson@redhat.com;
>> ddutile@redhat.com; Duyck, Alexander H<alexander.h.duyck@intel.com>;
>> virtio-dev@lists.oasis-open.org;linux-kernel@vger.kernel.org;
>> kvm@vger.kernel.org;virtualization@lists.linux-foundation.org;
>> netdev@vger.kernel.org; Daly, Dan<dan.daly@intel.com>; Wang, Zhihong
>> <zhihong.wang@intel.com>; Tan, Jianfeng<jianfeng.tan@intel.com>; Wang, Xiao
>> W<xiao.w.wang@intel.com>
>> Subject: Re: [virtio-dev] Re: [RFC] vhost: introduce mdev based hardware vhost
>> backend
>>
>> On Tue, Apr 10, 2018 at 09:23:53AM +0000, Liang, Cunming wrote:
>>>> -----Original Message-----
>>>> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
>>>> Sent: Tuesday, April 10, 2018 3:52 PM
>>>> To: Bie, Tiwei<tiwei.bie@intel.com>; Jason Wang
>>>> <jasowang@redhat.com>
>>>> Cc:mst@redhat.com;alex.williamson@redhat.com;ddutile@redhat.com;
>>>> Duyck, Alexander H<alexander.h.duyck@intel.com>;
>>>> virtio-dev@lists.oasis- open.org;linux-kernel@vger.kernel.org;
>>>> kvm@vger.kernel.org;virtualization@lists.linux-foundation.org;
>>>> netdev@vger.kernel.org; Daly, Dan<dan.daly@intel.com>; Liang,
>>>> Cunming<cunming.liang@intel.com>; Wang, Zhihong
>>>> <zhihong.wang@intel.com>; Tan, Jianfeng<jianfeng.tan@intel.com>;
>>>> Wang, Xiao W<xiao.w.wang@intel.com>
>>>> Subject: Re: [virtio-dev] Re: [RFC] vhost: introduce mdev based
>>>> hardware vhost backend
>>>>
>>>> On 10/04/2018 06:57, Tiwei Bie wrote:
>>>>>> So you just move the abstraction layer from qemu to kernel, and
>>>>>> you still need different drivers in kernel for different device
>>>>>> interfaces of accelerators. This looks even more complex than
>>>>>> leaving it in qemu. As you said, another idea is to implement
>>>>>> userspace vhost backend for accelerators which seems easier and
>>>>>> could co-work with other parts of qemu without inventing new type of
>> messages.
>>>>> I'm not quite sure. Do you think it's acceptable to add various
>>>>> vendor specific hardware drivers in QEMU?
>>>> I think so.  We have vendor-specific quirks, and at some point there
>>>> was an idea of using quirks to implement (vendor-specific) live
>>>> migration support for assigned devices.
>>> Vendor-specific quirks of accessing VGA is a small portion. Other major portions
>> are still handled by guest driver.
>>> While in this case, when saying various vendor specific drivers in QEMU, it says
>> QEMU takes over and provides the entire user space device drivers. Some parts
>> are even not relevant to vhost, they're basic device function enabling. Moreover,
>> it could be different kinds of devices(network/block/...) under vhost. No matter
>> # of vendors or # of types, total LOC is not small.
>>> The idea is to avoid introducing these extra complexity out of QEMU, keeping
>> vhost adapter simple. As vhost protocol is de factor standard, it leverages kernel
>> device driver to provide the diversity. Changing once in QEMU, then it supports
>> multi-vendor devices whose drivers naturally providing kernel driver there.
>>> If QEMU is going to build a user space driver framework there, we're open mind
>> on that, even leveraging DPDK as the underlay library. Looking forward to more
>> others' comments from community.
>>> Steve
>> Dependency on a kernel driver is fine IMHO. It's the dependency on a DPDK
>> backend that makes people unhappy, since the functionality in question is setup-
>> time only.
> Agreed, we don't see dependency on kernel driver is a problem.

At engineering level, kernel driver is harder than userspace driver.

>
> mdev based vhost backend (this patch set) is independent with vhost-user extension patch set. In fact, there're a few vhost-user providers, DPDK librte_vhost is one of them. FD.IO/VPP and snabbswitch have their own vhost-user providers. So I can't agree on vhost-user extension patch depends on DPDK backend. But anyway, that's the topic of another mail thread.
>

Well we can treat mdev as another kind of transport of vhost-user. And 
technically we can even implement a relay mdev than forward vhost-user 
messages to dpdk.

Thanks
