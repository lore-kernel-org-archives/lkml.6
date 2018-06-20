Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120F1C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA0BA20874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA0BA20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754077AbeFTMVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 08:21:08 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8585 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753266AbeFTMVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 08:21:06 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b2a46b30001>; Wed, 20 Jun 2018 05:21:07 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 20 Jun 2018 05:21:05 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 20 Jun 2018 05:21:05 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 20 Jun
 2018 12:21:04 +0000
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 20 Jun
 2018 12:21:04 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Wed, 20 Jun 2018 12:21:04 +0000
Received: from mperttunen-lnx.Nvidia.com (Not Verified[10.21.26.144]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b2a46ad0017>; Wed, 20 Jun 2018 05:21:04 -0700
From:   Mikko Perttunen <mperttunen@nvidia.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jassisinghbrar@gmail.com>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v2 0/8] Tegra Combined UART driver
Date:   Wed, 20 Jun 2018 15:20:34 +0300
Message-ID: <20180620122042.10950-1-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.16.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again - see individual patches for v2 changes.

Thanks,
Mikko

Original message:

Hi all,

on Tegra194, the primary console UART is the "Tegra Combined UART",
or TCU. This is a "virtual UART", where each consumer communicates
with a central implementation over mailboxes. The central
implementation then multiplexes the streams and arbitrates use of
a hardware serial port. This driver implements the consumer portion
to allow using the primary console.

The series is split into the following parts:
* patches 1 and 2 add the device tree bindings for mailbox and tcu
  itself.
* patch 3 adds a blocking transmission option to the mailbox
  framework.
* patches 4 and 5 add support for the "shared mailbox" primitive
  to the Tegra HSP driver.
* patch 6 adds the TCU driver itself
* patches 7 and 8 do the necessary device tree changes.

The series has been tested on the Tegra194 P2972 board.

Mikko Perttunen (8):
  dt-bindings: tegra186-hsp: Add shared interrupts
  dt-bindings: serial: Add bindings for nvidia,tegra194-tcu
  mailbox: Add transmit done by blocking option
  mailbox: tegra-hsp: Refactor in preparation of mailboxes
  mailbox: tegra-hsp: Add support for shared mailboxes
  serial: Add Tegra Combined UART driver
  arm64: tegra: Add nodes for tcu on Tegra194
  arm64: tegra: Mark tcu as primary serial port on Tegra194 P2888

 .../bindings/mailbox/nvidia,tegra186-hsp.txt       |   3 +
 .../bindings/serial/nvidia,tegra194-tcu.txt        |  35 +++
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi     |   2 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |  34 ++-
 drivers/mailbox/mailbox.c                          |  30 +-
 drivers/mailbox/mailbox.h                          |   1 +
 drivers/mailbox/tegra-hsp.c                        | 319 +++++++++++++++++----
 drivers/tty/serial/Kconfig                         |   9 +
 drivers/tty/serial/Makefile                        |   1 +
 drivers/tty/serial/tegra-tcu.c                     | 289 +++++++++++++++++++
 include/uapi/linux/serial_core.h                   |   3 +
 11 files changed, 658 insertions(+), 68 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
 create mode 100644 drivers/tty/serial/tegra-tcu.c

-- 
2.16.1

