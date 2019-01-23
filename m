Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B04C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253C121850
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OY3tPaoH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfAWX6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 18:58:45 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33409 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbfAWX6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 18:58:44 -0500
Received: by mail-pl1-f193.google.com with SMTP id z23so1984087plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 15:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=GZJe5EbKNHuto8QgrVl02gFWkFbtyAX9mqXZe888OO8=;
        b=OY3tPaoHGnOjIkVyDB2MTfeVzG/0RH08tubCal8WACGBYmOPAtJ+DQnFHSmccr8ham
         /qNmDrTL19u4v9s5/09tMco2ss4pYkj1JJf9ivG2WrpUPvhpZSIH/IbtyQ1wqNqrXWZo
         Up80Ty9MFBIEjuhQgklwjo+HJOoQSV0I5kL3nK70x9MxvtjRCzLXadUnEKHxUNNI5O1G
         W6y72nPqeR/QCpuZm8bQ+VRfFbmUd2E4/DUZIU5akC/Vs1tEiLyOY/2wOfqTxqXO0+sH
         GKeI/WWMHtzV3U0kwjVvVqUlcS00Wo3SJLmb++C+6RXkQj1mFI2xj58aTmoFVt1bQf5J
         itng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=GZJe5EbKNHuto8QgrVl02gFWkFbtyAX9mqXZe888OO8=;
        b=dPserzMLyHEOv8iypaZ/A4x6Kw4CGhFqZQJJmSWLCvwVLNVv/29aEA7lkrSK/EeD76
         p1ICVy0+585gIxXyXF9297DHG7V4/UCyDRv0imNnlZaHtTeOL/sIln1oyHserKtEWQ57
         aUKcIUsbODHUlDj2uzYqsmoKC/ymZuLCO0LL/qZesq/h67mWVOyoMilqjgmen4UmEMf+
         6fbrVNiazpH3vc0acqF80BU9NkcP3tdMTJT7dMnLrh0LtdWtUlQMB1w2I5oXEBybPkGL
         0iYe4QSMBSh0VbD5ErO2wSlXI4P+BvnjFU7BiiObM+VcXmVCCuB7xFnjILXqDhg/AYdr
         eeIg==
X-Gm-Message-State: AJcUukchBUaywBkEj2CgTKzuP8TCl+HWybsmLF4O588A9AO+8g1M8F0c
        MytzgS6ikCj/SQj4C1AdNUXpJw==
X-Google-Smtp-Source: ALg8bN545ZSLeJ/eysTaFxjJ03VGthSXs/Zpg/IM/sgTNv/TYcNVxhAhh+ZGHUb+t0Bf7ucAC+GNRg==
X-Received: by 2002:a17:902:9a9:: with SMTP id 38mr4250658pln.204.1548287924007;
        Wed, 23 Jan 2019 15:58:44 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id w184sm25022966pgd.34.2019.01.23.15.58.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 15:58:43 -0800 (PST)
Date:   Wed, 23 Jan 2019 15:58:43 -0800 (PST)
X-Google-Original-Date: Wed, 23 Jan 2019 15:44:01 PST (-0800)
Subject:     Re: [PATCH] tty/serial: use uart_console_write in the RISC-V SBL early console
In-Reply-To: <CAAhSdy07AeWeMxQJvzRGzMQ84Sxc6O899T0dWO1vz0LB89ORyw@mail.gmail.com>
CC:     schwab@suse.de, Greg KH <gregkh@linuxfoundation.org>,
        jslaby@suse.com, aou@eecs.berkeley.edu, atish.patra@wdc.com,
        Christoph Hellwig <hch@infradead.org>, robh@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     anup@brainfault.org
Message-ID: <mhng-2f2fd42e-7dc1-4a21-9105-e129d55f1e5b@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2019 03:13:30 PST (-0800), anup@brainfault.org wrote:
> On Thu, Jan 10, 2019 at 10:41 PM Andreas Schwab <schwab@suse.de> wrote:
>>
>> This enables proper NLCR processing.
>>
>> Suggested-by: Anup Patel <anup@brainfault.org>
>> Signed-off-by: Andreas Schwab <schwab@suse.de>
>> ---
>>  drivers/tty/serial/earlycon-riscv-sbi.c | 13 ++++++++-----
>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/tty/serial/earlycon-riscv-sbi.c b/drivers/tty/serial/earlycon-riscv-sbi.c
>> index e1a551aae3..ce81523c31 100644
>> --- a/drivers/tty/serial/earlycon-riscv-sbi.c
>> +++ b/drivers/tty/serial/earlycon-riscv-sbi.c
>> @@ -10,13 +10,16 @@
>>  #include <linux/serial_core.h>
>>  #include <asm/sbi.h>
>>
>> -static void sbi_console_write(struct console *con,
>> -                             const char *s, unsigned int n)
>> +static void sbi_putc(struct uart_port *port, int c)
>>  {
>> -       int i;
>> +       sbi_console_putchar(c);
>> +}
>>
>> -       for (i = 0; i < n; ++i)
>> -               sbi_console_putchar(s[i]);
>> +static void sbi_console_write(struct console *con,
>> +                             const char *s, unsigned n)
>> +{
>> +       struct earlycon_device *dev = con->data;
>> +       uart_console_write(&dev->port, s, n, sbi_putc);
>>  }
>>
>>  static int __init early_sbi_setup(struct earlycon_device *device,
>> --
>> 2.20.1
>>
>> --
>> Andreas Schwab, SUSE Labs, schwab@suse.de
>> GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
>> "And now for something completely different."
>
> Looks good to me.
>
> Reviewed-by: Anup Patel <anup@brainfault.org>
>
> Regards,
> Anup

Thanks.  I'm going to include this in my next PR, as it's pretty self contained 
and is necessary to actually use this sanely.
