Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A80C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB6D20C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="aIfpZoHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB6D20C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.bosch.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388328AbeGKRGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 13:06:07 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:43478 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbeGKRGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 13:06:06 -0400
Received: from fe0vm1650.rbesz01.com (unknown [139.15.230.188])
        by si0vms0217.rbdmz01.com (Postfix) with ESMTPS id 41Qlh2519vz4f3lMC;
        Wed, 11 Jul 2018 19:00:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=de.bosch.com;
        s=2015-01-21; t=1531328450;
        bh=p/fe7J9RJkx3znelLsxycOoCJZd7sbfKIrFwZoHrbyE=; l=10;
        h=From:From:Reply-To:Sender;
        b=aIfpZoHdrAGnnZzDD/W6JHoOPApatSWcy1bNEP+8pm4bFNdnBR8RQguNokmUPeEBo
         PuWQvNPz13WPsrtxKhIo1LeTDK0HWmoelvr3Kwsud6kCAinGDoNVdQw2KmBpuJeoBu
         aQYGnyA/2/WAsDaKrd5iKteFd0KQ461IUPXzkFow=
Received: from fe0vm1741.rbesz01.com (unknown [10.58.172.176])
        by fe0vm1650.rbesz01.com (Postfix) with ESMTPS id 41Qlh24bw6z1Ct;
        Wed, 11 Jul 2018 19:00:50 +0200 (CEST)
X-AuditID: 0a3aad15-18dff70000001291-2d-5b4637c2bdfc
Received: from fe0vm1652.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by fe0vm1741.rbesz01.com (SMG Outbound) with SMTP id 7A.A6.04753.2C7364B5; Wed, 11 Jul 2018 19:00:50 +0200 (CEST)
Received: from FE-MBX2018.de.bosch.com (fe-mbx2018.de.bosch.com [10.3.231.24])
        by fe0vm1652.rbesz01.com (Postfix) with ESMTPS id 41Qlh22gNczCvtX;
        Wed, 11 Jul 2018 19:00:50 +0200 (CEST)
Received: from FE-MBX2051.de.bosch.com (10.3.231.61) by
 FE-MBX2018.de.bosch.com (10.3.231.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1466.3; Wed, 11 Jul 2018 19:00:50 +0200
Received: from FE-MBX2051.de.bosch.com ([fe80::d5b5:44fa:ef15:153e]) by
 FE-MBX2051.de.bosch.com ([fe80::d5b5:44fa:ef15:153e%6]) with mapi id
 15.01.1466.008; Wed, 11 Jul 2018 19:00:50 +0200
From:   "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
To:     "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hs@denx.de" <hs@denx.de>,
        "ZHU Yi (BT-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>,
        "Petrovic Petar (CM-CI1/ENP1)" <Petar.Petrovic2@de.bosch.com>,
        "Baetge Stephan (CM-CI1/ENP1)" <Stephan.Baetge@de.bosch.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "socketcan@hartkopp.net" <socketcan@hartkopp.net>,
        "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
        "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Subject: Re: [PATCH v2 0/5] can: enable multi-queue for SocketCAN devices
Thread-Topic: [PATCH v2 0/5] can: enable multi-queue for SocketCAN devices
Thread-Index: AdQZODbRKdhxSbGzT2Gz6J7+5mb3jA==
Date:   Wed, 11 Jul 2018 17:00:49 +0000
Message-ID: <f858e62c59754a0c9f785b3dfc7aa50f@de.bosch.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.19.142.147]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA22Tf0wbZRjHeblrey0cXg8KD2UsrhFmRsDC2NbAYqbMpeg/Go1JrcksckAn
        bUkPCjQx1pXNbbAMujWDDmuZG4kYB+vQdIyspixjAzMUcKkooPwwgbEoChkKY145WPuH/z3v
        9/t+vs/zPpcjMNpHyAm9sZIxG3XlCqEEl+R9lZoZ2HdIq/yyk1DNNfYhle+XSUzV8ciJqUZ6
        WoWqzovncNVtT6JqZgKpgvPrItXlieuCA2K123UHV193jYvUi8M/I7X9yS2R+sxjpfpv7/bX
        he9I9hcz5XoLY37hxfckZX8ut2EVFzJrur87jmwo+OwpJCaAyoXpB5PCU0hC0FRzNMz+6sT5
        Qy8C30SXgD88ROBq8Yr4w7cI7DOnUYgXUnnwSfvghpFA1SMYWDsnDBkY9RsOj0+/G6rjqUK4
        bXdv6AnUq7B0fkjE11nQW9coCNU4lQbjU/c3dJLKh+n2ixsNEJUKXV1DGJ+ZBN7fHwn4wSm4
        1MvrQMlgbnqd0wmu3gGtzS/z17Mg6NwaJwPa2x5gfLwU7rbM4I1I5opIdUUgrgjEFYF4EN6B
        ZCWM0mLI3pebnWUuYlirMjvrfZPBi/gvKfOhzmtMAFEEUsSSfbmHtLRAZ2FrDQG0h4hWyEh5
        3itaOq7IVFxbpmPLDpuryhlWISdRVFQUHf9UZquKDHqW1ZuMAQQEpkgg954/qKXJYl2tlTGb
        eCyAUghckUS2vZ2hpalSXSXzAcNUMOYtN58gFEAe2cvNIDUzpUxNib68cstWpPI9EyOdyLbR
        hDiAdhOxXO8DoQiSrdAZWH3pJp7M4/SWGkYHUCExZm9wYMTaH04HRuNGk5GRJ5HFoRQqdL+s
        yvh0Dvk2srqAe5oswghnzaNRxG0ynjwWgmO53yY8AZC++FYNLd0Uw1COh2OoJik0uRWwOJkL
        T268BjePa8B91Ay+GQcC/08jCNy+ZQRNdVMYdK4/xGBspQ6HFdtZHK4Mj+Pgv3pUwGldAhju
        cYmg3t9HQF3/Z2K44+gXw7KtWwJXL9+MgYXPT5BwIvA1Cf4Ljjj4t8X5DDTMXaFg5UePFBpO
        HqNh5NK1BBia/SsRvM6xZFi60ZEyz202mttsRltBaLOVusr/2eymGn6Y3IbeKrk32vgFVXBQ
        w2QMrrpeKhIuxHUH0gPNq7uC1axSryl4/lN/v6vwY9uew6PG9ByU6fgohkpZNn6fdsa2835w
        m6V+0HpEU/3GD9aBk44Pd+f3FL/ZPZu2tH117Tn1jlup34yfHesga2ankvevTy8sDqbL7XeT
        LR7cyuTc22mL+UeBs2W67F2YmdX9B2Gh41zLBAAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

