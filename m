Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D211C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A32720861
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KygymblS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbfAOMj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:39:29 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49162 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbfAOMj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 07:39:29 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0FCd1h0075003;
        Tue, 15 Jan 2019 06:39:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547555941;
        bh=1b9IZZpxao3oVhk0afVgraIGTclD7OB4ku97dLLA7JQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KygymblSCGzAtffdNGxuKA3k/xMD77oIlvzyJ4dqwOmyyqNOmNF6az9KaZfwgE2IC
         eo5ed+Q5buv1Je7ixlMzGnbt4d2LOJ3cUeMtldrkbFxKXUlxmPXPOa12Si+H6zuM7D
         Zm3uAZaNlkhHkB4gHvqzO+22U88IkCZM4IksTX7A=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0FCd1F7000690
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Jan 2019 06:39:01 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 15
 Jan 2019 06:39:00 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 15 Jan 2019 06:39:00 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0FCcslB029165;
        Tue, 15 Jan 2019 06:38:54 -0600
Subject: Re: [RFC PATCH v4 12/13] irqchip: ti-sci-inta: Add support for
 Interrupt Aggregator driver
To:     Lokesh Vutla <lokeshvutla@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>, <marc.zyngier@arm.com>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>
References: <20181227060829.5080-1-lokeshvutla@ti.com>
 <20181227061313.5451-1-lokeshvutla@ti.com>
 <20181227061313.5451-12-lokeshvutla@ti.com>
 <9efbb01b-2ef9-13e7-f871-8db2c92844ee@ti.com>
 <50da7038-9b1c-6910-2cf1-78fa98ddc3bd@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <ad43911d-78b2-6ed0-31c2-8361b5f4911f@ti.com>
