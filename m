Return-Path: <dev@g0hl1n.net>
X-Google-Smtp-Source: AG47ELuTNgxouB0rW9HGNwMwXxYx+SwE8f3e1Zzv7N8ahIvBC+JNuOZqHBTVN0uTdiUJZg/TJQDI
ARC-Seal: i=1; a=rsa-sha256; t=1521541066; cv=none;
        d=google.com; s=arc-20160816;
        b=pT/anwISch/6+/i6AnfbyE72Cj2r6vx+482FH8OM/NZfU3zQB92h3ZAB8mKX1imhMd
         aflUuG4J5/ym0LpWSilkw1MbyMQtCtqL/Fw7GNoOzF4UdlwelUc9eal226AGNdpqO19B
         k1Qxo0VuZ1rBB9jbV3Ge61wCxFhggGO6Ey2Ui4qxfWIPT8W146nDRJAnIpQhUjQ6Be5J
         d4ToBlWNdzkpAaW4tXrbcyiLohZKbpS9eMhaBRKEKDCZsp4UbzyLnEMHXhEA4ew87UXl
         cSf9YlVo2r4shWonSPDrRaJMr+KMjbVNqlG6N5S96UkSPvWsG0ASGEJ/vBIf1BCRhQer
         tl/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=k4fqDmPnG0M/4+OL0GA0fJMzQig/KgOeMOsDIowxG/8=;
        b=zQsvEYlHmrBbRJ2Nt6niCePade4p3JZ70/7Q/k3ZwJhDBRDsytvNFoRq+LDjk7witc
         f/2Ij3ywI6uYekpGnY5nEDPZaVInK5RPqTs0Cebmn+m7nQcMOcmjZWNTO26XilOzrfHH
         g9DXHxcSH8aiqwwBQjtsKL+/okt0xDyzcVokaJ7cxdFYFy5GpSbbs9GV/l9KaqbbKE45
         Tg3nx4uHXBT7FeNZSgVuwN+T63jzWuk2FjKgX2lrTaTr9QA6QI9J3QHYGQ1bUTjJ7H+F
         oPytIzfMNXOJbWw0Dot43RZi5pQz6V/9TdCIyWeagOCYvUDBFrfmWXPKvJg05kIbXjrU
         8zvw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 109.237.142.238 is neither permitted nor denied by best guess record for domain of dev@g0hl1n.net) smtp.mailfrom=dev@g0hl1n.net
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 109.237.142.238 is neither permitted nor denied by best guess record for domain of dev@g0hl1n.net) smtp.mailfrom=dev@g0hl1n.net
X-Spam-DCC: : 
From: Richard Leitner <dev@g0hl1n.net>
To: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	stern@rowland.harvard.edu,
	linux@roeck-us.net,
	mathias.nyman@linux.intel.com,
	johan@kernel.org,
	felipe.balbi@linux.intel.com,
	ekorenevsky@gmail.com,
	peter.chen@nxp.com,
	drake@endlessm.com,
	joe@perches.com,
	Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH v4] usb: core: introduce per-port over-current counters
Date: Tue, 20 Mar 2018 11:17:13 +0100
Message-Id: <20180320101713.5650-1-dev@g0hl1n.net>
X-Mailer: git-send-email 2.11.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595451444613956744?=
X-GMAIL-MSGID: =?utf-8?q?1595451444613956744?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Richard Leitner <richard.leitner@skidata.com>

For some userspace applications information on the number of
over-current conditions at specific USB hub ports is relevant.

In our case we have a series of USB hardware (using the cp210x driver)
which communicates using a proprietary protocol. These devices sometimes
trigger an over-current situation on some hubs. In case of such an
over-current situation the USB devices offer an interface for reducing
the max used power. As these conditions are quite rare and imply
performance reductions of the device we don't want to reduce the max
power always.

Therefore give user-space applications the possibility to react
adequately by introducing an over_current_counter in the usb port struct
which is exported via sysfs.

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
Changes v4:
	- reintroduce forgotten Changelog
Changes v3:
	- Improve sysfs file description as recommended by greg k-h
Changes v2:
	- rename oc_count to over_current_count
	- add entry to Documentation/ABI
	- add detailled description to commit message
---
 Documentation/ABI/testing/sysfs-bus-usb | 10 ++++++++++
 drivers/usb/core/hub.c                  |  4 +++-
 drivers/usb/core/hub.h                  |  1 +
 drivers/usb/core/port.c                 | 10 ++++++++++
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
index 0bd731cbb50c..c702c78f24d8 100644
--- a/Documentation/ABI/testing/sysfs-bus-usb
+++ b/Documentation/ABI/testing/sysfs-bus-usb
@@ -189,6 +189,16 @@ Description:
 		The file will read "hotplug", "wired" and "not used" if the
 		information is available, and "unknown" otherwise.
 
+What:		/sys/bus/usb/devices/.../(hub interface)/portX/over_current_count
+Date:		February 2018
+Contact:	Richard Leitner <richard.leitner@skidata.com>
+Description:
+		Most hubs are able to detect over-current situations on their
+		ports and report them to the kernel. This attribute is to expose
+		the number of over-current situation occurred on a specific port
+		to user space. This file will contain an unsigned 32 bit value
+		which wraps to 0 after its maximum is reached.
+
 What:		/sys/bus/usb/devices/.../(hub interface)/portX/usb3_lpm_permit
 Date:		November 2015
 Contact:	Lu Baolu <baolu.lu@linux.intel.com>
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index c5c1f6cf3228..6f779b518e75 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -5104,8 +5104,10 @@ static void port_event(struct usb_hub *hub, int port1)
 
 	if (portchange & USB_PORT_STAT_C_OVERCURRENT) {
 		u16 status = 0, unused;
+		port_dev->over_current_count++;
 
-		dev_dbg(&port_dev->dev, "over-current change\n");
+		dev_dbg(&port_dev->dev, "over-current change #%u\n",
+			port_dev->over_current_count);
 		usb_clear_port_feature(hdev, port1,
 				USB_PORT_FEAT_C_OVER_CURRENT);
 		msleep(100);	/* Cool down */
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index 2a700ccc868c..78d7f4dad618 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -100,6 +100,7 @@ struct usb_port {
 	unsigned int is_superspeed:1;
 	unsigned int usb3_lpm_u1_permit:1;
 	unsigned int usb3_lpm_u2_permit:1;
+	u32 over_current_count;
 };
 
 #define to_usb_port(_dev) \
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index 1a01e9ad3804..6979bde87d31 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -41,6 +41,15 @@ static ssize_t connect_type_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(connect_type);
 
+static ssize_t over_current_count_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct usb_port *port_dev = to_usb_port(dev);
+
+	return sprintf(buf, "%u\n", port_dev->over_current_count);
+}
+static DEVICE_ATTR_RO(over_current_count);
+
 static ssize_t usb3_lpm_permit_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
@@ -109,6 +118,7 @@ static DEVICE_ATTR_RW(usb3_lpm_permit);
 
 static struct attribute *port_dev_attrs[] = {
 	&dev_attr_connect_type.attr,
+	&dev_attr_over_current_count.attr,
 	NULL,
 };
 
-- 
2.11.0
