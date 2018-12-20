Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1BCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B5A21741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ruB6XXfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730844AbeLTKXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 05:23:08 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44093 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbeLTKXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 05:23:03 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181220102300euoutp02bd13ef2129f8493fe8c117a4d537d63a~yA2sYwgAG2917329173euoutp02P;
        Thu, 20 Dec 2018 10:23:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181220102300euoutp02bd13ef2129f8493fe8c117a4d537d63a~yA2sYwgAG2917329173euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545301380;
        bh=l9d5HR9T6mV0e4nZXjL57B2jHBVvBxDzB99xvEwtm8c=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=ruB6XXfXRZAcjz+C8TFurXYD4itDHEySfiRmamCWZuY0zGAWJaaEaEC4Wa+ozGoJD
         gQ2VmVEvL+1n1rDmZVlejb0GMFj84iLCWMHphjgZR1q2HCT960Lr1qwbOb0xrCMz+h
         CoOpzjdQcq3HoHR8M6axJ/+U0GZrUr929sLWCfMo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181220102300eucas1p12b22c221d4489e7e5f6bd4bc22bd95ca~yA2r_CL9T1463714637eucas1p1K;
        Thu, 20 Dec 2018 10:23:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 53.BC.04441.38D6B1C5; Thu, 20
        Dec 2018 10:22:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181220102259eucas1p2f748c68e01cd4e09a266da879722e218~yA2rN1C_n0445704457eucas1p25;
        Thu, 20 Dec 2018 10:22:59 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-c0-5c1b6d83f23a
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B2.49.04284.38D6B1C5; Thu, 20
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
Subject: [PATCH v4 1/3] driver core: add probe_err log helper
Date:   Thu, 20 Dec 2018 11:22:45 +0100
Message-id: <20181220102247.4911-2-a.hajda@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181220102247.4911-1-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsWy7djP87rNudIxBldmmFncWneO1eLlhMOM
        FhtnrGe1mPrwCZtF8+L1bBYLpy1ntNj0+BqrxeVdc9gsDk3dy2ix9shddou5X6YyO3B7XL52
        kdlj56y77B6bVnWyeeyfu4bdY/OSeo/3+66yefRtWcXo8XmTXABHFJdNSmpOZllqkb5dAlfG
        3oXrmQsWS1Rs7LvD1sB4SbiLkYNDQsBE4sPGwC5GLg4hgRWMEn3fG1khnM+MEs0NjSxdjJxg
        RYuuNLNAJJYxSmy8fI4RJCEk8J9R4uJRGRCbTUBT4u/mm2wgtoiAsUT/2VnsIA3MAvOYJV6+
        usMEsk5YwFbi0G0lkBoWAVWJtlnvWUFsXgFzieNHO1khlslLrN5wgBmknFPAQuLnSrAxEgJ7
        2CQampqhDnKR2L+7jQnCFpZ4dXwLO4QtI9HZcRAqXi/RNPMKM0RzB6PEicXL2SAS1hKHj18E
        W8YswCcxadt0ZkhQ8Ep0tAlBlHhInHl7BOrhbqDervPsExglFzAyrGIUTy0tzk1PLTbMSy3X
        K07MLS7NS9dLzs/dxAiM4NP/jn/awfj1UtIhRgEORiUe3hlRUjFCrIllxZW5hxglOJiVRHgf
        Z0nHCPGmJFZWpRblxxeV5qQWH2KU5mBREuetZngQLSSQnliSmp2aWpBaBJNl4uCUamAUffn5
        f+nkl9YRirX3H/87G/Hz+Jpb9oynLyXLBJq1J946lXTU/JeG6FKbX9f+Xu2esKOgw2PBo8x5
        0Vc38jGLJV3gd+r7bxu2eOnV6G3ap5+8zbyo+qiP+9hZ9ecTTZkUX597HvkhIXy/wT2ZHKs+
        74SEEoeC8vaGecGygfciEk4q6RbKGz1SYinOSDTUYi4qTgQAy3NdBNwCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOLMWRmVeSWpSXmKPExsVy+t/xq7rNudIxBnMucVjcWneO1eLlhMOM
        FhtnrGe1mPrwCZtF8+L1bBYLpy1ntNj0+BqrxeVdc9gsDk3dy2ix9shddou5X6YyO3B7XL52
        kdlj56y77B6bVnWyeeyfu4bdY/OSeo/3+66yefRtWcXo8XmTXABHFJdNSmpOZllqkb5dAlfG
        3oXrmQsWS1Rs7LvD1sB4SbiLkZNDQsBEYtGVZpYuRi4OIYEljBJbDl9jBUkICTQySRw7WQNi
        swloSvzdfJMNxBYRMJboPzuLHaSBWWARs8TedfuAGjg4hAVsJQ7dVgKpYRFQlWib9R5sDq+A
        ucTxo52sEMvkJVZvOMAMUs4pYCHxcyU7xCpziT93prNNYORZwMiwilEktbQ4Nz232FCvODG3
        uDQvXS85P3cTIzD4th37uXkH46WNwYcYBTgYlXh4Z0RJxQixJpYVV+YeYpTgYFYS4X2cJR0j
        xJuSWFmVWpQfX1Sak1p8iFGag0VJnPe8QWWUkEB6YklqdmpqQWoRTJaJg1OqgXFmYvPJCx1L
        WDZePq3zoNoyc5Gqz7KgzssZnn1LL81cderUlfvXi1T0dsv9Xn/r4s5XQYbTxZjCHzJ+u2m8
        6i0f/3UDT1F+Q02xqWvWz0w1C/0by7FuSs3naK+o26qnDeyXW62YM2PqNSOzRI/Qzjtmq/IV
        Gv0CIj/4XjfjVNmadCOupH2S+D0lluKMREMt5qLiRAA0/KqdOgIAAA==
