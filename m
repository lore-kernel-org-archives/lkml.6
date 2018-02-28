Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751737AbeB1Cir (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 21:38:47 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57760 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751463AbeB1Ciq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 21:38:46 -0500
Subject: Re: [PATCH RFC 2/2] vhost: packed ring support
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, wexu@redhat.com,
        jfreimann@redhat.com
References: <1518575829-1431-1-git-send-email-jasowang@redhat.com>
 <1518575829-1431-3-git-send-email-jasowang@redhat.com>
 <20180227090319.h7hxmxp5rpozrb5s@debian>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4a77554f-a4ce-a1d7-97c4-ffeb56bf1c90@redhat.com>
Date: Wed, 28 Feb 2018 10:38:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180227090319.h7hxmxp5rpozrb5s@debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年02月27日 17:03, Tiwei Bie wrote:
> On Wed, Feb 14, 2018 at 10:37:09AM +0800, Jason Wang wrote:
> [...]
>> +static void set_desc_used(struct vhost_virtqueue *vq,
>> +			  struct vring_desc_packed *desc, bool wrap_counter)
>> +{
>> +	__virtio16 flags = desc->flags;
>> +
>> +	if (wrap_counter) {
>> +		desc->flags |= cpu_to_vhost16(vq, DESC_AVAIL);
>> +		desc->flags |= cpu_to_vhost16(vq, DESC_USED);
>> +	} else {
>> +		desc->flags &= ~cpu_to_vhost16(vq, DESC_AVAIL);
>> +		desc->flags &= ~cpu_to_vhost16(vq, DESC_USED);
>> +	}
>> +
>> +	desc->flags = flags;
> The `desc->flags` is restored after the change.

Right, will fix.

>> +}
>> +
>> +static int vhost_get_vq_desc_packed(struct vhost_virtqueue *vq,
>> +				    struct iovec iov[], unsigned int iov_size,
>> +				    unsigned int *out_num, unsigned int *in_num,
>> +				    struct vhost_log *log,
>> +				    unsigned int *log_num)
>> +{
>> +	struct vring_desc_packed desc;
>> +	int ret, access, i;
>> +	u16 avail_idx = vq->last_avail_idx;
>> +
>> +	/* When we start there are none of either input nor output. */
>> +	*out_num = *in_num = 0;
>> +	if (unlikely(log))
>> +		*log_num = 0;
>> +
>> +	do {
>> +		unsigned int iov_count = *in_num + *out_num;
>> +
>> +		i = vq->last_avail_idx & (vq->num - 1);
> The queue size may not be a power of 2 in packed ring.

Will fix this too.

Thanks

> Best regards,
> Tiwei Bie
