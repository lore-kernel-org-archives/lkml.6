Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B962FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80579222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="L4jR5B/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405525AbfBNMpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 07:45:45 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46434 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387556AbfBNMpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 07:45:45 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1ECiOV8034708;
        Thu, 14 Feb 2019 06:44:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550148264;
        bh=+jsMrABFRq3JAYLqDdhLws59CZMHqDNNfRyOQ+yDdr8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=L4jR5B/FBMo0NvMg0bvTt2wMxzxqKMhIyqD/XpuIRNkGkuSaJ7fMJ8QY+0iy/eboC
         u2+xHTPaWXRwGKWFQ8t+hbtnqtZbqi2UKa+8zPhsuHZZGXkerflJoOt+zK09imiUFm
         UZz1gcChP4tn8tsQF3j05YkI1X3r2mUOam8AnvWA=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1ECiOFp097398
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Feb 2019 06:44:24 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 14
 Feb 2019 06:44:24 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 14 Feb 2019 06:44:24 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1ECiKI9009454;
        Thu, 14 Feb 2019 06:44:21 -0600
Subject: Re: [PATCH v3 20/37] ARM: davinci: aintc: move timer-specific
 irq_set_handler() out of irq.c
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        David Lechner <david@lechnology.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190212103835.7768-1-brgl@bgdev.pl>
 <20190212103835.7768-21-brgl@bgdev.pl> <86mumyskmg.wl-marc.zyngier@arm.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <28ca2198-ebe9-43b8-fcd6-c6dbd2939987@ti.com>
Date:   Thu, 14 Feb 2019 18:14:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <86mumyskmg.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/19 4:27 PM, Marc Zyngier wrote:
> On Tue, 12 Feb 2019 10:38:18 +0000,
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> I've been unable to figure out exactly why, but it seems that the
>> IRQ_TINT1_TINT34 interrupt for timer 1 needs to be handled as a
>> level irq, not edge like all others.
>>
>> Let's move the handler setup out of the aintc driver where it's lived
>> since the beginning and into the dm* SoC-specific files where it
>> belongs.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>  arch/arm/mach-davinci/dm355.c  | 8 ++++++++
>>  arch/arm/mach-davinci/dm365.c  | 8 ++++++++
>>  arch/arm/mach-davinci/dm644x.c | 8 ++++++++
>>  arch/arm/mach-davinci/dm646x.c | 8 ++++++++
>>  arch/arm/mach-davinci/irq.c    | 3 ---
>>  5 files changed, 32 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
>> index c7cd765114af..a732f2ea1d9a 100644
>> --- a/arch/arm/mach-davinci/dm355.c
>> +++ b/arch/arm/mach-davinci/dm355.c
>> @@ -15,6 +15,7 @@
>>  #include <linux/dma-mapping.h>
>>  #include <linux/dmaengine.h>
>>  #include <linux/init.h>
>> +#include <linux/irq.h>
>>  #include <linux/irqchip/irq-davinci-aintc.h>
>>  #include <linux/platform_data/edma.h>
>>  #include <linux/platform_data/gpio-davinci.h>
>> @@ -744,6 +745,13 @@ void __init dm355_init_time(void)
>>  	psc = ioremap(DAVINCI_PWR_SLEEP_CNTRL_BASE, SZ_4K);
>>  	dm355_psc_init(NULL, psc);
>>  
>> +	/*
>> +	 * Nobody knows why anymore, but this interrupt has been handled as
>> +	 * a level irq from the very beginning of davinci support in mainline
>> +	 * linux.
>> +	 */
>> +	irq_set_handler(DAVINCI_INTC_IRQ(IRQ_TINT1_TINT34), handle_level_irq);
>> +
> 
> I've said it on v2, I'm repeating it on v3. There is no point in
> duplicating this pointless hack on and on again. If there is a driver
> using this interrupt, move the setup there, and fix the irq_set_type
> callback.
> 
> If nothing is using it, remove it altogether.

Alright, fine with me as well. Dropping the hack is fine. And I think
that just boils down to discarding this patch.

Thanks,
Sekhar
