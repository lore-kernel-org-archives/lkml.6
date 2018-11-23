Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0163C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8084420685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8084420685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405456AbeKWWg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:36:56 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59976 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387885AbeKWWg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:36:56 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 77F5C263BE6
Subject: Re: [PATCH 2/7] mfd / platform: cros_ec: move lightbar attributes to
 its own driver.
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     lee.jones@linaro.org, gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org,
        Olof Johansson <olof@lixom.net>
References: <20181122113356.23610-1-enric.balletbo@collabora.com>
 <20181122113356.23610-3-enric.balletbo@collabora.com>
 <20181122174151.GA30386@roeck-us.net>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <2c70235f-8f10-de5f-7df5-21104fd371c4@collabora.com>
Date:   Fri, 23 Nov 2018 12:52:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181122174151.GA30386@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On 22/11/18 18:41, Guenter Roeck wrote:
> Hi Enric,
> 
> On Thu, Nov 22, 2018 at 12:33:51PM +0100, Enric Balletbo i Serra wrote:
>> The entire way how cros sysfs attibutes are created is broken.
>> cros_ec_lightbar should be its own driver and its attributes should be
>> associated with a lightbar driver not the mfd driver. In order to retain
>> the path, the lightbar attributes are attached to the cros_class.
>>
>> The patch also adds the sysfs documentation.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
> ...
>>  
>> +int cros_ec_attach_attribute_group(struct cros_ec_dev *ec,
>> +				   struct attribute_group *attrs)
>> +{
>> +	return sysfs_create_group(&ec->class_dev.kobj, attrs);
>> +}
>> +EXPORT_SYMBOL(cros_ec_attach_attribute_group);
>> +
>> +void cros_ec_detach_attribute_group(struct cros_ec_dev *ec,
>> +				    struct attribute_group *attrs)
>> +{
>> +	sysfs_remove_group(&ec->class_dev.kobj, attrs);
>> +}
>> +EXPORT_SYMBOL(cros_ec_detach_attribute_group);
>> +
> 
> Are those two functions necessary ? Why not just call sysfs_create_group
> and sysfs_remove_group directly from the calling code ?
> 

Actually we have cros_ec_dev which registers the cros_ec class, and sysfs/vbc
and lightbar using this cros_ec class. I had problems unloading the different
modules. For example, when I removed cros_ec_dev modules before
cros_ec_sysfs/cros_ec_vbc/cros_ec_lightbar I got a hang.

To solve the hang I did the easy solution that is make these drivers depend on
cros_ec_dev so you're not able to unload cros_ec_dev if first you don't unload
the sysfs/vbc/lightbar.

Thinking again about it, I don't really understand now why failed in the first
place, cros_ec_dev is the parent, so, on remove should call mfd_remove_devices
for the subdevices.

So, let me check again this and I'll back to you.

Thanks,
 Enric


> Thanks,
> Guenter
> 
