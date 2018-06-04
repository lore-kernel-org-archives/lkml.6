Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752995AbeFDM0V (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 08:26:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:27589 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751473AbeFDM0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 08:26:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,476,1520924400";
   d="scan'208";a="234461990"
Message-ID: <3f16e887bfdb543b02020f37d6b2cbb7921270f3.camel@linux.intel.com>
Subject: Re: [PATCH 4/8] serial: 8250: Handle case port doesn't have TEMT
 interrupt using em485.
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Matwey V.Kornilov" <matwey@sai.msu.ru>
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
Date: Mon, 04 Jun 2018 15:26:11 +0300
In-Reply-To: <2c61887c-53e0-1ece-9f4a-89250134f083@micronovasrl.com>
References: <20180601124021.102970-1-giulio.benetti@micronovasrl.com>
         <20180601124021.102970-5-giulio.benetti@micronovasrl.com>
         <3a66327727d9bf2ce5adf8ef0f1fcc1fffeaa4ec.camel@linux.intel.com>
         <4a7148d5-ab2c-425d-afdc-08ddd3c522c2@micronovasrl.com>
         <2a2f547d787db9d593bb7fe3ad9c833836e23749.camel@linux.intel.com>
         <2c61887c-53e0-1ece-9f4a-89250134f083@micronovasrl.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-04 at 13:50 +0200, Giulio Benetti wrote:
> Hi,
> 
> Il 04/06/2018 13:38, Andy Shevchenko ha scritto:
> > On Mon, 2018-06-04 at 12:50 +0200, Giulio Benetti wrote:
> > > Hi,
> > > 
> > > Il 04/06/2018 12:17, Andy Shevchenko ha scritto:
> > > > On Fri, 2018-06-01 at 14:40 +0200, Giulio Benetti wrote:
> > > > > Some 8250 ports only have TEMT interrupt, so current
> > > > > implementation
> > > > > can't work for ports without it. The only chance to make it
> > > > > work
> > > > > is to
> > > > > loop-read on LSR register.
> > > > > 
> > > > > With NO TEMT interrupt check if both TEMT and THRE are set
> > > > > looping
> > > > > on
> > > > > LSR register.
> > > > > --- a/drivers/tty/serial/8250/8250_dw.c
> > > > > +++ b/drivers/tty/serial/8250/8250_dw.c
> > > > > -		int ret = serial8250_em485_init(up);
> > > > > +		int ret = serial8250_em485_init(up, false);
> > > > 
> > > > Is true for all possible DW configured types? Or it's your
> > > > particular
> > > > case?
> > > > 
> > > 
> > > I've checked on Synopsis Designware 8250 datasheet and it's not
> > > supported.
> > > Here is datasheet I went through:
> > > https://linux-sunxi.org/images/d/d2/Dw_apb_uart_db.pdf
> > > 
> > > There seems not to be TEMT interrupt, I use it under sunxi SoC and
> > > on
> > > their datasheet(A20 for example), they don't report that interrupt
> > > too.
> > > So it seems to be valid for all DW configured types, anyway I
> > > don't
> > > know
> > > how many IP reviews there could be of that peripheral.
> > 
> > This is an excerpt from the document you referred to:
> > 
> > --- 8< --- 8< ---
> > 
> > 6 TEMT R Transmitter Empty bit. If in FIFO mode (FIFO_MODE != NONE)
> > and
> > FIFOs enabled (FCR[0] set to one), this bit is set whenever the
> > Transmitter Shift Register and the FIFO are both empty. If in non-
> > FIFO
> > mode or FIFOs are disabled, this bit is set whenever the Transmitter
> > Holding Register and the Transmitter Shift Register are both empty.
> > 
> > Reset Value: 0x1
> > 
> > --- 8< --- 8< ---
> > 
> > 
> > If I'm reading this correctly the support is there. Or otherwise,
> > care
> > to point exact paragraph needs to be read and checked?
> 
> In the beginning I thought the same as you but
> unfortunately LSR is only a status register and IER doesn't have 
> corresponding TEMT bit to enable an interrupt on TEMT triggering.
> On OMAP instead there is a specific interrupt bound to TEMT LSR flag.
> And THRE interrupt is not enough because shift register won't be
> empty 
> when it triggers, so you would loose some bit of last byte to be 
> transmitted.

Hmm... Okay, it's something you and Matwey better to discuss.

P.S. Latest version of document I have does describe RS485 HW supported
mode. I don't know if it was added recently to the IP itself, or just
missed documentation. That's what you need to clarify with Synopsys.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
