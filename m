Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E58DC4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 14:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99F220865
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 14:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIgSgenV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A99F220865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbeIITdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 15:33:43 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:37268 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbeIITdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 15:33:42 -0400
Received: by mail-oi0-f65.google.com with SMTP id p84-v6so35537762oic.4;
        Sun, 09 Sep 2018 07:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4ZHj/guxuBV4JlDmlZA6KWi8fwS2/XD6hEakjr67tcM=;
        b=GIgSgenVgH85yA9XP+CF2pfdADTAH4nefHZ0l2GRIf/MsTcaxjZgwXUb488jm2pCg/
         sPwCOawNFjYFKWZJhux+LrJ5Rb4GvvuKRk1g5KLbERBU+zW69UPWZ8J5k1W/SoCJl1jX
         5O0hEd6zgAqUa9XVB+vzvrgIzR3P3ZDM0xfPYbxhYexlfB4tkFW84nSZq56trPhWMT5J
         Pb0ASwZ54U5vXXCSYinLDJCh59LOalOeXzTFyoV8RXItkdsS4Ch8E/Y96MxwV5g3iEFM
         G7d4n4okdPF6FkExwtwadxiza48VmgcHBprSO3YXlAacp/vpYnADCVNwUzArQIEwziPy
         rTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4ZHj/guxuBV4JlDmlZA6KWi8fwS2/XD6hEakjr67tcM=;
        b=niviDUw3hdE3R287wL8sKw+Gp29xvNLjaJRnCT8atqDU/j7pBY+8nLkeojT+s42gBT
         DxP+rJ2ZkzFsK3HTgkkCTmZT1tBoCUW5zFfRCVCezYcZ/CLnUDvUvgt9vrUI16qJCO7Q
         jIs445NtwNAjnPN1PRSrKaDgWJKR6lVFzNz2C/wy921mLjesyxRG458D9xRBniNVz1uM
         /H3XLy+/8lKZVhwYXQ79sTNgkCVbrrqMZQNkzPRvBj9bjjW43NCepz9A6NC51Ygd6c00
         JTjCX8VeafAkFssP+SqNjpO+6nGZGI9z6aLG4JH3omYQ7B6hWah6/McFaeld5CH6GxO8
         Jriw==
X-Gm-Message-State: APzg51DJTvaLM5WH2Txd3dfEGdCJr64vCzy2URrofrRxLgnOHsLbjWao
        Rt8El2SbWOrXFp4VXcC7Foc=
X-Google-Smtp-Source: ANB0VdYZh6MNi348k2t1xFyYDBK+ENlWaC/DeB5vI+UieL4DyMDOUd9EvMh0udXlSp8ONvmoIH+KQQ==
X-Received: by 2002:aca:b702:: with SMTP id h2-v6mr18321428oif.66.1536504227914;
        Sun, 09 Sep 2018 07:43:47 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id a144-v6sm33186324oii.30.2018.09.09.07.43.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 07:43:47 -0700 (PDT)
Subject: Re: [PATCH] usb: typec: don't disable sink or source on
 initialization
To:     Angus Ainslie <angus@akkea.ca>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck7@gmail.com>
References: <20180906192644.24587-1-angus@akkea.ca>
 <20180907103438.GI25121@kuha.fi.intel.com>
 <0adff11c-4836-4035-39a7-1cd2ea3ff74d@roeck-us.net>
 <00ed8e5a4ae0dd40181b8de534684960@www.akkea.ca>
 <690375f9-b721-51d5-7292-59acff44af7c@roeck-us.net>
 <363bd1128780d8de8e560b1b82ce361a@www.akkea.ca>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e48e7ff0-751c-a559-138d-0bb9411e18b0@roeck-us.net>
Date:   Sun, 9 Sep 2018 07:43:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <363bd1128780d8de8e560b1b82ce361a@www.akkea.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2018 07:36 AM, Angus Ainslie wrote:
> On 2018-09-09 08:20, Guenter Roeck wrote:
>> On 09/09/2018 07:08 AM, Angus Ainslie wrote:
>>> Hi Guenter
>>>
>>> On 2018-09-07 06:55, Guenter Roeck wrote:
>>>> On 09/07/2018 03:34 AM, Heikki Krogerus wrote:
>>>>> +Guenter
>>>>>
>>>>> On Thu, Sep 06, 2018 at 01:26:44PM -0600, Angus Ainslie (Purism) wrote:
>>>>>> If the board is being powered by USB disabling the source and sink
>>>>>> can remove power from the board. Default to source and sink enabled.
>>>>>>
>>>>
>>>> Seems to me that might violate the specification, and cause trouble for systems
>>>> where vbus has to be off initially. It may be better to provide this kind of
>>>> information as configuration parameter instead of imposing it on everyone.
>>>>
>>>
>>> It felt like it would not be the correct thing to do either. I've tried re-arranging the code in tcpci.c to enable the sink before disabling the source but the only way I found to not disable the power was by setting both of those to true.
>>>
>>> What about adding some device tree entries for the initial vbus state and default to false if they are not present ?
>>>
>>> init-vbus-source and init-vbus-charge ?
>>>
>>
>> Yes, I think we should do something along that line. Another question is
>> if we could or should optionally pull the current state from the low level
>> driver, but that may be secondary.
>>
> 
> I thought of trying to do that but from reading the "PTN5110N PD PHY application programming guide" there didn't seem to be a direct way to read those parameters.
> 

Let's put that on the backburner (maybe it works for some other chips)
and go with the devicetree property for now.

Guenter


>> Thanks,
>> Guenter
>>
>>> Angus
>>>
>>>> Guenter
>>>>
>>>>>> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
>>>>>> ---
>>>>>>   drivers/usb/typec/tcpm.c | 8 +++++---
>>>>>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
>>>>>> index ca7bedb46f7f..a1b819cf31da 100644
>>>>>> --- a/drivers/usb/typec/tcpm.c
>>>>>> +++ b/drivers/usb/typec/tcpm.c
>>>>>> @@ -2462,9 +2462,11 @@ static int tcpm_init_vbus(struct tcpm_port *port)
>>>>>>   {
>>>>>>       int ret;
>>>>>>   -    ret = port->tcpc->set_vbus(port->tcpc, false, false);
>>>>>> -    port->vbus_source = false;
>>>>>> -    port->vbus_charge = false;
>>>>>> +    /* default to source and sink enabled in case USB is our only power
>>>>>> +     * source */
>>>>
>>>> I am personally in favor of standard multi-line comments.
>>>>
>>>>>> +    ret = port->tcpc->set_vbus(port->tcpc, true, true);
>>>>>> +    port->vbus_source = true;
>>>>>> +    port->vbus_charge = true;
>>>>>>       return ret;
>>>>>>   }
>>>>>
>>>
>>>
> 
> 

