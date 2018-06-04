Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752487AbeFDLuk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 07:50:40 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:45910 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbeFDLuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 07:50:39 -0400
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
Subject: Re: [PATCH 4/8] serial: 8250: Handle case port doesn't have TEMT
 interrupt using em485.
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Kees Cook <keescook@chromium.org>,
        Matthias Brugger <mbrugger@suse.com>,
        Allen Pais <allen.lkml@gmail.com>, Sean Young <sean@mess.org>,
        Ed Blake <ed.blake@sondrel.com>,
        Stefan Potyra <Stefan.Potyra@elektrobit.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Joshua Scott <joshua.scott@alliedtelesis.co.nz>,
        Vignesh R <vigneshr@ti.com>,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>,
        Aaron Sierra <asierra@xes-inc.com>,
        Rafael Gago <rafael.gago@gmail.com>, Joel Stanley <joel@jms.id.au>,
        Sean Wang <sean.wang@mediatek.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180601124021.102970-1-giulio.benetti@micronovasrl.com>
 <20180601124021.102970-5-giulio.benetti@micronovasrl.com>
 <3a66327727d9bf2ce5adf8ef0f1fcc1fffeaa4ec.camel@linux.intel.com>
 <4a7148d5-ab2c-425d-afdc-08ddd3c522c2@micronovasrl.com>
 <2a2f547d787db9d593bb7fe3ad9c833836e23749.camel@linux.intel.com>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <2c61887c-53e0-1ece-9f4a-89250134f083@micronovasrl.com>
Date: Mon, 4 Jun 2018 13:50:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <2a2f547d787db9d593bb7fe3ad9c833836e23749.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Il 04/06/2018 13:38, Andy Shevchenko ha scritto:
> On Mon, 2018-06-04 at 12:50 +0200, Giulio Benetti wrote:
>> Hi,
>>
>> Il 04/06/2018 12:17, Andy Shevchenko ha scritto:
>>> On Fri, 2018-06-01 at 14:40 +0200, Giulio Benetti wrote:
>>>> Some 8250 ports only have TEMT interrupt, so current
>>>> implementation
>>>> can't work for ports without it. The only chance to make it work
>>>> is to
>>>> loop-read on LSR register.
>>>>
>>>> With NO TEMT interrupt check if both TEMT and THRE are set looping
>>>> on
>>>> LSR register.
>>>> --- a/drivers/tty/serial/8250/8250_dw.c
>>>> +++ b/drivers/tty/serial/8250/8250_dw.c
>>>> -		int ret = serial8250_em485_init(up);
>>>> +		int ret = serial8250_em485_init(up, false);
>>>
>>> Is true for all possible DW configured types? Or it's your
>>> particular
>>> case?
>>>
>>
>> I've checked on Synopsis Designware 8250 datasheet and it's not
>> supported.
>> Here is datasheet I went through:
>> https://linux-sunxi.org/images/d/d2/Dw_apb_uart_db.pdf
>>
>> There seems not to be TEMT interrupt, I use it under sunxi SoC and on
>> their datasheet(A20 for example), they don't report that interrupt
>> too.
>> So it seems to be valid for all DW configured types, anyway I don't
>> know
>> how many IP reviews there could be of that peripheral.
> 
> This is an excerpt from the document you referred to:
> 
> --- 8< --- 8< ---
> 
> 6 TEMT R Transmitter Empty bit. If in FIFO mode (FIFO_MODE != NONE) and
> FIFOs enabled (FCR[0] set to one), this bit is set whenever the
> Transmitter Shift Register and the FIFO are both empty. If in non-FIFO
> mode or FIFOs are disabled, this bit is set whenever the Transmitter
> Holding Register and the Transmitter Shift Register are both empty.
> 
> Reset Value: 0x1
> 
> --- 8< --- 8< ---
> 
> 
> If I'm reading this correctly the support is there. Or otherwise, care
> to point exact paragraph needs to be read and checked?

In the beginning I thought the same as you but
unfortunately LSR is only a status register and IER doesn't have 
corresponding TEMT bit to enable an interrupt on TEMT triggering.
On OMAP instead there is a specific interrupt bound to TEMT LSR flag.
And THRE interrupt is not enough because shift register won't be empty 
when it triggers, so you would loose some bit of last byte to be 
transmitted.

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