Date:   Tue, 15 Jan 2019 14:38:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <50da7038-9b1c-6910-2cf1-78fa98ddc3bd@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/2019 14:26, Lokesh Vutla wrote:
> Hi Peter,
> 
> On 02/01/19 5:19 PM, Peter Ujfalusi wrote:
>>
>>
>>
>> On 27/12/2018 8.13, Lokesh Vutla wrote:
>>> Texas Instruments' K3 generation SoCs has an IP Interrupt Aggregator
>>> which is an interrupt controller that does the following:
>>> - Converts events to interrupts that can be understood by
>>>    an interrupt router.
>>> - Allows for multiplexing of events to interrupts.
>>>
>>> Configuration of the interrupt aggregator registers can only be done by
>>> a system co-processor and the driver needs to send a message to this
>>> co processor over TISCI protocol.
>>>
>>> Add support for Interrupt Aggregator driver over TISCI protocol.
>>>
>>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>> ---
>>>   MAINTAINERS                       |   1 +
>>>   drivers/irqchip/Kconfig           |  12 +
>>>   drivers/irqchip/Makefile          |   1 +
>>>   drivers/irqchip/irq-ti-sci-inta.c | 561 ++++++++++++++++++++++++++++++
>>>   4 files changed, 575 insertions(+)
>>>   create mode 100644 drivers/irqchip/irq-ti-sci-inta.c
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index aebce615151e..7d12788c844a 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -15026,6 +15026,7 @@ F:    drivers/reset/reset-ti-sci.c
>>>   F:    
>>> Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>>>   F:    
>>> Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
>>>   F:    drivers/irqchip/irq-ti-sci-intr.c
>>> +F:    drivers/irqchip/irq-ti-sci-inta.c
>>>   Texas Instruments ASoC drivers
>>>   M:    Peter Ujfalusi <peter.ujfalusi@ti.com>
>>> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>>> index a8d9bed0254b..d16fd39408ad 100644
>>> --- a/drivers/irqchip/Kconfig
>>> +++ b/drivers/irqchip/Kconfig
>>> @@ -417,6 +417,18 @@ config TI_SCI_INTR_IRQCHIP
>>>         If you wish to use interrupt router irq resources managed by the
>>>         TI System Controller, say Y here. Otherwise, say N.
>>> +config TI_SCI_INTA_IRQCHIP
>>> +    bool
>>> +    depends on TI_SCI_PROTOCOL && ARCH_K3
>>> +    select IRQ_DOMAIN
>>> +    select IRQ_DOMAIN_HIERARCHY
>>> +    select K3_INTA_MSI_DOMAIN
>>> +    help
>>> +      This enables the irqchip driver support for K3 Interrupt 
>>> aggregator
>>> +      over TI System Control Interface available on some new TI's SoCs.
>>> +      If you wish to use interrupt aggregator irq resources managed 
>>> by the
>>> +      TI System Controller, say Y here. Otherwise, say N.
>>> +
>>>   endmenu
>>>   config SIFIVE_PLIC
>>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
>>> index b4ff376a08ef..a679490a7059 100644
>>> --- a/drivers/irqchip/Makefile
>>> +++ b/drivers/irqchip/Makefile
>>> @@ -95,3 +95,4 @@ obj-$(CONFIG_SIFIVE_PLIC)        += irq-sifive-plic.o
>>>   obj-$(CONFIG_IMX_IRQSTEER)        += irq-imx-irqsteer.o
>>>   obj-$(CONFIG_MADERA_IRQ)        += irq-madera.o
>>>   obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)    += irq-ti-sci-intr.o
>>> +obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)    += irq-ti-sci-inta.o
>>> diff --git a/drivers/irqchip/irq-ti-sci-inta.c 
>>> b/drivers/irqchip/irq-ti-sci-inta.c
>>> new file mode 100644
>>> index 000000000000..78bfc83a079a
>>> --- /dev/null
>>> +++ b/drivers/irqchip/irq-ti-sci-inta.c
>>> @@ -0,0 +1,561 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Texas Instruments' K3 Interrupt Aggregator irqchip driver
>>> + *
>>> + * Copyright (C) 2018 Texas Instruments Incorporated - 
>>> http://www.ti.com/
>>> + *    Lokesh Vutla <lokeshvutla@ti.com>
>>> + */
>>> +
>>> +#include <linux/err.h>
>>> +#include <linux/io.h>
>>> +#include <linux/msi.h>
>>> +#include <linux/irqchip.h>
>>> +#include <linux/of_platform.h>
>>> +#include <linux/of_address.h>
>>> +#include <linux/of_irq.h>
>>> +#include <linux/module.h>
>>> +#include <linux/moduleparam.h>
>>> +#include <linux/irqdomain.h>
>>
>> To fix this:
>>
>> drivers/irqchip/irq-ti-sci-inta.c: In function ‘inta_msi_irq_handler’:
>> drivers/irqchip/irq-ti-sci-inta.c:308:8: error: ‘IRQF_TRIGGER_HIGH’ 
>> undeclared (first use in this function); did you mean 
>> ‘IRQD_TRIGGER_MASK’?
>>          IRQF_TRIGGER_HIGH)
>>          ^~~~~~~~~~~~~~~~~
>>          IRQD_TRIGGER_MASK
>> drivers/irqchip/irq-ti-sci-inta.c:308:8: note: each undeclared 
>> identifier is reported only once for each function it appears in
>> drivers/irqchip/irq-ti-sci-inta.c: In function 
>> ‘ti_sci_inta_alloc_parent_irq’:
>> drivers/irqchip/irq-ti-sci-inta.c:360:27: error: ‘IRQF_TRIGGER_HIGH’ 
>> undeclared (first use in this function); did you mean 
>> ‘IRQD_TRIGGER_MASK’?
>>    parent_fwspec.param[2] = IRQF_TRIGGER_HIGH;
>>                             ^~~~~~~~~~~~~~~~~
>>                             IRQD_TRIGGER_MASK
>> make[3]: *** [scripts/Makefile.build:276: 
>> drivers/irqchip/irq-ti-sci-inta.o] Error 1
>>
>> Add this:
>> #include <linux/interrupt.h>
> 
> I did not see any such build error during my testing as shown below. But 
> agree about the report. Will fix it in next version
> 
> ➜  linux git:(nex-master) v8make defconfig
>    HOSTCC  scripts/basic/fixdep
>    HOSTCC  scripts/kconfig/conf.o
>    HOSTCC  scripts/kconfig/confdata.o
>    HOSTCC  scripts/kconfig/expr.o
>    HOSTCC  scripts/kconfig/symbol.o
>    HOSTCC  scripts/kconfig/preprocess.o
>    LEX     scripts/kconfig/zconf.lex.c
>    YACC    scripts/kconfig/zconf.tab.h
>    HOSTCC  scripts/kconfig/zconf.lex.o
>    YACC    scripts/kconfig/zconf.tab.c
>    HOSTCC  scripts/kconfig/zconf.tab.o
> v8  HOSTLD  scripts/kconfig/conf
> *** Default configuration is based on 'defconfig'
> make #
> # configuration written to .config
> #
> I%
>                               ➜  linux git:(nex-master) v8make Image 
> dtbs -j4 -s
> arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts:25.9-29.5: Warning 
> (graph_port): /edp-panel/ports: graph port node name should be 'port'
> arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts:46.9-50.5: Warning 
> (graph_port): /edp-panel/ports: graph port node name should be 'port'
> arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts:94.9-98.5: 
> Warning (graph_port): /edp-panel/ports: graph port node name should be 
> 'port'
> <stdin>:1339:2: warning: #warning syscall open_tree not implemented [-Wcpp]
> <stdin>:1342:2: warning: #warning syscall move_mount not implemented 
> [-Wcpp]
> <stdin>:1345:2: warning: #warning syscall fsopen not implemented [-Wcpp]
> <stdin>:1348:2: warning: #warning syscall fsconfig not implemented [-Wcpp]
> <stdin>:1351:2: warning: #warning syscall fsmount not implemented [-Wcpp]
> <stdin>:1354:2: warning: #warning syscall fspick not implemented [-Wcpp]
> ➜  linux git:(nex-master)
> 
> Thanks and regards,
> Lokesh

The mentioned failure only happens with a specific .config. Not sure 
what is the actual Kconfig that masks the failure though, but anyway it 
looks like interrupt.h gets included via some indirect path with arm64 
defconfig making it pass.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
