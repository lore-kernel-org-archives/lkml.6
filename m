Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74552C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E3120851
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23E3120851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeH1Vts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:49:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:51156 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727040AbeH1Vts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:49:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BDEC0AFCE;
        Tue, 28 Aug 2018 17:56:58 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 6A4EBA0C37; Tue, 28 Aug 2018 19:56:58 +0200 (CEST)
Message-Id: <30b952c097df318a23b9d041ed5d47528aeea97b.1535477409.git.mkubecek@suse.cz>
In-Reply-To: <cover.1535477409.git.mkubecek@suse.cz>
References: <cover.1535477409.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH net-next 2/2] ethtool: drop get_settings and set_settings
 callbacks
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 28 Aug 2018 19:56:58 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since [gs]et_settings ethtool_ops callbacks have been deprecated in
February 2016, all in tree NIC drivers have been converted to provide
[gs]et_link_ksettings() and out of tree drivers have had enough time to do
the same.

Drop get_settings() and set_settings() and implement both ETHTOOL_[GS]SET
and ETHTOOL_[GS]LINKSETTINGS only using [gs]et_link_ksettings().

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 Documentation/ABI/testing/sysfs-class-net |   4 +-
 include/linux/ethtool.h                   |  33 ++---
 include/uapi/linux/ethtool.h              |  15 +-
 net/core/ethtool.c                        | 158 +++++-----------------
 4 files changed, 50 insertions(+), 160 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-net b/Documentation/ABI/testing/sysfs-class-net
index 2f1788111cd9..e2e0fe553ad8 100644
--- a/Documentation/ABI/testing/sysfs-class-net
+++ b/Documentation/ABI/testing/sysfs-class-net
@@ -117,7 +117,7 @@ Description:
 		full: full duplex
 
 		Note: This attribute is only valid for interfaces that implement
-		the ethtool get_settings method (mostly Ethernet).
+		the ethtool get_link_ksettings method (mostly Ethernet).
 
 What:		/sys/class/net/<iface>/flags
 Date:		April 2005
@@ -224,7 +224,7 @@ Description:
 		an integer representing the link speed in Mbits/sec.
 
 		Note: this attribute is only valid for interfaces that implement
