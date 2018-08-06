Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004EDC46470
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 03:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B543F219CB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 03:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B543F219CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbeHFFWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 01:22:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44726 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726338AbeHFFWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 01:22:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5C0AD4219DCB;
        Mon,  6 Aug 2018 03:15:46 +0000 (UTC)
Received: from [10.72.12.33] (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F039E2026D69;
        Mon,  6 Aug 2018 03:15:43 +0000 (UTC)
Subject: Re: [PATCH net-next] vhost: switch to use new message format
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533279891-12249-1-git-send-email-jasowang@redhat.com>
 <20180803105511-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <9f270c8c-e596-1e7f-f4f1-abfcdd467825@redhat.com>
Date:   Mon, 6 Aug 2018 11:15:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180803105511-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 06 Aug 2018 03:15:46 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 06 Aug 2018 03:15:46 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年08月03日 15:59, Michael S. Tsirkin wrote:
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index a502f1a..6f6c42d 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -315,6 +315,7 @@ static void vhost_vq_reset(struct vhost_dev *dev,
>>   	vq->log_addr = -1ull;
>>   	vq->private_data = NULL;
>>   	vq->acked_features = 0;
>> +	vq->acked_backend_features = 0;
>>   	vq->log_base = NULL;
>>   	vq->error_ctx = NULL;
>>   	vq->kick = NULL;
>> @@ -1027,28 +1028,40 @@ static int vhost_process_iotlb_msg(struct vhost_dev *dev,
>>   ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
>>   			     struct iov_iter *from)
>>   {
>> -	struct vhost_msg_node node;
>> -	unsigned size = sizeof(struct vhost_msg);
>> -	size_t ret;
>> -	int err;
>> +	struct vhost_iotlb_msg msg;
>> +	size_t offset;
>> +	int type, ret;
>>   
>> -	if (iov_iter_count(from) < size)
>> -		return 0;
>> -	ret = copy_from_iter(&node.msg, size, from);
>> -	if (ret != size)
>> +	ret = copy_from_iter(&type, sizeof(type), from);
>> +	if (ret != sizeof(type))
>>   		goto done;
>>   
>> -	switch (node.msg.type) {
>> +	switch (type) {
>>   	case VHOST_IOTLB_MSG:
>> -		err = vhost_process_iotlb_msg(dev, &node.msg.iotlb);
>> -		if (err)
>> -			ret = err;
>> +		/* There maybe a hole after type for V1 message type,
>> +		 * so skip it here.
>> +		 */
>> +		offset = offsetof(struct vhost_msg, iotlb) - sizeof(int);
>> +		break;
>> +	case VHOST_IOTLB_MSG_V2:
>> +		offset = sizeof(__u32);
>>   		break;
>>   	default:
>>   		ret = -EINVAL;
>> -		break;
>> +		goto done;
>> +	}
>> +
>> +	iov_iter_advance(from, offset);
>> +	ret = copy_from_iter(&msg, sizeof(msg), from);
>> +	if (ret != sizeof(msg))
>> +		goto done;
>> +	if (vhost_process_iotlb_msg(dev, &msg)) {
>> +		ret = -EFAULT;
>> +		goto done;
>>   	}
>>   
>> +	ret = (type == VHOST_IOTLB_MSG) ? sizeof(struct vhost_msg) :
>> +	      sizeof(struct vhost_msg_v2);
>>   done:
>>   	return ret;
>>   }
> We can actually fix 32 bit apps too, checking the mode for v1.
> But that can wait for another patch.
>

Yes, let me do it on top.

Thanks

