Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F31C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53EE620671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53EE620671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbeGSKJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 06:09:44 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:21968 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbeGSKJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 06:09:44 -0400
X-IronPort-AV: E=Sophos;i="5.51,374,1526367600"; 
   d="scan'208";a="13757175"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 19 Jul 2018 02:27:28 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch06.mchp-main.com
 (10.10.76.107) with Microsoft SMTP Server id 14.3.352.0; Thu, 19 Jul 2018
 02:27:27 -0700
Date:   Thu, 19 Jul 2018 11:26:17 +0200
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
CC:     <linux-serial@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <alexandre.belloni@bootlin.com>, <arnd@arndb.de>,
        <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <jslaby@suse.com>
Subject: Re: [PATCH v2 0/2] add ISO7816 support
Message-ID: <20180719092617.ubfh45wffjqqkt4e@M43218.corp.atmel.com>
Mail-Followup-To: Neil Armstrong <narmstrong@baylibre.com>,
        linux-serial@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, alexandre.belloni@bootlin.com,
        arnd@arndb.de, richard.genoud@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, jslaby@suse.com
References: <20180719084737.1490-1-ludovic.desroches@microchip.com>
 <034fe4ed-979b-51ee-db7c-5dc7137b98e5@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <034fe4ed-979b-51ee-db7c-5dc7137b98e5@baylibre.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Thu, Jul 19, 2018 at 10:59:47AM +0200, Neil Armstrong wrote:
> Hi Ludovic,
> 
> On 19/07/2018 10:47, Ludovic Desroches wrote:
> > Hi,
> > 
> > This patchset adds support for the ISO7816 standard. The USART devices in
> > Microchip SoCs have an ISO7816 mode. It allows to let the USART managing
> > the CLK and I/O signals of a smart card.
> 
> Wow, I would have loved to have this at the time...
> I'm curious, do you have an example of userspace code using this ?
> The ATR rx needs a very weird handling, I'm curious how you managed it.
> 

Unfortunately, I have nothing I can give you at the moment. I am doing
some experiments. Before going further, I need to have the interface
with the kernel accepted.

Of course, I can give more details about the experiments I am doing.
First of all, I am not used to ISO7816 so every feedback are
appreciated.

On the userspace part, there is the PCSC Lite library. It needs a
userspace driver. From what I've seen, most of the readers are managed
by the CCID driver. This driver handle different hardware capabilities.
Some hardware are very close to what we provide with our SoC ie. just
sending the data on the line and not manage the procedure bytes.

The CCID driver includes a lot of things related to the ISO7816 protocol
so I tried to plug my code into it to reuse this code. The issue is that I am
not a CCID device. At the moment, I am writing my own PCSC driver and I am
copying/pasting code I need. The USART only manages the CLK and I/O
signals. Others one are handled by the PCSC driver with the help of
GPIOs.

At a time, I was thinking about a CCID driver (which interprets the CCID
header and interacts with the device handling ISO7816) in the kernel to easily
interface with the PCSC CCID driver but I am not sure it's the right way
to go.

Regards

Ludovic


> Thanks,
> Neil
> 
> > 
> > Changes:
> > - v2
> >   - uart_get_iso7816_config: check there is an iso7816_config function
> >   - use IOCTL macros to generate the IOCTL number
> >   - check that reserved field is not used
> >   - remove debug logs
> >   - check that the iso7816_config is right before doing any action
> >   - change the error from nack and max iteration status to a debug message
> >   - remove patch 3 as it concerns both rs485 and iso7816 to think more
> >   about the need of adding a lock or not
> > 
> > Nicolas Ferre (2):
> >   tty/serial_core: add ISO7816 infrastructure
> >   tty/serial: atmel: add ISO7816 support
> > 
> >  arch/alpha/include/uapi/asm/ioctls.h   |   2 +
> >  arch/mips/include/uapi/asm/ioctls.h    |   2 +
> >  arch/powerpc/include/uapi/asm/ioctls.h |   2 +
> >  arch/sh/include/uapi/asm/ioctls.h      |   2 +
> >  arch/sparc/include/uapi/asm/ioctls.h   |   2 +
> >  arch/xtensa/include/uapi/asm/ioctls.h  |   2 +
> >  drivers/tty/serial/atmel_serial.c      | 170 +++++++++++++++++++++++++++++++--
> >  drivers/tty/serial/atmel_serial.h      |   3 +-
> >  drivers/tty/serial/serial_core.c       |  60 ++++++++++++
> >  include/linux/serial_core.h            |   3 +
> >  include/uapi/asm-generic/ioctls.h      |   2 +
> >  include/uapi/linux/serial.h            |  17 ++++
> >  12 files changed, 256 insertions(+), 11 deletions(-)
> > 
> 
