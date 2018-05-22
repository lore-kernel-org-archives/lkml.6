Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751439AbeEVImw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 04:42:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751002AbeEVImu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 04:42:50 -0400
Subject: Re: KASAN: use-after-free Read in vhost_chr_write_iter
To: DaeRyong Jeong <threeearcat@gmail.com>
Cc: mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, byoungyoung@purdue.edu, kt0755@gmail.com,
        bammanag@purdue.edu
References: <20180517134544.GA20646@dragonet.kaist.ac.kr>
 <58419d62-3074-2e5a-8504-da1cdeb08280@redhat.com>
 <fb27c1fd-5172-252a-cb8f-b53927a26d06@redhat.com>
 <20180522083842.GA10604@dragonet.kaist.ac.kr>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <231a857d-88b9-8bb3-3b57-fd62683c3e5c@redhat.com>
Date: Tue, 22 May 2018 16:42:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180522083842.GA10604@dragonet.kaist.ac.kr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年05月22日 16:38, DaeRyong Jeong wrote:
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
> Sorry to say this, but we don't have a reproducer for this bug since our
> reproducer is being implemented.
>
> This crash had occrued a few times in our fuzzer, so I inspected the code
> manually.
>
> It seems the patch is good for me, but we can't test the patch for now.
> Sorry.
>

No problem.

I'm trying to craft a reproducer, looks not hard.

Thanks
