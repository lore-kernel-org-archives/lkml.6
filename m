Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751842AbeFEKwT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 06:52:19 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:43582 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751534AbeFEKwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 06:52:17 -0400
X-Google-Smtp-Source: ADUXVKLw2ntnoilVIhEVZ+8CgwuAUfJOXQqj6fpzd0527R4ikk4xyEYhnoTtt3SyIt34Qs7dIdfNxOlPChgK/AHieEk=
MIME-Version: 1.0
In-Reply-To: <d130718a-444d-3a39-4da8-0f0b907f850d@micronovasrl.com>
References: <20180601124021.102970-1-giulio.benetti@micronovasrl.com>
 <20180601124021.102970-5-giulio.benetti@micronovasrl.com> <b14d4970-f14d-d59f-2072-b7d5704dd842@gmail.com>
 <d130718a-444d-3a39-4da8-0f0b907f850d@micronovasrl.com>
From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date: Tue, 5 Jun 2018 13:51:56 +0300
Message-ID: <CAJs94EZqdQAQG+inWvj89FCQtv06LxhY_J4YgNmK8mtvgDTchQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] serial: 8250: Handle case port doesn't have TEMT
 interrupt using em485.
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w55AqODx004072

2018-06-04 21:50 GMT+03:00 Giulio Benetti <giulio.benetti@micronovasrl.com>:
> Il 04/06/2018 19:40, Matwey V. Kornilov ha scritto:
>>
>> 01.06.2018 15:40, Giulio Benetti пишет:
>>>
>>> Some 8250 ports only have TEMT interrupt, so current implementation
>>> can't work for ports without it. The only chance to make it work is to
>>> loop-read on LSR register.
>>>
>>> With NO TEMT interrupt check if both TEMT and THRE are set looping on
>>> LSR register.
>>>
>>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
>>> ---
>>>   drivers/tty/serial/8250/8250.h      |  2 +-
>>>   drivers/tty/serial/8250/8250_dw.c   |  2 +-
>>>   drivers/tty/serial/8250/8250_omap.c |  2 +-
>>>   drivers/tty/serial/8250/8250_port.c | 26 ++++++++++++++++++--------
>>>   include/linux/serial_8250.h         |  1 +
>>>   5 files changed, 22 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/8250/8250.h
>>> b/drivers/tty/serial/8250/8250.h
>>> index ebfb0bd5bef5..5c6ae5f69432 100644
>>> --- a/drivers/tty/serial/8250/8250.h
>>> +++ b/drivers/tty/serial/8250/8250.h
>>> @@ -136,7 +136,7 @@ void serial8250_rpm_put(struct uart_8250_port *p);
>>>   void serial8250_rpm_get_tx(struct uart_8250_port *p);
>>>   void serial8250_rpm_put_tx(struct uart_8250_port *p);
>>>   -int serial8250_em485_init(struct uart_8250_port *p);
>>> +int serial8250_em485_init(struct uart_8250_port *p, bool has_temt_isr);
>>>   void serial8250_em485_destroy(struct uart_8250_port *p);
>>>     static inline void serial8250_out_MCR(struct uart_8250_port *up, int
>>> value)
>>> diff --git a/drivers/tty/serial/8250/8250_dw.c
>>> b/drivers/tty/serial/8250/8250_dw.c
>>> index 0f8b4da03d4e..888280ff5451 100644
>>> --- a/drivers/tty/serial/8250/8250_dw.c
>>> +++ b/drivers/tty/serial/8250/8250_dw.c
>>> @@ -330,7 +330,7 @@ static int dw8250_rs485_config(struct uart_port *p,
>>>          * are idempotent
>>>          */
>>>         if (rs485->flags & SER_RS485_ENABLED) {
>>> -               int ret = serial8250_em485_init(up);
>>> +               int ret = serial8250_em485_init(up, false);
>>>                 if (ret) {
>>>                         rs485->flags &= ~SER_RS485_ENABLED;
>>> diff --git a/drivers/tty/serial/8250/8250_omap.c
>>> b/drivers/tty/serial/8250/8250_omap.c
>>> index 624b501fd253..ab483c8b30c8 100644
>>> --- a/drivers/tty/serial/8250/8250_omap.c
>>> +++ b/drivers/tty/serial/8250/8250_omap.c
>>> @@ -725,7 +725,7 @@ static int omap_8250_rs485_config(struct uart_port
>>> *port,
>>>          * are idempotent
>>>          */
>>>         if (rs485->flags & SER_RS485_ENABLED) {
>>> -               int ret = serial8250_em485_init(up);
>>> +               int ret = serial8250_em485_init(up, true);
>>>                 if (ret) {
>>>                         rs485->flags &= ~SER_RS485_ENABLED;
>>> diff --git a/drivers/tty/serial/8250/8250_port.c
>>> b/drivers/tty/serial/8250/8250_port.c
>>> index 95833cbc4338..e14badbbf181 100644
>>> --- a/drivers/tty/serial/8250/8250_port.c
>>> +++ b/drivers/tty/serial/8250/8250_port.c
>>> @@ -599,15 +599,16 @@ EXPORT_SYMBOL_GPL(serial8250_rpm_put);
>>>   /**
>>>    *    serial8250_em485_init() - put uart_8250_port into rs485 emulating
>>>    *    @p:     uart_8250_port port instance
>>> + *     @p:     bool specify if 8250 port has TEMT interrupt or not
>>>    *
>>>    *    The function is used to start rs485 software emulating on the
>>>    *    &struct uart_8250_port* @p. Namely, RTS is switched before/after
>>>    *    transmission. The function is idempotent, so it is safe to call
>>> it
>>>    *    multiple times.
>>>    *
>>> - *     The caller MUST enable interrupt on empty shift register before
>>> - *     calling serial8250_em485_init(). This interrupt is not a part of
>>> - *     8250 standard, but implementation defined.
>>> + *     If has_temt_isr is passed as true, the caller MUST enable
>>> interrupt
>>> + *     on empty shift register before calling serial8250_em485_init().
>>> + *     This interrupt is not a part of 8250 standard, but implementation
>>> defined.
>>>    *
>>>    *    The function is supposed to be called from .rs485_config callback
>>>    *    or from any other callback protected with p->port.lock spinlock.
>>> @@ -616,7 +617,7 @@ EXPORT_SYMBOL_GPL(serial8250_rpm_put);
>>>    *
>>>    *    Return 0 - success, -errno - otherwise
>>>    */
>>> -int serial8250_em485_init(struct uart_8250_port *p)
>>> +int serial8250_em485_init(struct uart_8250_port *p, bool has_temt_isr)
>>>   {
>>>         if (p->em485)
>>>                 return 0;
>>> @@ -633,6 +634,7 @@ int serial8250_em485_init(struct uart_8250_port *p)
>>>         p->em485->start_tx_timer.function =
>>> &serial8250_em485_handle_start_tx;
>>>         p->em485->port = p;
>>>         p->em485->active_timer = NULL;
>>> +       p->em485->has_temt_isr = has_temt_isr;
>>>         serial8250_em485_rts_after_send(p);
>>>         return 0;
>>> @@ -1517,11 +1519,19 @@ static inline void __stop_tx(struct
>>> uart_8250_port *p)
>>>                 /*
>>>                  * To provide required timeing and allow FIFO transfer,
>>>                  * __stop_tx_rs485() must be called only when both FIFO
>>> and
>>> -                * shift register are empty. It is for device driver to
>>> enable
>>> -                * interrupt on TEMT.
>>> +                * shift register are empty. If 8250 port supports it,
>>> +                * it is for device driver to enable interrupt on TEMT.
>>> +                * Otherwise must loop-read until TEMT and THRE flags are
>>> set.
>>>                  */
>>> -               if ((lsr & BOTH_EMPTY) != BOTH_EMPTY)
>>> -                       return;
>>> +               if (em485->has_temt_isr) {
>>> +                       if ((lsr & BOTH_EMPTY) != BOTH_EMPTY)
>>> +                               return;
>>> +               } else {
>>> +                       while ((lsr & BOTH_EMPTY) != BOTH_EMPTY) {
>>> +                               lsr = serial_in(p, UART_LSR);
>>> +                               cpu_relax();
>>> +                       }
>>
>>
>> What happens if TEMP never be empty after interruption occurring?
>>
>
> I've added the field has_temt_isr to identify if peripheral provides or not
> TEMT interrupt. In DW case, differentely from OMAP case, there is not TEMT
> interrupt, at least on Datasheet I've found.
> At this time I don't have access to latest Datasheet.
>
> Specifying has_temt_isr = false during serial8250_em485_init(),
> I assume TEMT interrupt is not available and also is not enabled.
>
> IMHO the only possible case to loop inside there is if shift register is
> costantly filled, but soon or late it will get empty(hope I didn't miss
> something).

Well, I would not rely on this behavior. Eventually, powersave or
something else disable transmit with characters left in buffer, or
happens something like that.

Could I ask to split the series into fixes and new features? I see
that the fixes can be applied, probably it would be better to apply
them separately from discussing new features.

>
> --
> Giulio Benetti
> CTO
>
> MICRONOVA SRL
> Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
> Tel. 049/8931563 - Fax 049/8931346
> Cod.Fiscale - P.IVA 02663420285
> Capitale Sociale € 26.000 i.v.
> Iscritta al Reg. Imprese di Padova N. 02663420285
> Numero R.E.A. 258642



-- 
With best regards,
Matwey V. Kornilov
