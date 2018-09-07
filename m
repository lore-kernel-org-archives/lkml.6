Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EECC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A519F2075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A519F2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbeIGIBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 04:01:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40272 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725957AbeIGIBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 04:01:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C173BDC3E;
        Fri,  7 Sep 2018 03:22:16 +0000 (UTC)
Received: from [10.72.12.125] (ovpn-12-125.pek2.redhat.com [10.72.12.125])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3220910073C0;
        Fri,  7 Sep 2018 03:22:03 +0000 (UTC)
Subject: Re: [PATCH net-next 04/11] tuntap: simplify error handling in
 tun_build_skb()
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
References: <20180906040526.22518-1-jasowang@redhat.com>
 <20180906040526.22518-5-jasowang@redhat.com>
 <20180906130425-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <e1f17f51-5f99-df18-4185-6c6e4dfaba89@redhat.com>
Date:   Fri, 7 Sep 2018 11:22:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906130425-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 07 Sep 2018 03:22:16 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 07 Sep 2018 03:22:16 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年09月07日 01:14, Michael S. Tsirkin wrote:
> On Thu, Sep 06, 2018 at 12:05:19PM +0800, Jason Wang wrote:
>> There's no need to duplicate page get logic in each action. So this
>> patch tries to get page and calculate the offset before processing XDP
>> actions, and undo them when meet errors (we don't care the performance
>> on errors). This will be used for factoring out XDP logic.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> I see some issues with this one.
>
>> ---
>>   drivers/net/tun.c | 37 ++++++++++++++++---------------------
>>   1 file changed, 16 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index 372caf7d67d9..f8cdcfa392c3 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
>> @@ -1642,7 +1642,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>>   				     int len, int *skb_xdp)
>>   {
>>   	struct page_frag *alloc_frag = &current->task_frag;
>> -	struct sk_buff *skb;
>> +	struct sk_buff *skb = NULL;
>>   	struct bpf_prog *xdp_prog;
>>   	int buflen = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>>   	unsigned int delta = 0;
>> @@ -1668,6 +1668,9 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>>   	if (copied != len)
>>   		return ERR_PTR(-EFAULT);
>>   
>> +	get_page(alloc_frag->page);
>> +	alloc_frag->offset += buflen;
>> +
> This adds an atomic op on XDP_DROP which is a data path
> operation for some workloads.

Yes, I have patch on top to amortize this, the idea is to have a very 
big refcount once after the frag was allocated and maintain a bias and 
decrease them all when allocating new frags.'

>
>>   	/* There's a small window that XDP may be set after the check
>>   	 * of xdp_prog above, this should be rare and for simplicity
>>   	 * we do XDP on skb in case the headroom is not enough.
>> @@ -1695,23 +1698,15 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>>   
>>   		switch (act) {
>>   		case XDP_REDIRECT:
>> -			get_page(alloc_frag->page);
>> -			alloc_frag->offset += buflen;
>>   			err = xdp_do_redirect(tun->dev, &xdp, xdp_prog);
>>   			xdp_do_flush_map();
>>   			if (err)
>> -				goto err_redirect;
>> -			rcu_read_unlock();
>> -			local_bh_enable();
>> -			return NULL;
>> +				goto err_xdp;
>> +			goto out;
>>   		case XDP_TX:
>> -			get_page(alloc_frag->page);
>> -			alloc_frag->offset += buflen;
>>   			if (tun_xdp_tx(tun->dev, &xdp) < 0)
>> -				goto err_redirect;
>> -			rcu_read_unlock();
>> -			local_bh_enable();
>> -			return NULL;
>> +				goto err_xdp;
>> +			goto out;
>>   		case XDP_PASS:
>>   			delta = orig_data - xdp.data;
>>   			len = xdp.data_end - xdp.data;
>> @@ -1730,23 +1725,23 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>>   	local_bh_enable();
>>   
>>   	skb = build_skb(buf, buflen);
>> -	if (!skb)
>> -		return ERR_PTR(-ENOMEM);
>> +	if (!skb) {
>> +		skb = ERR_PTR(-ENOMEM);
>> +		goto out;
> So goto out will skip put_page, and we did
> do get_page above. Seems wrong. You should
> goto err_skb or something like this.

Yes, looks like err_xdp.

>
>
>> +	}
>>   
>>   	skb_reserve(skb, pad - delta);
>>   	skb_put(skb, len);
>> -	get_page(alloc_frag->page);
>> -	alloc_frag->offset += buflen;
>>   
>>   	return skb;
>>   
>> -err_redirect:
>> -	put_page(alloc_frag->page);
>>   err_xdp:
>> +	alloc_frag->offset -= buflen;
>> +	put_page(alloc_frag->page);
>> +out:
> Out here isn't an error at all, is it?  You should not mix return and
> error handling IMHO.

If you mean the name, I can rename the label to "drop".

>
>
>
>>   	rcu_read_unlock();
>>   	local_bh_enable();
>> -	this_cpu_inc(tun->pcpu_stats->rx_dropped);
> Doesn't this break rx_dropped accounting?

Let me fix this.

Thanks

>> -	return NULL;
>> +	return skb;
>>   }
>>   
>>   /* Get packet from user space buffer */
>> -- 
>> 2.17.1

