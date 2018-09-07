Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9283DC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 522D920857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 522D920857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbeIGICx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 04:02:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40308 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725785AbeIGICx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 04:02:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A40FC738F0;
        Fri,  7 Sep 2018 03:24:09 +0000 (UTC)
Received: from [10.72.12.125] (ovpn-12-125.pek2.redhat.com [10.72.12.125])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B38A10F1BFF;
        Fri,  7 Sep 2018 03:24:05 +0000 (UTC)
Subject: Re: [PATCH net-next 05/11] tuntap: tweak on the path of non-xdp case
 in tun_build_skb()
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
References: <20180906040526.22518-1-jasowang@redhat.com>
 <20180906040526.22518-6-jasowang@redhat.com>
 <20180906131509-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <8a5b5db7-ce53-7dc5-7410-0b6d51b5bf10@redhat.com>
Date:   Fri, 7 Sep 2018 11:24:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906131509-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 07 Sep 2018 03:24:09 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 07 Sep 2018 03:24:09 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年09月07日 01:16, Michael S. Tsirkin wrote:
> On Thu, Sep 06, 2018 at 12:05:20PM +0800, Jason Wang wrote:
>> If we're sure not to go native XDP, there's no need for several things
>> like bh and rcu stuffs.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> True...
>
>> ---
>>   drivers/net/tun.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index f8cdcfa392c3..389aa0727cc6 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
>> @@ -1675,10 +1675,12 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>>   	 * of xdp_prog above, this should be rare and for simplicity
>>   	 * we do XDP on skb in case the headroom is not enough.
>>   	 */
>> -	if (hdr->gso_type || !xdp_prog)
>> +	if (hdr->gso_type || !xdp_prog) {
>>   		*skb_xdp = 1;
>> -	else
>> -		*skb_xdp = 0;
>> +		goto build;
>> +	}
>> +
>> +	*skb_xdp = 0;
>>   
>>   	local_bh_disable();
>>   	rcu_read_lock();
>> @@ -1724,6 +1726,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>>   	rcu_read_unlock();
>>   	local_bh_enable();
>>   
>> +build:
> But this is spaghetti code. Please just put common
> code into functions and call them, don't goto.

Ok, will do this.

Thanks

>
>>   	skb = build_skb(buf, buflen);
>>   	if (!skb) {
>>   		skb = ERR_PTR(-ENOMEM);
>> -- 
>> 2.17.1