X-CMS-MailID: 20181220102259eucas1p2f748c68e01cd4e09a266da879722e218
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181220102259eucas1p2f748c68e01cd4e09a266da879722e218
References: <20181220102247.4911-1-a.hajda@samsung.com>
        <CGME20181220102259eucas1p2f748c68e01cd4e09a266da879722e218@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During probe every time driver gets resource it should usually check for error
printk some message if it is not -EPROBE_DEFER and return the error. This
pattern is simple but requires adding few lines after any resource acquisition
code, as a result it is often omited or implemented only partially.
probe_err helps to replace such code sequences with simple call, so code:
	if (err != -EPROBE_DEFER)
		dev_err(dev, ...);
	return err;
becomes:
	return probe_err(dev, err, ...);

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
v3:
  - added 'extern __printf(3, 4)' decorators to probe_err,
  - changed error logging format - newline at the end,
  - added empty lines in probe_err around dev_err,
  - added R-b by Mark and Andy.
v2:
  - added error value to log message,
  - fixed code style,
  - added EXPORT_SYMBOL_GPL,
  - Added R-B by Javier (I hope the changes did not invalidate it).
---
 drivers/base/core.c    | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/device.h |  3 +++
 2 files changed, 42 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 0073b09bb99f..7f644f3c41d3 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3099,6 +3099,45 @@ define_dev_printk_level(_dev_info, KERN_INFO);
 
 #endif
 
+/**
+ * probe_err - probe error check and log helper
+ * @dev: the pointer to the struct device
+ * @err: error value to test
+ * @fmt: printf-style format string
+ * @...: arguments as specified in the format string
+ *
+ * This helper implements common pattern present in probe functions for error
+ * checking: print message if the error is not -EPROBE_DEFER and propagate it.
+ * It replaces code sequence:
+ * 	if (err != -EPROBE_DEFER)
+ * 		dev_err(dev, ...);
+ * 	return err;
+ * with
+ * 	return probe_err(dev, err, ...);
+ *
+ * Returns @err.
+ *
+ */
+int probe_err(const struct device *dev, int err, const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	if (err == -EPROBE_DEFER)
+		return err;
+
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	dev_err(dev, "error %d: %pV", err, &vaf);
+
+	va_end(args);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(probe_err);
+
 static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
 {
 	return fwnode && !IS_ERR(fwnode->secondary);
diff --git a/include/linux/device.h b/include/linux/device.h
index 6cb4640b6160..2d3a1cc6f5da 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1591,6 +1591,9 @@ do {									\
 	WARN_ONCE(condition, "%s %s: " format, \
 			dev_driver_string(dev), dev_name(dev), ## arg)
 
+extern __printf(3, 4)
+int probe_err(const struct device *dev, int err, const char *fmt, ...);
+
 /* Create alias, so I can be autoloaded. */
 #define MODULE_ALIAS_CHARDEV(major,minor) \
 	MODULE_ALIAS("char-major-" __stringify(major) "-" __stringify(minor))
-- 
2.17.1

