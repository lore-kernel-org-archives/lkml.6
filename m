Return-Path: <mika.westerberg@linux.intel.com>
X-Google-Smtp-Source: AG47ELtnpft+FPlylY8YrWbAY0vx5qmPJbLEtVBWcBgEH4a9rYfw3Guvwl7UJLDJnX5FtkMSbTRM
ARC-Seal: i=1; a=rsa-sha256; t=1521476832; cv=none;
        d=google.com; s=arc-20160816;
        b=WUmtM/lSosrnEaCWbyEmM2twY2S0VNMehfgx1xni8TNiPZWnzV4tYp/U2os8OBq0Zm
         Pt91c8UNOsLjls5p/k2gORwnPM0m6Ps5DMVM3MZVWb4u383GSlyp5Kr36Qjm5sN1HgDQ
         chlwtgsItT624cgsFpPnIXbCteCelChqIpP6C4KjmaDWAEcdXjM05h84p+ZLW9dTKZAg
         0ZbX+MYfNkOafaTUme2zrJzmg4VXJqpyRwNmGpGL0alNVTy6eVq62KwJpAkxa+B6cZNB
         32NzMmWWcNlAXuR9CI1qfcPAwkBAYTbgsRNiR9wlTC4t2nWbxsVZJazy+9iX42trWNJJ
         CMcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=ggBDpIg2Jxi+CGC5UaGexGNvF36k4x62Npo10GebflE=;
        b=PptCQybzn2vq9D+Ep9HtijN7fJqp5FmS/gwK56cSF1WiaHFrKnfPYx+lccpDZZ4kCa
         dwUyXdV5P0U23AJ96ezB8paJrGEtHo7F9n71sj7xbg0FQOaWEYGyzeypuo69BTvUkC1L
         qOF4VLuJ+WwYqzqmzJJiVe0UKPJP10q7pEmlx3R1rXf45akV+/aIWxLmWouQHCJnrbhs
         4NHACvARvvYhFsSUA8PtbeicRYKuOWAdZomkAURwQPL6RaJGFNZnzEMKVk/Zq391S0QJ
         M0EWFW622Yf1x0WW2hNZeWB6//EnnHCsASKomGJ5OtRiBrUvTRAcK2mXnVPtzFBSimcv
         G1hw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,331,1517904000";
   d="scan'208";a="36279907"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <yehezkel.bernat@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/19] thunderbolt: Add 'boot' attribute for devices
Date: Mon, 19 Mar 2018 19:26:59 +0300
Message-Id: <20180319162703.5331-16-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319162703.5331-1-mika.westerberg@linux.intel.com>
References: <20180319162703.5331-1-mika.westerberg@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595384091184196772?=
X-GMAIL-MSGID: =?utf-8?q?1595384091184196772?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Yehezkel Bernat <yehezkel.bernat@intel.com>

In various cases, Thunderbolt device can be connected by ICM on boot
without waiting for approval from user. Most cases are related to
OEM-specific BIOS configurations. This information is interesting for
user-space as if the device isn't in SW ACL, it may create a friction in
the user experience where the device is automatically authorized if it's
connected on boot but requires an explicit user action if connected
after OS is up. User-space can use this information to suggest adding
the device to SW ACL for auto-authorization on later connections.

Signed-off-by: Yehezkel Bernat <yehezkel.bernat@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-thunderbolt |  7 +++++++
 drivers/thunderbolt/icm.c                       | 12 ++++++++----
 drivers/thunderbolt/switch.c                    | 14 ++++++++++++++
 drivers/thunderbolt/tb.h                        |  2 ++
 drivers/thunderbolt/tb_msgs.h                   |  1 +
 5 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-thunderbolt b/Documentation/ABI/testing/sysfs-bus-thunderbolt
index 93798c02e28b..1f145b727d76 100644
--- a/Documentation/ABI/testing/sysfs-bus-thunderbolt
+++ b/Documentation/ABI/testing/sysfs-bus-thunderbolt
@@ -38,6 +38,13 @@ Description:	This attribute is used to authorize Thunderbolt devices
 		   the device did not contain a key at all, and
 		   EKEYREJECTED if the challenge response did not match.
 
+What: /sys/bus/thunderbolt/devices/.../boot
+Date:		Jun 2018
+KernelVersion:	4.17
+Contact:	thunderbolt-software@lists.01.org
+Description:	This attribute contains 1 if Thunderbolt device was already
+		authorized on boot and 0 otherwise.
+
 What: /sys/bus/thunderbolt/devices/.../key
 Date:		Sep 2017
 KernelVersion:	4.13
diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 5d3cd740b71f..bece5540b06b 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -402,7 +402,7 @@ static int icm_fr_disconnect_xdomain_paths(struct tb *tb, struct tb_xdomain *xd)
 static void add_switch(struct tb_switch *parent_sw, u64 route,
 		       const uuid_t *uuid, u8 connection_id, u8 connection_key,
 		       u8 link, u8 depth, enum tb_security_level security_level,
-		       bool authorized)
+		       bool authorized, bool boot)
 {
 	struct tb_switch *sw;
 
@@ -417,6 +417,7 @@ static void add_switch(struct tb_switch *parent_sw, u64 route,
 	sw->depth = depth;
 	sw->authorized = authorized;
 	sw->security_level = security_level;
+	sw->boot = boot;
 
 	/* Link the two switches now */
 	tb_port_at(route, parent_sw)->remote = tb_upstream_port(sw);
@@ -431,7 +432,7 @@ static void add_switch(struct tb_switch *parent_sw, u64 route,
 
 static void update_switch(struct tb_switch *parent_sw, struct tb_switch *sw,
 			  u64 route, u8 connection_id, u8 connection_key,
-			  u8 link, u8 depth)
+			  u8 link, u8 depth, bool boot)
 {
 	/* Disconnect from parent */
 	tb_port_at(tb_route(sw), parent_sw)->remote = NULL;
@@ -445,6 +446,7 @@ static void update_switch(struct tb_switch *parent_sw, struct tb_switch *sw,
 	sw->connection_key = connection_key;
 	sw->link = link;
 	sw->depth = depth;
+	sw->boot = boot;
 
 	/* This switch still exists */
 	sw->is_unplugged = false;
@@ -504,6 +506,7 @@ icm_fr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 	bool authorized = false;
 	struct tb_xdomain *xd;
 	u8 link, depth;
+	bool boot;
 	u64 route;
 	int ret;
 
@@ -513,6 +516,7 @@ icm_fr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 	authorized = pkg->link_info & ICM_LINK_INFO_APPROVED;
 	security_level = (pkg->hdr.flags & ICM_FLAGS_SLEVEL_MASK) >>
 			 ICM_FLAGS_SLEVEL_SHIFT;
+	boot = pkg->link_info & ICM_LINK_INFO_BOOT;
 
 	if (pkg->link_info & ICM_LINK_INFO_REJECTED) {
 		tb_info(tb, "switch at %u.%u was rejected by ICM firmware because topology limit exceeded\n",
@@ -546,7 +550,7 @@ icm_fr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 		if (sw->depth == depth && sw_phy_port == phy_port &&
 		    !!sw->authorized == authorized) {
 			update_switch(parent_sw, sw, route, pkg->connection_id,
-				      pkg->connection_key, link, depth);
+				      pkg->connection_key, link, depth, boot);
 			tb_switch_put(sw);
 			return;
 		}
@@ -595,7 +599,7 @@ icm_fr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 
 	add_switch(parent_sw, route, &pkg->ep_uuid, pkg->connection_id,
 		   pkg->connection_key, link, depth, security_level,
-		   authorized);
+		   authorized, boot);
 
 	tb_switch_put(parent_sw);
 }
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 4e2b2097bbfc..e9e30aaab2a3 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -775,6 +775,15 @@ static ssize_t authorized_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(authorized);
 
+static ssize_t boot_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct tb_switch *sw = tb_to_switch(dev);
+
+	return sprintf(buf, "%u\n", sw->boot);
+}
+static DEVICE_ATTR_RO(boot);
+
 static ssize_t device_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
@@ -951,6 +960,7 @@ static DEVICE_ATTR_RO(unique_id);
 
 static struct attribute *switch_attrs[] = {
 	&dev_attr_authorized.attr,
+	&dev_attr_boot.attr,
 	&dev_attr_device.attr,
 	&dev_attr_device_name.attr,
 	&dev_attr_key.attr,
@@ -979,6 +989,10 @@ static umode_t switch_attr_is_visible(struct kobject *kobj,
 		if (sw->dma_port)
 			return attr->mode;
 		return 0;
+	} else if (attr == &dev_attr_boot.attr) {
+		if (tb_route(sw))
+			return attr->mode;
+		return 0;
 	}
 
 	return sw->safe_mode ? 0 : attr->mode;
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 2cd6085a6e10..9c9cef875ca8 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -66,6 +66,7 @@ struct tb_switch_nvm {
  * @nvm: Pointer to the NVM if the switch has one (%NULL otherwise)
  * @no_nvm_upgrade: Prevent NVM upgrade of this switch
  * @safe_mode: The switch is in safe-mode
+ * @boot: Whether the switch was already authorized on boot or not
  * @authorized: Whether the switch is authorized by user or policy
  * @work: Work used to automatically authorize a switch
  * @security_level: Switch supported security level
@@ -99,6 +100,7 @@ struct tb_switch {
 	struct tb_switch_nvm *nvm;
 	bool no_nvm_upgrade;
 	bool safe_mode;
+	bool boot;
 	unsigned int authorized;
 	struct work_struct work;
 	enum tb_security_level security_level;
diff --git a/drivers/thunderbolt/tb_msgs.h b/drivers/thunderbolt/tb_msgs.h
index 931db2a7c7b3..9f52f842257a 100644
--- a/drivers/thunderbolt/tb_msgs.h
+++ b/drivers/thunderbolt/tb_msgs.h
@@ -179,6 +179,7 @@ struct icm_fr_event_device_connected {
 #define ICM_LINK_INFO_DEPTH_MASK	GENMASK(7, 4)
 #define ICM_LINK_INFO_APPROVED		BIT(8)
 #define ICM_LINK_INFO_REJECTED		BIT(9)
+#define ICM_LINK_INFO_BOOT		BIT(10)
 
 struct icm_fr_pkg_approve_device {
 	struct icm_pkg_header hdr;
-- 
2.16.2
