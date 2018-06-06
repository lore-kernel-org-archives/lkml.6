Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="u5k5E2UG"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4EBF360764
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752093AbeFFOcO (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 10:32:14 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:38466 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751994AbeFFOcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 10:32:12 -0400
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
Subject: Re: [PATCH 1/4] serial: 8250: Copy em485 from port to real port.
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: matwey.kornilov@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Allen Pais <allen.lkml@gmail.com>, Sean Young <sean@mess.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <CAJs94EZqdQAQG+inWvj89FCQtv06LxhY_J4YgNmK8mtvgDTchQ@mail.gmail.com>
 <20180606094942.71190-1-giulio.benetti@micronovasrl.com>
 <20180606094942.71190-4-giulio.benetti@micronovasrl.com>
 <069f5cd3309e83d13c74929f240720b232ea7251.camel@linux.intel.com>
 <0bc400b1-6178-2021-c9a3-3190d1a1de32@micronovasrl.com>
 <2abe2137e699e5ae3100b97316da469f6d1c9bb9.camel@linux.intel.com>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <e312f1be-30e7-b379-3baa-8ae51fda61b2@micronovasrl.com>
Date: Wed, 6 Jun 2018 16:32:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <2abe2137e699e5ae3100b97316da469f6d1c9bb9.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Il 06/06/2018 15:11, Andy Shevchenko ha scritto:
> On Wed, 2018-06-06 at 14:15 +0200, Giulio Benetti wrote:
>> Il 06/06/2018 13:56, Andy Shevchenko ha scritto:
>>> On Wed, 2018-06-06 at 11:49 +0200, Giulio Benetti wrote:
>>>> em485 gets lost during
>>>>
>>>> Copy em485 to final uart port.
>>>>
>>>
>>> Is it needed at all?
>>>
>>> The individual driver decides either to use software emulation (and
>>> calls explicitly serial8250_em485_init() for that) or do HW assisted
>>> stuff.
>>
>> In 8250_dw.c, during probe(), I need to call dw8250_rs485_config()
>> against local struct uart_8250_port uart = {};
>> Inside serial8250_register_8250_port() not all uart fields are
>> copied(em485 too).
>> So after probe, em485 is NULL.
>>
>> Another way could be to call dw8250_rs485_config() against real uart
>> port, after calling serial8250_register_8250_port(),
>> would it make sense?
> 
> Look at OMAP case closely. They have a callback to configure RS485 which
> is called in uart_set_rs485_config()  which is called whenever user
> space does TIOCGRS485 IOCTL.
> 
> So, it's completely driven by user space which makes sense by my
> opinion.

This is my problem, being driven only by userspace means that until you 
don't open ttyS* from there, dw8250_rs485_config() won't be called and 
rs485 won't be configured.
In the case you have RTS_AFTER_SEND and 
"linux,rs485-enabled-at-boot-time" in dts, you need to handle RTS correctly.
Without calling:
- uart_get_rs485_mode() to collect dts properties
and
- dw8250_rs485_config() to configure according properties
the result is RTS NOT asserted, then pin is HIGH, meaning that rs485 
transceiver will be in tx mode until port is open.

Other drivers I've watched to for insipiration are:
- atmel_serial.c
- fsl_lpuart.c
- imx.c
etc.

everything containing uart_get_rs485_mode().

The main difficulty to understand this without a scope is that on 
rs485.txt documentation the property "rs485-rts-active-low" is described as:
"drive RTS low when sending (default is high)"
Instead it should report:
"de-assert RTS when sending(pin high), default is asserted(pin low)"

Maybe I should send a patch for that also.
I ended to this conclusion because on every check of RTS_AFTER_SEND and 
SER_RS485_RTS_ON_SEND RTS is treated this way.

Try to take a look at uart_port_dtr_rts() in serial_core.c for example.
Or serial8250_em485_rts_after_send() in 8250_port.c

What do you think?
-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale € 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
