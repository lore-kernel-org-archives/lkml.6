Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17943C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6ABB20672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMGLIOJ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6ABB20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504084AbeKWWrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:47:11 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43518 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388025AbeKWWrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:47:10 -0500
Received: by mail-pg1-f195.google.com with SMTP id v28so3003457pgk.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 04:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gXp7B0C6OpQdpsPvWbXiKDMl2kXbdFO+2j6/Vh1h1zQ=;
        b=PMGLIOJ14XlNaOFEUpQp809l2Ya5ujEEz2G++FfOHb104/aSu+GA488umDIQUOaZE6
         4Mc9499elPZHjkE7k1Svd3VAxlIPaV+wsD1fGfiZuocq6vCYciVCf489x7+vU3T5YcDb
         4dWCFgQserVGVgd6tmR0d/It//4h5wShWqwdYrRMcjfcW7B8/82EmB1vNFhf3SKBGHdT
         Ym34cFT9DQNs0EzDHxk9szuGfM33lDIXRMdfij4mAxUrGDjn3V1h5NegB2qu6gholYgX
         sQUPix1pgQngQZBPy9OGEeA5bihKmo6cTOctHGpew3LKR5X/R4iwh5Y2bp7ToO0hyNey
         3iug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gXp7B0C6OpQdpsPvWbXiKDMl2kXbdFO+2j6/Vh1h1zQ=;
        b=mHL+Tdi8Hfos5zUN008frxSbTYvySFn//A8nErjuOMo3/zaQ83a6VKQZbx13ftOMbz
         VR6eBrZHWJm4wuWLuuT/ojNwS7v0DR1kDDzqZ8FhpFpSBMDTSiB+Z+ApDh2hHiiHZUCv
         BCw2f0mlCy8+nDYlWqcrW0pD3G9W4+pm41orczQGQKtLKsQ6nbOHxz/q98JAXq1Y4nF3
         8StSgz0dLYbg0v8XXRJo5Q6XfdxUCnLaNzsRwyO6XZtn8qyX+dgSPC6kCI/1Ds3guxRX
         4gVG3CI5Evi4Ung137VuAxIwA4PSCHTTcZy9p7GXSJIpSa4Y8vQMtAuSQnlt2/vt8FKe
         hM9g==
X-Gm-Message-State: AGRZ1gJ3fuNKQ8/yTNFdoUjr18Iw5wigMzkTlO9RLJ5bscv2XbwizZ6Z
        0jlq8oWJCNIt/8ARqcV5ex8=
X-Google-Smtp-Source: AJdET5cUhfDgL6xyPJUU24Qrs1/6TLylYVzq5St5X/B0HprcXS2rImnY/EPlwTRqSXqk/f0vhb6BeQ==
X-Received: by 2002:a62:e501:: with SMTP id n1-v6mr15591095pff.71.1542974592844;
        Fri, 23 Nov 2018 04:03:12 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v70sm18248692pfa.152.2018.11.23.04.03.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 04:03:12 -0800 (PST)
Subject: Re: [PATCH 2/7] mfd / platform: cros_ec: move lightbar attributes to
 its own driver.
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     lee.jones@linaro.org, gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org,
        Olof Johansson <olof@lixom.net>
References: <20181122113356.23610-1-enric.balletbo@collabora.com>
 <20181122113356.23610-3-enric.balletbo@collabora.com>
 <20181122174151.GA30386@roeck-us.net>
 <2c70235f-8f10-de5f-7df5-21104fd371c4@collabora.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <2ca66046-b5eb-6c3a-3559-a12dd869ebbf@roeck-us.net>
Date:   Fri, 23 Nov 2018 04:03:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <2c70235f-8f10-de5f-7df5-21104fd371c4@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/18 3:52 AM, Enric Balletbo i Serra wrote:
> Hi Guenter,
> 
> On 22/11/18 18:41, Guenter Roeck wrote:
>> Hi Enric,
>>
>> On Thu, Nov 22, 2018 at 12:33:51PM +0100, Enric Balletbo i Serra wrote:
>>> The entire way how cros sysfs attibutes are created is broken.
>>> cros_ec_lightbar should be its own driver and its attributes should be
>>> associated with a lightbar driver not the mfd driver. In order to retain
>>> the path, the lightbar attributes are attached to the cros_class.
>>>
>>> The patch also adds the sysfs documentation.
>>>
>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>> ---
>>>
>> ...
>>>   
>>> +int cros_ec_attach_attribute_group(struct cros_ec_dev *ec,
>>> +				   struct attribute_group *attrs)
>>> +{
>>> +	return sysfs_create_group(&ec->class_dev.kobj, attrs);
>>> +}
>>> +EXPORT_SYMBOL(cros_ec_attach_attribute_group);
>>> +
>>> +void cros_ec_detach_attribute_group(struct cros_ec_dev *ec,
>>> +				    struct attribute_group *attrs)
>>> +{
>>> +	sysfs_remove_group(&ec->class_dev.kobj, attrs);
>>> +}
>>> +EXPORT_SYMBOL(cros_ec_detach_attribute_group);
>>> +
>>
>> Are those two functions necessary ? Why not just call sysfs_create_group
>> and sysfs_remove_group directly from the calling code ?
>>
> 
> Actually we have cros_ec_dev which registers the cros_ec class, and sysfs/vbc
> and lightbar using this cros_ec class. I had problems unloading the different
> modules. For example, when I removed cros_ec_dev modules before
> cros_ec_sysfs/cros_ec_vbc/cros_ec_lightbar I got a hang.
> 
> To solve the hang I did the easy solution that is make these drivers depend on
> cros_ec_dev so you're not able to unload cros_ec_dev if first you don't unload
> the sysfs/vbc/lightbar.
> 

That seems like a side effect of the callbacks, which may increase the use count
of cros_ec_dev. If the lack of these callbacks causes problems, we should identify
the root cause and fix it, and not depend on side effects of a callback.

Thanks,
Guenter

> Thinking again about it, I don't really understand now why failed in the first
> place, cros_ec_dev is the parent, so, on remove should call mfd_remove_devices
> for the subdevices.
> 
> So, let me check again this and I'll back to you.
> 
> Thanks,
>   Enric
> 
> 
>> Thanks,
>> Guenter
>>
> 

