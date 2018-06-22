Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A120C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8E923ECD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HEnnXQGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8E923ECD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754260AbeFVIKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:10:05 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40575 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbeFVIJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:09:59 -0400
Received: by mail-pf0-f193.google.com with SMTP id z24-v6so2838904pfe.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 01:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=0Tzpf9ziKr+g+hROmT1grV3fdzAFs7fX02E9A7Xg4ZM=;
        b=HEnnXQGlLutVmWD43oi6ceJzSCpIhb3RZy3tm9zT+XhTUKcW+b3PQpiLGunqUzvgsn
         3a/PQUSpkZJ/kprN/hGLvCZ3YeRop1ex0U7IdA2DCMU+AvpHCa7Og4VSZW+DUOSm3Tmj
         gL5s/eWARXTGSnix3CB7n7a0kvAnNCPeMelZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=0Tzpf9ziKr+g+hROmT1grV3fdzAFs7fX02E9A7Xg4ZM=;
        b=k9KbYI4AaxreA86wF2H154qY6a/bp6Q67wPrVoTuTHgKRN3q9DSZzXGrHHN3tA9C7x
         xbOy5TnKPTNebVF40CEbaPhb1fIDpZGufeaqCP4RwqEZ/VdphHyVucVjwhx9CbH2p/gt
         w/n/tl2uyGjJP/hI2g2+70V2QSx/8VVH7VEs7IgLufjLNN4GCGMHp0VhXzCyK1OnKb49
         OLrLOl1SxF0NKMfnLzJzQvVwsYWfcLNOh5xl0zHf9+baUXMrpUdcHO5uOt8MDZFc3WkF
         9Ejfma/AmzLl2VG4P3Diy5TeJX6klKhn12eOMxhwv3OekC99pmg5WclyWfFj68YH1j+d
         pLGw==
X-Gm-Message-State: APt69E171o2BsIukbV6jPZ1JcHWhM0TTketrw8BgyHeAc6d+PhOfSf+f
        zdJ2JV4v+Q1AwwasdyNOxCfN3w==
X-Google-Smtp-Source: ADUXVKL14cdsrF5x7Q6I2Kdillry/zFcZWsgptjgAVzNiOvfBwlYW9sWkyiaJW+rL/TieYzqH2CIwQ==
X-Received: by 2002:a63:78c6:: with SMTP id t189-v6mr482034pgc.239.1529654998951;
        Fri, 22 Jun 2018 01:09:58 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id i65-v6sm22656131pfd.17.2018.06.22.01.09.56
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Jun 2018 01:09:58 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, broonie@kernel.org
Cc:     baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] hwspinlock: Add devm_xxx() APIs to register/unregister one hwlock controller
Date:   Fri, 22 Jun 2018 16:09:00 +0800
Message-Id: <52f3abc65549f6b412587a2c5938ee1347bccde7.1529654288.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
References: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
In-Reply-To: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
References: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces devm_hwspin_lock_register() and devm_hwspin_lock_unregister()
interfaces to help to register or unregister one hardware spinlock controller, that
will help to simplify the cleanup code for hwspinlock drivers.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/hwspinlock/hwspinlock_core.c |   82 ++++++++++++++++++++++++++++++++++
 include/linux/hwspinlock.h           |    6 +++
 2 files changed, 88 insertions(+)

diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
index d542b6f..ba27465 100644
--- a/drivers/hwspinlock/hwspinlock_core.c
+++ b/drivers/hwspinlock/hwspinlock_core.c
@@ -529,6 +529,88 @@ int hwspin_lock_unregister(struct hwspinlock_device *bank)
 }
 EXPORT_SYMBOL_GPL(hwspin_lock_unregister);
 
+static void devm_hwspin_lock_unreg(struct device *dev, void *res)
+{
+	hwspin_lock_unregister(*(struct hwspinlock_device **)res);
+}
+
+static int devm_hwspin_lock_device_match(struct device *dev, void *res,
+					 void *data)
+{
+	struct hwspinlock_device **bank = res;
+
+	if (WARN_ON(!bank || !*bank))
+		return 0;
+
+	return *bank == data;
+}
+
+/**
+ * devm_hwspin_lock_unregister() - unregister an hw spinlock device for
+ *				   a managed device
+ * @dev: the backing device
+ * @bank: the hwspinlock device, which usually provides numerous hw locks
+ *
+ * This function should be called from the underlying platform-specific
+ * implementation, to unregister an existing (and unused) hwspinlock.
+ *
+ * Should be called from a process context (might sleep)
+ *
+ * Returns 0 on success, or an appropriate error code on failure
+ */
+int devm_hwspin_lock_unregister(struct device *dev,
+				struct hwspinlock_device *bank)
+{
+	int ret;
+
+	ret = devres_release(dev, devm_hwspin_lock_unreg,
+			     devm_hwspin_lock_device_match, bank);
+	WARN_ON(ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_hwspin_lock_unregister);
+
+/**
+ * devm_hwspin_lock_register() - register a new hw spinlock device for
+ *				 a managed device
+ * @dev: the backing device
+ * @bank: the hwspinlock device, which usually provides numerous hw locks
+ * @ops: hwspinlock handlers for this device
+ * @base_id: id of the first hardware spinlock in this bank
+ * @num_locks: number of hwspinlocks provided by this device
+ *
+ * This function should be called from the underlying platform-specific
+ * implementation, to register a new hwspinlock device instance.
+ *
+ * Should be called from a process context (might sleep)
+ *
+ * Returns 0 on success, or an appropriate error code on failure
+ */
+int devm_hwspin_lock_register(struct device *dev,
+			      struct hwspinlock_device *bank,
+			      const struct hwspinlock_ops *ops,
+			      int base_id, int num_locks)
+{
+	struct hwspinlock_device **ptr;
+	int ret;
+
+	ptr = devres_alloc(devm_hwspin_lock_unreg, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	ret = hwspin_lock_register(bank, dev, ops, base_id, num_locks);
+	if (!ret) {
+		*ptr = bank;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_hwspin_lock_register);
+
 /**
  * __hwspin_lock_request() - tag an hwspinlock as used and power it up
  *
diff --git a/include/linux/hwspinlock.h b/include/linux/hwspinlock.h
index dfd0593..94064cc 100644
--- a/include/linux/hwspinlock.h
+++ b/include/linux/hwspinlock.h
@@ -71,6 +71,12 @@ int __hwspin_lock_timeout(struct hwspinlock *, unsigned int, int,
 struct hwspinlock *devm_hwspin_lock_request(struct device *dev);
 struct hwspinlock *devm_hwspin_lock_request_specific(struct device *dev,
 						     unsigned int id);
+int devm_hwspin_lock_unregister(struct device *dev,
+				struct hwspinlock_device *bank);
+int devm_hwspin_lock_register(struct device *dev,
+			      struct hwspinlock_device *bank,
+			      const struct hwspinlock_ops *ops,
+			      int base_id, int num_locks);
 
 #else /* !CONFIG_HWSPINLOCK */
 
-- 
1.7.9.5

