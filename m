Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6E6C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEFBF207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fcmIQbeQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEFBF207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbeJ0AAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 20:00:19 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:40302 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeJ0AAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 20:00:18 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 6D7D324E12A8;
        Fri, 26 Oct 2018 08:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1540567370; bh=BRg85UQSQ6pLgeMxrZecHW82oYJhrNybCxAslUbWQUM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=fcmIQbeQAx6KkUN7loPFBc7qJCbpV91zyO0woF03ABJDF5d6becVWBbU2SggImDvY
         XuMGasCXVNXNLsex/yWv5qYI9d+gEefRRjTGlbZ5dB4vY8hBmspqAS9BQmijjUQvEu
         YTC9Dy43HBow9+4IwkxfbQp8iBcbfVxatIPriEw3dnbdXwx1W2XHqGxiwtK3gL6Raf
         JwDSE/Lqs/wodlavUWhvYa5cRV8mUh8rYren1lPW92zoMBsOePYujwGwJAx0k4UYbZ
         lHJHbxdhIH2oGlAtUKTRVNNSLClT51F3NVKQSGidVyo9J3ERNdHdYbK+iSghxHuFOG
         rXOnetn96+x/g==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id A2BF23FB3;
        Fri, 26 Oct 2018 08:22:46 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 26 Oct 2018 08:22:46 -0700
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 26 Oct 2018 17:22:44 +0200
Received: from [10.0.2.15] (10.107.19.127) by DE02WEHTCB.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 26 Oct
 2018 17:22:43 +0200
Subject: Re: [PATCH v10 0/9] Add the I3C subsystem
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        "Kumar Gala" <galak@codeaurora.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        <linux-gpio@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>,
        Mike Shettel <mshettel@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
