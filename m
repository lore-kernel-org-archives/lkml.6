Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A873DC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 500F525D01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVcYOGGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 500F525D01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752472AbeFYPjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:39:15 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34910 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751513AbeFYPjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:39:13 -0400
Received: by mail-pg0-f66.google.com with SMTP id i7-v6so6238683pgp.2;
        Mon, 25 Jun 2018 08:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xyXiKlwfphkMeUX8O3ot3JZwkiukF4c6oJVQiUyPf04=;
        b=cVcYOGGbm9PCb7Lq6IoJ+ygA05FQ0a58wk9l64+644p63VO+Tgvbxz5fdlBKUEBe/J
         hV+H7xoyPY9DO8pUArbY0G0ydkV/hzTZWRW8staHbEDgS25kCGPsvL/FOLTkf8vpiIBt
         20cuHiZwr79UEbaH+c+CLGRY40xaMNKu9eVEKjBnkeQBaXMcrFiAnujwh+i9R+IbFwdX
         4KduxFY7EQDj6v73aSKot2o7KtSyqdpeQSfYPO2P3cK+yE3UvCpLLnaI87nvW7dglvhU
         FkLyZy5IogDKxFa4Ock08XV4cOwqv7Ux1sWqLbkA3XuI4rgMP1aUrzktPrgTO0tNOlnA
         P6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xyXiKlwfphkMeUX8O3ot3JZwkiukF4c6oJVQiUyPf04=;
        b=WQuriUf4Oo2TbBHAU6YTMe56cTMr4vumwwFoiJ6yiwXRDLjevajUPRrUm9wpYttD8J
         zY2KpTROgQR3lWoBmzUF/lnFdaFjJRjFuvMalUJIomhUGE1C8dCtwGh4C6Ku7qinM1jn
         MF3/P4p93VwoRkMweW5Y/c/C7l46jVru5wjP3A0ahOfsODIyvR34x+WA8kB3NJyd1wlL
         mgxgBvpNyVGb2Dj9mC1mh+JWpwVEAIrrfiPKW4hRVZ6SkyZafHayR7Dy6bdYryZiBY2/
         i3YUjc2Dx++kGs+jlM84Ff/GdgHeoGLbwuOHPE7zu2eRO/+TYRuN7BMId5TBv0YHV6mP
         x9ng==
X-Gm-Message-State: APt69E3cWjM/r4mpR+6j12D4fdxYUE67Ce7kMp15HR8uF8VE0AVMq/zO
        9Sm4MUyQbL4oC047OeqWNt4=
X-Google-Smtp-Source: ADUXVKIwz91BaMCnjc4BU1kvvt8VvmPmX0lsg0Z/k0qu/d40blhXmAt6aOf8Ut+uoxH1s2jzApLTCQ==
X-Received: by 2002:a62:cd82:: with SMTP id o124-v6mr13670445pfg.250.1529941153017;
        Mon, 25 Jun 2018 08:39:13 -0700 (PDT)
Received: from ziggy.stardust ([37.223.136.20])
        by smtp.gmail.com with ESMTPSA id y14-v6sm5765321pgo.22.2018.06.25.08.39.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 08:39:11 -0700 (PDT)
Subject: Re: [v3 01/10] dt-bindings: mediatek: mmsys: Add support for mfd
To:     Lee Jones <lee.jones@linaro.org>, matthias.bgg@kernel.org
Cc:     ulrich.hecht+renesas@gmail.com, laurent.pinchart@ideasonboard.com,
        ck.hu@mediatek.com, p.zabel@pengutronix.de, airlied@linux.ie,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@codeaurora.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, mchehab@kernel.org,
        rdunlap@infradead.org, sean.wang@mediatek.com,
        linux-clk@vger.kernel.org, linux@armlinux.org.uk,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>
