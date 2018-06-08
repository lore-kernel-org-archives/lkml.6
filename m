Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id fjkTFGtoGltMSwAAmS7hNA
	; Fri, 08 Jun 2018 11:29:50 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D6A47607E4; Fri,  8 Jun 2018 11:29:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3F86F607A4;
	Fri,  8 Jun 2018 11:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3F86F607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752754AbeFHL3p (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 07:29:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:32416 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751265AbeFHL3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 07:29:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2018 04:29:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,490,1520924400";
   d="scan'208";a="62388977"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Jun 2018 04:29:42 -0700
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jun Li <jun.li@nxp.com>,
        Mats Karrman <mats.dev.list@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 0/8] usb: typec: Support for Alternate Modes
Date: Fri,  8 Jun 2018 14:29:33 +0300
Message-Id: <20180608112941.26332-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the fourth (and hopefully last RFC) of my proposal for more
complete alternate mode support. In this version the main difference
compared to the previous versions is the displayport alt mode driver.

For those who have no idea what is this about, the idea is to add a
bus type for the USB-C alternate modes. All alternate modes, for
example DisplayPort, require specific communication, so we will need
separate driver for every alternate mode. For more details please read
the cover letter of the previous version here:

https://lkml.org/lkml/2018/5/11/323

It took some time for me to get permission to publish the displayport
alt mode driver. Sorry for the delay. I was actually hoping that I
could include changes also to the drm subsystem already now, but it
ended up being more complicated than I first though, and I quite
simply don't have time for that, so let's just start with these.


Heikki Krogerus (8):
  usb: pd: include kernel.h
  usb: typec: helper for checking cable plug orientation
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
 MAINTAINERS                                   |  13 +-
 drivers/usb/typec/Kconfig                     |   2 +
 drivers/usb/typec/Makefile                    |   3 +-
 drivers/usb/typec/altmodes/Kconfig            |  14 +
 drivers/usb/typec/altmodes/Makefile           |   2 +
 drivers/usb/typec/altmodes/displayport.c      | 543 ++++++++++++++++++
 drivers/usb/typec/bus.c                       | 401 +++++++++++++
 drivers/usb/typec/bus.h                       |  38 ++
 drivers/usb/typec/class.c                     | 485 ++++++++++------
 drivers/usb/typec/mux.c                       |   6 +-
 drivers/usb/typec/mux/pi3usb30532.c           |  15 +-
 drivers/usb/typec/tcpm.c                      | 184 ++++--
 include/linux/mod_devicetable.h               |  15 +
 include/linux/usb/pd.h                        |   1 +
 include/linux/usb/tcpm.h                      |   9 -
 include/linux/usb/typec.h                     |  52 +-
 include/linux/usb/typec_altmode.h             | 160 ++++++
 include/linux/usb/typec_dp.h                  |  70 +++
 include/linux/usb/typec_mux.h                 |   2 +-
 scripts/mod/devicetable-offsets.c             |   4 +
 scripts/mod/file2alias.c                      |  13 +
 26 files changed, 2053 insertions(+), 325 deletions(-)
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
2.17.1
