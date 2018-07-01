Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A847C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 11:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE4B251C9
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 11:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE4B251C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752710AbeGALKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 07:10:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:47866 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752296AbeGALJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 07:09:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A4438AF5B;
        Sun,  1 Jul 2018 11:09:00 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     netdev@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>,
        Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        =?UTF-8?q?Michael=20R=C3=B6der?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        =?UTF-8?q?Konstantin=20B=C3=B6hm?= <konstantin.boehm@ancud.de>,
        Jan Jongboom <jan.jongboom@arm.com>,
        Jon Ortego <Jon.Ortego@imst.de>, contact@snootlab.com,
        Ben Whitten <ben.whitten@lairdtech.com>,
        Brian Ray <brian.ray@link-labs.com>, lora@globalsat.com.tw,
        lora@radioshuttle.de, Alexander Graf <agraf@suse.de>,
        =?UTF-8?q?Michal=20Kube=C4=8Dek?= <mkubecek@suse.cz>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Steve deRosier <derosier@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: [RFC net-next 00/15] net: A socket API for LoRa
Date:   Sun,  1 Jul 2018 13:07:49 +0200
Message-Id: <20180701110804.32415-1-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

LoRa is a long-range, low-power wireless technology by Semtech.
Unlike other LPWAN technologies, users don't need to rely on infrastructure
providers and SIM cards and expensive subscription plans, they can set up
their own gateways. Modules, adapters and evaluation boards are available
from a large number of vendors.

Many vendors also make available Open Source software examples on GitHub.
But when taking a closer look, many of them combine licenses in ways that are
not redistributable. My reports have remained without response or solution.

https://github.com/ernstdevreede/lmic_pi/issues/2
https://github.com/Snootlab/lmic_chisterapi/issues/2
https://github.com/Snootlab/lora_chisterapi/issues/2

Another issue was that most such projects around the Raspberry Pi make use of
spidev to communicate with the Semtech chipsets from userspace. The Linux spi
maintainers have chosen to greet any such users of spidev with a friendly
WARN_ON(), preferring in-kernel spi drivers and white-listing individual
devices only.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/spi/spidev.c?h=v4.17#n722
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/spi/spidev.c?h=v4.17#n667

Also I don't quite see the point in having userspace probe what SPI devices
are connected to a generic spidev driver when we have an easy Device Tree
hardware description on arm/arm64 that could give us that info.

I raised the topic during Q&A of a FOSDEM 2017 talk (cut off at the end
of the video) but unfortunately found no one to collaborate on this.

https://archive.fosdem.org/2017/schedule/event/lorawan/

Instead of porting from wiringPi to a differently licensed GPIO library
and dealing with seemingly unmaintained LoRaWAN code dumps, I started a
spi kernel driver for SX1276 back in 2016. But obviously a kernel driver
isn't too helpful without a userspace API to send and receive packets.

This patchset, updated from 2017 and extended, is implementing kernel drivers
for various LoRa chipsets and modules. As API I'm proposing a PF_LORA socket
implementation. Why? LoRa uses data packets with headers and checksums
and differing MTUs and multiple protocols layered on top of it. Apart from
simple headers for addressing used by RadioHead library and IMST's LoRa P2P
protocol, the main use case (not implemented in this patchset) is expected
to be LoRaWAN. And LoRaWAN has competing proprietary protocols, such as
Link Labs' Symphony Link or GlobalSat M.O.S.T. or RadioShuttle, that might
at some point want to adopt a standard API for their implementations, too.

Ready-made LoRa hardware modules come in three flavors,
a) with SPI access to the underlying Semtech chipsets, needing a software
   implementation of e.g. LoRaWAN protocol stack (i.e., a soft MAC),
b) with a custom, often UART based interface and a pre-certified LoRaWAN
   protocol stack already integrated (i.e., hard/full MAC), and
c) with a microcontroller that serves not only for the protocol stack but
   also as application processor, not offering a ready-made interface.

This patchset focuses on option a). An SX1276 based LoRaWAN stack appeared
to be the project of Jian-Hong Pan and is not included here.
This patchset also includes drivers for b), from text based AT commands to
a binary SLIP based HCI protocol.
Hardware examples for c) are Murata CMWX1ZZABZ-078 and RAK813.

This patchset is clearly not ready for merging, but is being submitted for
discussion, as requested by Jiri, in particular of the design choices:

1) PF_LORA/AF_LORA and associated identifiers are proposed to represent
   this technology. While for an SX1276 - case a) above - it might work to
   layer LoRaWAN as a protocol option for PF_LORA and add LoRaWAN address
   fields to the union in my sockaddr_lora, how would that work for devices
   that only support LoRaWAN but not pure LoRa? Do we need both AF_LORA and
   AF_LORAWAN, or just a separate ETH_P_LORAWAN or ARPHRD_LORAWAN?

2) PF_LORA is used with SOCK_DGRAM here. The assumption is that RAW mode
   would be DGRAM plus preamble plus optional checksum.

3) Only the transmit path is partially implemented already. The assumption
   is that the devices should go into receive mode by default and only
   interrupt that when asked to transmit.

4) Some hardware settings need to be supplied externally, such as the radio
   frequency for some modules, but many others can be runtime-configured,
   such as Spreading Factor, Bandwidth, Sync Word, or which antenna to use.
   What settings should be implemented as socket option vs. netlink layer
   vs. ioctl vs. sysfs? What are the criteria to apply?

