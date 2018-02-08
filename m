Return-Path: <vigneshr@ti.com>
X-Google-Smtp-Source: AH8x226Ptjjkk5s68wvvF+CPPmP9R/0gF6v4FR1tLgt8w2cHgC2Yo9RLLSektgDm50zRc58N17uD
ARC-Seal: i=1; a=rsa-sha256; t=1518110164; cv=none;
        d=google.com; s=arc-20160816;
        b=r5aTbaYQiPMCFI2CuaPKob1088/kSfDDOYdEzwcs8tAaJurcpitagOt0AkQlG60qUn
         YjbDXOWbRxhrF9hiZA1KW6t0Kbj/zjGqa1/BM9x5/MXB9rO9IevywUU/wy86CaraxOUN
         qNMmFGcVG7iSNH2brbXIJ1/hg7yoUgC9Y4fnQAw2tSId8wuxWur7Dn6XipymG34JxTFH
         7QJ/mtTxKU4YcsGPlyequKMGRNJ2zFtZSSvDssfiFwmFM/1MxGEdAUUj7ceikDGdEnPJ
         UesOz9AgYX16a6NQngsaA0p/1FqMOCndFDRNmv0PS5B6oz+EA78jPo5LGEaxQVSOKOOr
         f1qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=kQY2/alGybGE5OVjDWw2eVnAvCmueAxTyulUCaiiIQE=;
        b=SFGcAHXqPMwJCGTbi+7LcVxzmnxTYEOYRop3BTZxj+K2szad2mF2dFJHloVPYwVw/T
         xJMQBRvluyyUKMHCX8DQv+8pRaqVgELif/KxEldiqPpQHX8f3tcNR81GXqSmT7rxN9WN
         A65DySm7iYLdC23K8rUxc9khuSc6wVhNYycLV9aBS1UwXs01tlEfngqlq/68XzuQvP4O
         d5x9XmwLiNbR4k6YPMbWy69GhfOP3cm4ZefPXBgNOyp3zDHBT1c/1Im3d+Su3rnJweKE
         jgqD4rRZ/mWs8MgpgQD6ROJHlvjfH9YNKwiDqxkf9rsOgQW2QJGZA3NcZ4NGpEJgK1O8
         C1+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=xUO/Ll3G;
       spf=pass (google.com: domain of vigneshr@ti.com designates 198.47.19.16 as permitted sender) smtp.mailfrom=vigneshr@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=xUO/Ll3G;
       spf=pass (google.com: domain of vigneshr@ti.com designates 198.47.19.16 as permitted sender) smtp.mailfrom=vigneshr@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Subject: Re: [PATCH 1/2] serial: 8250: Don't service RX FIFO if interrupts are
 disabled
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jslaby@suse.com>, <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>,
        Linux OMAP Mailing List
	<linux-omap@vger.kernel.org>,
        linux-arm Mailing List
	<linux-arm-kernel@lists.infradead.org>
References: <20180208125542.15649-1-vigneshr@ti.com>
 <20180208125542.15649-2-vigneshr@ti.com>
 <CAHp75Vdo+B=Z+ScUgYvoWMSP7G6iC=LOiW57dViXCXm=g2gOLw@mail.gmail.com>
From: Vignesh R <vigneshr@ti.com>
Message-ID: <e50c8af2-0d9f-b589-29c8-e903576d8b70@ti.com>
Date: Thu, 8 Feb 2018 22:45:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vdo+B=Z+ScUgYvoWMSP7G6iC=LOiW57dViXCXm=g2gOLw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591837469077469236?=
X-GMAIL-MSGID: =?utf-8?q?1591853883840523208?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 08-Feb-18 8:46 PM, Andy Shevchenko wrote:
> On Thu, Feb 8, 2018 at 2:55 PM, Vignesh R <vigneshr@ti.com> wrote:
>> Currently, data in RX FIFO is read based on UART_LSR register state even
>> if RDI and RLSI interrupts are disabled in UART_IER register.
>> This is because when IRQ handler is called due to TX FIFO empty event,
>> RX FIFO is serviced based on UART_LSR register status instead of
>> UART_IIR status. This defeats the purpose of disabling UART RX
>> FIFO interrupts during throttling(see, omap_8250_throttle()) as IRQ
>> handler continues to drain UART RX FIFO resulting in overflow of buffer
>> at tty layer.
>> Fix this by making sure that driver drains UART RX FIFO only when
>> UART_IIR_RDI is set along with UART_LSR_BI or UART_LSR_DR bits.
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
> 
>> -       if (status & (UART_LSR_DR | UART_LSR_BI)) {
>> +       if (status & (UART_LSR_DR | UART_LSR_BI) &&
>> +           iir & UART_IIR_RDI) {
> 
>>                 if (!up->dma || handle_rx_dma(up, iir))
> 
> handle_rx_dma() checks for IRQ status as well.
> 
> But for now it seems we are on safe side since checks are done versus
> IRQ status with bit 2 set, meaning that iir & RDI will be true.
> 
>>                         status = serial8250_rx_chars(up, status);
>>         }
> 
> Anyway, thanks for the patch, though I need some time to test it on
> non-OMAP hardware with DMA enabled.

This patch is needed even when DMA is not enabled.
It would be great if you could test this. But, I don't see any other
8250 drivers apart from 8250_omap.c implementing
.throttle()/.unthrottle() callbacks.

Regards
Vignesh