References: <cover.1524820923.git.mbrugger@suse.com>
 <64ca273429d92f581568a48f3efe6035af65f579.1524820923.git.mbrugger@suse.com>
 <20180430103029.GD5147@dell>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 xsFNBFP1zgUBEAC21D6hk7//0kOmsUrE3eZ55kjc9DmFPKIz6l4NggqwQjBNRHIMh04BbCMY
 fL3eT7ZsYV5nur7zctmJ+vbszoOASXUpfq8M+S5hU2w7sBaVk5rpH9yW8CUWz2+ZpQXPJcFa
 OhLZuSKB1F5JcvLbETRjNzNU7B3TdS2+zkgQQdEyt7Ij2HXGLJ2w+yG2GuR9/iyCJRf10Okq
 gTh//XESJZ8S6KlOWbLXRE+yfkKDXQx2Jr1XuVvM3zPqH5FMg8reRVFsQ+vI0b+OlyekT/Xe
 0Hwvqkev95GG6x7yseJwI+2ydDH6M5O7fPKFW5mzAdDE2g/K9B4e2tYK6/rA7Fq4cqiAw1+u
 EgO44+eFgv082xtBez5WNkGn18vtw0LW3ESmKh19u6kEGoi0WZwslCNaGFrS4M7OH+aOJeqK
 fx5dIv2CEbxc6xnHY7dwkcHikTA4QdbdFeUSuj4YhIZ+0QlDVtS1QEXyvZbZky7ur9rHkZvP
 ZqlUsLJ2nOqsmahMTIQ8Mgx9SLEShWqD4kOF4zNfPJsgEMB49KbS2o9jxbGB+JKupjNddfxZ
 HlH1KF8QwCMZEYaTNogrVazuEJzx6JdRpR3sFda/0x5qjTadwIW6Cl9tkqe2h391dOGX1eOA
 1ntn9O/39KqSrWNGvm+1raHK+Ev1yPtn0Wxn+0oy1tl67TxUjQARAQABzSlNYXR0aGlhcyBC
 cnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPsLBkgQTAQIAPAIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AWIQTmuZIYwPLDJRwsOhfZFAuyVhMC8QUCWt3scQIZAQAKCRDZFAuy
 VhMC8WzRD/4onkC+gCxG+dvui5SXCJ7bGLCu0xVtiGC673Kz5Aq3heITsERHBV0BqqctOEBy
 ZozQQe2Hindu9lasOmwfH8+vfTK+2teCgWesoE3g3XKbrOCB4RSrQmXGC3JYx6rcvMlLV/Ch
 YMRR3qv04BOchnjkGtvm9aZWH52/6XfChyh7XYndTe5F2bqeTjt+kF/ql+xMc4E6pniqIfkv
 c0wsH4CkBHqoZl9w5e/b9MspTqsU9NszTEOFhy7p2CYw6JEa/vmzR6YDzGs8AihieIXDOfpT
 DUr0YUlDrwDSrlm/2MjNIPTmSGHH94ScOqu/XmGW/0q1iar/Yr0leomUOeeEzCqQtunqShtE
 4Mn2uEixFL+9jiVtMjujr6mphznwpEqObPCZ3IcWqOFEz77rSL+oqFiEA03A2WBDlMm++Sve
 9jpkJBLosJRhAYmQ6ey6MFO6Krylw1LXcq5z1XQQavtFRgZoruHZ3XlhT5wcfLJtAqrtfCe0
 aQ0kJW+4zj9/So0uxJDAtGuOpDYnmK26dgFN0tAhVuNInEVhtErtLJHeJzFKJzNyQ4GlCaLw
 jKcwWcqDJcrx9R7LsCu4l2XpKiyxY6fO4O8DnSleVll9NPfAZFZvf8AIy3EQ8BokUsiuUYHz
 wUo6pclk55PZRaAsHDX/fNr24uC6Eh5oNQ+v4Pax/gtyyc7BTQRT9gkSARAApxtQ4zUMC512
 kZ+gCiySFcIF/mAf7+l45689Tn7LI1xmPQrAYJDoqQVXcyh3utgtvBvDLmpQ+1BfEONDWc8K
 RP6Abo35YqBx3udAkLZgr/RmEg3+Tiof+e1PJ2zRh5zmdei5MT8biE2zVd9DYSJHZ8ltEWIA
 LC9lAsv9oa+2L6naC+KFF3i0m5mxklgFoSthswUnonqvclsjYaiVPoSldDrreCPzmRCUd8zn
 f//Z4BxtlTw3SulF8weKLJ+Hlpw8lwb3sUl6yPS6pL6UV45gyWMe677bVUtxLYOu+kiv2B/+
 nrNRDs7B35y/J4t8dtK0S3M/7xtinPiYRmsnJdk+sdAe8TgGkEaooF57k1aczcJlUTBQvlYA
 Eg2NJnqaKg3SCJ4fEuT8rLjzuZmLkoHNumhH/mEbyKca82HvANu5C9clyQusJdU+MNRQLRmO
 Ad/wxGLJ0xmAye7Ozja86AIzbEmuNhNH9xNjwbwSJNZefV2SoZUv0+V9EfEVxTzraBNUZifq
 v6hernMQXGxs+lBjnyl624U8nnQWnA8PwJ2hI3DeQou1HypLFPeY9DfWv4xYdkyeOtGpueeB
 lqhtMoZ0kDw2C3vzj77nWwBgpgn1Vpf4hG/sW/CRR6tuIQWWTvUM3ACa1pgEsBvIEBiVvPxy
 AtL+L+Lh1Sni7w3HBk1EJvUAEQEAAcLBXwQYAQIACQUCU/YJEgIbDAAKCRDZFAuyVhMC8Qnd
 EACuN16mvivnWwLDdypvco5PF8w9yrfZDKW4ggf9TFVB9skzMNCuQc+tc+QM+ni2c4kKIdz2
 jmcg6QytgqVum6V1OsNmpjADaQkVp5jL0tmg6/KA9Tvr07Kuv+Uo4tSrS/4djDjJnXHEp/tB
 +Fw7CArNtUtLlc8SuADCmMD+kBOVWktZyzkBkDfBXlTWl46T/8291lEspDWe5YW1ZAH/HdCR
 1rQNZWjNCpB2Cic58CYMD1rSonCnbfUeyZYNNhNHZosl4dl7f+am87Q2x3pK0DLSoJRxWb7v
 ZB0uo9CzCSm3I++aYozF25xQoT+7zCx2cQi33jwvnJAK1o4VlNx36RfrxzBqc1uZGzJBCQu4
 8UjmUSsTwWC3HpE/D9sM+xACs803lFUIZC5H62G059cCPAXKgsFpNMKmBAWweBkVJAisoQeX
 50OP+/11ArV0cv+fOTfJj0/KwFXJaaYh3LUQNILLBNxkSrhCLl8dUg53IbHx4NfIAgqxLWGf
 XM8DY1aFdU79pac005PuhxCWkKTJz3gCmznnoat4GCnL5gy/m0Qk45l4PFqwWXVLo9AQg2Kp
 3mlIFZ6fsEKIAN5hxlbNvNb9V2Zo5bFZjPWPFTxOteM0omUAS+QopwU0yPLLGJVf2iCmItHc
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <4ead47f6-2f69-2afa-bfcc-a240a9845dc4@gmail.com>
Date:   Mon, 25 Jun 2018 17:39:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180430103029.GD5147@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/04/18 12:30, Lee Jones wrote:
> On Fri, 27 Apr 2018, matthias.bgg@kernel.org wrote:
> 
>> From: Matthias Brugger <mbrugger@suse.com>
>>
>> Add binding description for the mmsys mfd for some Mediatek
>> devices. mmsys has some registers to control clock gates (which is
>> used in the clk driver) and some registers to set the routing and enable
>> the differnet blocks of the display subsystem.
>>
>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>> ---
>>  .../bindings/arm/mediatek/mediatek,mmsys.txt       |  2 --
>>  .../bindings/display/mediatek/mediatek,disp.txt    |  2 +-
>>  .../devicetree/bindings/mfd/mediatek,mmsys.txt     | 27 ++++++++++++++++++++++
>>  3 files changed, 28 insertions(+), 3 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mmsys.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
>> index 4eb8bbe15c01..4468345f8b1a 100644
>> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
>> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
>> @@ -6,10 +6,8 @@ The Mediatek mmsys controller provides various clocks to the system.
>>  Required Properties:
>>  
>>  - compatible: Should be one of:
>> -	- "mediatek,mt2701-mmsys", "syscon"
>>  	- "mediatek,mt2712-mmsys", "syscon"
>>  	- "mediatek,mt6797-mmsys", "syscon"
>> -	- "mediatek,mt8173-mmsys", "syscon"
>>  - #clock-cells: Must be 1
>>  
>>  The mmsys controller uses the common clk binding from
>> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
>> index 383183a89164..85a3b4ec06cd 100644
>> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
>> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
>> @@ -9,7 +9,7 @@ function block.
>>  
>>  All DISP device tree nodes must be siblings to the central MMSYS_CONFIG node.
>>  For a description of the MMSYS_CONFIG binding, see
>> -Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt.
>> +Documentation/devicetree/bindings/mfd/mediatek,mmsys.txt
>>  
>>  DISP function blocks
>>  ====================
>> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mmsys.txt b/Documentation/devicetree/bindings/mfd/mediatek,mmsys.txt
>> new file mode 100644
>> index 000000000000..2331ae16917e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mmsys.txt
>> @@ -0,0 +1,27 @@
>> +MediaTek MMSYS Multifunction Device Driver
> 
> What is "MMSYS"?
> 
> "Multi-Function Driver"s are specific to Linux.
> 
> What actually is the device?
> 

It's includes all the DRM parts of the SoC together with the clocks for the
device. MMSYS IMHO stands for Multi-Media-System.

Regards,
Matthias

>> +MMSYS is a multifunction device with the following sub modules:
>> +- clocks for the multi-media subsystem
>> +- central node for the DRM subsystem.
>> +
>> +This document describes the binding for MFD device. The MFD takes care to initailize
>> +the clock driver and the DRM driver. More info see
>> +Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
>> +
>> +Required properties:
>> +- compatible: Should be one of:
>> +	- "mediatek,mt2701-mmsys", "syscon"
>> +	- "mediatek,mt8173-mmsys", "syscon"
>> +- #clock-cells: Must be 1
>> +
>> +Optional properties:
>> +- power-domains: list of powerdomains needed for the subsystem to work
>> +
>> +Example:
>> +
>> +mmsys: clock-controller@14000000 {
>> +	compatible = "mediatek,mt8173-mmsys", "syscon";
>> +	reg = <0 0x14000000 0 0x1000>;
>> +	power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
>> +	#clock-cells = <1>;
>> +};
> 
