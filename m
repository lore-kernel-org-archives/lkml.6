Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3B7ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9633E204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pPA9OO6W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9633E204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeJQVTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:19:48 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58543 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeJQVTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:19:48 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181017132405euoutp02005d68ab1e0ef2ca264267500000b78c~eaCh62nEj0173801738euoutp02n;
        Wed, 17 Oct 2018 13:24:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181017132405euoutp02005d68ab1e0ef2ca264267500000b78c~eaCh62nEj0173801738euoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539782645;
        bh=GjM3hXLpGpu2oLx0y/QxqDKTrt2I5BaXddjRV+9RukY=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=pPA9OO6W0HBaEG5kfKHSoOYGCm/rdxkGWb70B2J715tBhcm11QSV44Ibm93n7Cj7Z
         SQVS1i9A7E4BMxJY/N/D0W5njoJ8UBFS2z05LYK05IlfDyIUI+jTepJA7ijkuOKKWM
         9nInjC6SMODKKBQg+xSSs8a69KiHvLJmbd9F0uIA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181017132405eucas1p2aad685ce534a2bf2915e154781498620~eaChUXMkH2955629556eucas1p20;
        Wed, 17 Oct 2018 13:24:05 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 3D.0A.04294.4F737CB5; Wed, 17
        Oct 2018 14:24:04 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181017132404eucas1p2a413f6853af8f11a874650b6289d56cf~eaCgnAlOV1251312513eucas1p2D;
        Wed, 17 Oct 2018 13:24:04 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-c1-5bc737f41b86
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 15.4F.04284.4F737CB5; Wed, 17
        Oct 2018 14:24:04 +0100 (BST)
