Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1155CC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBBA220851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBBA220851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbeLCWNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:13:25 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43114 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeLCWNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 17:13:25 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id D18DC276369
Subject: Re: [PATCH v3 1/8] mfd / platform: cros_ec: use devm_mfd_add_devices.
To:     Lee Jones <lee.jones@linaro.org>
Cc:     gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org,
        Olof Johansson <olof@lixom.net>
References: <20181127121849.23975-1-enric.balletbo@collabora.com>
 <20181127121849.23975-2-enric.balletbo@collabora.com>
 <20181203103228.GC26661@dell>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <652e1f21-c443-3a25-a57f-71e0f835d47d@collabora.com>
Date:   Mon, 3 Dec 2018 23:13:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181203103228.GC26661@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 3/12/18 11:32, Lee Jones wrote:
> On Tue, 27 Nov 2018, Enric Balletbo i Serra wrote:
> 
>> Use devm_mfd_add_devices() for adding cros-ec core MFD child devices. This
>> reduces the need of remove callback from platform/chrome for removing the
>> MFD child devices.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>> Changes in v3:
>> - Removed cros_ec_remove from include file.
>>
>> Changes in v2:
>> - Use devm only for the cros-ec core.
>>
>>  drivers/mfd/cros_ec.c                 | 14 +++-----------
>>  drivers/mfd/cros_ec_dev.c             |  1 +
>>  drivers/platform/chrome/cros_ec_i2c.c | 10 ----------
>>  drivers/platform/chrome/cros_ec_lpc.c |  4 ----
>>  drivers/platform/chrome/cros_ec_spi.c | 11 -----------
>>  include/linux/mfd/cros_ec.h           | 10 ----------
>>  6 files changed, 4 insertions(+), 46 deletions(-)
> 
> Nice patch.
> 
> Just one question:
> 
> [...]
> 
>> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
>> index 8f9d6964173e..ff788d3e6d5f 100644
>> --- a/drivers/mfd/cros_ec_dev.c
>> +++ b/drivers/mfd/cros_ec_dev.c
>> @@ -493,6 +493,7 @@ static int ec_device_remove(struct platform_device *pdev)
>>  
>>  	cros_ec_debugfs_remove(ec);
>>  
>> +	mfd_remove_devices(ec->dev);
> 
> Why is this still required?
> 

Hmm, maybe that line shouldn't be here as is not really related to this patch,
it's more a fix for the cros_ec_dev to remove those cells that are registered
with mfd_add_devices.

Actually what we have is cros_ec that instantiates one or two cros_ec_dev
(depends on the platform) and cros_ec_dev instantiating different subdrivers.
The purpose of the patch was use the device managed resource for the cros_ec
driver, I did not touch the cros_ec_dev driver

>>  	cdev_del(&ec->cdev);
>>  	device_unregister(&ec->class_dev);
>>  	return 0;
> 
> [...]
> 
