Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2F9EFC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A61208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RAxSEA7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A61208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934216AbeFLRGm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:06:42 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:39861 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933658AbeFLRGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 13:06:40 -0400
Received: by mail-qk0-f196.google.com with SMTP id g14-v6so15506825qkm.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 10:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d+Gp79xn1V/Jb9QT0t625UKjQZ86Es2lcOAGlFLu/x4=;
        b=RAxSEA7rDnQiNHZ7sAbA9r+PhwJZlMo/kvzbC7XT/YObp0zat7tsXWNyJkpjyIAUCY
         FLMox8DCyUiCM+yaPX75OTVpODvqxdIJ4XBXtx3gwFZ9QAJcQYiV57V3FvGzK4NCdVTi
         ayBRIQ2xF9W5IF1/DREwaaHii+0CwaogiAN2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d+Gp79xn1V/Jb9QT0t625UKjQZ86Es2lcOAGlFLu/x4=;
        b=TRa51zh/v0q+CO8vwzB6QVDhetbge+m5JQaFbzMPd+X2hmNhFDUZJdY/aqCTS389Be
         J0MOo05VmrGn4hnKJyxcufctsvP4WBq5cheo9pCHR3auYcJ+XmlSDw8pAt3UuuNbrLDD
         u25wIfpEoxjKqN5jUPDdyVB6sHix+EFEy4M1q439gG3PyRj87MaA6cSc94kJrMjnzDve
         Y5Vb7D9o0MBP/U/K/x9VYQLaWCGw7GNqV7nNMlAlR0Q4iZFZClvxivJiB3w9qlMUmWmC
         4TxklkZ7lxmkMA9g19hOuPHgHVdUlkI14u2vKzHGtO28REdcXnKieR54Ddsors1XDqrv
         4I8Q==
X-Gm-Message-State: APt69E0IRYGyvDiWyuNmyHi4GRmLU20b1o3T04AXkh2RgSyInqFeYlWQ
        +2pMEtrDgfddYHhNdOIeT2pA3A==
X-Google-Smtp-Source: ADUXVKLJDH2PcJUhUASob1Oonsgg4OtlL4C9uxkPA/PB4AtDgckUTMu6FFTGzpsmmtOgTXIqm2Wbng==
X-Received: by 2002:a37:d1d0:: with SMTP id o77-v6mr1258471qkl.185.1528823199537;
        Tue, 12 Jun 2018 10:06:39 -0700 (PDT)
Received: from [10.136.8.248] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id b14-v6sm380820qtp.26.2018.06.12.10.06.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 10:06:38 -0700 (PDT)
Subject: Re: [PATCH 2/6] PCI: iproc: Add INTx support with better modeling
To:     poza@codeaurora.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci-owner@vger.kernel.org
References: <1527631130-20045-1-git-send-email-ray.jui@broadcom.com>
 <1527631130-20045-3-git-send-email-ray.jui@broadcom.com>
 <3ecc33ebe3db1f010f5c8938dfb87677@codeaurora.org>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <89adfced-75d6-9ad2-0a39-1fbdf9a33cb0@broadcom.com>
