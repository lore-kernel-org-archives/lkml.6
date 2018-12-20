Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F8EC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A664721741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pWzG0FXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbeLTKXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 05:23:05 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49236 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbeLTKXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 05:23:03 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181220102301euoutp011d2f8fa81597595e91faf4c075aef9fd~yA2s7z1h71726317263euoutp01C;
        Thu, 20 Dec 2018 10:23:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181220102301euoutp011d2f8fa81597595e91faf4c075aef9fd~yA2s7z1h71726317263euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545301381;
        bh=xiRdmEIjOQ4EiEDf+t5yeCMyixU5eUBvPbNazTa7hqM=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=pWzG0FXzJIQVwYsxGZlr6+9ofFku2EJ6LpGNB7Futel5If04FYse9mPCihyH4tvLo
         HWBxYbT/kM2VyB/jKCcSL+h7MsEpHrgF8DNXBPSm0z1gKJRdLzrA/gelE51mQ+Xj1b
         jm+yctrVbetmtcPOR97M9zJ8o8dConj1wJb5jyY4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181220102300eucas1p2be6910aca112870eb95bf44d54f87d75~yA2sdmyvI0424004240eucas1p2B;
        Thu, 20 Dec 2018 10:23:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B1.78.04806.48D6B1C5; Thu, 20
        Dec 2018 10:23:00 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181220102259eucas1p1884a0b68ce342239c2a43a74cc50725a~yA2rdSQbY1464414644eucas1p1Q;
        Thu, 20 Dec 2018 10:22:59 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-b5-5c1b6d84646f
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 78.6E.04128.38D6B1C5; Thu, 20
        Dec 2018 10:22:59 +0000 (GMT)
Received: from AMDC3748.DIGITAL.local ([106.120.43.17]) by
        eusync3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PK100480669SP10@eusync3.samsung.com>;
        Thu, 20 Dec 2018 10:22:59 +0000 (GMT)
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
Subject: [PATCH v4 2/3] driver core: add deferring probe reason to
 devices_deferred property
Date:   Thu, 20 Dec 2018 11:22:46 +0100
Message-id: <20181220102247.4911-3-a.hajda@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181220102247.4911-1-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsWy7djP87otudIxBtNWCFvcWneO1eLlhMOM
        FhtnrGe1mPrwCZtF8+L1bBYLpy1ntNj0+BqrxeVdc9gsDk3dy2ix9shddou5X6YyO3B7XL52
        kdlj56y77B6bVnWyeeyfu4bdY/OSeo/3+66yefRtWcXo8XmTXABHFJdNSmpOZllqkb5dAlfG
        j/2PWQv+qFa07vrJ3MB4UL6LkZNDQsBE4srVg8xdjFwcQgIrGCVeHPjMCOF8ZpR4e/o1axcj
        B1jV5w5eiPgyRolzGxrZQbqFBP4zSlw8KgNiswloSvzdfJMNxBYRMJboPzuLHaSBWWAes8TL
        V3eYQBLCAnES527OAxvKIqAq8fReCUiYV8BcouHYLVaIi+QlVm84wAxSwilgIfFzJdgYCYEd
        bBInVl5lhKhxkej/MZUJwhaWeHV8CzuELSNxeXI3C4RdL9E08wozRHMHo8SJxcvZIBLWEoeP
        XwRbxizAJzFp23RmiCd5JTrahCBKPCS2fnvGBPFwN6PEo12bGScwSi5gZFjFKJ5aWpybnlps
        nJdarlecmFtcmpeul5yfu4kRGMGn/x3/uoNx35+kQ4wCHIxKPLwzoqRihFgTy4orcw8xSnAw
        K4nwPs6SjhHiTUmsrEotyo8vKs1JLT7EKM3BoiTOW83wIFpIID2xJDU7NbUgtQgmy8TBKdXA
        mOnxZyfHwScrPnnYvJ6aqv9s3cSqti2GFZvtl9qtuLA6ycBTPnnp/yVljmx+H5ZNEqjWfVPe
        d77o4iuRv61/7dddWBf0/u2G3wyvsh1iWKO3/LovUu11pkhEh/WPkohN9b7L81qC4pNSzdZs
        vnI8YVHMnRthX69zfFof8bdfbZGRuMts79J2DSWW4oxEQy3mouJEAMNGbc/cAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGLMWRmVeSWpSXmKPExsVy+t/xq7rNudIxBo8OqlncWneO1eLlhMOM
        FhtnrGe1mPrwCZtF8+L1bBYLpy1ntNj0+BqrxeVdc9gsDk3dy2ix9shddou5X6YyO3B7XL52
        kdlj56y77B6bVnWyeeyfu4bdY/OSeo/3+66yefRtWcXo8XmTXABHFJdNSmpOZllqkb5dAlfG
        j/2PWQv+qFa07vrJ3MB4UL6LkYNDQsBE4nMHbxcjF4eQwBJGiTeXnzB1MXICOY1MEsdO1oDY
        bAKaEn8332QDsUUEjCX6z85iB2lgFljELLF33T5WkISwQJzEuZvzWEGGsgioSjy9VwIS5hUw
        l2g4dgusREJAXmL1hgPMICWcAhYSP1eyQ6wyl/hzZzrbBEaeBYwMqxhFUkuLc9Nzi430ihNz
        i0vz0vWS83M3MQJDb9uxn1t2MHa9Cz7EKMDBqMTDOyNKKkaINbGsuDL3EKMEB7OSCO/jLOkY
        Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rznDSqjhATSE0tSs1NTC1KLYLJMHJxSDYyipatk5P42
        eTDn91kwLj5Qu2lVO6Mz+xmWsArPtXbifn11WyY7yKac/5C49u6E9hRZz6vNPapHEy5/l3+6
        kzfz0NIUb/ZN08yym1zOa7lrvHTbGnNB3tZq25ObcSIx3/9y9Nff4lGOT/8+rTF9H/9k0yt3
        JBrVM9dac2pl/qxpVmP2Tpm+UYmlOCPRUIu5qDgRACwsLNo5AgAA
X-CMS-MailID: 20181220102259eucas1p1884a0b68ce342239c2a43a74cc50725a
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181220102259eucas1p1884a0b68ce342239c2a43a74cc50725a
References: <20181220102247.4911-1-a.hajda@samsung.com>
        <CGME20181220102259eucas1p1884a0b68ce342239c2a43a74cc50725a@eucas1p1.samsung.com>
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
v4:
  - removed NULL check before kfree,
  - coding style tweaking.
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
index 7f644f3c41d3..d3eb5aeeaa28 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3108,6 +3108,7 @@ define_dev_printk_level(_dev_info, KERN_INFO);
  *
  * This helper implements common pattern present in probe functions for error
  * checking: print message if the error is not -EPROBE_DEFER and propagate it.
+ * In case of -EPROBE_DEFER it sets defer probe reason.
  * It replaces code sequence:
  * 	if (err != -EPROBE_DEFER)
  * 		dev_err(dev, ...);
@@ -3123,14 +3124,14 @@ int probe_err(const struct device *dev, int err, const char *fmt, ...)
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
index 88713f182086..857aa4d1d45d 100644
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
+	const char *drv = dev_driver_string(dev);
+
+	mutex_lock(&deferred_probe_mutex);
+
+	kfree(dev->p->deferred_probe_msg);
+	dev->p->deferred_probe_msg = kasprintf(GFP_KERNEL, "%s: %pV", drv, vaf);
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
2.17.1

