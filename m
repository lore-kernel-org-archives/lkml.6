Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752663AbeEVDun (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 23:50:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38240 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751745AbeEVDui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 23:50:38 -0400
Subject: Re: KASAN: use-after-free Read in vhost_chr_write_iter
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: DaeRyong Jeong <threeearcat@gmail.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, byoungyoung@purdue.edu, kt0755@gmail.com,
        bammanag@purdue.edu
References: <20180517134544.GA20646@dragonet.kaist.ac.kr>
 <58419d62-3074-2e5a-8504-da1cdeb08280@redhat.com>
 <fb27c1fd-5172-252a-cb8f-b53927a26d06@redhat.com>
 <20180521173645-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <51cf8274-162f-384b-0ff7-47fbf15412f1@redhat.com>
Date: Tue, 22 May 2018 11:50:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180521173645-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年05月21日 22:42, Michael S. Tsirkin wrote:
> On Mon, May 21, 2018 at 10:38:10AM +0800, Jason Wang wrote:
>> On 2018年05月18日 17:24, Jason Wang wrote:
>>> On 2018年05月17日 21:45, DaeRyong Jeong wrote:
>>>> We report the crash: KASAN: use-after-free Read in vhost_chr_write_iter
>>>>
>>>> This crash has been found in v4.17-rc1 using RaceFuzzer (a modified
>>>> version of Syzkaller), which we describe more at the end of this
>>>> report. Our analysis shows that the race occurs when invoking two
>>>> syscalls concurrently, write$vnet and ioctl$VHOST_RESET_OWNER.
>>>>
>>>>
>>>> Analysis:
>>>> We think the concurrent execution of vhost_process_iotlb_msg() and
>>>> vhost_dev_cleanup() causes the crash.
>>>> Both of functions can run concurrently (please see call sequence below),
>>>> and possibly, there is a race on dev->iotlb.
>>>> If the switch occurs right after vhost_dev_cleanup() frees
>>>> dev->iotlb, vhost_process_iotlb_msg() still sees the non-null value
>>>> and it
>>>> keep executing without returning -EFAULT. Consequently, use-after-free
>>>> occures
>>>>
>>>>
>>>> Thread interleaving:
>>>> CPU0 (vhost_process_iotlb_msg)                CPU1 (vhost_dev_cleanup)
>>>> (In the case of both VHOST_IOTLB_UPDATE and
>>>> VHOST_IOTLB_INVALIDATE)
>>>> =====                            =====
>>>>                              vhost_umem_clean(dev->iotlb);
>>>> if (!dev->iotlb) {
>>>>              ret = -EFAULT;
>>>>                  break;
>>>> }
>>>>                              dev->iotlb = NULL;
>>>>
>>>>
>>>> Call Sequence:
>>>> CPU0
>>>> =====
>>>> vhost_net_chr_write_iter
>>>>      vhost_chr_write_iter
>>>>          vhost_process_iotlb_msg
>>>>
>>>> CPU1
>>>> =====
>>>> vhost_net_ioctl
>>>>      vhost_net_reset_owner
>>>>          vhost_dev_reset_owner
>>>>              vhost_dev_cleanup
>>> Thanks a lot for the analysis.
>>>
>>> This could be addressed by simply protect it with dev mutex.
>>>
>>> Will post a patch.
>>>
>> Could you please help to test the attached patch? I've done some smoking
>> test.
>>
>> Thanks
>> >From 88328386f3f652e684ee33dc4cf63dcaed871aea Mon Sep 17 00:00:00 2001
>> From: Jason Wang<jasowang@redhat.com>
>> Date: Fri, 18 May 2018 17:33:27 +0800
>> Subject: [PATCH] vhost: synchronize IOTLB message with dev cleanup
>>
>> DaeRyong Jeong reports a race between vhost_dev_cleanup() and
>> vhost_process_iotlb_msg():
>>
>> Thread interleaving:
>> CPU0 (vhost_process_iotlb_msg)			CPU1 (vhost_dev_cleanup)
>> (In the case of both VHOST_IOTLB_UPDATE and
>> VHOST_IOTLB_INVALIDATE)
>> =====						=====
>> 						vhost_umem_clean(dev->iotlb);
>> if (!dev->iotlb) {
>> 	        ret = -EFAULT;
>> 		        break;
>> }
>> 						dev->iotlb = NULL;
>>
>> The reason is we don't synchronize between them, fixing by protecting
>> vhost_process_iotlb_msg() with dev mutex.
>>
>> Reported-by: DaeRyong Jeong<threeearcat@gmail.com>
>> Fixes: 6b1e6cc7855b0 ("vhost: new device IOTLB API")
>> Reported-by: DaeRyong Jeong<threeearcat@gmail.com>
> Long terms we might want to move iotlb into vqs
> so that messages can be processed in parallel.
> Not sure how to do it yet.
>

Then we probably need to extend IOTLB msg to have a queue idx. But I 
thinkit was probably only help if we split tx/rx into separate processes.

Thanks
