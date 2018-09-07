Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7062C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61624205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61624205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeIGII3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 04:08:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38534 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725999AbeIGII3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 04:08:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C0283401EF3D;
        Fri,  7 Sep 2018 03:29:42 +0000 (UTC)
Received: from [10.72.12.125] (ovpn-12-125.pek2.redhat.com [10.72.12.125])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 622C010F1BFF;
        Fri,  7 Sep 2018 03:29:37 +0000 (UTC)
Subject: Re: [PATCH net-next 06/11] tuntap: split out XDP logic
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
References: <20180906040526.22518-1-jasowang@redhat.com>
 <20180906040526.22518-7-jasowang@redhat.com>
 <20180906131703-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <84ae17c1-f34b-610d-a5a1-ba8dce1732f3@redhat.com>
Date:   Fri, 7 Sep 2018 11:29:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906131703-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 07 Sep 2018 03:29:42 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 07 Sep 2018 03:29:42 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年09月07日 01:21, Michael S. Tsirkin wrote:
> On Thu, Sep 06, 2018 at 12:05:21PM +0800, Jason Wang wrote:
>> This patch split out XDP logic into a single function. This make it to
>> be reused by XDP batching path in the following patch.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   drivers/net/tun.c | 84 ++++++++++++++++++++++++++++-------------------
>>   1 file changed, 51 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index 389aa0727cc6..21b125020b3b 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
>> @@ -1635,6 +1635,44 @@ static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
>>   	return true;
>>   }
>>   
>> +static u32 tun_do_xdp(struct tun_struct *tun,
>> +		      struct tun_file *tfile,
>> +		      struct bpf_prog *xdp_prog,
>> +		      struct xdp_buff *xdp,
>> +		      int *err)
>> +{
>> +	u32 act = bpf_prog_run_xdp(xdp_prog, xdp);
>> +
>> +	switch (act) {
>> +	case XDP_REDIRECT:
>> +		*err = xdp_do_redirect(tun->dev, xdp, xdp_prog);
>> +		xdp_do_flush_map();
>> +		if (*err)
>> +			break;
>> +		goto out;
>> +	case XDP_TX:
>> +		*err = tun_xdp_tx(tun->dev, xdp);
>> +		if (*err < 0)
>> +			break;
>> +		*err = 0;
>> +		goto out;
>> +	case XDP_PASS:
>> +		goto out;
> Do we need goto? why not just return?

I don't see any difference.

>
>> +	default:
>> +		bpf_warn_invalid_xdp_action(act);
>> +		/* fall through */
>> +	case XDP_ABORTED:
>> +		trace_xdp_exception(tun->dev, xdp_prog, act);
>> +		/* fall through */
>> +	case XDP_DROP:
>> +		break;
>> +	}
>> +
>> +	put_page(virt_to_head_page(xdp->data_hard_start));
> put here because caller does get_page :( Not pretty.
> I'd move this out to the caller.

Then we need a switch in the caller, not sure it's better.

>
>> +out:
>> +	return act;
> How about combining err and act? err is < 0 XDP_PASS is > 0.
> No need for pointers then.

Ok.

>
>> +}
>> +
>>   static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>>   				     struct tun_file *tfile,
>>   				     struct iov_iter *from,
>> @@ -1645,10 +1683,10 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>>   	struct sk_buff *skb = NULL;
>>   	struct bpf_prog *xdp_prog;
>>   	int buflen = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>> -	unsigned int delta = 0;
>>   	char *buf;
>>   	size_t copied;
>> -	int err, pad = TUN_RX_PAD;
>> +	int pad = TUN_RX_PAD;
>> +	int err = 0;
>>   
>>   	rcu_read_lock();
>>   	xdp_prog = rcu_dereference(tun->xdp_prog);
>> @@ -1685,9 +1723,8 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>>   	local_bh_disable();
>>   	rcu_read_lock();
>>   	xdp_prog = rcu_dereference(tun->xdp_prog);
>> -	if (xdp_prog && !*skb_xdp) {
>> +	if (xdp_prog) {
>>   		struct xdp_buff xdp;
>> -		void *orig_data;
>>   		u32 act;
>>   
>>   		xdp.data_hard_start = buf;
>> @@ -1695,33 +1732,14 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>>   		xdp_set_data_meta_invalid(&xdp);
>>   		xdp.data_end = xdp.data + len;
>>   		xdp.rxq = &tfile->xdp_rxq;
>> -		orig_data = xdp.data;
>> -		act = bpf_prog_run_xdp(xdp_prog, &xdp);
>> -
>> -		switch (act) {
>> -		case XDP_REDIRECT:
>> -			err = xdp_do_redirect(tun->dev, &xdp, xdp_prog);
>> -			xdp_do_flush_map();
>> -			if (err)
>> -				goto err_xdp;
>> -			goto out;
>> -		case XDP_TX:
>> -			if (tun_xdp_tx(tun->dev, &xdp) < 0)
>> -				goto err_xdp;
>> -			goto out;
>> -		case XDP_PASS:
>> -			delta = orig_data - xdp.data;
>> -			len = xdp.data_end - xdp.data;
>> -			break;
>> -		default:
>> -			bpf_warn_invalid_xdp_action(act);
>> -			/* fall through */
>> -		case XDP_ABORTED:
>> -			trace_xdp_exception(tun->dev, xdp_prog, act);
>> -			/* fall through */
>> -		case XDP_DROP:
>> +		act = tun_do_xdp(tun, tfile, xdp_prog, &xdp, &err);
>> +		if (err)
>>   			goto err_xdp;
>> -		}
>> +		if (act != XDP_PASS)
>> +			goto out;
> likely?

It depends on the XDP program, so I tend not to use it.

>
>> +
>> +		pad = xdp.data - xdp.data_hard_start;
>> +		len = xdp.data_end - xdp.data;
>>   	}
>>   	rcu_read_unlock();
>>   	local_bh_enable();
>> @@ -1729,18 +1747,18 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>>   build:
>>   	skb = build_skb(buf, buflen);
>>   	if (!skb) {
>> +		put_page(alloc_frag->page);
>>   		skb = ERR_PTR(-ENOMEM);
>>   		goto out;
>>   	}
>>   
>> -	skb_reserve(skb, pad - delta);
>> +	skb_reserve(skb, pad);
>>   	skb_put(skb, len);
>>   
>>   	return skb;
>>   
>>   err_xdp:
>> -	alloc_frag->offset -= buflen;
>> -	put_page(alloc_frag->page);
>> +	this_cpu_inc(tun->pcpu_stats->rx_dropped);
>
> This fixes bug in previous patch which dropped it. OK :)

Yes, but let me move this to the buggy patch.

Thanks

>>   out:
>>   	rcu_read_unlock();
>>   	local_bh_enable();
>> -- 
>> 2.17.1

