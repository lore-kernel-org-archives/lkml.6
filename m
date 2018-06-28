Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD048C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6481C27323
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6481C27323
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934579AbeF1MHu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:07:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36098 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934421AbeF1MHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:07:48 -0400
Received: from localhost (unknown [104.153.224.166])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CE1DECC9;
        Thu, 28 Jun 2018 12:07:29 +0000 (UTC)
Date:   Thu, 28 Jun 2018 21:01:03 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Pavel Machek <pavel@ucw.cz>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/8] gnss: add new GNSS subsystem
Message-ID: <20180628120103.GA28131@kroah.com>
References: <20180601082259.17563-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601082259.17563-1-johan@kernel.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 10:22:51AM +0200, Johan Hovold wrote:
> This series adds a new subsystem for GNSS receivers (e.g. GPS
> receivers).
> 
> While GNSS receivers are typically accessed using a UART interface they
> often also support other I/O interfaces such as I2C, SPI and USB, while
> yet other devices use iomem or even some form of remote-processor
> messaging (rpmsg).
> 
> The new GNSS subsystem abstracts the underlying interface and provides a
> new "gnss" class type, which exposes a character-device interface (e.g.
> /dev/gnss0) to user space. This allows GNSS receivers to have a
> representation in the Linux device model, something which is important
> not least for power management purposes and which also allows for easy
> detection and identification of GNSS devices.
> 
> Note that the character-device interface provides raw access to whatever
> protocol the receiver is (currently) using, such as NMEA 0183, UBX or
> SiRF Binary. These protocols are expected to be continued to be handled
> by user space for the time being, even if some hybrid solutions are also
> conceivable (e.g. to have kernel drivers issue management commands).
> 
> This will still allow for better platform integration by allowing GNSS
> devices and their resources (e.g. regulators and enable-gpios) to be
> described by firmware and managed by kernel drivers rather than
> platform-specific scripts and services.
> 
> While the current interface is kept minimal, it could be extended using
> IOCTLs, sysfs or uevents as needs and proper abstraction levels are
> identified and determined (e.g. for device and feature identification).
> 
> Another possible extension is to add generic 1PPS support.
> 
> I decided to go with a custom character-device interface rather than
> pretend that these abstract GNSS devices are still TTY devices (e.g.
> /dev/ttyGNSS0). Obviously, modifying line settings or reading modem
> control signals does not make any sense for a device using, say, a
> USB (not USB-serial) or iomem interface. This also means, however, that
> user space would no longer be able to set the line speed to match a new
> port configuration that can be set using the various GNSS protocols when
> the underlying interface is indeed a UART; instead this would need to be
> taken care of by the driver.
> 
> Also note that writes are always synchronous instead of requiring user
> space to call tcdrain() after every command.
> 
> This all seems to work well-enough (e.g. with gpsd), but please let me
> know if I've overlooked something which would indeed require a TTY
> interface instead.
> 
> I have implemented drivers for receivers based on two common GNSS
> chipsets; SiRFstar and u-blox. Due to lack of hardware, the sirf driver
> has been tested using a mockup device and a USB-serial-based SiRFstar IV
> GPS (using out-of-tree USB-serial code). [ Let me know if you've got any
> evaluation kits to spare. ] The ubx driver has been tested using a
> u-blox 8 GNSS evaluation kit (thanks u-blox!).
> 
> Finally, note that documentation (including kerneldoc) remains to be
> written, but hopefully this will not hinder review given that the
> current interfaces are fairly self-describing.

This all looks great.  Thanks for doing this work and adding a new
subsystem for something that has been asked for for many years.

All now merged in my tree, nice job!

greg k-h
