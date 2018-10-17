Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B725BECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6A821527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nGx4ELd8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D6A821527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeJQVRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:17:53 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57791 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbeJQVRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:17:52 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181017132211euoutp0298c7166dd56b4e3e370dc351bc453f37~eaA3Ow7L33232132321euoutp02W;
        Wed, 17 Oct 2018 13:22:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181017132211euoutp0298c7166dd56b4e3e370dc351bc453f37~eaA3Ow7L33232132321euoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539782531;
        bh=AEQgS7jJhpFlYZlbHO3kE7SSEZ4yh2WZch0IlMydKtc=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=nGx4ELd8eNNVFdd1Pup1/bpPoCa2JbyIwqYrBLAi8s5TbyBi+8rDhWTQXEMQ1WGLb
         pQrIYOor7/Gs+RC0FnyzQCMn7eAyWneQ3jRfjJ3rUwUckalv+b0A2U/F53IuUbniuA
         0coZuRpIW5T1qRMBes9qkNMKvlQtsPbVcUcEUjI4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181017132210eucas1p230ed694bb3524d672975e67d21652f00~eaA2rHiIT0677706777eucas1p2u;
        Wed, 17 Oct 2018 13:22:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id BC.0B.04441.28737CB5; Wed, 17
        Oct 2018 14:22:10 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181017132209eucas1p1d23615adc15663caaffb3c117dc61151~eaA13oOkA2705227052eucas1p16;
        Wed, 17 Oct 2018 13:22:09 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-02-5bc737826228
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 87.FE.04284.18737CB5; Wed, 17
        Oct 2018 14:22:09 +0100 (BST)
Received: from AMDC2768.DIGITAL.local ([106.120.43.17]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PGQ00409VSWEA00@eusync1.samsung.com>;
        Wed, 17 Oct 2018 14:22:09 +0100 (BST)
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
Subject: [PATCH v3 1/4] driver core: add probe_err log helper
Date:   Wed, 17 Oct 2018 15:22:05 +0200
Message-id: <20181017132205.5204-1-a.hajda@samsung.com>
X-Mailer: git-send-email 2.18.0
In-reply-to: <CAHp75Vd1JQVx96FLEtTO7a7-OBaC1nUKcoSk4S6wvO6BtjJ-3w@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsWy7djPc7pN5sejDTZd5rG4te4cq8XLCYcZ
        LTbOWM9qMfXhEzaL5sXr2SwWTlvOaLHp8TVWi8u75rBZHJq6l9Fi7ZG77BZzv0xlduD2uHzt
        IrPHzll32T02repk89g/dw27x+Yl9R7v911l8+jbsorR4/MmuQCOKC6blNSczLLUIn27BK6M
        A28vsRQslqhYcrGmgfGScBcjJ4eEgIlE46ZnzF2MXBxCAisYJQ53zGWBcD4zSky+dYgVpmrb
        3pNQiWWMEpuWPGGEcP4zSmyZc4AJpIpNQFPi7+abbCC2iICxRP/ZWewgRcwC85glXr66A1Yk
        LGArcXTObkYQm0VAVeJX/3kwm1fAXOLxrTlMEOvkJR4ebweKc3BwCgRL7L4jDDJHQmAPm8Sj
        xiNQJ7lIrD7dzAxhC0u8Or6FHcKWkejsOAg1p16iaeYVZojmDkaJE4uXs0EkrCUOH78INohZ
        gE9i0rbpzCDLJAR4JTrahCBKPCSOtz8EKxESWMIocemF+wRGyQWMDKsYxVNLi3PTU4sN81LL
        9YoTc4tL89L1kvNzNzECY/j0v+OfdjB+vZR0iFGAg1GJh3eH2LFoIdbEsuLK3EOMEhzMSiK8
        VYrHo4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzLpu3MVpIID2xJDU7NbUgtQgmy8TBKdXAWKJn
        9/RvJWOLw6HbBS9TNqbzuFsvYLtpe3TDpd2Rqq1Lk5nONjukFQTGyU2/nJNYvpPX45HBrh0L
        J0x+JJnn8pH1gMjkW9em+T/mSTy4QSr6WlGo2+LH32tikju9F/foe+nsi7xtVrlKxEHkx7cV
        zkukviZlaawocb/sOVnG2J5Lt602NfaeEktxRqKhFnNRcSIAEZgFL90CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsVy+t/xy7qN5sejDa7vVbO4te4cq8XLCYcZ
        LTbOWM9qMfXhEzaL5sXr2SwWTlvOaLHp8TVWi8u75rBZHJq6l9Fi7ZG77BZzv0xlduD2uHzt
        IrPHzll32T02repk89g/dw27x+Yl9R7v911l8+jbsorR4/MmuQCOKC6blNSczLLUIn27BK6M
        A28vsRQslqhYcrGmgfGScBcjJ4eEgInEtr0nWboYuTiEBJYwSnzf95ARwmlkkuhZu4MJpIpN
        QFPi7+abbCC2iICxRP/ZWewgRcwCi5gl9q7bxwqSEBawlTg6ZzcjiM0ioCrxq/88mM0rYC7x
        +NYcJoh18hIPj7eDxTkFgiU+3pvNDmILCQRI/Fx8m20CI88CRoZVjCKppcW56bnFhnrFibnF
        pXnpesn5uZsYgQG47djPzTsYL20MPsQowMGoxMO7Q+xYtBBrYllxZe4hRgkOZiUR3irF49FC
        vCmJlVWpRfnxRaU5qcWHGKU5WJTEec8bVEYJCaQnlqRmp6YWpBbBZJk4OKUaGNtPT9d53//p
        yZIvE+oMa5nfS1/Q2WIe+frK1K2T5TxXaxQefXxHNSTr9OU5aQY/b36ZJcHbH3Mw0t7+Qfrh
        4+pneAQX/nimmLYsZ+VJbTszi+7n35YmvGMtSatf5nLJcr5Ahk1wrVqZX3WPEsdudbeyScqn
        585zjuqwmL1d8+OZ+w/izwvNNlNiKc5INNRiLipOBAAeL7woPAIAAA==
X-CMS-MailID: 20181017132209eucas1p1d23615adc15663caaffb3c117dc61151
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181017132209eucas1p1d23615adc15663caaffb3c117dc61151
References: <CAHp75Vd1JQVx96FLEtTO7a7-OBaC1nUKcoSk4S6wvO6BtjJ-3w@mail.gmail.com>
        <CGME20181017132209eucas1p1d23615adc15663caaffb3c117dc61151@eucas1p1.samsung.com>
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
index 04bbcd779e11..1f3e99c2ef03 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3067,6 +3067,45 @@ define_dev_printk_level(_dev_info, KERN_INFO);
 
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
index 90224e75ade4..6831677d5278 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1577,6 +1577,9 @@ do {									\
 	WARN_ONCE(condition, "%s %s: " format, \
 			dev_driver_string(dev), dev_name(dev), ## arg)
 
+extern __printf(3, 4)
+int probe_err(const struct device *dev, int err, const char *fmt, ...);
+
 /* Create alias, so I can be autoloaded. */
 #define MODULE_ALIAS_CHARDEV(major,minor) \
 	MODULE_ALIAS("char-major-" __stringify(major) "-" __stringify(minor))
-- 
2.18.0

