Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9446C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D64C214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pl+J7XFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbfAJMxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:53:55 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54876 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfAJMxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:53:55 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0ACrZv4067953;
        Thu, 10 Jan 2019 06:53:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547124815;
        bh=IaS1PXhDONTksppz1ZwK4WXNe8wkDqcYFRVb/fGcS1A=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=pl+J7XFWttH4Tl/ECxi3mSqJ54uza0WsVAYcafYSi9L2Hcv/lcSoilSUwYIShqtKw
         /135OSmI0/R7BXzDzfyYkiVZ0WoRypURPGxDHU9LsVJDAgkybwKdIyvYljo/YaY6/E
         nqPQV7CWd4M8yeDcceUkBiQ9fYDrfA3MHIGExIxU=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0ACrZHC022970
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Jan 2019 06:53:35 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 10
 Jan 2019 06:53:35 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 10 Jan 2019 06:53:35 -0600
Received: from [172.22.122.36] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0ACrZtr023734;
        Thu, 10 Jan 2019 06:53:35 -0600
Subject: Re: [RFC PATCH 1/3] can: m_can: Create m_can core to leverage common
 code
To:     Wolfgang Grandegger <wg@grandegger.com>, <mkl@pengutronix.de>,
        <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20181010142055.25271-1-dmurphy@ti.com>
 <20181010142055.25271-2-dmurphy@ti.com>
 <52811b27-00c0-f5e2-2b18-608ccf846723@grandegger.com>
 <349ef8be-f4c7-25cc-2c33-7ce1fd0b0f40@ti.com>
 <9003a544-83cf-7dce-7f14-4abd292d470e@grandegger.com>
 <b73e200c-8a6b-00e0-dabc-af3245cc36fd@ti.com>
 <69d3a046-2d55-06e0-fba7-c9a0d20e6daa@grandegger.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <06e0146a-5f96-5f60-1ab3-be21b854932a@ti.com>
Date:   Thu, 10 Jan 2019 06:53:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <69d3a046-2d55-06e0-fba7-c9a0d20e6daa@grandegger.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfgang

On 1/10/19 1:44 AM, Wolfgang Grandegger wrote:
> Hello Dan,
> 
> sorry for my late response on that topic...
> 
> Am 09.01.19 um 21:58 schrieb Dan Murphy:
>> Wolfgang
>>
>> On 11/3/18 5:45 AM, Wolfgang Grandegger wrote:
>>> Hello Dan,
>>>
>>> Am 31.10.2018 um 21:15 schrieb Dan Murphy:
>>>> Wolfgang
>>>>
>>>> Thanks for the review
>>>>
>>>> On 10/27/2018 09:19 AM, Wolfgang Grandegger wrote:
>>>>> Hello Dan,
>>>>>
>>>>> for the RFC, could you please just do the necessary changes to the
>>>>> existing code. We can discuss about better names, etc. later. For
>>>>> the review if the common code I quickly did:
>>>>>
>>>>>   mv m_can.c m_can_platform.c
>>>>>   mv m_can_core.c m_can.c
>>>>>
>>>>> The file names are similar to what we have for the C_CAN driver.
>>>>>
>>>>>   s/classdev/priv/
>>>>>   variable name s/m_can_dev/priv/
>>>>>
>>>>> Then your patch 1/3 looks as shown below. I'm going to comment on that
>>>>> one. The comments start with "***"....
>>>>>
>>>>
>>>> So you would like me to align the names with the c_can driver?
>>>
>>> That would be the obvious choice.
>>>> <snip>
>>>>>
>>>>> *** I didn't review the rest of the patch for now.
>>>>>
>>>>
>>>> snipped the code to reply to the comment.
>>>>
>>>>> Looking to the generic code, you didn't really change the way
>>>>> the driver is accessing the registers. Also the interrupt handling
>>>>> and rx polling is as it was before. Does that work properly using
>>>>> the SPI interface of the TCAN4x5x?
>>>>
>>>> I don't want to change any of that yet.  Maybe my cover letter was not clear
>>>> or did not go through.
>>>>
>>>> But the intention was just to break out the functionality to create a MCAN framework
>>>> that can be used by devices that contain the Bosch MCAN core and provider their own protocal to access
>>>> the registers in the device.
>>>>
>>>> I don't want to do any functional changes at this time on the IP code itself until we have a framework.
>>>> There should be no regression in the io mapped code.
>>>>
>>>> I did comment on the interrupt handling and asked if a threaded work queue would affect CAN timing.
>>>> For the original TCAN driver this was the way it was implemented.
>>>
>>> Do threaded interrupts with RX polling make sense? I think we need a
>>> common interface allowing to select hard-irqs+napi or threaded-irqs.
>>>
>>
>> I have been working on this code for about a month now and I am *not happy* with the amount of change that needs
>> to be done to make the m_can a framework.
>>
>> I can tx/rx frames from another CAN device to the TCAN part but I have not even touched the iomapped code.
>>
>> The challenging part is that the m_can code that is currently available does not have to worry about atomic context because
>> there is no peripheral waiting.  Since the TCAN is a peripheral device we need to take into about the hard waits in IRQ context
>> as well as the atomic context.  Doing this creates many deltas in the base code that may break iomapped devices.  I have had to 
>> add the thread_irqs and now I am in the midst of the issue you brought up with napi.  I would have to schedule a queue for perp devices
>> and leave the non-threaded iomapped irq.
>>
>> At this point I think it may be wise to leave the m_can code alone as it is working and stable and just work on the TCAN driver as
>> a standalone driver.  A framework would be nice but I think it would destablize the m_can driver which is embedded in many SoC's and
>> we cannot possibly test everyone of them.
> 
> Unfortunately, I do not have m_can hardware at hand.
> 
>> What are your thoughts?
> 
> What we need is a common set of functions doing tx, rx, error and state
> handling. This will requires substantial changes to the existing
> io-mapped m_can driver, of course. I still believe it's worth the
> effort, but I agree that it's difficult for you to re-write and test the
> existing m_can driver.

OK I will keep working on it.  What you are describing is what I have done.
I have abstracted the register reads and writes away and I am in the process
of abstracting away the device specific initialization.

> 
> What about implementing such a set of common functions plus the SPI
> specific part for your TCAN device. What do you/others think?

As stated above this is what I have.  But the m_can driver was written for io-mapped that has no delays
so we need to take into about peripheral wait time in IRQ and atomic context.

This is where the issues are stemming from mainly in the atomic context.

Dan


> 
> Wolfgang.
> 


-- 
------------------
Dan Murphy
