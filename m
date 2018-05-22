Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeEVM2A (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 08:28:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45624 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751161AbeEVM15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 08:27:57 -0400
Subject: Re: [RFC PATCH net-next 02/12] vhost_net: introduce
 vhost_exceeds_weight()
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
References: <1526893473-20128-1-git-send-email-jasowang@redhat.com>
 <1526893473-20128-3-git-send-email-jasowang@redhat.com>
 <20180521092923.00005cec@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ab546c2a-182f-830b-0e81-56a50da80677@redhat.com>
Date: Tue, 22 May 2018 20:27:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180521092923.00005cec@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年05月22日 00:29, Jesse Brandeburg wrote:
> On Mon, 21 May 2018 17:04:23 +0800 Jason wrote:
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   drivers/vhost/net.c | 13 ++++++++-----
>>   1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
>> index 15d191a..de544ee 100644
>> --- a/drivers/vhost/net.c
>> +++ b/drivers/vhost/net.c
>> @@ -479,6 +479,12 @@ static size_t init_iov_iter(struct vhost_virtqueue *vq, struct iov_iter *iter,
>>   	return len;
>>   }
>>   
>> +static bool vhost_exceeds_weight(int pkts, int total_len)
>> +{
>> +	return unlikely(total_len >= VHOST_NET_WEIGHT) ||
>> +	       unlikely(pkts >= VHOST_NET_PKT_WEIGHT);
> I was going to say just one unlikely, but then the caller of this
> function also says unlikely(vhost_exceeds...), so I think you should
> just drop the unlikely statements here (both of them)

Ok.

>
>> +}
>> +
>>   /* Expects to be always run from workqueue - which acts as
>>    * read-size critical section for our kind of RCU. */
>>   static void handle_tx(struct vhost_net *net)
>> @@ -570,7 +576,6 @@ static void handle_tx(struct vhost_net *net)
>>   			msg.msg_control = NULL;
>>   			ubufs = NULL;
>>   		}
>> -
> unrelated whitespace changes?

Yes.

Thanks

>
>>   		total_len += len;
>>   		if (total_len < VHOST_NET_WEIGHT &&
>>   		    !vhost_vq_avail_empty(&net->dev, vq) &&
>> @@ -600,8 +605,7 @@ static void handle_tx(struct vhost_net *net)
>>   		else
>>   			vhost_zerocopy_signal_used(net, vq);
>>   		vhost_net_tx_packet(net);
>> -		if (unlikely(total_len >= VHOST_NET_WEIGHT) ||
>> -		    unlikely(++sent_pkts >= VHOST_NET_PKT_WEIGHT)) {
>> +		if (unlikely(vhost_exceeds_weight(++sent_pkts, total_len))) {
>>   			vhost_poll_queue(&vq->poll);
>>   			break;
>>   		}
>> @@ -887,8 +891,7 @@ static void handle_rx(struct vhost_net *net)
>>   		if (unlikely(vq_log))
>>   			vhost_log_write(vq, vq_log, log, vhost_len);
>>   		total_len += vhost_len;
>> -		if (unlikely(total_len >= VHOST_NET_WEIGHT) ||
>> -		    unlikely(++recv_pkts >= VHOST_NET_PKT_WEIGHT)) {
>> +		if (unlikely(vhost_exceeds_weight(++recv_pkts, total_len))) {
>>   			vhost_poll_queue(&vq->poll);
>>   			goto out;
>>   		}
