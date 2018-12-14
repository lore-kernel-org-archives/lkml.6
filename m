Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1253C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2800208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ralRyThW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2800208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbeLNLNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 06:13:37 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:53828 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbeLNLNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 06:13:36 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBEBDT0C120637;
        Fri, 14 Dec 2018 05:13:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544786009;
        bh=LgDbleTPzqepNQfg+C0pn1INv0Xfe4g292FVb2TeZ2s=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ralRyThWzZWipFz7xqy+LAnNkAVPxf35YjRdFkquwlbXQth8yErW0GeoIROjwkmyR
         zkOCQq5gk4ZSqsBaPGIK86BrSB7nOxerTJIpqA531Jm1aykqjtaEonkLXaiFQSDwSw
         PHfyUuJXTV8FB4B6tZsn3zRjq3MOG6r5fT9j5js0=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBEBDTsJ113247
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Dec 2018 05:13:29 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 14
 Dec 2018 05:13:29 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 14 Dec 2018 05:13:29 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBEBDONL003013;
        Fri, 14 Dec 2018 05:13:25 -0600
Subject: Re: [RFC PATCH v2 08/15] usb:cdns3: Implements device operations part
 of the API
To:     Felipe Balbi <balbi@kernel.org>,
        Peter Chen <hzpeterchen@gmail.com>, <pawell@cadence.com>
CC:     <rogerq@ti.com>, <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        <adouglas@cadence.com>, <jbergsagel@ti.com>, <nm@ti.com>,
        <sureshp@cadence.com>, <peter.chen@nxp.com>, <pjez@cadence.com>,
        <kurahul@cadence.com>
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
 <1542535751-16079-9-git-send-email-pawell@cadence.com>
 <5BFE8883.7090802@ti.com>
 <CAL411-oKvu3EADStit=JtbcxVzM_fFGF2uPn67-wmXxPzUK6GQ@mail.gmail.com>
 <6b19b55c-66d7-439e-df8f-7b311b45af5e@ti.com>
 <BYAPR07MB470972A525D85B03C3037D3BDDA60@BYAPR07MB4709.namprd07.prod.outlook.com>
 <CAL411-oc-_0H88egpHsc06ptL12UsaE63rWwjN7novuFFx_qbA@mail.gmail.com>
 <5a41de27-cd1f-0cfd-ccdc-dccbf0854fcb@ti.com>
 <87bm5ol6zt.fsf@linux.intel.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <d5623e70-7971-d729-f395-7259ab0efdb0@ti.com>
Date:   Fri, 14 Dec 2018 16:43:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <87bm5ol6zt.fsf@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

On 14/12/18 4:17 PM, Felipe Balbi wrote:
> Hi,
> 
> Sekhar Nori <nsekhar@ti.com> writes:
> 
> <snip>
> 
>>>>> All this should be part of comments in code along with information about
>>>>> controller versions which suffer from the errata.
>>>>>
>>>>> Is there a version of controller available which does not have the
>>>>> defect? Is there a future plan to fix this?
>>>>>
>>>>> If any of that is yes, you probably want to handle this with runtime
>>>>> detection of version (like done with DWC3_REVISION_XXX macros).
>>>>> Sometimes the hardware-read versions themselves are incorrect, so its
>>>>> better to introduce a version specific compatible too like
>>>>> "cdns,usb-1.0.0" (as hinted to by Rob Herring as well).
>>>>>
>>>>
>>>> custom match_ep is used and works with all versions of the gen1
>>>> controller. Future (gen2) releases of the controller won’t have such
>>>> limitation but there is no plan to change current (gen1) functionality
>>>> of the controller.
>>>>
>>>> I will add comment before cdns3_gadget_match_ep function.
>>>> Also I will change cdns,usb3 to cdns,usb3-1.0.0 and add additional
>>>> cdns,usb3-1.0.1 compatible.
>>>>
>>>> cdns,usb3-1.0.1 will be for current version of controller which I use.
>>>> cdns,usb3-1.0.0 will be for older version - Peter Chan platform.
>>>> I now that I have some changes in controller, and one of them require
>>>> some changes in DRD driver. It will be safer to add two separate
>>>> version in compatibles.
>>>>
>>>
>>> Pawel, could we have correct register to show controller version? It is
>>> better we could version judgement at runtime instead of static compatible.
>>
>> Agree with detecting IP version at runtime.
>>
>> But please have some indication of version in compatible string too,
> 
> why? Runtime detection by revision register should be the way to go if
> the HW provides it. Why duplicate the information in compatible string?
> 
>> especially since you already know there is going to be another revision
>> of hardware. It has the advantage that one can easily grep to see which
>> hardware is running current version of controller without having access
>> to the hardware itself. Becomes useful later on when its time to
>> clean-up unused code when boards become obsolete or for requesting
>> testing help.
> 
> This doesn't sound like a very strong argument, actually. Specially when
> you consider that, since driver will do revision checking based on
> revision register, you already have strings to grep. Moreover, we don't
> usually drop support just like that.

AFAICS, it is impossible to know just by grep'ing if there is any
hardware still supported in kernel and using DWC3_REVISION_194A, for
example.

If we are never going to drop support for any revision, this does not
matter much.

Also, once you have the controller supported behind PCI, then I guess
you are pretty much tied to having to read hardware revision at runtime.

> Personally, I wouldn't bother. Just like dwc3 never bothered and nothing
> bad came about because of it. Well, there are quirks which are
> undetectable and for those we have quirk flags. I much prefer that
> arrangement.

Yes, quirk flags will work too for undetectable quirks.

Thanks,
Sekhar