Date:   Tue, 12 Jun 2018 10:06:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <3ecc33ebe3db1f010f5c8938dfb87677@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/12/2018 1:52 AM, poza@codeaurora.org wrote:
> On 2018-05-30 03:28, Ray Jui wrote:
>> Add PCIe legacy interrupt INTx support to the iProc PCIe driver by
>> modeling it with its own IRQ domain. All 4 interrupts INTA, INTB, INTC,
>> INTD share the same interrupt line connected to the GIC in the system,
>> while the status of each INTx can be obtained through the INTX CSR
>> register
>>
>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>> ---
>>  drivers/pci/host/pcie-iproc-platform.c |  2 +
>>  drivers/pci/host/pcie-iproc.c          | 95 
>> +++++++++++++++++++++++++++++++++-
>>  drivers/pci/host/pcie-iproc.h          |  6 +++
>>  3 files changed, 101 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/host/pcie-iproc-platform.c
>> b/drivers/pci/host/pcie-iproc-platform.c
>> index e764a2a..7a51e6c 100644
>> --- a/drivers/pci/host/pcie-iproc-platform.c
>> +++ b/drivers/pci/host/pcie-iproc-platform.c
>> @@ -70,6 +70,8 @@ static int iproc_pcie_pltfm_probe(struct
>> platform_device *pdev)
>>      }
>>      pcie->base_addr = reg.start;
>>
>> +    pcie->irq = platform_get_irq(pdev, 0);
>> +
>>      if (of_property_read_bool(np, "brcm,pcie-ob")) {
>>          u32 val;
>>
>> diff --git a/drivers/pci/host/pcie-iproc.c 
>> b/drivers/pci/host/pcie-iproc.c
>> index 14f374d..0bd2c14 100644
>> --- a/drivers/pci/host/pcie-iproc.c
>> +++ b/drivers/pci/host/pcie-iproc.c
>> @@ -14,6 +14,7 @@
>>  #include <linux/delay.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/irqchip/arm-gic-v3.h>
>> +#include <linux/irqchip/chained_irq.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/of_address.h>
>>  #include <linux/of_pci.h>
>> @@ -264,6 +265,7 @@ enum iproc_pcie_reg {
>>
>>      /* enable INTx */
>>      IPROC_PCIE_INTX_EN,
>> +    IPROC_PCIE_INTX_CSR,
>>
>>      /* outbound address mapping */
>>      IPROC_PCIE_OARR0,
>> @@ -305,6 +307,7 @@ static const u16 iproc_pcie_reg_paxb_bcma[] = {
>>      [IPROC_PCIE_CFG_ADDR]        = 0x1f8,
>>      [IPROC_PCIE_CFG_DATA]        = 0x1fc,
>>      [IPROC_PCIE_INTX_EN]        = 0x330,
>> +    [IPROC_PCIE_INTX_CSR]        = 0x334,
>>      [IPROC_PCIE_LINK_STATUS]    = 0xf0c,
>>  };
>>
>> @@ -316,6 +319,7 @@ static const u16 iproc_pcie_reg_paxb[] = {
>>      [IPROC_PCIE_CFG_ADDR]        = 0x1f8,
>>      [IPROC_PCIE_CFG_DATA]        = 0x1fc,
>>      [IPROC_PCIE_INTX_EN]        = 0x330,
>> +    [IPROC_PCIE_INTX_CSR]        = 0x334,
>>      [IPROC_PCIE_OARR0]        = 0xd20,
>>      [IPROC_PCIE_OMAP0]        = 0xd40,
>>      [IPROC_PCIE_OARR1]        = 0xd28,
>> @@ -332,6 +336,7 @@ static const u16 iproc_pcie_reg_paxb_v2[] = {
>>      [IPROC_PCIE_CFG_ADDR]        = 0x1f8,
>>      [IPROC_PCIE_CFG_DATA]        = 0x1fc,
>>      [IPROC_PCIE_INTX_EN]        = 0x330,
>> +    [IPROC_PCIE_INTX_CSR]        = 0x334,
>>      [IPROC_PCIE_OARR0]        = 0xd20,
>>      [IPROC_PCIE_OMAP0]        = 0xd40,
>>      [IPROC_PCIE_OARR1]        = 0xd28,
>> @@ -782,9 +787,90 @@ static int iproc_pcie_check_link(struct 
>> iproc_pcie *pcie)
>>      return link_is_active ? 0 : -ENODEV;
>>  }
>>
>> -static void iproc_pcie_enable(struct iproc_pcie *pcie)
>> +static int iproc_pcie_intx_map(struct irq_domain *domain, unsigned 
>> int irq,
>> +                   irq_hw_number_t hwirq)
>>  {
>> +    irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
>> +    irq_set_chip_data(irq, domain->host_data);
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct irq_domain_ops intx_domain_ops = {
>> +    .map = iproc_pcie_intx_map,
>> +};
>> +
>> +static void iproc_pcie_isr(struct irq_desc *desc)
>> +{
>> +    struct irq_chip *chip = irq_desc_get_chip(desc);
>> +    struct iproc_pcie *pcie;
>> +    struct device *dev;
>> +    unsigned long status;
>> +    u32 bit, virq;
>> +
>> +    chained_irq_enter(chip, desc);
>> +    pcie = irq_desc_get_handler_data(desc);
>> +    dev = pcie->dev;
>> +
>> +    /* go through INTx A, B, C, D until all interrupts are handled */
>> +    while ((status = iproc_pcie_read_reg(pcie, IPROC_PCIE_INTX_CSR) &
>> +        SYS_RC_INTX_MASK) != 0) {
>> +        for_each_set_bit(bit, &status, PCI_NUM_INTX) {
>> +            virq = irq_find_mapping(pcie->irq_domain, bit + 1);
>> +            if (virq)
>> +                generic_handle_irq(virq);
>> +            else
>> +                dev_err(dev, "unexpected INTx%u\n", bit);
>> +        }
>> +    }
>> +
> 
> Are these level or edge interrupts ? although I see DT says: IRQ_TYPE_NONE

DT entries should be fixed to trigger on level HIGH like Florian and I 
discussed on the mailing list yesterday. It looks like you are missing a 
lot of discussions on the mailing list. Could you please help to make 
sure you read all the existing discussions when commenting on a patch?

> do you not need to clear interrupt status bits in IPROC_PCIE_INTX_CSR ?
> 

RO

