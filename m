Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="J51/VRhq"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6173F60555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752042AbeFFMP3 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:15:29 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:60514 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbeFFMP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:15:27 -0400
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
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <0bc400b1-6178-2021-c9a3-3190d1a1de32@micronovasrl.com>
Date: Wed, 6 Jun 2018 14:15:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <069f5cd3309e83d13c74929f240720b232ea7251.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/06/2018 13:56, Andy Shevchenko ha scritto:
> On Wed, 2018-06-06 at 11:49 +0200, Giulio Benetti wrote:
>> em485 gets lost during serial8250_register_8250_port().
>>
>> Copy em485 to final uart port.
>>
> 
> Is it needed at all?
> 
> The individual driver decides either to use software emulation (and
> calls explicitly serial8250_em485_init() for that) or do HW assisted
> stuff.

In 8250_dw.c, during probe(), I need to call dw8250_rs485_config() 
against local struct uart_8250_port uart = {};
Inside serial8250_register_8250_port() not all uart fields are 
copied(em485 too).
So after probe, em485 is NULL.

Another way could be to call dw8250_rs485_config() against real uart 
port, after calling serial8250_register_8250_port(),
would it make sense?

> 
>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
>> ---
>>   drivers/tty/serial/8250/8250_core.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/tty/serial/8250/8250_core.c
>> b/drivers/tty/serial/8250/8250_core.c
>> index 9342fc2ee7df..c8c2b260c681 100644
>> --- a/drivers/tty/serial/8250/8250_core.c
>> +++ b/drivers/tty/serial/8250/8250_core.c
>> @@ -994,6 +994,7 @@ int serial8250_register_8250_port(struct
>> uart_8250_port *up)
>>   		uart->port.rs485_config	= up-
>>> port.rs485_config;
>>   		uart->port.rs485	= up->port.rs485;
>>   		uart->dma		= up->dma;
>> +		uart->em485		= up->em485;
>>   
>>   		/* Take tx_loadsz from fifosize if it wasn't set
>> separately */
>>   		if (uart->port.fifosize && !uart->tx_loadsz)
> 

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
