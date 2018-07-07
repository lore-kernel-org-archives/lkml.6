Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FE8C3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC28221CD0
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC28221CD0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754131AbeGGB25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 21:28:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753956AbeGGB24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 21:28:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7C65D4075184;
        Sat,  7 Jul 2018 01:28:55 +0000 (UTC)
Received: from [10.72.12.18] (ovpn-12-18.pek2.redhat.com [10.72.12.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5739A2026D68;
        Sat,  7 Jul 2018 01:28:49 +0000 (UTC)
Subject: Re: [PATCH v3 3/3] uio: fix crash after the device is unregistered
To:     Mike Christie <mchristi@redhat.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     hamish.martin@alliedtelesis.co.nz, jannh@google.com,
        pkalever@redhat.com, pkarampu@redhat.com, atumball@redhat.com,
        sabose@redhat.com
References: <1530845836-49101-1-git-send-email-xiubli@redhat.com>
 <1530845836-49101-4-git-send-email-xiubli@redhat.com>
 <5B3FB3B0.7010105@redhat.com>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <1d3a72f6-2d48-1e36-82e4-c764c5359765@redhat.com>
Date:   Sat, 7 Jul 2018 09:28:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <5B3FB3B0.7010105@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Sat, 07 Jul 2018 01:28:55 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Sat, 07 Jul 2018 01:28:55 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'xiubli@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/7 2:23, Mike Christie wrote:
> On 07/05/2018 09:57 PM, xiubli@redhat.com wrote:
>>   static irqreturn_t uio_interrupt(int irq, void *dev_id)
>>   {
>>   	struct uio_device *idev = (struct uio_device *)dev_id;
>> -	irqreturn_t ret = idev->info->handler(irq, idev->info);
>> +	irqreturn_t ret;
>> +
>> +	mutex_lock(&idev->info_lock);
>> +	if (!idev->info) {
>> +		ret = IRQ_NONE;
>> +		goto out;
>> +	}
>>   
>> +	ret = idev->info->handler(irq, idev->info);
>>   	if (ret == IRQ_HANDLED)
>>   		uio_event_notify(idev->info);
>>   
>> +out:
>> +	mutex_unlock(&idev->info_lock);
>>   	return ret;
>>   }
>
> Do you need the interrupt related changes in this patch and the first
> one?
Actually, the NULL checking is not a must, we can remove this. But the 
lock/unlock is needed.
>   When we do uio_unregister_device -> free_irq does free_irq return
> when there are no longer running interrupt handlers that we requested?
>
> If that is not the case then I think we can hit a similar bug. We do:
>
> __uio_register_device -> device_register -> device's refcount goes to
> zero so we do -> uio_device_release -> kfree(idev)
>
> and if it is possible the interrupt handler could still run after
> free_irq then we would end up doing:
>
> uio_interrupt -> mutex_lock(&idev->info_lock) -> idev access freed memory.

I think this shouldn't happen. Because the free_irq function does not 
return until any executing interrupts for this IRQ have completed.

Thanks,
BRs

