Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DA1C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 04:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CDF72086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 04:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CDF72086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbeLNEAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 23:00:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55864 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbeLNEAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 23:00:13 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7756DC049D7F;
        Fri, 14 Dec 2018 04:00:13 +0000 (UTC)
Received: from [10.72.12.142] (ovpn-12-142.pek2.redhat.com [10.72.12.142])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F1F45D6A9;
        Fri, 14 Dec 2018 04:00:05 +0000 (UTC)
Subject: Re: [PATCH net-next 1/3] vhost: generalize adding used elem
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181213101022.12475-1-jasowang@redhat.com>
 <20181213101022.12475-2-jasowang@redhat.com>
 <20181213144027-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <bca9a3a1-0d42-e028-8145-aa2153432571@redhat.com>
Date:   Fri, 14 Dec 2018 12:00:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181213144027-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 14 Dec 2018 04:00:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/12/14 上午3:41, Michael S. Tsirkin wrote:
> On Thu, Dec 13, 2018 at 06:10:20PM +0800, Jason Wang wrote:
>> Use one generic vhost_copy_to_user() instead of two dedicated
>> accessor. This will simplify the conversion to fine grain accessors.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> The reason we did it like this is because it was faster.
> Want to try benchmarking before we change it?


Faster is a good side effect of such conversion. Otherwise we need two 
new fine grain memory accessor.

But, anyway, I can test its impact.

Thanks


>
>> ---
>>   drivers/vhost/vhost.c | 11 +----------
>>   1 file changed, 1 insertion(+), 10 deletions(-)
>>
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index 3a5f81a66d34..1c54ec1b82f8 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -2164,16 +2164,7 @@ static int __vhost_add_used_n(struct vhost_virtqueue *vq,
>>   
>>   	start = vq->last_used_idx & (vq->num - 1);
>>   	used = vq->used->ring + start;
>> -	if (count == 1) {
>> -		if (vhost_put_user(vq, heads[0].id, &used->id)) {
>> -			vq_err(vq, "Failed to write used id");
>> -			return -EFAULT;
>> -		}
>> -		if (vhost_put_user(vq, heads[0].len, &used->len)) {
>> -			vq_err(vq, "Failed to write used len");
>> -			return -EFAULT;
>> -		}
>> -	} else if (vhost_copy_to_user(vq, used, heads, count * sizeof *used)) {
>> +	if (vhost_copy_to_user(vq, used, heads, count * sizeof *used)) {
>>   		vq_err(vq, "Failed to write used");
>>   		return -EFAULT;
>>   	}
>> -- 
>> 2.17.1