References: <20181026144333.12276-1-boris.brezillon@bootlin.com>
From:   vitor <vitor.soares@synopsys.com>
Message-ID: <ad79f586-860e-bf57-9970-f58dc16d33b8@synopsys.com>
Date:   Fri, 26 Oct 2018 16:22:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181026144333.12276-1-boris.brezillon@bootlin.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.107.19.127]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 26/10/18 15:43, Boris Brezillon wrote:
> Hi Greg,
>
> I think we've reached a point where we can eventually consider the I3C
> framework for inclusion in 4.20 (5.0?). A few more issues were reported
> on v9 and fixed in v10. I can't guarantee that the implementation is
> free of bugs but I still think it's worth merging it in v4.20: it's a
> new subsystem, so we don't risk regressions, and the only way we can
> detect other issues is by having other people experiment with this
> implementation.
>
> The only remaining concern raised by Arnd is the fact that both hosts
> and slaves share the same bus type and are differentiated thanks to
> their device_type, which IMHO is fine since this is what other
> subsystems do (plus I don't see other solutions to have both I3C
> devices and I3C buses represented under /sys/bus/i3c/).
>
> I'd really like to get this series merged in 4.20 so that other
> contributors can work on top of it to add
>
> 1/ new host drivers
> 2/ support for advanced features
> 3/ new device drivers
>
> So, unless you have strong reasons to reject this request, and,
> assuming I get Rob's ack soon enough, I plan to send a PR for this
> framework next week.
>
> Here is the usual description copy&pasted from the previous versions:
>
> This patch series is adding a new subsystem to support I3C devices.
>
> This is just adding support for basic features. Extra features will
> be added afterwards.
>
> There are a few design choices that are worth mentioning because they
> impact the way I3C device drivers can interact with their devices:
>
> - all functions used to send I3C/I2C frames must be called in
>    non-atomic context. Mainly done this way to ease implementation, but
>    this is still open to discussion. Please let me know if you think it's
>    worth considering an asynchronous model here
> - the I3C bus and I3C master controller are now tightly coupled even
>    though they're still allocated separately. There's now a 1:1
>    relationship between these objects, and the I3C master is no longer
>    represented under the I3C bus object.
>    Arnd, let me know if you had something different in mind, and I'll
>    rework the implementation accordingly.
>
> - I2C backward compatibility has been designed to be transparent to I2C
>    drivers and the I2C subsystem. The I3C master just registers an I2C
>    adapter which creates a new I2C bus. I'd say that, from a
>    representation PoV it's not ideal because what should appear as a
>    single I3C bus exposing I3C and I2C devices here appears as 2
>    different busses connected to each other through the parenting (the
>    I3C master is the parent of the I2C and I3C busses).
>    On the other hand, I don't see a better solution if we want something
>    that is not invasive.
>
> Missing features (will be added in separate patch series after initial
> support has been accepted/merged):
> - support for HDR modes (has been removed because of lack of real users)
> - no support for multi-master and the associated concepts (mastership
>    handover, support for secondary masters, ...)
> - I2C devices can only be described using DT because this is the only
>    use case I have. However, the framework can easily be extended with
>    ACPI and board info support
> - I3C slave framework. This has been completely omitted, but shouldn't
>    have a huge impact on the I3C framework because I3C slaves don't see
>    the whole bus, it's only about handling master requests and generating
>    IBIs. Some of the struct, constant and enum definitions could be
>    shared, but most of the I3C slave framework logic will be different
>
> Note that this patchset is available on the linux-i3c repo[1].
>
> Main change between v8 and v9:
> - The DT bindings have been simplified to get rid of the I3C/I3C_DEV()
>    macros
>
> Main change between v7 and v8:
> - The bus object is now embedded in the master_controller object (as
>    suggested by Arnd)
>
> Main changes between v6 and v7:
> - I3C bus/master representations have been reworked to match what other
>    subsystems are doing (master implicitly represented by the bus
>    object)
> - I3C dev registration has been fixed
> - I3C bus mode selection has been fixed
> - Calls to readsl/writesl() in the Cadence I3C master driver have been
>    fixed
>
> Main changes between v5 and v6:
> - Introduce {i3c,i2c}_dev_desc structures to better match how I3C
>    master controllers (reservation of one HW slot for each device
>    attached to the bus). With this solution, the resource migration
>    that happens when a device lose its dynamic address and is
>    re-assigned a different address is simplified on the driver side,
>    because most of it is now handled in the core (reserve a new dev
>    slot, reserve IBI resources and free all resources attached to the
>    old slot)
> - Add I3C error codes (M0 to M2) so that the core and device drivers
>    can have fine grained information on what caused an EIO error.
>
> Only minor things happened between v3 and v5 (you can go check the
> changelog in each patch for more details).
>
> Main changes between v2 and v3 are:
> - Reworked the DT bindings as suggested by Rob
> - Reworked the bus initialization step as suggested by Vitor
> - Added a driver for an I3C GPIO expander
>
> Main changes between the initial RFC and this v2 are:
> - Add a generic infrastructure to support IBIs. It's worth mentioning
>    that I tried exposing IBIs as a regular IRQs, but after several
>    attempts and a discussion with Mark Zyngier, it appeared that it was
>    not really fitting in the Linux IRQ model (the fact that you have
>    payload attached to IBIs, the fact that most of the time an IBI will
>    generate a transfer on the bus which has to be done in an atomic
>    context, ...)
>    The counterpart of this decision is the latency induced by the
>    workqueue approach, but since I don't have real use cases, I don't
>    know if this can be a problem or not.
> - Add helpers to support Hot Join
> - Add support for IBIs and Hot Join in Cadence I3C master driver
> - Address several issues in how I was using the device model
>
> Thanks,
>
> Boris
>
> [1]https://urldefense.proofpoint.com/v2/url?u=https-3A__git.kernel.org_pub_scm_linux_kernel_git_i3c_linux.git_log_-3Fh-3Di3c_next&d=DwIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=qVuU64u9x77Y0Kd0PhDK_lpxFgg6PK9PateHwjb_DY0&m=TkhdwjEerP4IBiC_WzI_vEUyZD2Dcxl03UeycbwNI2Q&s=KK31_5lEEgNN2iyURFULH0HmjkOPWoarNiT1hehvIsY&e=
>
> *** BLURB HERE ***
>
> Boris Brezillon (9):
>    i3c: Add core I3C infrastructure
>    docs: driver-api: Add I3C documentation
>    i3c: Add sysfs ABI spec
>    dt-bindings: i3c: Document core bindings
>    MAINTAINERS: Add myself as the I3C subsystem maintainer
>    i3c: master: Add driver for Cadence IP
>    dt-bindings: i3c: Document Cadence I3C master bindings
>    gpio: Add a driver for Cadence I3C GPIO expander
>    dt-bindings: gpio: Add bindings for Cadence I3C gpio expander
>
>   Documentation/ABI/testing/sysfs-bus-i3c       |  146 +
>   .../bindings/gpio/gpio-cdns-i3c.txt           |   39 +
>   .../bindings/i3c/cdns,i3c-master.txt          |   44 +
>   Documentation/devicetree/bindings/i3c/i3c.txt |  139 +
>   .../driver-api/i3c/device-driver-api.rst      |    9 +
>   Documentation/driver-api/i3c/index.rst        |   11 +
>   .../driver-api/i3c/master-driver-api.rst      |   10 +
>   Documentation/driver-api/i3c/protocol.rst     |  203 ++
>   Documentation/driver-api/index.rst            |    1 +
>   MAINTAINERS                                   |   12 +
>   drivers/Kconfig                               |    2 +
>   drivers/Makefile                              |    2 +-
>   drivers/gpio/Kconfig                          |   11 +
>   drivers/gpio/Makefile                         |    1 +
>   drivers/gpio/gpio-cdns-i3c.c                  |  411 +++
>   drivers/i3c/Kconfig                           |   24 +
>   drivers/i3c/Makefile                          |    4 +
>   drivers/i3c/device.c                          |  233 ++
>   drivers/i3c/internals.h                       |   26 +
>   drivers/i3c/master.c                          | 2661 +++++++++++++++++
>   drivers/i3c/master/Kconfig                    |    6 +
>   drivers/i3c/master/Makefile                   |    1 +
>   drivers/i3c/master/i3c-master-cdns.c          | 1671 +++++++++++
>   include/linux/i3c/ccc.h                       |  385 +++
>   include/linux/i3c/device.h                    |  331 ++
>   include/linux/i3c/master.h                    |  648 ++++
>   include/linux/mod_devicetable.h               |   17 +
>   27 files changed, 7047 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-bus-i3c
>   create mode 100644 Documentation/devicetree/bindings/gpio/gpio-cdns-i3c.txt
>   create mode 100644 Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt
>   create mode 100644 Documentation/devicetree/bindings/i3c/i3c.txt
>   create mode 100644 Documentation/driver-api/i3c/device-driver-api.rst
>   create mode 100644 Documentation/driver-api/i3c/index.rst
>   create mode 100644 Documentation/driver-api/i3c/master-driver-api.rst
>   create mode 100644 Documentation/driver-api/i3c/protocol.rst
>   create mode 100644 drivers/gpio/gpio-cdns-i3c.c
>   create mode 100644 drivers/i3c/Kconfig
>   create mode 100644 drivers/i3c/Makefile
>   create mode 100644 drivers/i3c/device.c
>   create mode 100644 drivers/i3c/internals.h
>   create mode 100644 drivers/i3c/master.c
>   create mode 100644 drivers/i3c/master/Kconfig
>   create mode 100644 drivers/i3c/master/Makefile
>   create mode 100644 drivers/i3c/master/i3c-master-cdns.c
>   create mode 100644 include/linux/i3c/ccc.h
>   create mode 100644 include/linux/i3c/device.h
>   create mode 100644 include/linux/i3c/master.h
>
Can you update the i3c/next tree?


Best regards,

Vitor Soares


