Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D88C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6444321872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ehF+577l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfAXSPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:15:19 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10711 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfAXSPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 13:15:19 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4a00a40000>; Thu, 24 Jan 2019 10:15:00 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 24 Jan 2019 10:15:18 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 24 Jan 2019 10:15:18 -0800
Received: from [10.25.74.189] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Jan
 2019 18:15:16 +0000
Subject: Re: [PATCH] ALSA: hda: runtime PM is always active
To:     Takashi Iwai <tiwai@suse.de>
CC:     <abhijeet.kumar@intel.com>, <perex@perex.cz>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
References: <1548345432-11449-1-git-send-email-spujar@nvidia.com>
 <s5hef9211pm.wl-tiwai@suse.de>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <770a8e0e-3e20-6997-3342-98a3656e14c1@nvidia.com>
Date:   Thu, 24 Jan 2019 23:45:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <s5hef9211pm.wl-tiwai@suse.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548353700; bh=mLnv4HC51qowpoHLol8w4Sl22MEdbxLV/qZXn0QoiWo=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=ehF+577lopRxSDBcStk8gYZP+FgiMwOu9Ox5fbbekz1t2e0MpaTcIkmCevQnVg2Q1
         ZIWcgLoWVwKZ1irRSN+d8da5PhJDuFVQ5LIKc4FNBj7Xs5G2d8N9J/2D0bBgHnVexo
         mzBVCLfCy+RY5xHYlsr8XwSsC0PaVbjM562gGFUYkbTLt6dopLI3pBaTo/vZlkyUar
         DIKV4jRgTg6srtstpmxtiWpaALNmC4sxTEnD1xUth1EsCWPZvMppyUsWhirrI+EstP
         P8aCCImthM9rAHZga0PLHOjiMbpjHgjSZQjSPy0tcNUBZNZDdi0kDHK7oYskxco3m9
         gj6Ldiob/Sn1A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/24/2019 9:34 PM, Takashi Iwai wrote:
> On Thu, 24 Jan 2019 16:57:11 +0100,
> Sameer Pujar wrote:
>> The runtime PM count is incremented and set to active during hda codec
>> device init, but it is decremented and set to suspend during exit only.
>> Hence the runtime PM status is always active and hda device cannot be
>> put to runtime suspend. Keeping device usage active for entire period,
>> though nothing really happening on the device, seems unnecessary.
>>
>> This patch avoides incrementing runtime PM usage count of the device.
>>
>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>> Reviewed-by: Ravindra Lokhande <rlokhande@nvidia.com>
>> Reviewed-by: Mohan Kumar D <mkumard@nvidia.com>
> This breaks the existing things, I'm afraid.
> Did you really test and verify the behavior...?
>
> The runtime PM refcount is decremented at snd_hda_codec_register(),
> and that's the place to let runtime suspend of the codec really
> effective.  (It's not about the controller, though.)
>
It worked fine at my end. I could put the device to runtime suspend and 
resume it back multiple times.
Since you are suggesting it could break things, let me rework on the 
patch and dig up a little more to
see if there is better way to fix this.

Thanks,
Sameer.

> thanks,
>
> Takashi
>
>
>> ---
>>   sound/hda/hdac_device.c | 6 ------
>>   1 file changed, 6 deletions(-)
>>
>> diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
>> index 95b073e..72aa342 100644
>> --- a/sound/hda/hdac_device.c
>> +++ b/sound/hda/hdac_device.c
>> @@ -31,9 +31,6 @@ static void default_release(struct device *dev)
>>    *
>>    * Returns zero for success or a negative error code.
>>    *
>> - * This function increments the runtime PM counter and marks it active.
>> - * The caller needs to turn it off appropriately later.
>> - *
>>    * The caller needs to set the device's release op properly by itself.
>>    */
>>   int snd_hdac_device_init(struct hdac_device *codec, struct hdac_bus *bus,
>> @@ -55,8 +52,6 @@ int snd_hdac_device_init(struct hdac_device *codec, struct hdac_bus *bus,
>>   	codec->bus = bus;
>>   	codec->addr = addr;
>>   	codec->type = HDA_DEV_CORE;
>> -	pm_runtime_set_active(&codec->dev);
>> -	pm_runtime_get_noresume(&codec->dev);
>>   	atomic_set(&codec->in_pm, 0);
>>   
>>   	err = snd_hdac_bus_add_device(bus, codec);
>> @@ -123,7 +118,6 @@ EXPORT_SYMBOL_GPL(snd_hdac_device_init);
>>    */
>>   void snd_hdac_device_exit(struct hdac_device *codec)
>>   {
>> -	pm_runtime_put_noidle(&codec->dev);
>>   	snd_hdac_bus_remove_device(codec->bus, codec);
>>   	kfree(codec->vendor_name);
>>   	kfree(codec->chip_name);
>> -- 
>> 2.7.4
>>
>>
