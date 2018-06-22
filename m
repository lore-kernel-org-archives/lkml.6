Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DCAC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4026423DFB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X8143tQr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kQm7e4uz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4026423DFB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751194AbeFVHEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 03:04:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46460 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750886AbeFVHEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:04:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7BB5460714; Fri, 22 Jun 2018 07:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529651044;
        bh=LaXr7iFtgOjQNnwRtISsfO6vz338MEX0S/l2gRh8qg4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=X8143tQr7FaPs9xUDZfzIuMmhxjX6r5rU3k7uyHZHBkZXDIPcFg8Ry902dwol0s8u
         6zjkJD14pWgQNO0TcFQe3y7MHiy9kzrFzkfADPbhPuOl1u6/n5WcBLT1CeOy+f74U3
         qEzEgaOym4ZdMTEIszwJrDdZkjHrPfD0NaAVw04c=
Received: from [10.204.66.249] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akhilpo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A539D60227;
        Fri, 22 Jun 2018 07:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529651043;
        bh=LaXr7iFtgOjQNnwRtISsfO6vz338MEX0S/l2gRh8qg4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kQm7e4uzTXg9495Rg9QHOdCCL3HZLSjf93ouBu173wal3LhPItxYpNXjw9gCXkyfi
         UtAFlkRqMo+JUCsdyboXU6sx5YB3+hmNCa/i/Ayy9E1oeCabrRrN7ijGuvPN2X/Jq4
         yhjacfuW9tdVt5YIZ6vgOYqrdpv8o3HNbTYdmwMk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A539D60227
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=akhilpo@codeaurora.org
Subject: Re: [PATCH v3] PM / devfreq: Fix devfreq_add_device() when drivers
 are built as modules.
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-pm@vger.kernel.org
References: <20180621220430.25644-1-enric.balletbo@collabora.com>
 <0383b4a703a0b619023c0654a4a7637419c72ebd.camel@collabora.com>
From:   Akhil P Oommen <akhilpo@codeaurora.org>
Message-ID: <addc4280-729f-85d7-a314-35afbb7c8bb1@codeaurora.org>
Date:   Fri, 22 Jun 2018 12:33:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <0383b4a703a0b619023c0654a4a7637419c72ebd.camel@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/22/2018 6:41 AM, Ezequiel Garcia wrote:
> Hey Enric,
>
> On Fri, 2018-06-22 at 00:04 +0200, Enric Balletbo i Serra wrote:
>> When the devfreq driver and the governor driver are built as modules,
>> the call to devfreq_add_device() or governor_store() fails because
>> the
>> governor driver is not loaded at the time the devfreq driver loads.
>> The
>> devfreq driver has a build dependency on the governor but also should
>> have a runtime dependency. We need to make sure that the governor
>> driver
>> is loaded before the devfreq driver.
>>
>> This patch fixes this bug by adding a try_then_request_governor()
>> function. First tries to find the governor, and then, if it is not
>> found,
>> it requests the module and tries again.
>>
>> Fixes: 1b5c1be2c88e (PM / devfreq: map devfreq drivers to governor
>> using name)
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>> Changes in v3:
>> - Remove unneded change in dev_err message.
>> - Fix err returned value in case to not find the governor.
>>
>> Changes in v2:
>> - Add a new function to request the module and call that function
>> from
>>    devfreq_add_device and governor_store.
>>
>>   drivers/devfreq/devfreq.c | 65 ++++++++++++++++++++++++++++++++-----
>> --
> [snip snip]
>> -	governor = find_devfreq_governor(devfreq->governor_name);
>> +	governor = try_then_request_governor(devfreq-
>>> governor_name);
>>   	if (IS_ERR(governor)) {
>>   		dev_err(dev, "%s: Unable to find governor for the
>> device\n",
>>   			__func__);
>>   		err = PTR_ERR(governor);
>> -		goto err_init;
>> +		goto err_unregister;
>>   	}
>>   
>> +	mutex_lock(&devfreq_list_lock);
>> +
> I know it's not something we are introducing in this patch,
> but still... calling a hook with a mutex held looks
> fishy to me.
>
> This lock should only protect the list, unless I am missing
> something.
>
>>   	devfreq->governor = governor;
>>   	err = devfreq->governor->event_handler(devfreq,
>> DEVFREQ_GOV_START,
>>   						NULL);
>> @@ -663,14 +703,16 @@ struct devfreq *devfreq_add_device(struct
>> device *dev,
>>   			__func__);
>>   		goto err_init;
>>   	}
>> +
>> +	list_add(&devfreq->node, &devfreq_list);
>> +
>>   	mutex_unlock(&devfreq_list_lock);
>>   
>>   	return devfreq;
>>   
>>   err_init:
>> -	list_del(&devfreq->node);
>>   	mutex_unlock(&devfreq_list_lock);
>> -
>> +err_unregister:
>>   	device_unregister(&devfreq->dev);
>>   err_dev:
>>   	if (devfreq)
>> @@ -988,12 +1030,13 @@ static ssize_t governor_store(struct device
>> *dev, struct device_attribute *attr,
>>   	if (ret != 1)
>>   		return -EINVAL;
>>   
>> -	mutex_lock(&devfreq_list_lock);
>> -	governor = find_devfreq_governor(str_governor);
>> +	governor = try_then_request_governor(str_governor);
>>   	if (IS_ERR(governor)) {
>> -		ret = PTR_ERR(governor);
>> -		goto out;
>> +		return PTR_ERR(governor);
>>   	}
>> +
>> +	mutex_lock(&devfreq_list_lock);
>> +
>>   	if (df->governor == governor) {
>>   		ret = 0;
>>   		goto out;
>> -- 
>> 2.17.1
>>
>>
>
> Regards,
> Eze

Adding to Ezequiel's point, shouldn't we take more granular lock 
(devfreq->lock) first and then call devfreq_list_lock at the time of 
adding to the list?

-Akhil.
