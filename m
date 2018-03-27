Return-Path: <sebastian.reichel@collabora.co.uk>
X-Google-Smtp-Source: AIpwx4+z8E6ez1NFFMLxyF0vQZB34vCiObEcgBxdRUjwZdHIGUxxQ0D58DYGTCH/IURurovd3mgp
ARC-Seal: i=1; a=rsa-sha256; t=1522158783; cv=none;
        d=google.com; s=arc-20160816;
        b=jFKPqaGEU6je1TZSp+HFvSUo5jsLlGv//gFRL9U9wNMRg/VZr3fjIJ9YO8h0gue0jp
         3ZCCSfYUIlrmLgqrwXFns+JTlAoKrSa7JA6KMv4LLqotBPDHo0LLDgxu+L8cSAvZjq+f
         E8Ge8vjZHnyYYp0PQriqHMxF2MYiJ+z21DvL6RVDHeqtKt1cBt7clcBgfHj+vQx66c/a
         j+j97N5FktygwV8zGqvtI1vO+nowLRLJ3tZhMcIMcBWGhJrqqBOBX7G/ATNaz2INKC4X
         J5JCXoO8SW6D5vkFQPZn+FCCFmJhxdz3OFLxPOTdV4pHlafANwETfrPIhMVZ6f1Mk34a
         sPwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=N/X4Q6tJiDrqU85DQBpmj/bkWQbN2R+9pabCufHUqtw=;
        b=ihk7Lc9WqmG/qGf1d+YAyo5/+5hMJEp3AcWLTF+Q10dGHCnea1W/yYfmAo36lV/13D
         OjymafY7f7USEzfGShji55d6Q9iyGvkGQX+nU3IdIuD+7bv2xWsbjPthZ1CTs3ABlCW+
         KNDZ3zp05VhwFGzQHnCYULXVMv0dacpdVM1oTiwbDptexl/5I4eg+5icSCOAaHvG0e4B
         7kJTA6nsMZJhEZvFJMWfJM95jQrkJbEj/acR95lspdCIn415FbpGfQogk/mPfIlQrotu
         VPGixOop+jihXf3yYcbLL5egSW57QeFW8i3QD2Rb+ksRcUeoCVL3/B90zomfqwFoWhaW
         YjkA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sebastian.reichel@collabora.co.uk designates 46.235.227.227 as permitted sender) smtp.mailfrom=sebastian.reichel@collabora.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=collabora.co.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sebastian.reichel@collabora.co.uk designates 46.235.227.227 as permitted sender) smtp.mailfrom=sebastian.reichel@collabora.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=collabora.co.uk
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Nandor Han <nandor.han@ge.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCHv2 0/3] GE Healthcare PPD firmware upgrade driver for ACHC
Date: Tue, 27 Mar 2018 15:52:56 +0200
Message-Id: <20180327135259.30890-1-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.16.2
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596099168711275767?=
X-GMAIL-MSGID: =?utf-8?q?1596099168711275767?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

The PPD has a secondary processor from NXP, which can be programmed
from the main system. It is connected to the main processor by having
it's EzPort interface connected to the SPI bus.

This adds a generic driver to handle firmware flashing via NXP EzPort
and adds a custom compatible for the instance found in GE's device.
The reset gpio is only requested during flashing, since it is also
used for resetting other devices. A better solution for the shared
reset gpio is required at some point, but this does neither affect
the userspace interface, nor the DT interface and should not block
upstreaming this driver.

Changes since PATCHv1:
 * split DT binding update into its own patch
 * add sysfs attribute documentation
 * fix problem reported by kbuild test robot

-- Sebastian

Sebastian Reichel (3):
  dt-bindings: misc: achc: Make ezport distinguishable
  misc: ezport-firmware: new driver
  ARM: dts: imx53: PPD: Update ACHC programming interface

 Documentation/ABI/testing/sysfs-bus-spi-ezport-fw  |  23 +
 Documentation/devicetree/bindings/misc/ge-achc.txt |  19 +-
 arch/arm/boot/dts/imx53-ppd.dts                    |   5 +-
 drivers/misc/Kconfig                               |   9 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/ezport-firmware.c                     | 491 +++++++++++++++++++++
 6 files changed, 543 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-spi-ezport-fw
 create mode 100644 drivers/misc/ezport-firmware.c

-- 
2.16.2
