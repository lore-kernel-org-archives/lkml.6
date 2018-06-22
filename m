Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42E0C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7596D240BB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7596D240BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933748AbeFVKwm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:52:42 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49417 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933292AbeFVKtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:49:47 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4A20120719; Fri, 22 Jun 2018 12:49:45 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9B467207EB;
        Fri, 22 Jun 2018 12:49:34 +0200 (CEST)
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Przemyslaw Sroka <psroka@cadence.com>,
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
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        linux-gpio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v5 03/10] i3c: Add sysfs ABI spec
Date:   Fri, 22 Jun 2018 12:49:23 +0200
Message-Id: <20180622104930.32050-4-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180622104930.32050-1-boris.brezillon@bootlin.com>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document sysfs files/directories/symlinks exposed by the I3C subsystem.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
Changes in v5:
- Fix the kernel version
- Rename address into dynamic_address to match changes done in the code

Changes in v4:
- none

Changes in v3:
- none

Changes in v2:
- new patch
---
 Documentation/ABI/testing/sysfs-bus-i3c | 95 +++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-i3c

diff --git a/Documentation/ABI/testing/sysfs-bus-i3c b/Documentation/ABI/testing/sysfs-bus-i3c
new file mode 100644
index 000000000000..068fd1e97c01
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-i3c
@@ -0,0 +1,95 @@
+What:		/sys/bus/i3c/devices/i3c-<bus-id>
+KernelVersion:  4.19
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		An I3C bus. This directory will contain one sub-directory per
+		I3C device present on the bus.
+
+What:		/sys/bus/i3c/devices/i3c-<bus-id>/current_master
+KernelVersion:  4.19
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		Expose the master that owns the bus (<bus-id>-<master-pid>) at
+		the time this file is read. Note that bus ownership can change
+		overtime, so there's no guarantee that when the read() call
+		returns, the value returned is still valid.
+
+What:		/sys/bus/i3c/devices/i3c-<bus-id>/mode
+KernelVersion:  4.19
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		I3C bus mode. Can be "pure", "mixed-fast" or "mixed-slow". See
+		the I3C specification for a detailed description of what each
+		of these modes implies.
+
+What:		/sys/bus/i3c/devices/i3c-<bus-id>/i3c_scl_frequency
+KernelVersion:  4.19
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		The frequency (expressed in Hz) of the SCL signal when
+		operating in I3C SDR mode.
+
+What:		/sys/bus/i3c/devices/i3c-<bus-id>/i2c_scl_frequency
+KernelVersion:  4.19
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		The frequency (expressed in Hz) of the SCL signal when
+		operating in I2C mode.
+
+What:		/sys/bus/i3c/devices/i3c-<bus-id>/<bus-id>-<device-pid>
+KernelVersion:  4.19
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		An I3C device present on I3C bus identified by <bus-id>. Note
+		that all devices are represented including the master driving
+		the bus.
+
+What:		/sys/bus/i3c/devices/i3c-<bus-id>/<bus-id>-<device-pid>/dynamic_address
+KernelVersion:  4.19
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		Dynamic address assigned to device <bus-id>-<device-pid>. This
+		address may change if the bus is re-initialized.
+
+What:		/sys/bus/i3c/devices/i3c-<bus-id>/<bus-id>-<device-pid>/bcr
+KernelVersion:  4.19
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		BCR stands for Bus Characteristics Register and express the
+		device capabilities in term of speed, maximum read/write
+		length, etc. See the I3C specification for more details.
+
+What:		/sys/bus/i3c/devices/i3c-<bus-id>/<bus-id>-<device-pid>/dcr
+KernelVersion:  4.19
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		DCR stands for Device Characteristics Register and express the
+		device capabilities in term of exposed features. See the I3C
+		specification for more details.
+
+What:		/sys/bus/i3c/devices/i3c-<bus-id>/<bus-id>-<device-pid>/pid
+KernelVersion:  4.19
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		PID stands for Provisional ID and is used to uniquely identify
+		a device on a bus. This PID contains information about the
+		vendor, the part and an instance ID so that several devices of
+		the same type can be connected on the same bus.
+		See the I3C specification for more details.
+
+What:		/sys/bus/i3c/devices/i3c-<bus-id>/<bus-id>-<device-pid>/hdrcap
+KernelVersion:  4.19
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		Expose the HDR (High Data Rate) capabilities of a device.
+		Returns a list of supported HDR mode, each element is separated
+		by space. Modes can be "hdr-ddr", "hdr-tsp" and "hdr-tsl".
+		See the I3C specification for more details about these HDR
+		modes.
+
+What:		/sys/bus/i3c/devices/<bus-id>-<device-pid>
+KernelVersion:  4.19
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		These directories are just symbolic links to
+		/sys/bus/i3c/devices/i3c-<bus-id>/<bus-id>-<device-pid>.
-- 
2.14.1

