Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C269ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07EF72064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:40:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07EF72064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arcx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbeJXXIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 19:08:41 -0400
Received: from mail.arcx.com ([184.94.50.18]:27680 "EHLO WEBMAIL.arcx.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbeJXXIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 19:08:34 -0400
X-Greylist: delayed 906 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Oct 2018 19:08:27 EDT
Received: from svens-asus.arcx.com (192.168.2.132) by WEBMAIL.arcx.com
 (192.168.2.64) with Microsoft SMTP Server (TLS) id 15.0.847.32; Wed, 24 Oct
 2018 10:26:18 -0400
From:   Sven Van Asbroeck <svendev@arcx.com>
To:     <svendev@arcx.com>, <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <afaerber@suse.de>, <treding@nvidia.com>,
        <david@lechnology.com>, <noralf@tronnes.org>, <johan@kernel.org>,
        <monstr@monstr.eu>, <michal.vokac@ysoft.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <john.garry@huawei.com>,
        <andriy.shevchenko@linux.intel.com>, <geert+renesas@glider.be>,
        <robin.murphy@arm.com>, <paul.gortmaker@windriver.com>,
        <sebastien.bourdelin@savoirfairelinux.com>, <icenowy@aosc.io>,
        <yuanzhichang@hisilicon.com>, <stuyoder@gmail.com>,
        <linus.walleij@linaro.org>, <maxime.ripard@bootlin.com>,
        <bogdan.purcareata@nxp.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH anybus v1 0/4] Support HMS Profinet Card over Anybus
Date:   Wed, 24 Oct 2018 10:24:52 -0400
Message-ID: <20181024142456.10084-1-svendev@arcx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.2.132]
X-ClientProxiedBy: webmail.arcx.com (192.168.2.64) To WEBMAIL.arcx.com
 (192.168.2.64)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds support for the HMS Industrial Networks AB Profinet card.

Profinet is an industry technical standard for data communication over
Industrial Ethernet, designed for collecting data from, and controlling,
equipment in industrial systems, with a particular strength in delivering data
under tight time constraints (on the order of 1ms or less).

The profinet card itself is connected to the system via an industrial bus
called 'anybus'.

I have followed the bus driver/client driver pattern, and created an anybus
bus driver, plus a client driver for the profinet card.

In case this patch set gets (eventually) accepted, drivers for other anybus
client cards may follow: flnet, cc-link, ...

The anybus slot on the host is located on an 'anybus bridge', which is
custom h/w designed by Arcx. Its driver is modeled as an mfd, which
instantiates two anybus slots.

v1:
	first shot

Sven Van Asbroeck (4):
  mfd: support the Arcx anybus bridge.
  dt-bindings: anybus-bridge: document devicetree binding.
  bus: support HMS Anybus-S bus.
  misc: support HMS Profinet IRT industrial controller.

 .../bindings/mfd/arcx,anybus-bridge.txt       |   37 +
 .../devicetree/bindings/vendor-prefixes.txt   |    1 +
 drivers/bus/Kconfig                           |   11 +
 drivers/bus/Makefile                          |    1 +
 drivers/bus/anybuss-host.c                    | 1301 +++++++++++++++++
 drivers/mfd/Kconfig                           |   11 +
 drivers/mfd/Makefile                          |    1 +
 drivers/mfd/anybus-bridge.c                   |  441 ++++++
 drivers/misc/Kconfig                          |   11 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/hms-profinet.c                   |  747 ++++++++++
 include/linux/anybuss-client.h                |  100 ++
 include/linux/anybuss-host.h                  |   28 +
 include/uapi/linux/hms-common.h               |   14 +
 include/uapi/linux/hms-profinet.h             |  101 ++
 15 files changed, 2806 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/arcx,anybus-bridge.txt
 create mode 100644 drivers/bus/anybuss-host.c
 create mode 100644 drivers/mfd/anybus-bridge.c
 create mode 100644 drivers/misc/hms-profinet.c
 create mode 100644 include/linux/anybuss-client.h
 create mode 100644 include/linux/anybuss-host.h
 create mode 100644 include/uapi/linux/hms-common.h
 create mode 100644 include/uapi/linux/hms-profinet.h

-- 
2.17.1

