Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F46C43142
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 01:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2681220894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 01:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2681220894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732978AbeHADWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 23:22:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47924 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732855AbeHADWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 23:22:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3327687A74;
        Wed,  1 Aug 2018 01:39:13 +0000 (UTC)
Received: from [10.72.12.57] (ovpn-12-57.pek2.redhat.com [10.72.12.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B3622026D7E;
        Wed,  1 Aug 2018 01:39:10 +0000 (UTC)
Subject: Re: [PATCH net-next 2/2] virtio-net: get rid of unnecessary container
 of rq stats
To:     Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533030219-9904-1-git-send-email-jasowang@redhat.com>
 <1533030219-9904-2-git-send-email-jasowang@redhat.com>
 <da012c13-e438-f45e-5c41-2f159e791f00@lab.ntt.co.jp>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <d11c65d8-20be-1a85-c687-c6f182264e41@redhat.com>
Date:   Wed, 1 Aug 2018 09:39:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <da012c13-e438-f45e-5c41-2f159e791f00@lab.ntt.co.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 01 Aug 2018 01:39:13 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 01 Aug 2018 01:39:13 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年07月31日 18:02, Toshiaki Makita wrote:
> On 2018/07/31 18:43, Jason Wang wrote:
>> We don't maintain tx counters in rx stats any more. There's no need
>> for an extra container of rq stats.
>>
>> Cc: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   drivers/net/virtio_net.c | 80 ++++++++++++++++++++++--------------------------
>>   1 file changed, 36 insertions(+), 44 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 72d3f68..14f661c 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -87,7 +87,8 @@ struct virtnet_sq_stats {
>>   	u64 kicks;
>>   };
>>   
>> -struct virtnet_rq_stat_items {
>> +struct virtnet_rq_stats {
>> +	struct u64_stats_sync syncp;
>>   	u64 packets;
>>   	u64 bytes;
>>   	u64 drops;
>> @@ -98,17 +99,8 @@ struct virtnet_rq_stat_items {
>>   	u64 kicks;
>>   };
>>   
>> -struct virtnet_rq_stats {
>> -	struct u64_stats_sync syncp;
>> -	struct virtnet_rq_stat_items items;
>> -};
> I'm not thinking removing sq stat is needed but even if it is I want to
> keep virtnet_rq_stats to avoid allocating unnecessary u64_stats_syncp on
> stack in virtnet_receive. I would just remove virtnet_rx_stats if necessary.

It's a nop on 64bit machines. And an unsigned on 32bit. So it's overhead 
could be ignored I think.

Thanks

>> -
>> -struct virtnet_rx_stats {
>> -	struct virtnet_rq_stat_items rx;
>> -};
>> -

