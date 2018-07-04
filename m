Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA11BC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EDBD24207
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RdOaiR6W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EDBD24207
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934444AbeGDJF5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:05:57 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53658 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932479AbeGDJFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:05:53 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6494LUD065656;
        Wed, 4 Jul 2018 04:04:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530695061;
        bh=r2OE8sJUi9rHlS+9rxJszYaAItoKn2wRLCXTgktCMPA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=RdOaiR6WThMrCmFfExPMLmmXr72OVguXF5i87g2QllKiihqMuizZcHaroGtFuvMZu
         qE8lJhXG7YZ3WgEkvmlblyP7bQhgu64cLxoGq0roJ73uN+biXDFakWh7uMq6Cnry9I
         HLKeik7EZSt14eEzlE9XgWRbTm8xniNZoT6rOO4E=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6494LhQ004281;
        Wed, 4 Jul 2018 04:04:21 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 4 Jul
 2018 04:04:20 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 4 Jul 2018 04:04:20 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6494CDd007627;
        Wed, 4 Jul 2018 04:04:13 -0500
Subject: Re: [PATCH v4 08/18] net: davinci_emac: potentially get the MAC
 address from MTD
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Ladislav Michl <ladis@linux-mips.org>
CC:     Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <netdev@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180629094039.7543-1-brgl@bgdev.pl>
 <20180629094039.7543-9-brgl@bgdev.pl>
 <03b77e24-9ab9-fa01-2387-9de0408a9942@gmail.com>
 <20180704070919.GA14051@lenoch>
 <CAMRc=McOYG9=naT2=4c4hnhJwxcqBCATEZOGXXv9u9zuvXyDXw@mail.gmail.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <c0ffc590-8064-3b02-9b5c-fcc24628d390@ti.com>
Date:   Wed, 4 Jul 2018 14:34:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAMRc=McOYG9=naT2=4c4hnhJwxcqBCATEZOGXXv9u9zuvXyDXw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 July 2018 01:59 PM, Bartosz Golaszewski wrote:
> 2018-07-04 9:09 GMT+02:00 Ladislav Michl <ladis@linux-mips.org>:
>> On Tue, Jul 03, 2018 at 09:39:51AM -0700, Florian Fainelli wrote:
>>>
>>>
>>> On 06/29/2018 02:40 AM, Bartosz Golaszewski wrote:
>>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>
>>>> On da850-evm board we can read the MAC address from MTD. It's currently
>>>> done in the relevant board file, but we want to get rid of all the MAC
>>>> reading callbacks from the board file (SPI and NAND). Move the reading
>>>> of the MAC address from SPI to the emac driver's probe function.
>>>
>>> This should be made something generic to all drivers, not just something
>>> the davinci_emac driver does, something like this actually:
>>>
>>> https://lkml.org/lkml/2018/3/24/312
>>
>> ...and that's would also make it work when MAC address is stored
>> in 24c08 EEPROM, which is quite common.
>>
> 
> This is what the second patch for davinci_emac in this series does. I
> agree that this should become more generic at some point - we should
> probably have a routine somewhere in net that would try to get the MAC
> address from all possible sources (nvmem, of etc.). This is somewhat
> related to the work I want to do on nvmem to make the at24 setup()
> callback more generic.
> 
> Unfortunately we don't have it yet and I will not have time to work on
> it before v4.20 so if there are no serious objections, I'd like to get
> this series merged for v4.19 and then we can refactor the MAC reading
> later.
> 
> How does it sound?

I don't think the series introduces any regressions. We need to have MTD
and SPI flash built into the kernel even today to get mac address on
DA850 EVM. So from that perspective, I don't have objections (I need to
actually test still).

OTOH, it will be nice to do the conversion once and not piecemeal. That
way there is less churn and scope for regressions.

So from a mach-davinci perspective, I don't have a very strong position
either way.

Thanks,
Sekhar
