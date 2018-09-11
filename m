Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BB5C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD3920839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD3920839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbeIKNai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:30:38 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:1376 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbeIKNah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:30:37 -0400
X-IronPort-AV: E=Sophos;i="5.53,359,1531810800"; 
   d="scan'208";a="19314445"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Sep 2018 01:32:23 -0700
Received: from [10.159.245.112] (10.10.76.4) by chn-sv-exch07.mchp-main.com
 (10.10.76.108) with Microsoft SMTP Server id 14.3.352.0; Tue, 11 Sep 2018
 01:32:23 -0700
Subject: Re: linux-next: build failure after merge of the tty tree
To:     Lee Jones <lee.jones@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg KH <greg@kroah.com>
CC:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Radu Pirea <radu.pirea@microchip.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh@kernel.org>
References: <20180911125857.5e5c34f4@canb.auug.org.au>
 <20180911082534.GA4185@dell>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <84bafe76-741e-7dc1-d985-62027f4f634a@microchip.com>
Date:   Tue, 11 Sep 2018 10:32:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180911082534.GA4185@dell>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2018 at 10:25, Lee Jones wrote:
> On Tue, 11 Sep 2018, Stephen Rothwell wrote:
> 
>> Hi Greg,
>>
>> After merging the tty tree, today's linux-next build (arm
>> multi_v7_defconfig) failed like this:
>>
>> drivers/mfd/at91-usart.c:51:34: error: array type has incomplete element type 'struct of_device_id'
>>   static const struct of_device_id at91_usart_mode_of_match[] = {
>>                                    ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/mfd/at91-usart.c:52:4: error: field name not in record or union initializer
>>    { .compatible = "atmel,at91rm9200-usart" },
>>      ^
>> drivers/mfd/at91-usart.c:52:4: note: (near initialization for 'at91_usart_mode_of_match')
>> drivers/mfd/at91-usart.c:53:4: error: field name not in record or union initializer
>>    { .compatible = "atmel,at91sam9260-usart" },
>>      ^
>> drivers/mfd/at91-usart.c:53:4: note: (near initialization for 'at91_usart_mode_of_match')
>> drivers/mfd/at91-usart.c:51:34: warning: 'at91_usart_mode_of_match' defined but not used [-Wunused-variable]
>>   static const struct of_device_id at91_usart_mode_of_match[] = {
>>                                    ^~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Caused by commit
>>
>>    7d3aa342cef7 ("mfd: at91-usart: Add MFD driver for USART")
>>
>> Forgot to include <linux/mod_devicetable.h>?
> 
> Looks like a missing Device Tree header <linux/of.h>.
> 
> Will chase this today and follow up with another PR.

Hi all,

Actually it is due to the missing of  <linux/mod_devicetable.h> as 
Stephen suggested. It is due to the patch ac3167257b9f ("headers: 
separate linux/mod_devicetable.h from linux/platform_device.h") merged 
in v4.19-rc1.

because linux/platform_device.h was included by linux/mfd/core.h that is 
present in this driver. This is why the issue was not identified beforehand.

I'm building a tiny patch to address this right now.

Thanks for your help. Best regards,
-- 
Nicolas Ferre
