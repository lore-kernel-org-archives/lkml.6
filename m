Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA3EC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC9720883
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vc/lydKI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC9720883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757219AbeFSNBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:01:14 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36579 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755616AbeFSNBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:01:12 -0400
Received: by mail-pg0-f66.google.com with SMTP id m5-v6so9152847pgd.3;
        Tue, 19 Jun 2018 06:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Jwg4yjXFakzeSm/U0KvedSppQOjv6aTFz/fs5Kqj7ZQ=;
        b=vc/lydKI4r1jbBoBxUKYOpbPv04/LLW0XMNVdI9ucPkX3pW9BUIaSHZdagSVwFyveg
         fDOtr5rhZFsKPwCySLvt9eDWcwEr71YNt1gsH7w+Z5pcagbmEjpLlJMCjUYbVsL2792m
         ty9L8tgW0TgqKf65bTFlrGhmnwiNr5mR6thKi4ep940i52t04O4/gM7Z8pjIybhPZnZA
         OqrmvHxgr2SFNSaGs8KFMBPq/Cte/qkoZkScOLgalIJh56/v28oqJx7BcHYxnSu9zr/Z
         alEpfUQjZ2phzwK6T/rl0jgfN+AQcl4QELbIHKTPSPgNvvWy0w/R13l0yOOApETWw1Ps
         Hj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jwg4yjXFakzeSm/U0KvedSppQOjv6aTFz/fs5Kqj7ZQ=;
        b=nF7QedZBjfOZ2Z6HDOOhbVMc9q6ekjXq2myRit2/KUTYH418VJkCOJ+NE37yY0i54f
         zpbM9vRwidasnvMoGqvmcdxwPJHeCSX2R4a//bSt0iVEV4WXsndvh6Gkl9DZBx7L+wka
         XIF7tXSpTNu3INE6w3GlLqU19NX4zSaFnz0yteElak0umA2f4uFuv9b933PmWG1DFUSb
         85/gMvvi3DZka9fZsHMqOdko9FaDuDGJfZ7DWDZaQbA80NqD70zl1tE3PriM2iuT+hY+
         RXTPmwP9do2UgPfGFYWxPiOMlMeus6caJF1NffKS/eKSBC+EgsIMNEuIh4oRsOVYToar
         iEVg==
X-Gm-Message-State: APt69E3at4ZhzZ9D2wfX2COsTcYn3K/UWJlxB+cs7WryqbIAaU3fkOo0
        0KYT/gRsg/3gzXWtUKBocuE=
X-Google-Smtp-Source: ADUXVKJC/xXKdVz2ynYzL10dka7LJKiW/pIc8MQB/Aqr0c+T/3yt4+XmdZFhCstiaWx83L3JkC8NGw==
X-Received: by 2002:a63:4d14:: with SMTP id a20-v6mr15071908pgb.46.1529413271769;
        Tue, 19 Jun 2018 06:01:11 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id d18-v6sm12003719pfn.118.2018.06.19.06.01.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 06:01:10 -0700 (PDT)
Subject: Re: [PATCH] serial: mps2-uart: Initialize early console
To:     Vladimir Murzin <vladimir.murzin@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1529384097-1631-1-git-send-email-linux@roeck-us.net>
 <173551dd-3632-08a6-ec42-2ee416ccb9ad@arm.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <da7ba538-a81e-f2d2-d51c-1b39f5b455f0@roeck-us.net>
Date:   Tue, 19 Jun 2018 06:01:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <173551dd-3632-08a6-ec42-2ee416ccb9ad@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19/2018 02:07 AM, Vladimir Murzin wrote:
> Hi Guenter,
> 
> On 19/06/18 05:54, Guenter Roeck wrote:
>> The early console code for mps2-uart assumes that the serial hardware is
>> enabled for transmit when the system boots. However, this is not the case
>> after reset. This results in a hang in mps2_early_putchar() if the serial
>> transmitter is not enabled by a boot loader or ROM monitor.
> 
> I was under impression that for earlycon there is an assumption/requirement
> that the serial port must already be setup and configured. For instance, I
> see such requirement for pl011. So it looks like boot code's fault not to
> enable serial (for mps2 it needs to setup BAUDDIV as well).
> 

Good to know. Fine with me as well; I wasn't aware that such a requirement
existed.

Guenter

> I'm not against the patch per se, but I'd like to hear if my understanding of
> earlycon requirements is correct or not.
> 
> Cheers
> Vladimir
> 
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/tty/serial/mps2-uart.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
>> index 9f8f63719126..0743a0551ce1 100644
>> --- a/drivers/tty/serial/mps2-uart.c
>> +++ b/drivers/tty/serial/mps2-uart.c
>> @@ -448,6 +448,14 @@ static struct console mps2_uart_console = {
>>   
>>   #define MPS2_SERIAL_CONSOLE (&mps2_uart_console)
>>   
>> +static void mps2_early_init(struct uart_port *port)
>> +{
>> +	u8 control = readb(port->membase + UARTn_CTRL);
>> +
>> +	control |= UARTn_CTRL_TX_ENABLE;
>> +	writeb(control, port->membase + UARTn_CTRL);
>> +}
>> +
>>   static void mps2_early_putchar(struct uart_port *port, int ch)
>>   {
>>   	while (readb(port->membase + UARTn_STATE) & UARTn_STATE_TX_FULL)
>> @@ -469,6 +477,7 @@ static int __init mps2_early_console_setup(struct earlycon_device *device,
>>   	if (!device->port.membase)
>>   		return -ENODEV;
>>   
>> +	mps2_early_init(&device->port);
>>   	device->con->write = mps2_early_write;
>>   
>>   	return 0;
>>
> 
> 

