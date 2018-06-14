Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A8B8AC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5325F208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oK9jakPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5325F208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754827AbeFNIvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:51:21 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:62341 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752928AbeFNIvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:51:19 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelnx193.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5E8pIaN025581;
        Thu, 14 Jun 2018 03:51:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1528966278;
        bh=3BXTDbmmpHklBcZS9e1Y98mVEBTSmaD7fO90AFiOW9Q=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=oK9jakPsCCoLeDYj5GwAXTP5cHAms2TJvoiimXKSjVIV7Fy1w9obeR9CRr1eF2Xeo
         miK/JeFr5tA1KsOBurQOuP8bdfHbGijZqW76UFruyJfYhoSGtAkLeqwg0X8OGOADkz
         EXZm51Qc/IVBJvoUkPqaBpIMi4bd1k/PLE1IhEMU=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5E8pIOi013040;
        Thu, 14 Jun 2018 03:51:18 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 14
 Jun 2018 03:51:17 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 14 Jun 2018 03:51:17 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5E8pF4W014161;
        Thu, 14 Jun 2018 03:51:15 -0500
Subject: Re: [PATCH 2/2] gpio: davinci: Do not assume continuous IRQ numbering
To:     Linus Walleij <linus.walleij@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>
References: <1528276734-1483-1-git-send-email-j-keerthy@ti.com>
 <1528276734-1483-2-git-send-email-j-keerthy@ti.com>
 <CACRpkdbFyZwG4S9t3ts3wmVWioadd7NjpdMUkq-wujH=g68zvw@mail.gmail.com>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <711dc0a5-9099-dbc9-6f8f-f37caf69105f@ti.com>
Date:   Thu, 14 Jun 2018 14:21:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdbFyZwG4S9t3ts3wmVWioadd7NjpdMUkq-wujH=g68zvw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday 14 June 2018 01:59 PM, Linus Walleij wrote:
> On Wed, Jun 6, 2018 at 11:18 AM, Keerthy <j-keerthy@ti.com> wrote:
> 
>> Currently the driver assumes that the interrupts are continuous
>> and does platform_get_irq only once and assumes the rest are continuous,
>> instead call platform_get_irq for all the interrupts and store them
>> in an array for later use.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
> 
> Hm! Thierry has recently submitted patches to make it easier for chips with
> banked IRQs to use the GPIOLIB_IRQCHIP.
> 
> Please look at the code in gpio/gpio-tegra186.c and see if you can use
> his approach.
> 
> As you can see this chip is using gpiochip_irq_map/unmap in its
> domain, and manipulates struct gpio_irq_chip directly.
> 
> I think the idea is to make it possible to use GPIOLIB_IRQCHIP
> for banked IRQs but the infrastructure is not yet inside the gpiolib
> so it is a bit taped on the side right now.

Okay. I will take a look at that. The key issue that this patch
addresses is that currently driver only calls platform_get_irq once and
assumes the rest are continuous which is wrong hence the key issue
addressed with this patch is to call platform_get_irq for each interrupt.

The version 4 is here:

https://patchwork.kernel.org/patch/10461537/

I will try to follow up with generic gpiochip_irq_map/unmap once i get
that working. Hope that is okay?

> 
> Yours,
> Linus Walleij
> 
