Return-Path: <mika.westerberg@linux.intel.com>
X-Google-Smtp-Source: AG47ELsSmK4mF1YIXYWgr1f9nYI1Iwj6x8hEtfsGjpd5Ny1vfBaK5jpJUrjEHD+sadhAqLihXR7O
ARC-Seal: i=1; a=rsa-sha256; t=1521476832; cv=none;
        d=google.com; s=arc-20160816;
        b=VwY0FFV0fxt4uaanXgcdlxsNlzGMzLJpquIIierkvh9R0QclVfzYGkyR0h2M7P5DI2
         R8xtYDKbQoW0cS/WA9uyZ9TCaoWHqO6VEHSfHtJw8Rg/WPvsf1A4YbAt+AAbvcA2Nf/m
         1gQRnWN6B1KWhUyQT5v10HRD6ct+Kk+LvW+6Zk3WFiwJYMWbPDw9pet/BejIKFtXXrol
         si09v3psBVCxlAqRGzMdz5vV8Q8UAFj52TX+RPR/BxFtpNbKdfBkw1lTX4HvmF16baxv
         EczK7np94/eARxli+MMPPeEA3qQJx6QXscXGLylUSXTLXhLoRUJcEMSkDrrD1ly3vuHJ
         HByA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=3auHjx+5xAJ+xyM5TRd3qcNUWvdEBgXRD+eG+GdtC/o=;
        b=hL6En8jhnG5buw0jzs+4dN7D9gdngIIS500t4kEfcfZqHPNZ4wUwq5dgMibpaZKnij
         AiwE46i2ouY8epkL7qhHNFUejqDedm/fCMvWLVw4/Lq39/KzjnYB/uZCAELCAYU178re
         jXaACJzi3pJdCOq2k6IDyjTIgrPnEELG+NbvdhwgEE/IfNM8+jDU1ePJK2Dl1IdMQ9u+
         mJAlYcQ5jtLQvisflaaMqOspJT10C5Ym7kbWhLljDFjPjFa4yun6lICqcv2h2dDdXQH/
         de6V6CCzIHRiQql05xnuCrdyJDFic4/4O29g2zr+dBQfygVBYN3fZB+OTLNb8cqnvqUB
         teQw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,331,1517904000";
   d="scan'208";a="212699945"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <yehezkel.bernat@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 17/19] thunderbolt: Introduce USB only (SL4) security level
Date: Mon, 19 Mar 2018 19:27:01 +0300
Message-Id: <20180319162703.5331-18-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319162703.5331-1-mika.westerberg@linux.intel.com>
References: <20180319162703.5331-1-mika.westerberg@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595384091000843078?=
X-GMAIL-MSGID: =?utf-8?q?1595384091000843078?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This new security level works so that it creates one PCIe tunnel to the
connected Thunderbolt dock, removing PCIe links downstream of the dock.
This leaves only the internal USB controller visible.

Display Port tunnels are created normally.

While there make sure security sysfs attribute returns "unknown" for any
future security level.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-thunderbolt |  3 +++
 Documentation/admin-guide/thunderbolt.rst       | 15 ++++++++++-----
 drivers/thunderbolt/domain.c                    |  7 ++++++-
 include/linux/thunderbolt.h                     |  4 ++++
 4 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-thunderbolt b/Documentation/ABI/testing/sysfs-bus-thunderbolt
index 4ed229789852..151584a1f950 100644
--- a/Documentation/ABI/testing/sysfs-bus-thunderbolt
+++ b/Documentation/ABI/testing/sysfs-bus-thunderbolt
@@ -35,6 +35,9 @@ Description:	This attribute holds current Thunderbolt security level
 			minimum. User needs to authorize each device.
 		dponly: Automatically tunnel Display port (and USB). No
 			PCIe tunnels are created.
+		usbonly: Automatically tunnel USB controller of the
+			 connected Thunderbolt dock (and Display Port). All
+			 PCIe links downstream of the dock are removed.
 
 What: /sys/bus/thunderbolt/devices/.../authorized
 Date:		Sep 2017
diff --git a/Documentation/admin-guide/thunderbolt.rst b/Documentation/admin-guide/thunderbolt.rst
index 9948ec36a204..35fccba6a9a6 100644
--- a/Documentation/admin-guide/thunderbolt.rst
+++ b/Documentation/admin-guide/thunderbolt.rst
@@ -21,11 +21,11 @@ vulnerable to DMA attacks.
 Security levels and how to use them
 -----------------------------------
 Starting with Intel Falcon Ridge Thunderbolt controller there are 4
-security levels available. The reason for these is the fact that the
-connected devices can be DMA masters and thus read contents of the host
-memory without CPU and OS knowing about it. There are ways to prevent
-this by setting up an IOMMU but it is not always available for various
-reasons.
+security levels available. Intel Titan Ridge added one more security level
+(usbonly). The reason for these is the fact that the connected devices can
+be DMA masters and thus read contents of the host memory without CPU and OS
+knowing about it. There are ways to prevent this by setting up an IOMMU but
+it is not always available for various reasons.
 
 The security levels are as follows:
 
@@ -52,6 +52,11 @@ The security levels are as follows:
     USB. No PCIe tunneling is done. In BIOS settings this is
     typically called *Display Port Only*.
 
+  usbonly
+    The firmware automatically creates tunnels for the USB controller and
+    Display Port in a dock. All PCIe links downstream of the dock are
+    removed.
+
 The current security level can be read from
 ``/sys/bus/thunderbolt/devices/domainX/security`` where ``domainX`` is
 the Thunderbolt domain the host controller manages. There is typically
diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index ab4b304306f7..6281266b8ec0 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -117,6 +117,7 @@ static const char * const tb_security_names[] = {
 	[TB_SECURITY_USER] = "user",
 	[TB_SECURITY_SECURE] = "secure",
 	[TB_SECURITY_DPONLY] = "dponly",
+	[TB_SECURITY_USBONLY] = "usbonly",
 };
 
 static ssize_t boot_acl_show(struct device *dev, struct device_attribute *attr,
@@ -227,8 +228,12 @@ static ssize_t security_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
 	struct tb *tb = container_of(dev, struct tb, dev);
+	const char *name = "unknown";
 
-	return sprintf(buf, "%s\n", tb_security_names[tb->security_level]);
+	if (tb->security_level < ARRAY_SIZE(tb_security_names))
+		name = tb_security_names[tb->security_level];
+
+	return sprintf(buf, "%s\n", name);
 }
 static DEVICE_ATTR_RO(security);
 
diff --git a/include/linux/thunderbolt.h b/include/linux/thunderbolt.h
index 47251844d064..a3ed26082bc1 100644
--- a/include/linux/thunderbolt.h
+++ b/include/linux/thunderbolt.h
@@ -45,12 +45,16 @@ enum tb_cfg_pkg_type {
  * @TB_SECURITY_USER: User approval required at minimum
  * @TB_SECURITY_SECURE: One time saved key required at minimum
  * @TB_SECURITY_DPONLY: Only tunnel Display port (and USB)
+ * @TB_SECURITY_USBONLY: Only tunnel USB controller of the connected
+ *			 Thunderbolt dock (and Display Port). All PCIe
+ *			 links downstream of the dock are removed.
  */
 enum tb_security_level {
 	TB_SECURITY_NONE,
 	TB_SECURITY_USER,
 	TB_SECURITY_SECURE,
 	TB_SECURITY_DPONLY,
+	TB_SECURITY_USBONLY,
 };
 
 /**
-- 
2.16.2