5) Many of the modules support multiple modes, such as LoRa, LoRaWAN and FSK.
   Lacking a LoRaWAN implementation, I am currently switching them into LoRa
   mode at probe time wherever possible. How do we deal with that properly?

  a) Is there any precedence from the Wifi world for dynamically selecting
     between our own trusted Open Source implementation vs. hardware/firmware
     accelerated and/or certified implementations?

  b) Would a proof of concept for FSK (non-LoRa) modes be required for
     merging any LoRa driver for chipsets that support both? Or is there any
     facility or design guidelines that would allow us to focus on LoRa and
     LoRaWAN and leave non-LoRa radio modes to later contributors?

As evident by the many questions, this is my first deep dive into the Linux
net subsystem. It's also my first experiments with the new serdev subsystem,
so in particular the receive paths will need some review and optimizations.

This patchset was developed and tested mainly as KMP, originally at
https://github.com/afaerber/lora-modules. It was recently transformed into a
linux-next based tree, still mostly tested on our openSUSE Tumbleweed kernel
with a differing AF_LORA value below current AF_MAX limit.

Some corresponding Device Tree Overlays have been collected here:
https://github.com/afaerber/dt-overlays

Only European models for 868 MHz and 433 MHz could be tested when available.
Thanks to all companies and people that have supported this project so far.

Have a lot of fun!

Cheers,
Andreas

Cc: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Matthias Brugger <mbrugger@suse.com>
Cc: Konstantin Böhm <konstantin.boehm@ancud.de>
Cc: Jan Jongboom <jan.jongboom@arm.com>
Cc: Janus Piwek <jpiwek@arroweurope.com>
Cc: Michael Röder <michael.roeder@avnet.eu>
Cc: Dollar Chen (陳義元) <dollar.chen@wtmec.com>
Cc: Ken Yu (禹凯) <ken.yu@rakwireless.com>
Cc: Jon Ortego <Jon.Ortego@imst.de>
Cc: contact@snootlab.com
Cc: Ben Whitten <ben.whitten@lairdtech.com>
Cc: Brian Ray <brian.ray@link-labs.com>
Cc: lora@globalsat.com.tw
Cc: lora@radioshuttle.de
Cc: Alexander Graf <agraf@suse.de>
Cc: Michal Kubeček <mkubecek@suse.cz>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Steve deRosier <derosier@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org

Andreas Färber (15):
  net: Reserve protocol numbers for LoRa
  net: lora: Define sockaddr_lora
  net: lora: Add protocol numbers
  net: Add lora subsystem
  HACK: net: lora: Deal with .poll_mask in 4.18-rc2
  net: lora: Prepare for device drivers
  net: lora: Add Semtech SX1276
  net: lora: sx1276: Add debugfs
  net: lora: Prepare EUI helpers
  net: lora: Add Microchip RN2483
  net: lora: Add IMST WiMOD
  net: lora: Add USI WM-SG-SM-42
  net: lora: Prepare RAK RAK811
  net: lora: Prepare Semtech SX1257
  net: lora: Add Semtech SX1301

 drivers/net/Makefile                |   1 +
 drivers/net/lora/Kconfig            |  72 ++++
 drivers/net/lora/Makefile           |  32 ++
 drivers/net/lora/dev.c              | 125 ++++++
 drivers/net/lora/rak811.c           | 219 +++++++++++
 drivers/net/lora/rn2483.c           | 344 +++++++++++++++++
 drivers/net/lora/rn2483.h           |  40 ++
 drivers/net/lora/rn2483_cmd.c       | 130 +++++++
 drivers/net/lora/sx1257.c           |  96 +++++
 drivers/net/lora/sx1276.c           | 740 ++++++++++++++++++++++++++++++++++++
 drivers/net/lora/sx1301.c           | 446 ++++++++++++++++++++++
 drivers/net/lora/usi.c              | 411 ++++++++++++++++++++
 drivers/net/lora/wimod.c            | 597 +++++++++++++++++++++++++++++
 include/linux/lora/dev.h            |  44 +++
 include/linux/lora/skb.h            |  29 ++
 include/linux/socket.h              |   4 +-
 include/uapi/linux/if_arp.h         |   1 +
 include/uapi/linux/if_ether.h       |   1 +
 include/uapi/linux/lora.h           |  24 ++
 net/Kconfig                         |   1 +
 net/Makefile                        |   1 +
 net/lora/Kconfig                    |  15 +
 net/lora/Makefile                   |   8 +
 net/lora/af_lora.c                  | 152 ++++++++
 net/lora/af_lora.h                  |  13 +
 net/lora/dgram.c                    | 297 +++++++++++++++
 security/selinux/hooks.c            |   4 +-
 security/selinux/include/classmap.h |   4 +-
 28 files changed, 3848 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/lora/Kconfig
 create mode 100644 drivers/net/lora/Makefile
 create mode 100644 drivers/net/lora/dev.c
 create mode 100644 drivers/net/lora/rak811.c
 create mode 100644 drivers/net/lora/rn2483.c
 create mode 100644 drivers/net/lora/rn2483.h
 create mode 100644 drivers/net/lora/rn2483_cmd.c
 create mode 100644 drivers/net/lora/sx1257.c
 create mode 100644 drivers/net/lora/sx1276.c
 create mode 100644 drivers/net/lora/sx1301.c
 create mode 100644 drivers/net/lora/usi.c
 create mode 100644 drivers/net/lora/wimod.c
 create mode 100644 include/linux/lora/dev.h
 create mode 100644 include/linux/lora/skb.h
 create mode 100644 include/uapi/linux/lora.h
 create mode 100644 net/lora/Kconfig
 create mode 100644 net/lora/Makefile
 create mode 100644 net/lora/af_lora.c
 create mode 100644 net/lora/af_lora.h
 create mode 100644 net/lora/dgram.c

-- 
2.16.4

