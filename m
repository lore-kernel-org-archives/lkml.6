Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05C8C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C3320854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFHb/cLm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C3320854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbeIMSnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:43:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35554 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbeIMSnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:43:01 -0400
Received: by mail-pf1-f195.google.com with SMTP id p12-v6so2694664pfh.2;
        Thu, 13 Sep 2018 06:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g4eoSrsy5upUlsJV4SyYexINV3PdT/n9DepTlpNTUjY=;
        b=YFHb/cLmlyG7i6W+8EKzijM5SsKJaGVnnbkJ+y5of+8fid7I832jF8fYqI58s0O7u/
         fmFaPVs6tWYBxOlwt2HLv7HL+ZwUftbt6Lz1SlYUP2yxX4+v8B7ejFXedLMn/Fc/eGPa
         jC8s1Jq2XvKNrkGCWHK19WjPPWjL6zmuQem7du3+I4anjrWLJHhNeUa+64PXyv9d8PZs
         2tErmpeD/1WnKp+DMDh531gkdxcT0zbveJl6EyCZ5nyHWcpdHzww3Zw6fiDqZxcQapOr
         34j7ex12L59gPEMMkwySUNGBM4EpTaxVr+VzaVoe9xA3sptsj0IBkq//a05TXauwfot1
         5m4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g4eoSrsy5upUlsJV4SyYexINV3PdT/n9DepTlpNTUjY=;
        b=G5WGy0QUS/C6O4jZlyzoD8mQL545Nuwpc79JoIVN1i5iU4hgX+TocPDscB3fh8EBam
         mCHvv9LdGRyD8FtHpKDpwho2QtYvaA35a/yFny3hTowcTdEFiNp9nDErhM2tiQLnuL1/
         +0Y9twe5saeBp7sRwgXzY1jdzXrISyOJDDaET7di0tS5AGLy2SLmsHcxD1oey94Qikz6
         g0mj623eEg4SCtUMrP+3BCm8n9KHtXT0bxHlpdeS0swAfD0DI6NXSANxhDMDtUcbGh31
         GRPMjM5fTWHQDyU+C8i8umvCj5ckj/BLHE6UJ7CsWmCSPJCBRIZ1E7PipeMW9ouq3D2k
         8T5g==
X-Gm-Message-State: APzg51Bvk9w6tuylELvgsbZW9vlTJfn5/C66fp8/xEqqy9gJUzaoAwSJ
        7caWLVYf/fdpT7N0rfavpy0nUUDq
X-Google-Smtp-Source: ANB0VdbiWg52ZC2c8Nu5J8P1LmEsxKqwsIRs6CvGv6EbwBaI93rVmiNorfO425/VjXbvaTFJUNjVZg==
X-Received: by 2002:a62:9bc9:: with SMTP id e70-v6mr7395770pfk.95.1536845611555;
        Thu, 13 Sep 2018 06:33:31 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id k69-v6sm4957590pgd.9.2018.09.13.06.33.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 06:33:30 -0700 (PDT)
Subject: Re: [PATCH i2c-next v6] i2c: aspeed: Handle master/slave combined irq
 events properly
To:     =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-i2c@vger.kernel.org, jarkko.nikula@linux.intel.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        James Feist <james.feist@linux.intel.com>
References: <1f34fe8c-69ef-5f2d-25dc-d5f6037cc558@linux.intel.com>
 <20180911204107.GA26017@roeck-us.net>
 <e5135af4-9105-214f-5de2-65cc03804222@linux.intel.com>
 <CACPK8Xdv3aP_zOHAL0WMgwvkpBHAUesU7OdhW==jgvXjRmt-Zw@mail.gmail.com>
 <20180911233302.GA18799@roeck-us.net>
 <5698ca34-14c9-8d05-c4e6-5acf85ff9d14@linux.intel.com>
 <20180912013449.GA12612@roeck-us.net>
 <7fd98646-fb5a-be4d-ce37-84b74e0fa8b3@linux.intel.com>
 <20180912195844.GA6893@roeck-us.net>
 <da7f4691-7428-3114-32bb-e0171f6c7228@linux.intel.com>
 <20180912203059.GA18201@roeck-us.net>
 <fb185839-3ae0-01dc-09e8-f22db55ecb04@kaod.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <3f86e75f-1502-eae8-0633-d087937111c8@roeck-us.net>
Date:   Thu, 13 Sep 2018 06:33:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <fb185839-3ae0-01dc-09e8-f22db55ecb04@kaod.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2018 10:45 PM, Cédric Le Goater wrote

[ ... ]