Received: from AMDC2768.DIGITAL.local ([106.120.43.17]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PGQ00EGYVW3RX40@eusync1.samsung.com>;
        Wed, 17 Oct 2018 14:24:04 +0100 (BST)
From:   Andrzej Hajda <a.hajda@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-arm-kernel@lists.infradead.org, andy.shevchenko@gmail.com,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: [PATCH v3 2/4] driver core: add deferring probe reason to
 devices_deferred property
Date:   Wed, 17 Oct 2018 15:24:00 +0200
Message-id: <20181017132400.5300-1-a.hajda@samsung.com>
X-Mailer: git-send-email 2.18.0
In-reply-to: <CAHp75Vd2c3sHz=ZObsNAyEmOK-=__2=y-soDM5DqNUyLLK8jdA@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsWy7djP87pfzI9HG9zq0ra4te4cq8XLCYcZ
        LTbOWM9qMfXhEzaL5sXr2SwWTlvOaLHp8TVWi8u75rBZHJq6l9Fi7ZG77BZzv0xlduD2uHzt
        IrPHzll32T02repk89g/dw27x+Yl9R7v911l8+jbsorR4/MmuQCOKC6blNSczLLUIn27BK6M
        FV0PWQuOqlY0Nd1mbmCcKt/FyMkhIWAisWRbNxuILSSwglFi9yyNLkYuIPszo0Tjz1vsMEXn
        vxxjhEgsY5Ro6n3ADOH8Z5Q4eaaNEaSKTUBT4u/mm2CjRASMJfrPzmIHKWIWmMcs8fLVHSaQ
        hLBAnMS5k+vBilgEVCU6Pm0Gi/MKmEtMmH0Cap28xMPj7WBDOQWCJdY3nmUCGSQhsIdNYl/X
        XEaIIheJN/dfsEDYwhKvjm+BapaR6Ow4yARh10s0zbzCDNHcwShxYvFyNoiEtcTh4xdZQWxm
        AT6JSdumAxVxAMV5JTrahCBKPCRO3r7CBvHmEkaJYw+Ps0xglFzAyLCKUTy1tDg3PbXYKC+1
        XK84Mbe4NC9dLzk/dxMjMI5P/zv+ZQfjrj9JhxgFOBiVeHh3iB2LFmJNLCuuzD3EKMHBrCTC
        W6V4PFqINyWxsiq1KD++qDQntfgQozQHi5I477J5G6OFBNITS1KzU1MLUotgskwcnFINjNaC
        IlrL4nkyvWY9fB39KETFRHyr35O1uV9Dils2TD77eGKDb6xqp2V594w7uq2Gt6YYixgkHG9L
        zLn11PFDgtnJ3V3Bv6qfTToQYeG/QyRxfztfm6Rsr2VkVR33hPVyc7Yo26k7pKzYbm2xVf76
        lquWJ4Ne7tonGDHBVXcDw8zU2jqF1g/1SizFGYmGWsxFxYkAAnDQct8CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsVy+t/xy7pfzI9HGzz7zWdxa905VouXEw4z
        WmycsZ7VYurDJ2wWzYvXs1ksnLac0WLT42usFpd3zWGzODR1L6PF2iN32S3mfpnK7MDtcfna
        RWaPnbPusntsWtXJ5rF/7hp2j81L6j3e77vK5tG3ZRWjx+dNcgEcUVw2Kak5mWWpRfp2CVwZ
        K7oeshYcVa1oarrN3MA4Vb6LkZNDQsBE4vyXY4xdjFwcQgJLGCXuLDrHCuE0Mkn0/3vFBFLF
        JqAp8XfzTTYQW0TAWKL/7Cx2kCJmgUXMEnvX7WMFSQgLxEmcO7kerIhFQFWi49NmsGZeAXOJ
        CbNPsEOsk5d4eLydEcTmFAiWOPxmCguILSQQIHFrbhPzBEaeBYwMqxhFUkuLc9Nziw31ihNz
        i0vz0vWS83M3MQJDcNuxn5t3MF7aGHyIUYCDUYmHd4fYsWgh1sSy4srcQ4wSHMxKIrxVisej
        hXhTEiurUovy44tKc1KLDzFKc7AoifOeN6iMEhJITyxJzU5NLUgtgskycXBKNTCWR3muPvRt
        75aln+Y9O+N1+Kbmj9Jvq/eZXIv60X843M4poX5th+acv+5f9uUf+m/weOeUhX5+6fnT1PUe
        GW3d3h2/QWynQ+KzYKXGkqVM83jKbt2KV1Jwrhb4cWvyoz+bwm9Ib5z+O81n29RKR5mqt1ve
        aG50Zmk8GGa7/MCtLx+un2i7/dC4TYmlOCPRUIu5qDgRAOvtZiQ9AgAA
X-CMS-MailID: 20181017132404eucas1p2a413f6853af8f11a874650b6289d56cf
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181017132404eucas1p2a413f6853af8f11a874650b6289d56cf
References: <CAHp75Vd2c3sHz=ZObsNAyEmOK-=__2=y-soDM5DqNUyLLK8jdA@mail.gmail.com>
        <CGME20181017132404eucas1p2a413f6853af8f11a874650b6289d56cf@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/sys/kernel/debug/devices_deferred property contains list of deferred devices.
This list does not contain reason why the driver deferred probe, the patch
improves it.
The natural place to set the reason is probe_err function introduced recently,
ie. if probe_err will be called with -EPROBE_DEFER instead of printk the message
will be attached to deferred device and printed when user read devices_deferred
property.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
v3:
  - adjusted deferred_devs_show, to accept newline ended messages,
  - changed conditonal check to positive,
  - added R-b by Andy.
v2:
  - changed __deferred_probe_set_msg args - like in __dev_printk, fits better,
  - use kasprintf instead of bunch of code,
  - keep consistent format of devices_deferred lines,
  - added R-Bs (again I hope changes above are not against it).
---
 drivers/base/base.h |  3 +++
 drivers/base/core.c |  9 +++++----
 drivers/base/dd.c   | 21 ++++++++++++++++++++-
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 7a419a7a6235..effbd5e7f9f1 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -75,6 +75,7 @@ struct device_private {
 	struct klist_node knode_driver;
 	struct klist_node knode_bus;
 	struct list_head deferred_probe;
+	char *deferred_probe_msg;
 	struct device *device;
 };
 #define to_device_private_parent(obj)	\
@@ -113,6 +114,8 @@ extern void device_release_driver_internal(struct device *dev,
 extern void driver_detach(struct device_driver *drv);
 extern int driver_probe_device(struct device_driver *drv, struct device *dev);
 extern void driver_deferred_probe_del(struct device *dev);
+extern void __deferred_probe_set_msg(const struct device *dev,
+				     struct va_format *vaf);
 static inline int driver_match_device(struct device_driver *drv,
 				      struct device *dev)
 {
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 1f3e99c2ef03..27990110fb24 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3076,6 +3076,7 @@ define_dev_printk_level(_dev_info, KERN_INFO);
  *
  * This helper implements common pattern present in probe functions for error
  * checking: print message if the error is not -EPROBE_DEFER and propagate it.
+ * In case of -EPROBE_DEFER it sets defer probe reason.
  * It replaces code sequence:
  * 	if (err != -EPROBE_DEFER)
  * 		dev_err(dev, ...);
@@ -3091,14 +3092,14 @@ int probe_err(const struct device *dev, int err, const char *fmt, ...)
 	struct va_format vaf;
 	va_list args;
 
-	if (err == -EPROBE_DEFER)
-		return err;
-
 	va_start(args, fmt);
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	dev_err(dev, "error %d: %pV", err, &vaf);
+	if (err == -EPROBE_DEFER)
+		__deferred_probe_set_msg(dev, &vaf);
+	else
+		dev_err(dev, "error %d: %pV", err, &vaf);
 
 	va_end(args);
 
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 169412ee4ae8..6e488146b328 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -27,6 +27,7 @@
 #include <linux/async.h>
 #include <linux/pm_runtime.h>
 #include <linux/pinctrl/devinfo.h>
+#include <linux/slab.h>
 
 #include "base.h"
 #include "power/power.h"
@@ -132,6 +133,8 @@ void driver_deferred_probe_del(struct device *dev)
 	if (!list_empty(&dev->p->deferred_probe)) {
 		dev_dbg(dev, "Removed from deferred list\n");
 		list_del_init(&dev->p->deferred_probe);
+		kfree(dev->p->deferred_probe_msg);
+		dev->p->deferred_probe_msg = NULL;
 	}
 	mutex_unlock(&deferred_probe_mutex);
 }
@@ -202,6 +205,21 @@ void device_unblock_probing(void)
 	driver_deferred_probe_trigger();
 }
 
+/*
+ * __deferred_probe_set_msg() - Set defer probe reason message for device
+ */
+void __deferred_probe_set_msg(const struct device *dev, struct va_format *vaf)
+{
+	mutex_lock(&deferred_probe_mutex);
+
+	if (dev->p->deferred_probe_msg)
+		kfree(dev->p->deferred_probe_msg);
+	dev->p->deferred_probe_msg = kasprintf(GFP_KERNEL, "%s: %pV",
+					       dev_driver_string(dev), vaf);
+
+	mutex_unlock(&deferred_probe_mutex);
+}
+
 /*
  * deferred_devs_show() - Show the devices in the deferred probe pending list.
  */
@@ -212,7 +230,8 @@ static int deferred_devs_show(struct seq_file *s, void *data)
 	mutex_lock(&deferred_probe_mutex);
 
 	list_for_each_entry(curr, &deferred_probe_pending_list, deferred_probe)
-		seq_printf(s, "%s\n", dev_name(curr->device));
+		seq_printf(s, "%s\t%s", dev_name(curr->device),
+			   curr->device->p->deferred_probe_msg ?: "\n");
 
 	mutex_unlock(&deferred_probe_mutex);
 
-- 
2.18.0

