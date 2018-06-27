Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2DEC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC7F25F18
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FC7F25F18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934804AbeF0PWX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:22:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:43102 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934411AbeF0PUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:20:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2018 08:20:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,279,1526367600"; 
   d="scan'208";a="67768731"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jun 2018 08:19:50 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>,
        Mats Karrman <mats.dev.list@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] usb: typec: Support for Alternate Modes
Date:   Wed, 27 Jun 2018 18:19:45 +0300
Message-Id: <20180627151953.30942-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since we now have an implementation for an actual alternate mode (DisplayPort),
I guess there is no reason to send another RFC. This series is the same as the
last RFC proposal [1] with only minor changes. There were only a few comments.

[1] https://lkml.org/lkml/2018/6/8/225

I've tested these with a platform that has fusb302, and also with UCSI
platforms. The UCSI driver will need separate support for alternate modes that
I'm not including to this series. I'm still working on it. I've used various
DisplayPort to Type-C adapters for testing, both DisplayPort receptacles and
connectors.


Heikki Krogerus (8):
  usb: pd: include kernel.h
  usb: typec: function for checking cable plug orientation
  usb: typec: mux: Get the mux identifier from function parameter
  usb: typec: Register a device for every mode
  usb: typec: Bus type for alternate modes
  usb: typec: Add driver for DisplayPort alternate mode
  usb: typec: pi3usb30532: Start using generic state values
  usb: typec: tcpm: Support for Alternate Modes

 Documentation/ABI/obsolete/sysfs-class-typec  |  48 ++
 Documentation/ABI/testing/sysfs-bus-typec     |  51 ++
 Documentation/ABI/testing/sysfs-class-typec   |  62 +-
 .../testing/sysfs-driver-typec-displayport    |  49 ++
 Documentation/driver-api/usb/typec_bus.rst    | 136 +++++
 MAINTAINERS                                   |  11 +-
 drivers/usb/typec/Kconfig                     |   2 +
 drivers/usb/typec/Makefile                    |   3 +-
 drivers/usb/typec/altmodes/Kconfig            |  14 +
 drivers/usb/typec/altmodes/Makefile           |   2 +
 drivers/usb/typec/altmodes/displayport.c      | 578 ++++++++++++++++++
 drivers/usb/typec/bus.c                       | 401 ++++++++++++
 drivers/usb/typec/bus.h                       |  38 ++
 drivers/usb/typec/class.c                     | 486 ++++++++++-----
 drivers/usb/typec/mux.c                       |   6 +-
 drivers/usb/typec/mux/pi3usb30532.c           |  13 +-
 drivers/usb/typec/tcpm.c                      | 188 ++++--
 include/linux/mod_devicetable.h               |  15 +
 include/linux/usb/pd.h                        |   1 +
 include/linux/usb/tcpm.h                      |   9 -
 include/linux/usb/typec.h                     |  52 +-
 include/linux/usb/typec_altmode.h             | 160 +++++
 include/linux/usb/typec_dp.h                  |  95 +++
 include/linux/usb/typec_mux.h                 |   2 +-
 scripts/mod/devicetable-offsets.c             |   4 +
 scripts/mod/file2alias.c                      |  13 +
 26 files changed, 2116 insertions(+), 323 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/sysfs-class-typec
 create mode 100644 Documentation/ABI/testing/sysfs-bus-typec
 create mode 100644 Documentation/ABI/testing/sysfs-driver-typec-displayport
 create mode 100644 Documentation/driver-api/usb/typec_bus.rst
 create mode 100644 drivers/usb/typec/altmodes/Kconfig
 create mode 100644 drivers/usb/typec/altmodes/Makefile
 create mode 100644 drivers/usb/typec/altmodes/displayport.c
 create mode 100644 drivers/usb/typec/bus.c
 create mode 100644 drivers/usb/typec/bus.h
 create mode 100644 include/linux/usb/typec_altmode.h
 create mode 100644 include/linux/usb/typec_dp.h

-- 
2.18.0

