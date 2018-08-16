Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CCDC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86A8214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YsaS2FHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D86A8214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389386AbeHPK2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 06:28:42 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36984 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730053AbeHPK2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 06:28:42 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7G7Vken048198;
        Thu, 16 Aug 2018 02:31:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1534404706;
        bh=dpt4A8mVBtbw2c31lFJ4H4ZnB+7mTYqQNVK8X57A5S0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YsaS2FHlKeqCggheOGRiEAEEbY5aUFSWvWVlJRMtAnqqHk9vXuRdxOsMvL2bOg4zQ
         VUKv4k/cqJG+RBffR9gA0Dgm+DA3nFbdvWnpWKDRuxtrKiCecM/OOOVlUSNUexEhea
         fVnQHOcn5uUWp70wX1PSb7dyt5Yf/XinPVBw/oEg=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7G7Vkqk013496;
        Thu, 16 Aug 2018 02:31:46 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 16
 Aug 2018 02:31:45 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 16 Aug 2018 02:31:46 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7G7VgYN002159;
        Thu, 16 Aug 2018 02:31:43 -0500
Subject: Re: [PATCH] usb: hub: try old enumeration scheme first for high speed
 devices
To:     "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>,
        "drinkcat@chromium.org" <drinkcat@chromium.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "drake@endlessm.com" <drake@endlessm.com>,
        "mike.looijmans@topic.nl" <mike.looijmans@topic.nl>,
        "joe@perches.com" <joe@perches.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1533913304-15737-1-git-send-email-prime.zeng@hisilicon.com>
 <a29afa26-22b4-3188-f9ee-993e44df7703@ti.com>
 <678F3D1BB717D949B966B68EAEB446ED0C9B129B@dggemm526-mbx.china.huawei.com>
From:   Roger Quadros <rogerq@ti.com>
Openpgp: preference=signencrypt
Autocrypt: addr=rogerq@ti.com; prefer-encrypt=mutual; keydata=
 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
 IwrfNkJOLj3CvocMIw==
Message-ID: <bf88d120-0147-a42a-9217-8fc91bd3ee2a@ti.com>
Date:   Thu, 16 Aug 2018 10:31:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED0C9B129B@dggemm526-mbx.china.huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/18 10:33, Zengtao (B) wrote:
> Hi Roger:
> 
> Thank you for review
> 
>> -----Original Message-----
>> From: Roger Quadros [mailto:rogerq@ti.com]
>> Sent: Friday, August 10, 2018 6:51 PM
>> To: Zengtao (B) <prime.zeng@hisilicon.com>; gregkh@linuxfoundation.org;
>> stern@rowland.harvard.edu; mathias.nyman@linux.intel.com;
>> drinkcat@chromium.org; felipe.balbi@linux.intel.com; drake@endlessm.com;
>> mike.looijmans@topic.nl; joe@perches.com
>> Cc: linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] usb: hub: try old enumeration scheme first for high speed
>> devices
>>
>> Hi,
>>
>> On 10/08/18 18:01, Zeng Tao wrote:
>>> The new scheme is required just to support legacy low and full-speed
>>> devices. For high speed devices, it will slower the enumeration speed.
>>> So in this patch we try the "old" enumeration scheme first for high
>>> speed devices.
>>
>> How slow does it get? Is it significant?
>> Do we risk breaking existing HS devices that work? I don't think we can be sure
>> till we run this through testing.
>>
> 
> We added the new scheme because this is what the windows did , and mainly for 
> legacy low and full speed devices.
> Now for new windows version(8.1 and later), the second port reset has already been
> removed for high speed devices for better enumeration speed.
> And In this patch if use_both_schemes is true, it will fallback to new scheme if the old
> scheme fails.
> 
> So I think it's reasonable to follow the windows behavior again.
> 
>>>
>>> Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
>>> ---
>>>  drivers/usb/core/hub.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c index
>>> 1fb2668..d265b19 100644
>>> --- a/drivers/usb/core/hub.c
>>> +++ b/drivers/usb/core/hub.c
>>> @@ -2661,10 +2661,13 @@ static bool use_new_scheme(struct usb_device
>> *udev, int retry,
>>>  	int old_scheme_first_port =
>>>  		port_dev->quirks & USB_PORT_QUIRK_OLD_SCHEME;
>>>
>>> +	int quick_enumeration = (udev->speed == USB_SPEED_HIGH);
>>> +
>>>  	if (udev->speed >= USB_SPEED_SUPER)
>>>  		return false;
>>
>> how about replacing the above if with
>>
>> 	if (udev->speed >= USB_SPEED_HIGH)
>> 		return false;
> 
> No, for SS device, only use old scheme, but for speed device, we can fallback to new 
> scheme if the old fails.

You are correct.
> 
>>>
>>> -	return USE_NEW_SCHEME(retry, old_scheme_first_port ||
>> old_scheme_first);
>>> +	return USE_NEW_SCHEME(retry, old_scheme_first_port ||
>> old_scheme_first
>>> +			      || quick_enumeration);
>>>  }
>>
>> Now we no longer respect the "old_scheme_first" parameter for most of the
>> devices.
>>
>> It should be clarified in Documentation/admin/kernel-parameters.txt that
>> "old_scheme_first" is only applicable to LOW/FULL speed devices.
>>
> 
> On the contrary, new scheme is only applicable for LOW/FULL speed devices? 

No. What I meant is that the "old_scheme_first" module parameter is now
only applicable for LOW/FULL speed devices.

As HIGH_SPEED devices will always use old scheme first after this patch.

cheers,
-roger

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
