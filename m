Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932134AbeEWI55 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 04:57:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754334AbeEWI5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 04:57:54 -0400
Subject: Re: [RFC V4 PATCH 7/8] vhost: packed ring support
To: Wei Xu <wexu@redhat.com>
Cc: mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jfreimann@redhat.com,
        tiwei.bie@intel.com
References: <1526473941-16199-1-git-send-email-jasowang@redhat.com>
 <1526473941-16199-8-git-send-email-jasowang@redhat.com>
 <20180522165448.GA13523@wei-ubt>
 <e12d4055-6ae6-4d00-ae8b-1acd88633f48@redhat.com>
 <20180523071727.GA13373@wei-ubt>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d2f9192f-9a4c-da35-72b5-c55df1efc01e@redhat.com>
Date: Wed, 23 May 2018 16:57:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180523071727.GA13373@wei-ubt>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年05月23日 15:17, Wei Xu wrote:
> On Wed, May 23, 2018 at 09:39:28AM +0800, Jason Wang wrote:
>>
>> On 2018年05月23日 00:54, Wei Xu wrote:
>>> On Wed, May 16, 2018 at 08:32:20PM +0800, Jason Wang wrote:
>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>> ---
>>>>   drivers/vhost/net.c   |   3 +-
>>>>   drivers/vhost/vhost.c | 539 ++++++++++++++++++++++++++++++++++++++++++++++----
>>>>   drivers/vhost/vhost.h |   8 +-
>>>>   3 files changed, 513 insertions(+), 37 deletions(-)
>>>>
>>>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>>>> index 8304c30..f2a0f5b 100644
>>>> --- a/drivers/vhost/vhost.c
>>>> +++ b/drivers/vhost/vhost.c
>>>> @@ -1358,6 +1382,8 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
>>>>   			break;
>>>>   		}
>>>>   		vq->last_avail_idx = s.num;
>>>> +		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
>>>> +			vq->avail_wrap_counter = s.num >> 31;
>>>>   		/* Forget the cached index value. */
>>>>   		vq->avail_idx = vq->last_avail_idx;
>>>>   		break;
>>>> @@ -1366,6 +1392,8 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
>>>>   		s.num = vq->last_avail_idx;
>>>>   		if (copy_to_user(argp, &s, sizeof s))
>>>>   			r = -EFAULT;
>>>> +		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
>>>> +			s.num |= vq->avail_wrap_counter << 31;
>>>>   		break;
>>>>   	case VHOST_SET_VRING_ADDR:
>>>>   		if (copy_from_user(&a, argp, sizeof a)) {
>>> 'last_used_idx' also needs to be saved/restored here.
>>>
>>> I have figured out the root cause of broken device after reloading
>>> 'virtio-net' module, all indices have been reset for a reloading but
>>> 'last_used_idx' is not properly reset in this case. This confuses
>>> handle_rx()/tx().
>>>
>>> Wei
>>>
>> Good catch, so we probably need a new ioctl to sync between qemu and vhost.
>>
>> Something like VHOST_SET/GET_USED_BASE.
> Sure, or can we expand 'vhost_vring_state' to keep them done in a bunch?

It's port of uapi, so we can't.

Thanks

>
>> Thanks
>>
