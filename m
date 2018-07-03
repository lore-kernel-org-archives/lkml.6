Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08CFC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625FA23F62
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 625FA23F62
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753302AbeGCNQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 09:16:41 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60416 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752423AbeGCNQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 09:16:40 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 066B4260185
Subject: Re: [PATCH v3] PM / devfreq: Fix devfreq_add_device() when drivers
 are built as modules.
To:     myungjoo.ham@samsung.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "kernel@collabora.com" <kernel@collabora.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <20180621220430.25644-1-enric.balletbo@collabora.com>
 <CGME20180621220442epcas2p14960cff4b08825aceb9d0e7ff810aeae@epcms1p6>
 <20180703105723epcms1p63bd7b3cf49722b204d7ca0dfd98d5d15@epcms1p6>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <60b611ac-69e0-1339-599a-299483b6df3d@collabora.com>
Date:   Tue, 3 Jul 2018 15:16:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180703105723epcms1p63bd7b3cf49722b204d7ca0dfd98d5d15@epcms1p6>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi MyungJoo

On 03/07/18 12:57, MyungJoo Ham wrote:
>> @@ -988,12 +1030,13 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>> 	if (ret != 1)
>> 		return -EINVAL;
>>
>> -	mutex_lock(&devfreq_list_lock);
>> -	governor = find_devfreq_governor(str_governor);
>> +	governor = try_then_request_governor(str_governor);
>> 	if (IS_ERR(governor)) {
>> -		ret = PTR_ERR(governor);
>> -		goto out;
>> +		return PTR_ERR(governor);
>> 	}
>> +
>> +	mutex_lock(&devfreq_list_lock);
>> +
>> 	if (df->governor == governor) {
>> 		ret = 0;
>> 		goto out;
>> -- 
> 
> The possibility that the result of try_then_request_governor is
> not kept protected until the line of
> "if (df->governor == governor)" is itching.
> 
> Can you make it kept "locked" from the return of
> find_devfreq_governor() (either in try_then... or in this function)
> to the unlock of governor_store()?
> 

Sure, I'll send v4 in a minute.

Thanks,
 Enric

> 
> Cheers,
> MyungJoo
> 
