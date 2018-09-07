Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE3BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68AE820857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68AE820857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbeIGHvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 03:51:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725785AbeIGHvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 03:51:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7E75F4023475;
        Fri,  7 Sep 2018 03:12:31 +0000 (UTC)
Received: from [10.72.12.125] (ovpn-12-125.pek2.redhat.com [10.72.12.125])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 29D87A30DD;
        Fri,  7 Sep 2018 03:12:26 +0000 (UTC)
Subject: Re: [PATCH net-next 02/11] tuntap: switch to use XDP_PACKET_HEADROOM
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
References: <20180906040526.22518-1-jasowang@redhat.com>
 <20180906040526.22518-3-jasowang@redhat.com>
 <20180906125718-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <27def3eb-1b43-ec29-7380-c8078fe7ea8f@redhat.com>
Date:   Fri, 7 Sep 2018 11:12:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906125718-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 07 Sep 2018 03:12:31 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 07 Sep 2018 03:12:31 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年09月07日 00:57, Michael S. Tsirkin wrote:
> On Thu, Sep 06, 2018 at 12:05:17PM +0800, Jason Wang wrote:
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> any idea why didn't we do this straight away?

Dunno, but git grep told me not all XDP capable driver use this (e.g 
virtio_net has its own value).

Anyway, I think it's ok for driver to have their specific value if they 
can make sure the value is equal or greater than XDP_PACKET_HEADROOM.

Thanks

>
>> ---
>>   drivers/net/tun.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index 2c548bd20393..d3677a544b56 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
>> @@ -113,7 +113,6 @@ do {								\
>>   } while (0)
>>   #endif
>>   
>> -#define TUN_HEADROOM 256
>>   #define TUN_RX_PAD (NET_IP_ALIGN + NET_SKB_PAD)
>>   
>>   /* TUN device flags */
>> @@ -1654,7 +1653,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>>   	rcu_read_lock();
>>   	xdp_prog = rcu_dereference(tun->xdp_prog);
>>   	if (xdp_prog)
>> -		pad += TUN_HEADROOM;
>> +		pad += XDP_PACKET_HEADROOM;
>>   	buflen += SKB_DATA_ALIGN(len + pad);
>>   	rcu_read_unlock();
>>   
>> -- 
>> 2.17.1

