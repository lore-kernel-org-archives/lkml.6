Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DA2C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9059F21476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="L1TFiD5W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9059F21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbeJROsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 10:48:50 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41811 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbeJROst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 10:48:49 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181018064918euoutp02e6da4cc0d674b0ee810eaa2a0500f47f~eoTHV1xuw2667226672euoutp02u;
        Thu, 18 Oct 2018 06:49:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181018064918euoutp02e6da4cc0d674b0ee810eaa2a0500f47f~eoTHV1xuw2667226672euoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539845358;
        bh=qAREvdHcFvOM48/FqFxff/A8CbHIHJf1GkZzLV/P1Nk=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=L1TFiD5W0D8tLBuSXpPpPc6nKfiopJbnRo6/CuJ7pElLNcKKfmxPklWYjAFHLA+dk
         71pw1yno2UlfHWLoJp1JfiOJCkJX6U9cREcsBTGeGPlm53pVFi3p9vtvtDq1AhahYr
         QM3htuAeSYe6W8GFakX8lj4hXmUETo3+DTLn3lgM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181018064917eucas1p10bd9cf1a4de80027a3328554210d3274~eoTGvukGN1478014780eucas1p1K;
        Thu, 18 Oct 2018 06:49:17 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 1D.D3.04294.DEC28CB5; Thu, 18
        Oct 2018 07:49:17 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181018064916eucas1p22f03a19eb09cecdb0061dc5a4bf99ce6~eoTFkltpY2757327573eucas1p2O;
        Thu, 18 Oct 2018 06:49:16 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-f8-5bc82ced14ff
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5E.96.04128.CEC28CB5; Thu, 18
        Oct 2018 07:49:16 +0100 (BST)
Received: from AMDC2768.DIGITAL.local ([106.120.43.17]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PGS004LF8A3IH30@eusync1.samsung.com>;
        Thu, 18 Oct 2018 07:49:16 +0100 (BST)
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
Date:   Thu, 18 Oct 2018 08:49:06 +0200
Message-id: <20181018064906.23116-1-a.hajda@samsung.com>
X-Mailer: git-send-email 2.18.0
In-reply-to: <CAHp75VdwnHLuXazD926CU+HWWv+sgp8BFCdW=vHqzMqsE87Ekg@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsWy7djP87pvdU5EG8zbzWJxa905VouXEw4z
        WmycsZ7VYurDJ2wWzYvXs1ksnLac0WLT42usFpd3zWGzODR1L6PF2iN32S3mfpnK7MDtcfna
        RWaPnbPusntsWtXJ5rF/7hp2j81L6j3e77vK5tG3ZRWjx+dNcgEcUVw2Kak5mWWpRfp2CVwZ
        j96fZiv4o1rRcmwqYwPjQfkuRk4OCQETiQevN7B2MXJxCAmsYJTYc/IulPOZUWLrnSnsMFWr
        r05nhEgsY5S4sKyVBcL5zyhx4/gKFpAqNgFNib+bb7KB2CICxhL9Z2exgxQxC8xjlnj56g4T
        SEJYIE7i3M15rCA2i4CqxLwZh8FsXgELiQeTfzJBrJOXeHi8nRHE5hQIltjYMZMJZJCEwA42
        ie4dC9kgilwkHvzZxghhC0u8Or4F6lYZicuTu1kg7HqJpplXmCGaOxglTixeDtVsLXH4+EWw
        zcwCfBKTtk0HKuIAivNKdLQJQZR4SFye/hzqzSWMEq8PbGWfwCi5gJFhFaN4amlxbnpqsVFe
        arlecWJucWleul5yfu4mRmAkn/53/MsOxl1/kg4xCnAwKvHwPkg9Hi3EmlhWXJl7iFGCg1lJ
        hJdlNlCINyWxsiq1KD++qDQntfgQozQHi5I477J5G6OFBNITS1KzU1MLUotgskwcnFINjJo+
        spybNdtfMiT+veniJbCTZakWT5SxqcI153suRzTNdn5u6LMwzqze0NZ1N7x130f1VZ6swlPe
        bWWc9lIg681NjpyVnBevpM8vWsDD3MogtJJ1exTfyw1Xan6Xahkv/6TAud8xt+Bb+fNY18qL
        05vFb+3q12xdfX1+8z6nL6FvvsrP+fPhmhJLcUaioRZzUXEiAOwDG5/gAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsVy+t/xy7pvdE5EG7x5xmpxa905VouXEw4z
        WmycsZ7VYurDJ2wWzYvXs1ksnLac0WLT42usFpd3zWGzODR1L6PF2iN32S3mfpnK7MDtcfna
        RWaPnbPusntsWtXJ5rF/7hp2j81L6j3e77vK5tG3ZRWjx+dNcgEcUVw2Kak5mWWpRfp2CVwZ
        j96fZiv4o1rRcmwqYwPjQfkuRk4OCQETidVXpzN2MXJxCAksYZS4+uEzG4TTyCTx5N45ZpAq
        NgFNib+bb7KB2CICxhL9Z2exgxQxCyxilti7bh8rSEJYIE7i3M15YDaLgKrEvBmHwWxeAQuJ
        B5N/MkGsk5d4eLydEcTmFAiWeNK6GqxGSCBAYtKGd8wTGHkWMDKsYhRJLS3OTc8tNtIrTswt
        Ls1L10vOz93ECAzBbcd+btnB2PUu+BCjAAejEg/vg9Tj0UKsiWXFlbmHGCU4mJVEeFlmA4V4
        UxIrq1KL8uOLSnNSiw8xSnOwKInznjeojBISSE8sSc1OTS1ILYLJMnFwSjUwhu43+LXs80Ub
        ne0Sm98yTV6lJLODeduvWhOJyM4fXF0Cpq84HzIJ2L+xEHlh5hp7NPdrQEH/rtMLbmXZ5anf
        3X/K4eatkGrZSTcYbC7eSHr8J+HrKYULX+9nhsYxVO/gePlu65uGl1x+HteN/059cf7OVk0n
        3XtSf+Kt9DJ/OnJUCB3K/bv5mhJLcUaioRZzUXEiALVaPKc9AgAA
X-CMS-MailID: 20181018064916eucas1p22f03a19eb09cecdb0061dc5a4bf99ce6
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181018064916eucas1p22f03a19eb09cecdb0061dc5a4bf99ce6
References: <CAHp75VdwnHLuXazD926CU+HWWv+sgp8BFCdW=vHqzMqsE87Ekg@mail.gmail.com>
        <CGME20181018064916eucas1p22f03a19eb09cecdb0061dc5a4bf99ce6@eucas1p2.samsung.com>
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
index 169412ee4ae8..e7986a307420 100644
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
2.18.0

