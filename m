Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751553AbeEVM0s (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 08:26:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751340AbeEVM0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 08:26:46 -0400
Subject: Re: [RFC PATCH net-next 01/12] vhost_net: introduce helper to
 initialize tx iov iter
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
References: <1526893473-20128-1-git-send-email-jasowang@redhat.com>
 <1526893473-20128-2-git-send-email-jasowang@redhat.com>
 <20180521092400.00004c68@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2d54d4e2-c5fc-167b-9a8d-762aed2d1ba5@redhat.com>
Date: Tue, 22 May 2018 20:26:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180521092400.00004c68@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年05月22日 00:24, Jesse Brandeburg wrote:
> Hi Jason, a few nits.
>
> On Mon, 21 May 2018 17:04:22 +0800 Jason wrote:
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   drivers/vhost/net.c | 34 +++++++++++++++++++++++-----------
>>   1 file changed, 23 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
>> index c4b49fc..15d191a 100644
>> --- a/drivers/vhost/net.c
>> +++ b/drivers/vhost/net.c
>> @@ -459,6 +459,26 @@ static bool vhost_exceeds_maxpend(struct vhost_net *net)
>>   	       min_t(unsigned int, VHOST_MAX_PEND, vq->num >> 2);
>>   }
>>   
>> +static size_t init_iov_iter(struct vhost_virtqueue *vq, struct iov_iter *iter,
>> +			    size_t hdr_size, int out)
>> +{
>> +	/* Skip header. TODO: support TSO. */
>> +	size_t len = iov_length(vq->iov, out);
>> +
>> +	iov_iter_init(iter, WRITE, vq->iov, out, len);
>> +	iov_iter_advance(iter, hdr_size);
>> +	/* Sanity check */
>> +	if (!iov_iter_count(iter)) {
>> +		vq_err(vq, "Unexpected header len for TX: "
>> +			"%zd expected %zd\n",
>> +			len, hdr_size);
> ok, it was like this before, but please unwrap the string in " ", there
> should be no line breaks in string declarations and they are allowed to
> go over 80 characters.

Ok.

>
>> +		return -EFAULT;
>> +	}
>> +	len = iov_iter_count(iter);
>> +
>> +	return len;
>> +}
>> +
>>   /* Expects to be always run from workqueue - which acts as
>>    * read-size critical section for our kind of RCU. */
>>   static void handle_tx(struct vhost_net *net)
>> @@ -521,18 +541,10 @@ static void handle_tx(struct vhost_net *net)
>>   			       "out %d, int %d\n", out, in);
>>   			break;
>>   		}
>> -		/* Skip header. TODO: support TSO. */
>> -		len = iov_length(vq->iov, out);
>> -		iov_iter_init(&msg.msg_iter, WRITE, vq->iov, out, len);
>> -		iov_iter_advance(&msg.msg_iter, hdr_size);
>> -		/* Sanity check */
>> -		if (!msg_data_left(&msg)) {
>> -			vq_err(vq, "Unexpected header len for TX: "
>> -			       "%zd expected %zd\n",
>> -			       len, hdr_size);
>> +
>> +		len = init_iov_iter(vq, &msg.msg_iter, hdr_size, out);
>> +		if (len < 0)
> len is declared as size_t, which is unsigned, and can never be
> negative.  I'm pretty sure this is a bug.

Yes, let me fix it in next version.

Thanks

>
>
>>   			break;
>> -		}
>> -		len = msg_data_left(&msg);
>>   
>>   		zcopy_used = zcopy && len >= VHOST_GOODCOPY_LEN
>>   				   && !vhost_exceeds_maxpend(net)
