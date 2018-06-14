Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1A32BC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 17:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04DD208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 17:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ENX4TaST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C04DD208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755196AbeFNRcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 13:32:16 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:24723 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754656AbeFNRcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 13:32:14 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelnx193.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5EHWDFv020651;
        Thu, 14 Jun 2018 12:32:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1528997533;
        bh=7DlFSSG7M4UlFG7JiwY+S8QayYzB1ATDTf6eH6rWJOY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ENX4TaST95y6UdW7hvOecaLDE7sv1BCPJR+c15btXMBOJ/DfX9274SAKHL2GqxG0I
         x7q6zf+Y4szhHqQvMUIgjwuvr25QO1/KY+2M1DxaVLd72d1jwqvTrr54qWIjYxmZKf
         hnF5maEuz7Yj9zJQlVQI3C/YfLr9R7N2WXe85cPI=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5EHWDtr032106;
        Thu, 14 Jun 2018 12:32:13 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 14
 Jun 2018 12:32:13 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 14 Jun 2018 12:32:13 -0500
Received: from [172.22.216.30] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5EHW9xJ013375;
        Thu, 14 Jun 2018 12:32:11 -0500
Subject: Re: [PATCH 2/2] gpio: davinci: Do not assume continuous IRQ numbering
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>
References: <1528276734-1483-1-git-send-email-j-keerthy@ti.com>
 <1528276734-1483-2-git-send-email-j-keerthy@ti.com>
 <CACRpkdbFyZwG4S9t3ts3wmVWioadd7NjpdMUkq-wujH=g68zvw@mail.gmail.com>
 <711dc0a5-9099-dbc9-6f8f-f37caf69105f@ti.com>
 <CACRpkdYOrg2M4zcomaGu_uUGMdnajwtoD-voETp-dRvL2WJpCA@mail.gmail.com>
From:   "J, KEERTHY" <j-keerthy@ti.com>
Message-ID: <3ac5bf3e-6e56-b190-aa97-df850f2545bb@ti.com>
Date:   Thu, 14 Jun 2018 23:02:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdYOrg2M4zcomaGu_uUGMdnajwtoD-voETp-dRvL2WJpCA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/2018 4:48 PM, Linus Walleij wrote:
> On Thu, Jun 14, 2018 at 10:51 AM, Keerthy <j-keerthy@ti.com> wrote:
> 
>>> I think the idea is to make it possible to use GPIOLIB_IRQCHIP
>>> for banked IRQs but the infrastructure is not yet inside the gpiolib
>>> so it is a bit taped on the side right now.
>>
>> Okay. I will take a look at that. The key issue that this patch
>> addresses is that currently driver only calls platform_get_irq once and
>> assumes the rest are continuous which is wrong hence the key issue
>> addressed with this patch is to call platform_get_irq for each interrupt.
>>
>> The version 4 is here:
>>
>> https://patchwork.kernel.org/patch/10461537/
>>
>> I will try to follow up with generic gpiochip_irq_map/unmap once i get
>> that working. Hope that is okay?
> 
> Oh that's fine, I'll merge it.

Thanks!

> 
> Just wanted you to have a look at Thierry's stuff so we can share
> more code, you're a core developer so I wanted some smart people
> to look at this.

Sure Linus!

> 
> Yours,
> Linus Walleij
> 
