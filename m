Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8686DC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 18:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2413621567
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 18:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HobUUM6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2413621567
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbeHBUXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 16:23:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42223 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729963AbeHBUXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 16:23:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id l9-v6so1784972pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 11:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=U3M3SDId4q9V1N9JvBrbgvvXZNheulB6QcH6wpMM7ZI=;
        b=HobUUM6P/mCrk70DUmuvMrq+7FeoTA4qrl9lKdPDM+Scdc8uL9/UepD/IT5TR8BnfO
         5r8SQQYhjoct2PN7BnTsJ2eP4tH0EJdNBhh488AxY5XtaXAU4Dzd4kaUGbK4yjErdpD9
         /2QngFtMChx1eAwY8Ah/xGsHr5NZ4T7kaD4AKRv+8hwrrogGURzv57W9MuwvsLGiL4+i
         tpOd2JxRlY2YCGj+f4Ryd1R20aOwXVbjQmND1ZJ9DdEq3xDlRBzQOo2upxiX6otRj0sY
         iJrWEghkVF7vtQXNPQJ+mdb60NNIqtt0Imj6GtEcW+442aoCOHe/soZggbqfZrdvw1RA
         KgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=U3M3SDId4q9V1N9JvBrbgvvXZNheulB6QcH6wpMM7ZI=;
        b=CWGDQ/vlcD834cBv1iDaAO9O7NQi3cEz+X5sCECF07OwXq9N+3emazAKDGuTYpbWqp
         SxCA+knArPpf94adgLyqVLzSe+TQUkdI4/Ufq1VSFWT/xAsjuq8R+Ib2rHoppapjAhvw
         nZszrLUiPhIvITe0yXuxKk8FcBBAv0/Ujjw+ZCEx0ibez+8jrvJWhVAhj+6VXeBzwYmg
         q+UioH2nXPRxtVWd8iH2YXcPyWmTDmPJDSEVUDY9KSKRl15x14baknyrXvpdTVhi07l+
         Awly7hGgLQyuLYPUEOkS/x5FquHI/9g/PC3MWvpx1x5OSHbP+tPkRebfWyJT5KCbmV9p
         da/A==
X-Gm-Message-State: AOUpUlEVpc9T1J4UKT00AW9JsXa8DNlMVmxzBvyw5JJlvfjyyCFfsNZM
        JGp2k3EDM0csuFQdPfptPPUJHg==
X-Google-Smtp-Source: AAOMgpdxx2gB4DeJXBowSKxTL39VBHbTT7TqeGn9zLM4HEdgK6glCVcTNqhCmrHkMV6dNe5qSVlXeQ==
X-Received: by 2002:a63:d54e:: with SMTP id v14-v6mr581600pgi.264.1533234652472;
        Thu, 02 Aug 2018 11:30:52 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id g63-v6sm3730691pfc.77.2018.08.02.11.30.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 11:30:51 -0700 (PDT)
Date:   Thu, 02 Aug 2018 11:30:51 -0700 (PDT)
X-Google-Original-Date: Thu, 02 Aug 2018 11:22:24 PDT (-0700)
Subject:     Re: [PATCH 3/3] irqchip: RISC-V Local Interrupt Controller Driver
In-Reply-To: <1d55b6ee-2fa4-269b-4166-ffd36646f61f@infradead.org>
CC:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, aou@eecs.berkeley.edu,
        shorne@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Michael Clark <mjc@sifive.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     rdunlap@infradead.org
Message-ID: <mhng-5566e2ea-dfc6-44a7-afd7-798dd6945071@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018 17:08:58 PDT (-0700), rdunlap@infradead.org wrote:
> On 06/22/2018 04:20 PM, Palmer Dabbelt wrote:
>> From: Palmer Dabbelt <palmer@dabbelt.com>
>>
>> This patch adds a driver that manages the local interrupts on each
>> RISC-V hart, as specifiec by the RISC-V supervisor level ISA manual.
>> The local interrupt controller manages software interrupts, timer
>> interrupts, and hardware interrupts (which are routed via the
>> platform level interrupt controller).  Per-hart local interrupt
>> controllers are found on all RISC-V systems.
>>
>> CC: Michael Clark <mjc@sifive.com>
>> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
>> ---
>>  drivers/irqchip/Kconfig          |  13 +++
>>  drivers/irqchip/Makefile         |   1 +
>>  drivers/irqchip/irq-riscv-intc.c | 215 +++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 229 insertions(+)
>>  create mode 100644 drivers/irqchip/irq-riscv-intc.c
>>
>> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>> index e9233db16e03..bf7fc86673b1 100644
>> --- a/drivers/irqchip/Kconfig
>> +++ b/drivers/irqchip/Kconfig
>> @@ -372,3 +372,16 @@ config QCOM_PDC
>>  	  IRQs for Qualcomm Technologies Inc (QTI) mobile chips.
>>
>>  endmenu
>> +
>> +config RISCV_INTC
>> +	#bool "RISC-V Interrupt Controller"
>
> Hi,
> What does the leading '#' do?

It's just a comment.  I'd seen this idiom used before to say "here's what this 
option would say if it was optional, which it may be at some point in the 
future, but for now it's just always enabled."

>> +	depends on RISCV
>> +	default y
>> +	help
>> +	   This enables support for the local interrupt controller found in
>> +	   standard RISC-V systems.  The local interrupt controller handles
>> +	   timer interrupts, software interrupts, and hardware interrupts.
>> +	   Without a local interrupt controller the system will be unable to
>> +	   handle any interrupts, including those passed via the PLIC.
>> +
>> +	   If you don't know what to do here, say Y.
>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
>> index 15f268f646bf..74e333cc274c 100644
>> --- a/drivers/irqchip/Makefile
>> +++ b/drivers/irqchip/Makefile
>> @@ -87,3 +87,4 @@ obj-$(CONFIG_MESON_IRQ_GPIO)		+= irq-meson-gpio.o
>>  obj-$(CONFIG_GOLDFISH_PIC) 		+= irq-goldfish-pic.o
>>  obj-$(CONFIG_NDS32)			+= irq-ativic32.o
>>  obj-$(CONFIG_QCOM_PDC)			+= qcom-pdc.o
>> +obj-$(CONFIG_RISCV_INTC)		+= irq-riscv-intc.o