> Betreff: [PATCH v2 0/5] can: enable multi-queue for SocketCAN devices

You have been interested in seeing the reason why we are proposing the
"can: enable multi-queue for SocketCAN devices" patch for the Linux
mainline. So far I have not heard from you. Do you now see a chance of
getting the patch accepted?

>=20
> Changes in v2:
> - use GPIO descriptor API
> - make error handling pattern consistent
> - use more kernel helper macros and functions
> - fix coding style issues
> - remove superfluous subsystem name from filename
>=20
> ---
>=20
> Upon request by Marc Kleine-Budde this patch series does not only
> contain our patch to enable enable multi-queue for SocketCAN devices
> but also a driver (Companion driver suite) which makes active use of
> this feature.
>=20
> The driver suite implements
>   - two CAN interfaces
>   - one generic command interfaces
> and offers a SocketCAN as well as a char device interface. The
> SocketCAN interface supports multi-queue.
>=20
> The functionality bases on an external peripheral chip named Companion.
> It offers two CAN interfaces, each has 8 prioritized transmit FIFOs as
> well as one receive FIFO. Besides CAN, undisclosed additional functions
> can be accessed through the char device.
>=20
> A standard SPI interface with two additional lines for flow control is
> used. The Companion chip is the SPI slave.
>=20
> The driver suite consists of three separate drivers. The following
> diagram illustrates the dependencies in layers.
>=20
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
>=20
> companion-spi
>    core.c: handles SPI, sysfs entry and interface to upper layer
>    protocol-manager.c: handles protocol with the SPI HW
>    queue-manager.c: handles buffering and packets scheduling
>=20
> companion-can
>    makes use of multi-queue support and allows to use tc to configure
>    the queuing discipline (e.g. mqprio). Together with the SO_PRIORITY
>    socket option this allows to specify the FIFO a CAN frame shall be
>    sent to.
>=20
> companion-char
>    handles messages to other undisclosed functionality beyond CAN.
>=20
> Zhu Yi (5):
>   can: enable multi-queue for SocketCAN devices
>   spi: implement companion-spi driver
>   char: implement companion-char driver
>   can: implement companion-can driver
>   spi,can,char: add companion DT binding documentation
>=20
>  .../devicetree/bindings/spi/bosch,companion.txt    |   82 ++
>  drivers/char/Kconfig                               |    7 +
>  drivers/char/Makefile                              |    3 +
>  drivers/char/companion.c                           |  360 ++++++
>  drivers/net/can/Kconfig                            |    8 +
>  drivers/net/can/Makefile                           |    2 +
>  drivers/net/can/companion.c                        |  693 ++++++++++++
>  drivers/net/can/dev.c                              |    8 +-
>  drivers/spi/Kconfig                                |    2 +
>  drivers/spi/Makefile                               |    2 +
>  drivers/spi/companion/Kconfig                      |    5 +
>  drivers/spi/companion/Makefile                     |    2 +
>  drivers/spi/companion/core.c                       | 1185 ++++++++++++++=
++++++
>  drivers/spi/companion/protocol-manager.c           | 1032 ++++++++++++++=
+++
>  drivers/spi/companion/protocol-manager.h           |  341 ++++++
>  drivers/spi/companion/protocol.h                   |  273 +++++
>  drivers/spi/companion/queue-manager.c              |  144 +++
>  drivers/spi/companion/queue-manager.h              |  245 ++++
>  include/linux/can/dev.h                            |    7 +-
>  include/linux/companion.h                          |  259 +++++
>  20 files changed, 4656 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/bosch,companion=
.txt
>  create mode 100644 drivers/char/companion.c
>  create mode 100644 drivers/net/can/companion.c
>  create mode 100644 drivers/spi/companion/Kconfig
>  create mode 100644 drivers/spi/companion/Makefile
>  create mode 100644 drivers/spi/companion/core.c
>  create mode 100644 drivers/spi/companion/protocol-manager.c
>  create mode 100644 drivers/spi/companion/protocol-manager.h
>  create mode 100644 drivers/spi/companion/protocol.h
>  create mode 100644 drivers/spi/companion/queue-manager.c
>  create mode 100644 drivers/spi/companion/queue-manager.h
>  create mode 100644 include/linux/companion.h
>=20
> --
> 2.7.4

Greetings,
Mark

Building Technologies, Panel Software Fire (BT-FIR/ENG1)=20
Bosch Sicherheitssysteme GmbH | Postfach 11 11 | 85626 Grasbrunn | GERMANY =
| www.boschsecurity.com

Sitz: Stuttgart, Registergericht: Amtsgericht Stuttgart HRB 23118=20
Aufsichtsratsvorsitzender: Stefan Hartung; Gesch=E4ftsf=FChrung: Gert van I=
peren, Andreas Bartz, Thomas Quante, Bernhard Schuster
