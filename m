Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FFEC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF1920849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF1920849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbeLKKAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:00:53 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46624 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbeLKKAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:00:53 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id CB28D265075
Subject: Re: [PATCH] mfd: cros_ec_dev: Add missing mfd_remove_devices() call
 in remove
To:     Lee Jones <lee.jones@linaro.org>
Cc:     groeck@chromium.org, gwendal@chromium.org, kernel@collabora.com,
        bleung@chromium.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20181210180002.4440-1-enric.balletbo@collabora.com>
 <20181211061207.GE4497@dell>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <188dacba-9b4e-3884-d4b3-588b865a1f65@collabora.com>
Date:   Tue, 11 Dec 2018 11:00:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181211061207.GE4497@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 11/12/18 7:12, Lee Jones wrote:
> On Mon, 10 Dec 2018, Enric Balletbo i Serra wrote:
> 
>> The driver adds different MFD child devices via mfd_add_devices() and
>> hence it is required to call mfd_remove_devices() to remove MFD child
>> devices.
>>
>> Fixes: 5e0115581bbc ("cros_ec: Move cros_ec_dev module to drivers/mfd")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>> Hi Lee,
>>
>> I saw that you send a mfd-fixes pull request this morning, so sorry in
>> advance for sending this too late. This was broken since the driver
>> moved from platform/chrome to mfd (and probably before that), so
>> it's an old problem. Note that I plan to send a patch series that depends
>> on this to apply cleanly. If the patch is fine with you and there is any
>> possibility to go in this version that will be good, if not, let me know
>> if you prefer queue this in your for-next branch or if you prefer I
>> include the patch on the series I plan to send on top of it to not mess
>> things.
> 
> It wouldn't have made the v4.20-rcs anyway.  Even if you did send it
> earlier.  I only send fixes to that -rcs which fix issues introduced
> during the current release cycle.
> 

Ok.

> If memory serves, doesn't this driver now (or will in the very near
> future) use devm_* for device creation?  That would make this patch
> either incorrect (should be devm_mfd_remove_devices() if really
> required) or moot?
> 

I think you have in mind this patch [1], right? Note that in this patch we're
using devm_* for cros_ec driver, _not_ cros_ec_dev driver which is different.
For the cros_ec_dev driver we need to take care with device managed allocations
as explained in the last fix merged [2]. For the cros_ec_dev I was trying to no
mix device managed allocations with non-device managed allocations, and as we
can't use devm_kzalloc in this case, I thought that was worth use the
mfd_add/mfd_remove functions like is now. Makes sense? What are your thoughts here?

Thanks,
 Enric

[1] https://lkml.org/lkml/2018/11/27/881
[2]
https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/commit/?h=for-mfd-fixes&id=48a2ca0ee3994df53da230c7079a18a70ec914f9

>>  drivers/mfd/cros_ec_dev.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
>> index b99a194ce5a4..2d0fee488c5a 100644
>> --- a/drivers/mfd/cros_ec_dev.c
>> +++ b/drivers/mfd/cros_ec_dev.c
>> @@ -499,6 +499,7 @@ static int ec_device_remove(struct platform_device *pdev)
>>  
>>  	cros_ec_debugfs_remove(ec);
>>  
>> +	mfd_remove_devices(ec->dev);
>>  	cdev_del(&ec->cdev);
>>  	device_unregister(&ec->class_dev);
>>  	return 0;
> 
