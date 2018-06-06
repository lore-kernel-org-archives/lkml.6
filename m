Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5yz+Rv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 68294606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754146AbeFFSGe (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 14:06:34 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35274 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752401AbeFFSGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 14:06:32 -0400
X-Google-Smtp-Source: ADUXVKI7lYObkZaWEgWRcXDxTHGnkJ2D6KwL94P2jTIb7t8kFb4Ubaxho2GdLwC+LEy3wsDiDIZRMS8Gql/Y9tLhUZU=
MIME-Version: 1.0
In-Reply-To: <1528224240-30786-1-git-send-email-mark.jonas@de.bosch.com>
References: <1528224240-30786-1-git-send-email-mark.jonas@de.bosch.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 6 Jun 2018 21:06:31 +0300
Message-ID: <CAHp75VdRPA_29hLKLvDe+VZZunGCtffUusamH0YQyQpWcNOY6g@mail.gmail.com>
Subject: Re: [PATCH 0/5] can: enable multi-queue for SocketCAN devices
To: Mark Jonas <mark.jonas@de.bosch.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiko Schocher <hs@denx.de>, Zhu Yi <yi.zhu5@cn.bosch.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 9:43 PM, Mark Jonas <mark.jonas@de.bosch.com> wrote:
> Upon request by Marc Kleine-Budde this patch series does not only
> contain our patch to enable enable multi-queue for SocketCAN devices
> but also a driver (Companion driver suite) which makes active use of
> this feature.
>
> The driver suite implements
>   - two CAN interfaces
>   - one generic command interfaces
> and offers a SocketCAN as well as a char device interface. The
> SocketCAN interface supports multi-queue.
>
> The functionality bases on an external peripheral chip named Companion.
> It offers two CAN interfaces, each has 8 prioritized transmit FIFOs as
> well as one receive FIFO. Besides CAN, undisclosed additional functions
> can be accessed through the char device.
>
> A standard SPI interface with two additional lines for flow control is
> used. The Companion chip is the SPI slave.

Can remoteproc API be utilized here?

>
> The driver suite consists of three separate drivers. The following
> diagram illustrates the dependencies in layers.
>
>            /dev/companion       SocketCAN                User Space
> -------------------------------------------------------------------
>          +----------------+ +---------------+
>          | companion-char | | companion-can |
>          +----------------+ +---------------+
>          +----------------------------------+
>          |          companion-spi           |
>          +----------------------------------+
>          +----------------------------------+
>          |     standard SPI subsystem       |
>          +----------------------------------+          Linux Kernel
> -------------------------------------------------------------------
>                | | | |      | |                            Hardware
>             CS-+ | | |      | +-BUSY
>             CLK--+ | |      +---REQUEST
>             MOSI---+ |
>             MISO-----+
>
> companion-spi
>    core.c: handles SPI, sysfs entry and interface to upper layer
>    protocol-manager.c: handles protocol with the SPI HW
>    queue-manager.c: handles buffering and packets scheduling
>
> companion-can
>    makes use of multi-queue support and allows to use tc to configure
>    the queuing discipline (e.g. mqprio). Together with the SO_PRIORITY
>    socket option this allows to specify the FIFO a CAN frame shall be
>    sent to.
>
> companion-char
>    handles messages to other undisclosed functionality beyond CAN.
>
> Zhu Yi (5):
>   can: enable multi-queue for SocketCAN devices
>   spi: implement companion-spi driver
>   char: implement companion-char driver
>   can: implement companion-can driver
>   spi,can,char: add companion DT binding documentation
>
>  .../devicetree/bindings/spi/bosch,companion.txt    |   82 ++
>  drivers/char/Kconfig                               |    7 +
>  drivers/char/Makefile                              |    2 +
>  drivers/char/companion-char.c                      |  367 ++++++
>  drivers/net/can/Kconfig                            |    8 +
>  drivers/net/can/Makefile                           |    1 +
>  drivers/net/can/companion-can.c                    |  694 ++++++++++++
>  drivers/net/can/dev.c                              |    8 +-
>  drivers/spi/Kconfig                                |    2 +
>  drivers/spi/Makefile                               |    2 +
>  drivers/spi/companion/Kconfig                      |    5 +
>  drivers/spi/companion/Makefile                     |    2 +
>  drivers/spi/companion/core.c                       | 1189 ++++++++++++++++++++
>  drivers/spi/companion/protocol-manager.c           | 1035 +++++++++++++++++
>  drivers/spi/companion/protocol-manager.h           |  348 ++++++
>  drivers/spi/companion/protocol.h                   |  273 +++++
>  drivers/spi/companion/queue-manager.c              |  146 +++
>  drivers/spi/companion/queue-manager.h              |  245 ++++
>  include/linux/can/dev.h                            |    7 +-
>  include/linux/companion.h                          |  258 +++++
>  20 files changed, 4677 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/bosch,companion.txt
>  create mode 100644 drivers/char/companion-char.c
>  create mode 100644 drivers/net/can/companion-can.c
>  create mode 100644 drivers/spi/companion/Kconfig
>  create mode 100644 drivers/spi/companion/Makefile
>  create mode 100644 drivers/spi/companion/core.c
>  create mode 100644 drivers/spi/companion/protocol-manager.c
>  create mode 100644 drivers/spi/companion/protocol-manager.h
>  create mode 100644 drivers/spi/companion/protocol.h
>  create mode 100644 drivers/spi/companion/queue-manager.c
>  create mode 100644 drivers/spi/companion/queue-manager.h
>  create mode 100644 include/linux/companion.h
>
> --
> 2.7.4
>



-- 
With Best Regards,
Andy Shevchenko