-		the ethtool get_settings method (mostly Ethernet ).
+		the ethtool get_link_ksettings method (mostly Ethernet).
 
 What:		/sys/class/net/<iface>/tx_queue_len
 Date:		April 2005
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index f8a2245b70ac..afd9596ce636 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -183,14 +183,6 @@ bool ethtool_convert_link_mode_to_legacy_u32(u32 *legacy_u32,
 
 /**
  * struct ethtool_ops - optional netdev operations
- * @get_settings: DEPRECATED, use %get_link_ksettings/%set_link_ksettings
- *	API. Get various device settings including Ethernet link
- *	settings. The @cmd parameter is expected to have been cleared
- *	before get_settings is called. Returns a negative error code
- *	or zero.
- * @set_settings: DEPRECATED, use %get_link_ksettings/%set_link_ksettings
- *	API. Set various device settings including Ethernet link
- *	settings.  Returns a negative error code or zero.
  * @get_drvinfo: Report driver/device information.  Should only set the
  *	@driver, @version, @fw_version and @bus_info fields.  If not
  *	implemented, the @driver and @bus_info fields will be filled in
@@ -297,19 +289,16 @@ bool ethtool_convert_link_mode_to_legacy_u32(u32 *legacy_u32,
  *	a TX queue has this number, return -EINVAL. If only a RX queue or a TX
  *	queue has this number, ignore the inapplicable fields.
  *	Returns a negative error code or zero.
- * @get_link_ksettings: When defined, takes precedence over the
- *	%get_settings method. Get various device settings
- *	including Ethernet link settings. The %cmd and
- *	%link_mode_masks_nwords fields should be ignored (use
- *	%__ETHTOOL_LINK_MODE_MASK_NBITS instead of the latter), any
- *	change to them will be overwritten by kernel. Returns a
- *	negative error code or zero.
- * @set_link_ksettings: When defined, takes precedence over the
- *	%set_settings method. Set various device settings including
- *	Ethernet link settings. The %cmd and %link_mode_masks_nwords
- *	fields should be ignored (use %__ETHTOOL_LINK_MODE_MASK_NBITS
- *	instead of the latter), any change to them will be overwritten
- *	by kernel. Returns a negative error code or zero.
+ * @get_link_ksettings: Get various device settings including Ethernet link
+ *	settings. The %cmd and %link_mode_masks_nwords fields should be
+ *	ignored (use %__ETHTOOL_LINK_MODE_MASK_NBITS instead of the latter),
+ *	any change to them will be overwritten by kernel. Returns a negative
+ *	error code or zero.
+ * @set_link_ksettings: Set various device settings including Ethernet link
+ *	settings. The %cmd and %link_mode_masks_nwords fields should be
+ *	ignored (use %__ETHTOOL_LINK_MODE_MASK_NBITS instead of the latter),
+ *	any change to them will be overwritten by kernel. Returns a negative
+ *	error code or zero.
  * @get_fecparam: Get the network device Forward Error Correction parameters.
  * @set_fecparam: Set the network device Forward Error Correction parameters.
  * @get_ethtool_phy_stats: Return extended statistics about the PHY device.
@@ -329,8 +318,6 @@ bool ethtool_convert_link_mode_to_legacy_u32(u32 *legacy_u32,
  * of the generic netdev features interface.
  */
 struct ethtool_ops {
-	int	(*get_settings)(struct net_device *, struct ethtool_cmd *);
-	int	(*set_settings)(struct net_device *, struct ethtool_cmd *);
 	void	(*get_drvinfo)(struct net_device *, struct ethtool_drvinfo *);
 	int	(*get_regs_len)(struct net_device *);
 	void	(*get_regs)(struct net_device *, struct ethtool_regs *, void *);
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index dc69391d2bba..c8f8e2455bf3 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -91,10 +91,6 @@
  * %ETHTOOL_GSET to get the current values before making specific
  * changes and then applying them with %ETHTOOL_SSET.
  *
- * Drivers that implement set_settings() should validate all fields
- * other than @cmd that are not described as read-only or deprecated,
- * and must ignore all fields described as read-only.
- *
  * Deprecated fields should be ignored by both users and drivers.
  */
 struct ethtool_cmd {
@@ -1800,14 +1796,9 @@ enum ethtool_reset_flags {
  * rejected.
  *
  * Deprecated %ethtool_cmd fields transceiver, maxtxpkt and maxrxpkt
- * are not available in %ethtool_link_settings. Until all drivers are
- * converted to ignore them or to the new %ethtool_link_settings API,
- * for both queries and changes, users should always try
- * %ETHTOOL_GLINKSETTINGS first, and if it fails with -ENOTSUPP stick
- * only to %ETHTOOL_GSET and %ETHTOOL_SSET consistently. If it
- * succeeds, then users should stick to %ETHTOOL_GLINKSETTINGS and
- * %ETHTOOL_SLINKSETTINGS (which would support drivers implementing
- * either %ethtool_cmd or %ethtool_link_settings).
+ * are not available in %ethtool_link_settings. These fields will be
+ * always set to zero in %ETHTOOL_GSET reply and %ETHTOOL_SSET will
+ * fail if any of them is set to non-zero value.
  *
  * Users should assume that all fields not marked read-only are
  * writable and subject to validation by the driver.  They should use
diff --git a/net/core/ethtool.c b/net/core/ethtool.c
index c9993c6c2fd4..9d4e56d97080 100644
--- a/net/core/ethtool.c
+++ b/net/core/ethtool.c
@@ -539,47 +539,17 @@ struct ethtool_link_usettings {
 	} link_modes;
 };
 
-/* Internal kernel helper to query a device ethtool_link_settings.
- *
- * Backward compatibility note: for compatibility with legacy drivers
- * that implement only the ethtool_cmd API, this has to work with both
- * drivers implementing get_link_ksettings API and drivers
- * implementing get_settings API. When drivers implement get_settings
- * and report ethtool_cmd deprecated fields
- * (transceiver/maxrxpkt/maxtxpkt), these fields are silently ignored
- * because the resulting struct ethtool_link_settings does not report them.
- */
+/* Internal kernel helper to query a device ethtool_link_settings. */
 int __ethtool_get_link_ksettings(struct net_device *dev,
 				 struct ethtool_link_ksettings *link_ksettings)
 {
-	int err;
-	struct ethtool_cmd cmd;
-
 	ASSERT_RTNL();
 
-	if (dev->ethtool_ops->get_link_ksettings) {
-		memset(link_ksettings, 0, sizeof(*link_ksettings));
-		return dev->ethtool_ops->get_link_ksettings(dev,
-							    link_ksettings);
-	}
-
-	/* driver doesn't support %ethtool_link_ksettings API. revert to
-	 * legacy %ethtool_cmd API, unless it's not supported either.
-	 * TODO: remove when ethtool_ops::get_settings disappears internally
-	 */
-	if (!dev->ethtool_ops->get_settings)
+	if (!dev->ethtool_ops->get_link_ksettings)
 		return -EOPNOTSUPP;
 
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.cmd = ETHTOOL_GSET;
-	err = dev->ethtool_ops->get_settings(dev, &cmd);
-	if (err < 0)
-		return err;
-
-	/* we ignore deprecated fields transceiver/maxrxpkt/maxtxpkt
-	 */
-	convert_legacy_settings_to_link_ksettings(link_ksettings, &cmd);
-	return err;
+	memset(link_ksettings, 0, sizeof(*link_ksettings));
+	return dev->ethtool_ops->get_link_ksettings(dev, link_ksettings);
 }
 EXPORT_SYMBOL(__ethtool_get_link_ksettings);
 
@@ -635,16 +605,7 @@ store_link_ksettings_for_user(void __user *to,
 	return 0;
 }
 
-/* Query device for its ethtool_link_settings.
- *
- * Backward compatibility note: this function must fail when driver
- * does not implement ethtool::get_link_ksettings, even if legacy
- * ethtool_ops::get_settings is implemented. This tells new versions
- * of ethtool that they should use the legacy API %ETHTOOL_GSET for
- * this driver, so that they can correctly access the ethtool_cmd
- * deprecated fields (transceiver/maxrxpkt/maxtxpkt), until no driver
- * implements ethtool_ops::get_settings anymore.
- */
+/* Query device for its ethtool_link_settings. */
 static int ethtool_get_link_ksettings(struct net_device *dev,
 				      void __user *useraddr)
 {
@@ -652,7 +613,6 @@ static int ethtool_get_link_ksettings(struct net_device *dev,
 	struct ethtool_link_ksettings link_ksettings;
 
 	ASSERT_RTNL();
-
 	if (!dev->ethtool_ops->get_link_ksettings)
 		return -EOPNOTSUPP;
 
@@ -699,16 +659,7 @@ static int ethtool_get_link_ksettings(struct net_device *dev,
 	return store_link_ksettings_for_user(useraddr, &link_ksettings);
 }
 
-/* Update device ethtool_link_settings.
- *
- * Backward compatibility note: this function must fail when driver
- * does not implement ethtool::set_link_ksettings, even if legacy
- * ethtool_ops::set_settings is implemented. This tells new versions
- * of ethtool that they should use the legacy API %ETHTOOL_SSET for
- * this driver, so that they can correctly update the ethtool_cmd
- * deprecated fields (transceiver/maxrxpkt/maxtxpkt), until no driver
- * implements ethtool_ops::get_settings anymore.
- */
+/* Update device ethtool_link_settings. */
 static int ethtool_set_link_ksettings(struct net_device *dev,
 				      void __user *useraddr)
 {
@@ -746,51 +697,31 @@ static int ethtool_set_link_ksettings(struct net_device *dev,
 
 /* Query device for its ethtool_cmd settings.
  *
- * Backward compatibility note: for compatibility with legacy ethtool,
- * this has to work with both drivers implementing get_link_ksettings
- * API and drivers implementing get_settings API. When drivers
- * implement get_link_ksettings and report higher link mode bits, a
- * kernel warning is logged once (with name of 1st driver/device) to
- * recommend user to upgrade ethtool, but the command is successful
- * (only the lower link mode bits reported back to user).
+ * Backward compatibility note: for compatibility with legacy ethtool, this is
+ * now implemented via get_link_ksettings. When driver reports higher link mode
+ * bits, a kernel warning is logged once (with name of 1st driver/device) to
+ * recommend user to upgrade ethtool, but the command is successful (only the
+ * lower link mode bits reported back to user). Deprecated fields from
+ * ethtool_cmd (transceiver/maxrxpkt/maxtxpkt) are always set to zero.
  */
 static int ethtool_get_settings(struct net_device *dev, void __user *useraddr)
 {
+	struct ethtool_link_ksettings link_ksettings;
 	struct ethtool_cmd cmd;
+	int err;
 
 	ASSERT_RTNL();
+	if (!dev->ethtool_ops->get_link_ksettings)
+		return -EOPNOTSUPP;
 
-	if (dev->ethtool_ops->get_link_ksettings) {
-		/* First, use link_ksettings API if it is supported */
-		int err;
-		struct ethtool_link_ksettings link_ksettings;
-
-		memset(&link_ksettings, 0, sizeof(link_ksettings));
-		err = dev->ethtool_ops->get_link_ksettings(dev,
-							   &link_ksettings);
-		if (err < 0)
-			return err;
-		convert_link_ksettings_to_legacy_settings(&cmd,
-							  &link_ksettings);
-
-		/* send a sensible cmd tag back to user */
-		cmd.cmd = ETHTOOL_GSET;
-	} else {
-		/* driver doesn't support %ethtool_link_ksettings
-		 * API. revert to legacy %ethtool_cmd API, unless it's
-		 * not supported either.
-		 */
-		int err;
-
-		if (!dev->ethtool_ops->get_settings)
-			return -EOPNOTSUPP;
+	memset(&link_ksettings, 0, sizeof(link_ksettings));
+	err = dev->ethtool_ops->get_link_ksettings(dev, &link_ksettings);
+	if (err < 0)
+		return err;
+	convert_link_ksettings_to_legacy_settings(&cmd, &link_ksettings);
 
-		memset(&cmd, 0, sizeof(cmd));
-		cmd.cmd = ETHTOOL_GSET;
-		err = dev->ethtool_ops->get_settings(dev, &cmd);
-		if (err < 0)
-			return err;
-	}
+	/* send a sensible cmd tag back to user */
+	cmd.cmd = ETHTOOL_GSET;
 
 	if (copy_to_user(useraddr, &cmd, sizeof(cmd)))
 		return -EFAULT;
@@ -800,48 +731,29 @@ static int ethtool_get_settings(struct net_device *dev, void __user *useraddr)
 
 /* Update device link settings with given ethtool_cmd.
  *
- * Backward compatibility note: for compatibility with legacy ethtool,
- * this has to work with both drivers implementing set_link_ksettings
- * API and drivers implementing set_settings API. When drivers
- * implement set_link_ksettings and user's request updates deprecated
- * ethtool_cmd fields (transceiver/maxrxpkt/maxtxpkt), a kernel
- * warning is logged once (with name of 1st driver/device) to
- * recommend user to upgrade ethtool, and the request is rejected.
+ * Backward compatibility note: for compatibility with legacy ethtool, this is
+ * now always implemented via set_link_settings. When user's request updates
+ * deprecated ethtool_cmd fields (transceiver/maxrxpkt/maxtxpkt), a kernel
+ * warning is logged once (with name of 1st driver/device) to recommend user to
+ * upgrade ethtool, and the request is rejected.
  */
 static int ethtool_set_settings(struct net_device *dev, void __user *useraddr)
 {
+	struct ethtool_link_ksettings link_ksettings;
 	struct ethtool_cmd cmd;
 
 	ASSERT_RTNL();
 
 	if (copy_from_user(&cmd, useraddr, sizeof(cmd)))
 		return -EFAULT;
-
-	/* first, try new %ethtool_link_ksettings API. */
-	if (dev->ethtool_ops->set_link_ksettings) {
-		struct ethtool_link_ksettings link_ksettings;
-
-		if (!convert_legacy_settings_to_link_ksettings(&link_ksettings,
-							       &cmd))
-			return -EINVAL;
-
-		link_ksettings.base.cmd = ETHTOOL_SLINKSETTINGS;
-		link_ksettings.base.link_mode_masks_nwords
-			= __ETHTOOL_LINK_MODE_MASK_NU32;
-		return dev->ethtool_ops->set_link_ksettings(dev,
-							    &link_ksettings);
-	}
-
-	/* legacy %ethtool_cmd API */
-
-	/* TODO: return -EOPNOTSUPP when ethtool_ops::get_settings
-	 * disappears internally
-	 */
-
-	if (!dev->ethtool_ops->set_settings)
+	if (!dev->ethtool_ops->set_link_ksettings)
 		return -EOPNOTSUPP;
 
-	return dev->ethtool_ops->set_settings(dev, &cmd);
+	if (!convert_legacy_settings_to_link_ksettings(&link_ksettings, &cmd))
+		return -EINVAL;
+	link_ksettings.base.link_mode_masks_nwords =
+		__ETHTOOL_LINK_MODE_MASK_NU32;
+	return dev->ethtool_ops->set_link_ksettings(dev, &link_ksettings);
 }
 
 static noinline_for_stack int ethtool_get_drvinfo(struct net_device *dev,
-- 
2.18.0

