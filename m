Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752067AbeFDKm4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:42:56 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:43466 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751187AbeFDKmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:42:54 -0400
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
Subject: Re: [PATCH 0/8] serial: 8250: Add 485 emulation to 8250_dw.
To: "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Kees Cook <keescook@chromium.org>,
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
 <65c26f5db1275e958cfe6390e9336568b0158dea.camel@linux.intel.com>
 <CAJs94EZEEBNZRU3ixkdG9w44xsQDi7MUYAya2dzkAErT=xwqVA@mail.gmail.com>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <c14c671c-3240-0170-7c0e-2b195c5b1398@micronovasrl.com>
Date: Mon, 4 Jun 2018 12:42:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAJs94EZEEBNZRU3ixkdG9w44xsQDi7MUYAya2dzkAErT=xwqVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

Il 04/06/2018 12:34, Matwey V. Kornilov ha scritto:
> 2018-06-04 13:12 GMT+03:00 Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
>> On Fri, 2018-06-01 at 14:40 +0200, Giulio Benetti wrote:
>>> Need to handle rs485 with 8250_dw port.
>>>
>>> Use existing em485 emulation layer for 8250 taking care to fix some
>>> bug
>>> and taking care especially of RTS_AFTER_SEND case.
>>>
>>
>> I don't see in Cc list author of rs485 code, who might be interested in
>> this.
>>
>> So, added him here.

Thanks Andy for adding in Cc an reviewing.
Dumb question: how did you find him?
I thought he was between people on get_maintainer.pl output.

>>
> 
> Hi, Andy
> 
> Nice to see you there. I will look through the code later.
> I always thought that DW has its own hardware rs485 support.

Hi Matwey,
I've checked on Synopsis Designware 8250 datasheet and it's not supported.
Here is datasheet I went through:
https://linux-sunxi.org/images/d/d2/Dw_apb_uart_db.pdf

On IER register there is not TEMT bit or something like that used in 
8250_omap.

Am I right?

Thanks everybody and
best regards

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

> 
>>> Giulio Benetti (8):
>>>    serial: 8250_dw: add em485 support
>>>    serial: 8250_dw: allow enable rs485 at boot time
>>>    serial: 8250: Copy em485 from port to real port.
>>>    serial: 8250: Handle case port doesn't have TEMT interrupt using
>>>      em485.
>>>    serial: 8250_dw: treat rpm suspend with -EBUSY if RS485 ON and
>>>      RTS_AFTER_SEND
>>>    serial: 8250: Copy mctrl when register port.
>>>    serial: 8250: Make em485_rts_after_send() set mctrl according to rts
>>>      state.
>>>    serial: core: Mask mctrl with TIOCM_RTS too if rs485 on and
>>>      RTS_AFTER_SEND set.
>>>
>>>   drivers/tty/serial/8250/8250.h      |  2 +-
>>>   drivers/tty/serial/8250/8250_core.c |  2 ++
>>>   drivers/tty/serial/8250/8250_dw.c   | 41
>>> ++++++++++++++++++++++++++++-
>>>   drivers/tty/serial/8250/8250_omap.c |  2 +-
>>>   drivers/tty/serial/8250/8250_port.c | 33 ++++++++++++++++-------
>>>   drivers/tty/serial/serial_core.c    | 12 ++++++++-
>>>   include/linux/serial_8250.h         |  1 +
>>>   7 files changed, 79 insertions(+), 14 deletions(-)
>>>
>>
>> --
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Intel Finland Oy
>>
> 
> 
> 
