Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18B8C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F04320818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F04320818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbeKLFsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:48:11 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49678 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730056AbeKLFsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:10 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsW-0000lM-4B; Sun, 11 Nov 2018 19:58:40 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsT-0001ay-4f; Sun, 11 Nov 2018 19:58:37 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>,
        "David Vrabel" <david.vrabel@citrix.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.917619220@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 166/366] xen-netfront: Use static attribute groups
 for sysfs entries
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 27b917e54bed7156c2b0249969ace34a5f585626 upstream.

Instead of manual calls of device_create_file() and
device_remove_files(), assign the static attribute groups to netdev
groups array.  This simplifies the code and avoids the possible
races.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Acked-by: David Vrabel <david.vrabel@citrix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/xen-netfront.c | 62 ++++++++++----------------------------
 1 file changed, 16 insertions(+), 46 deletions(-)

--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -228,11 +228,7 @@ static grant_ref_t xennet_get_rx_ref(str
 }
 
 #ifdef CONFIG_SYSFS
-static int xennet_sysfs_addif(struct net_device *netdev);
-static void xennet_sysfs_delif(struct net_device *netdev);
-#else /* !CONFIG_SYSFS */
-#define xennet_sysfs_addif(dev) (0)
-#define xennet_sysfs_delif(dev) do { } while (0)
+static const struct attribute_group xennet_dev_group;
 #endif
 
 static bool xennet_can_sg(struct net_device *dev)
@@ -1399,20 +1395,15 @@ static int netfront_probe(struct xenbus_
 
 	info = netdev_priv(netdev);
 	dev_set_drvdata(&dev->dev, info);
-
+#ifdef CONFIG_SYSFS
+	info->netdev->sysfs_groups[0] = &xennet_dev_group;
+#endif
 	err = register_netdev(info->netdev);
 	if (err) {
 		pr_warn("%s: register_netdev err=%d\n", __func__, err);
 		goto fail;
 	}
 
-	err = xennet_sysfs_addif(info->netdev);
-	if (err) {
-		unregister_netdev(info->netdev);
-		pr_warn("%s: add sysfs failed err=%d\n", __func__, err);
-		goto fail;
-	}
-
 	return 0;
 
  fail:
@@ -2278,39 +2269,20 @@ static ssize_t show_rxbuf_cur(struct dev
 		return sprintf(buf, "0\n");
 }
 
-static struct device_attribute xennet_attrs[] = {
-	__ATTR(rxbuf_min, S_IRUGO|S_IWUSR, show_rxbuf_min, store_rxbuf_min),
-	__ATTR(rxbuf_max, S_IRUGO|S_IWUSR, show_rxbuf_max, store_rxbuf_max),
-	__ATTR(rxbuf_cur, S_IRUGO, show_rxbuf_cur, NULL),
+static DEVICE_ATTR(rxbuf_min, S_IRUGO|S_IWUSR, show_rxbuf_min, store_rxbuf_min);
+static DEVICE_ATTR(rxbuf_max, S_IRUGO|S_IWUSR, show_rxbuf_max, store_rxbuf_max);
+static DEVICE_ATTR(rxbuf_cur, S_IRUGO, show_rxbuf_cur, NULL);
+
+static struct attribute *xennet_dev_attrs[] = {
+	&dev_attr_rxbuf_min.attr,
+	&dev_attr_rxbuf_max.attr,
+	&dev_attr_rxbuf_cur.attr,
+	NULL
 };
 
-static int xennet_sysfs_addif(struct net_device *netdev)
-{
-	int i;
-	int err;
-
-	for (i = 0; i < ARRAY_SIZE(xennet_attrs); i++) {
-		err = device_create_file(&netdev->dev,
-					   &xennet_attrs[i]);
-		if (err)
-			goto fail;
-	}
-	return 0;
-
- fail:
-	while (--i >= 0)
-		device_remove_file(&netdev->dev, &xennet_attrs[i]);
-	return err;
-}
-
-static void xennet_sysfs_delif(struct net_device *netdev)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(xennet_attrs); i++)
-		device_remove_file(&netdev->dev, &xennet_attrs[i]);
-}
-
+static const struct attribute_group xennet_dev_group = {
+	.attrs = xennet_dev_attrs
+};
 #endif /* CONFIG_SYSFS */
 
 static const struct xenbus_device_id netfront_ids[] = {
@@ -2328,8 +2300,6 @@ static int xennet_remove(struct xenbus_d
 
 	xennet_disconnect_backend(info);
 
-	xennet_sysfs_delif(info->netdev);
-
 	unregister_netdev(info->netdev);
 
 	if (num_queues) {

