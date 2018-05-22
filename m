Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751441AbeEVMbt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 08:31:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60744 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751172AbeEVMbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 08:31:45 -0400
Subject: Re: [RFC PATCH net-next 03/12] vhost_net: introduce
 vhost_has_more_pkts()
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
References: <1526893473-20128-1-git-send-email-jasowang@redhat.com>
 <1526893473-20128-4-git-send-email-jasowang@redhat.com>
 <20180521093908.00006747@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f0573c9a-7d24-4f3c-1e45-7ca14fcf43e1@redhat.com>
Date: Tue, 22 May 2018 20:31:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180521093908.00006747@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年05月22日 00:39, Jesse Brandeburg wrote:
> On Mon, 21 May 2018 17:04:24 +0800 Jason wrote:
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   drivers/vhost/net.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
>> index de544ee..4ebac76 100644
>> --- a/drivers/vhost/net.c
>> +++ b/drivers/vhost/net.c
>> @@ -485,6 +485,13 @@ static bool vhost_exceeds_weight(int pkts, int total_len)
>>   	       unlikely(pkts >= VHOST_NET_PKT_WEIGHT);
>>   }
>>   
>> +static bool vhost_has_more_pkts(struct vhost_net *net,
>> +				struct vhost_virtqueue *vq)
>> +{
>> +	return !vhost_vq_avail_empty(&net->dev, vq) &&
>> +	       likely(!vhost_exceeds_maxpend(net));
> This really seems like mis-use of likely/unlikely, in the middle of a
> sequence of operations that will always be run when this function is
> called.  I think you should remove the likely from this helper,
> especially, and control the branch from the branch point.

Yes, so I'm consider to make it a macro in next version.

>
>
>> +}
>> +
>>   /* Expects to be always run from workqueue - which acts as
>>    * read-size critical section for our kind of RCU. */
>>   static void handle_tx(struct vhost_net *net)
>> @@ -578,8 +585,7 @@ static void handle_tx(struct vhost_net *net)
>>   		}
>>   		total_len += len;
>>   		if (total_len < VHOST_NET_WEIGHT &&
>> -		    !vhost_vq_avail_empty(&net->dev, vq) &&
>> -		    likely(!vhost_exceeds_maxpend(net))) {
>> +		    vhost_has_more_pkts(net, vq)) {
> Yes, I know it came from here, but likely/unlikely are for branch
> control, so they should encapsulate everything inside the if, unless
> I'm mistaken.

Ok.

>
>>   			msg.msg_flags |= MSG_MORE;
>>   		} else {
>>   			msg.msg_flags &= ~MSG_MORE;
>> @@ -605,7 +611,7 @@ static void handle_tx(struct vhost_net *net)
>>   		else
>>   			vhost_zerocopy_signal_used(net, vq);
>>   		vhost_net_tx_packet(net);
>> -		if (unlikely(vhost_exceeds_weight(++sent_pkts, total_len))) {
>> +		if (vhost_exceeds_weight(++sent_pkts, total_len)) {
> You should have kept the unlikely here, and not had it inside the
> helper (as per the previous patch.  Also, why wasn't this change part
> of the previous patch?

Yes, will squash the above into previous one.

Thanks

>
>>   			vhost_poll_queue(&vq->poll);
>>   			break;
>>   		}