>> ---
>> qemu:
>>
>> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
>> index c762c73..0d4aa08 100644
>> --- a/hw/i2c/aspeed_i2c.c
>> +++ b/hw/i2c/aspeed_i2c.c
>> @@ -180,6 +180,33 @@ static uint8_t aspeed_i2c_get_state(AspeedI2CBus *bus)
>>       return (bus->cmd >> I2CD_TX_STATE_SHIFT) & I2CD_TX_STATE_MASK;
>>   }
>>   
>> +static void aspeed_i2c_handle_rx_cmd(AspeedI2CBus *bus)
>> +{
>> +    int ret;
>> +
>> +    if (!(bus->cmd & (I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST))) {
>> +        return;
>> +    }
> 
> it deserves a comment to understand which scenario we are trying to handle.
> 
>> +    if (bus->intr_status & I2CD_INTR_RX_DONE) {
>> +        return;
>> +    }
> 
> should be handled in aspeed_i2c_bus_handle_cmd() I think
> 

I moved those two checks into the calling code.


>> +    aspeed_i2c_set_state(bus, I2CD_MRXD);
>> +    ret = i2c_recv(bus->bus);
>> +    if (ret < 0) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: read failed\n", __func__);
>> +        ret = 0xff;
>> +    } else {
>> +        bus->intr_status |= I2CD_INTR_RX_DONE;
>> +    }
>> +    bus->buf = (ret & I2CD_BYTE_BUF_RX_MASK) << I2CD_BYTE_BUF_RX_SHIFT;
>> +    if (bus->cmd & I2CD_M_S_RX_CMD_LAST) {
>> +        i2c_nack(bus->bus);
>> +    }
>> +    bus->cmd &= ~(I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST);
>> +    aspeed_i2c_set_state(bus, I2CD_MACTIVE);
>> +}
>> +
>>   /*
>>    * The state machine needs some refinement. It is only used to track
>>    * invalid STOP commands for the moment.
>> @@ -188,7 +215,7 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
>>   {
>>       bus->cmd &= ~0xFFFF;
>>       bus->cmd |= value & 0xFFFF;
>> -    bus->intr_status = 0;> +    bus->intr_status &= I2CD_INTR_RX_DONE;
> 
> it deserves a comment to understand which scenario we are trying to handle.
>    

Ok. FWIW, I wonder if intr_status should be touched here in the first place,
but I neither have the hardware nor a datasheet, so I don't know if any bits
are auto-cleared.

>>       if (bus->cmd & I2CD_M_START_CMD) {
>>           uint8_t state = aspeed_i2c_get_state(bus) & I2CD_MACTIVE ?
>> @@ -227,22 +254,7 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
>>       }
>>   
>>       if (bus->cmd & (I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST)) {
>> -        int ret;
>> -
>> -        aspeed_i2c_set_state(bus, I2CD_MRXD);
>> -        ret = i2c_recv(bus->bus);
>> -        if (ret < 0) {
>> -            qemu_log_mask(LOG_GUEST_ERROR, "%s: read failed\n", __func__);
>> -            ret = 0xff;
>> -        } else {
>> -            bus->intr_status |= I2CD_INTR_RX_DONE;
>> -        }
>> -        bus->buf = (ret & I2CD_BYTE_BUF_RX_MASK) << I2CD_BYTE_BUF_RX_SHIFT;
>> -        if (bus->cmd & I2CD_M_S_RX_CMD_LAST) {
>> -            i2c_nack(bus->bus);
>> -        }
>> -        bus->cmd &= ~(I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST);
>> -        aspeed_i2c_set_state(bus, I2CD_MACTIVE);
>> +        aspeed_i2c_handle_rx_cmd(bus);
>>       }
>>   
>>       if (bus->cmd & I2CD_M_STOP_CMD) {
>> @@ -263,6 +275,7 @@ static void aspeed_i2c_bus_write(void *opaque, hwaddr offset,
>>                                    uint64_t value, unsigned size)
>>   {
>>       AspeedI2CBus *bus = opaque;
>> +    int status;
>>   
>>       switch (offset) {
>>       case I2CD_FUN_CTRL_REG:
>> @@ -283,9 +296,16 @@ static void aspeed_i2c_bus_write(void *opaque, hwaddr offset,
>>           bus->intr_ctrl = value & 0x7FFF;
>>           break;
>>       case I2CD_INTR_STS_REG:
>> +        status = bus->intr_status;
>>           bus->intr_status &= ~(value & 0x7FFF);
>> -        bus->controller->intr_status &= ~(1 << bus->id);
>> -        qemu_irq_lower(bus->controller->irq);
>> +        if (!bus->intr_status) {
>> +            bus->controller->intr_status &= ~(1 << bus->id);
>> +            qemu_irq_lower(bus->controller->irq);
>> +        }
> 
> That part below is indeed something to fix. I had a similar patch.
> 

Should I split it out as separate patch ? Alternatively, if you submitted
your patch already, I'll be happy to use it as base for mine.

Thanks,
Guenter

> 
>> +        if ((status & I2CD_INTR_RX_DONE) && !(bus->intr_status & I2CD_INTR_RX_DONE)) {
>> +            aspeed_i2c_handle_rx_cmd(bus);
>> +            aspeed_i2c_bus_raise_interrupt(bus);
>> +        }
> 
> ok.
> 
> Thanks for looking into this.
> 
> C.
> 
>>           break;
>>       case I2CD_DEV_ADDR_REG:
>>           qemu_log_mask(LOG_UNIMP, "%s: slave mode not implemented\n",
>>
> 
> 

