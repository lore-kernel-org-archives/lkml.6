Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEA0C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65FB420825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1BQtIUr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65FB420825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbeKJFm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 00:42:28 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45643 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeKJFm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 00:42:27 -0500
Received: by mail-wr1-f67.google.com with SMTP id k15-v6so3093638wre.12;
        Fri, 09 Nov 2018 12:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ioxSwm0dGrklDc0TwkbOc8BCspbfINnsEVGDj6FBrbM=;
        b=B1BQtIUrCgGweUBnwx9iW4ANN5utcy3DnDX4LVLTV2LMcvgzBlR8/fyPUbGvGo+GU6
         mT+Rm8sbPsNO9rBRg1f63MaFTMBGBi70SGqihKm2pps8d9lxHPlKF+Kn9iGqjhcQm6ii
         dxfkbj8uVVKjYVLtfWWWOv/dRIZzNDD2+BnpMhbv1aBX3j81pSdQnY9kfTKv4fNqJCgw
         OVz9Ss/JK7yWCn93EoLg7iJW06ZdV+m5XRdqu5yWqF0EMvcFGzgaS39SGZhPB20MOCty
         wfxVXgapWEVIj9a0ffSerIj2Ria1AktPJB8NR+Jmqpw1aLLeD141Z1H7G+3fnTf+JZjU
         4cHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ioxSwm0dGrklDc0TwkbOc8BCspbfINnsEVGDj6FBrbM=;
        b=rpiCI6xUvLLAclkikLRNXYDuz62cJh139aim17zYtuQX4pe1cGBRPfZVJEz1OVa94A
         GZTx9JCfWOvfizvOYCZ//bNmiwY5a3hvhd+haxEh4JTeXq19i7UEsF8w3FSK1aNki/Ax
         daK4sbUtS0jKVi43Lim1zhvm+azRSeOWeox++an4czhLtNnP3g+WY/5NWYHnzYURluJ4
         mv6VqMI5YPLCoNDhkXNvDqcU51TgJDd5rgw/4jci6xaKY7HVTE7kcZdWqQ/wvCQ4B6oS
         OMFOyhddifh+6RXdFsyBWBAPD3FxrKs3AV4XROuXThH3UrSyGTAicaXkGJcg40N3t9TN
         wdig==
X-Gm-Message-State: AGRZ1gK6Tgjg+x7UJ3DH0CQnMdNYzyDrymzuT+X5SSVm6+lcHhVaw9Kw
        ArGVVvIExz5dwbJ9bRV7AhE=
X-Google-Smtp-Source: AJdET5fg7dimDhn9axtlM1fnLxqzwaeFIHSU1NP8s5BrXW0mXgIyVzFOVo1UWHXlbKddT9Muzmwntw==
X-Received: by 2002:adf:cd0c:: with SMTP id w12-v6mr9587585wrm.67.1541793620603;
        Fri, 09 Nov 2018 12:00:20 -0800 (PST)
Received: from [192.168.1.18] (coo53.neoplus.adsl.tpnet.pl. [83.31.194.53])
        by smtp.gmail.com with ESMTPSA id e5-v6sm4954443wru.88.2018.11.09.12.00.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 12:00:19 -0800 (PST)
Subject: Re: [PATCH 04/24] dt-bindings: leds: Add function and color
 properties
To:     Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-5-git-send-email-jacek.anaszewski@gmail.com>
 <26714494-06f8-163d-1ef8-75f75c25a467@ti.com>
 <c650a9eb-afae-2a27-e39c-d448a5b3eadd@gmail.com>
 <81884969-956c-9d21-4114-4cb10d1e90e3@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <f573f259-9458-10b7-5e1e-423ffcd7f8ee@gmail.com>
Date:   Fri, 9 Nov 2018 21:00:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <81884969-956c-9d21-4114-4cb10d1e90e3@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

On 11/08/2018 10:08 PM, Dan Murphy wrote:
> Jacek
> 
> On 11/08/2018 02:47 PM, Jacek Anaszewski wrote:
>> Dan,
>>
>> On 11/08/2018 07:00 PM, Dan Murphy wrote:
>>> Jacek
>>>
>>> On 11/06/2018 04:07 PM, Jacek Anaszewski wrote:
>>>> Introduce dedicated properties for conveying information about
>>>> LED function and color. Mark old "label" property as deprecated.
>>>>
>>>> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>>>> Cc: Baolin Wang <baolin.wang@linaro.org>
>>>> Cc: Daniel Mack <daniel@zonque.org>
>>>> Cc: Dan Murphy <dmurphy@ti.com>
>>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>>> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
>>>> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
>>>> Cc: Simon Shields <simon@lineageos.org>
>>>> Cc: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/leds/common.txt | 52 +++++++++++++++++++----
>>>>  1 file changed, 44 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
>>>> index aa13998..3efc826 100644
>>>> --- a/Documentation/devicetree/bindings/leds/common.txt
>>>> +++ b/Documentation/devicetree/bindings/leds/common.txt
>>>> @@ -10,14 +10,20 @@ can influence the way of the LED device initialization, the LED components
>>>>  have to be tightly coupled with the LED device binding. They are represented
>>>>  by child nodes of the parent LED device binding.
>>>>  
>>>> +
>>>>  Optional properties for child nodes:
>>>>  - led-sources : List of device current outputs the LED is connected to. The
>>>>  		outputs are identified by the numbers that must be defined
>>>>  		in the LED device binding documentation.
>>>> +- function: LED functon. Use one of the LED_FUNCTION_* prefixed definitions
>>>> +	    from the header include/dt-bindings/leds/functions.h.
>>>> +	    If there is no matching LED_FUNCTION available, add a new one.
>>>> +- color : Color of the LED.
>>>
>>> Should we define the colors too?  There are only really 4.  Red, green, blue and white.
>>>
>>> Generally varying colors are created base on the primary colors.  Even the amber color
>>
>> No problem, I can add LED colors. However, I don't quite follow how
>> the mix of base color strings would give "amber" ? :-)
>>
> 
> Amber or yellow.  Red and green with a hint of blue or no blue depending on how dark you want it.
> 
> You don't always have to turn the LED on full to mix.  Sometimes lowering the level of the stronger colors like red 
> and upping weaker colors like green you can different color

That's obvious. I was rather curious what you had on mind by mentioning
four colors (red, green, blue and white) in the context of "amber".
Just to remind: we're still talking about LED names, not the values.

-- 
Best regards,
Jacek Anaszewski
