Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE86C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E44B23EDB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QGn5hNib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E44B23EDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754324AbeFVIOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:14:06 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41368 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbeFVIJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:09:56 -0400
Received: by mail-pl0-f68.google.com with SMTP id w8-v6so3108290ply.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 01:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=EvEb9AghybtdnkxHfKvMzouMMdmNPOMDUDXqyHf1hyQ=;
        b=QGn5hNibPxZvcY+B8cCrU5jZegOWBsI956F5lIQd0q/RYra2/LPc3P3vKd0X+NluHy
         KZTAe8xCyRJ2WMB1dhZRc9RbFoVXeOcqJLyuEctmn8SZWc3HzEahke5m+2vuneWhUvsx
         md4VioeOYEhWs6eyTgyvTih1QRbzRA2P2mVdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=EvEb9AghybtdnkxHfKvMzouMMdmNPOMDUDXqyHf1hyQ=;
        b=Ge6oe4K86ObbzxjGkPL5Qd0VSgL9lPtNesNcftIgA7TZeHso6XDeKQdDVAzS8pa6L0
         lrbej6+Og7qpQzlcvyttS7V3r/Xx2JjGxpbbRzPTTcoIE45P/+Zdd8UvaXgRhMVpUQMk
         WXaDcbTVI9PO3g/zz+Mocb598wHXPfWwMzKiVheFQ+Uil0prm0h6m4T6238fqA70Yu8Z
         0aX54hV3cxvJw5qvo1PpqGNgf73xWApVNBE6U57qNaoxKWuwBL0jhAY73U27ymmwY4A5
         X2nSnUmxD1phJO4NrgY7KkvgCgtO4R/wyuPuX7dihlNmFyoavFGWJnPh990Dic2i7hEK
         7E7g==
X-Gm-Message-State: APt69E0TdFE4KmE7mGnFXlYDqnpa00FdzUrSSESM+Y6XAzx/Blgkjqns
        r0JGiOqgUk7O6J7vcFGJaozDnw==
X-Google-Smtp-Source: ADUXVKIy9vbNtjAnhPrNRhEEEGjUIuatZF+kBJ6478TfN6Ql0uMSMG0OJLFIm35YoX6rEv4r3HkG1Q==
X-Received: by 2002:a17:902:6bc7:: with SMTP id m7-v6mr633780plt.162.1529654996417;
        Fri, 22 Jun 2018 01:09:56 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id i65-v6sm22656131pfd.17.2018.06.22.01.09.54
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Jun 2018 01:09:55 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, broonie@kernel.org
Cc:     baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] hwspinlock: Add devm_xxx() APIs to request/free hwlock
Date:   Fri, 22 Jun 2018 16:08:59 +0800
Message-Id: <f75f8ab18e2e27077536692ae35e3dd707920238.1529654288.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
References: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
In-Reply-To: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
References: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces some devm_xxx() APIs to help to request or free
the hwlocks, which will help to simplify the cleanup code for drivers
requesting one hwlock, ensuring that the hwlock is automatically freed
whenever the device is unbound.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/hwspinlock/hwspinlock_core.c |  110 ++++++++++++++++++++++++++++++++++
 include/linux/hwspinlock.h           |   22 +++++++
 2 files changed, 132 insertions(+)

diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
index bea3586..d542b6f 100644
--- a/drivers/hwspinlock/hwspinlock_core.c
+++ b/drivers/hwspinlock/hwspinlock_core.c
@@ -735,6 +735,116 @@ int hwspin_lock_free(struct hwspinlock *hwlock)
 }
 EXPORT_SYMBOL_GPL(hwspin_lock_free);
 
+static int devm_hwspin_lock_match(struct device *dev, void *res, void *data)
+{
+	struct hwspinlock **hwlock = res;
+
+	if (WARN_ON(!hwlock || !*hwlock))
+		return 0;
+
+	return *hwlock == data;
+}
+
+static void devm_hwspin_lock_release(struct device *dev, void *res)
+{
+	hwspin_lock_free(*(struct hwspinlock **)res);
+}
+
+/**
+ * devm_hwspin_lock_free() - free a specific hwspinlock for a managed device
+ * @dev: the device to free the specific hwspinlock
+ * @hwlock: the specific hwspinlock to free
+ *
+ * This function mark @hwlock as free again.
+ * Should only be called with an @hwlock that was retrieved from
+ * an earlier call to hwspin_lock_request{_specific}.
+ *
+ * Should be called from a process context (might sleep)
+ *
+ * Returns 0 on success, or an appropriate error code on failure
+ */
+int devm_hwspin_lock_free(struct device *dev, struct hwspinlock *hwlock)
+{
+	int ret;
+
+	ret = devres_release(dev, devm_hwspin_lock_release,
+			     devm_hwspin_lock_match, hwlock);
+	WARN_ON(ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_hwspin_lock_free);
+
+/**
+ * devm_hwspin_lock_request() - request an hwspinlock for a managed device
+ * @dev: the device to request an hwspinlock
+ *
+ * This function should be called by users of the hwspinlock device,
+ * in order to dynamically assign them an unused hwspinlock.
+ * Usually the user of this lock will then have to communicate the lock's id
+ * to the remote core before it can be used for synchronization (to get the
+ * id of a given hwlock, use hwspin_lock_get_id()).
+ *
+ * Should be called from a process context (might sleep)
+ *
+ * Returns the address of the assigned hwspinlock, or NULL on error
+ */
+struct hwspinlock *devm_hwspin_lock_request(struct device *dev)
+{
+	struct hwspinlock **ptr, *hwlock;
+
+	ptr = devres_alloc(devm_hwspin_lock_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	hwlock = hwspin_lock_request();
+	if (!IS_ERR(hwlock)) {
+		*ptr = hwlock;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return hwlock;
+}
+EXPORT_SYMBOL_GPL(devm_hwspin_lock_request);
+
+/**
+ * devm_hwspin_lock_request_specific() - request for a specific hwspinlock for
+ *					 a managed device
+ * @dev: the device to request the specific hwspinlock
+ * @id: index of the specific hwspinlock that is requested
+ *
+ * This function should be called by users of the hwspinlock module,
+ * in order to assign them a specific hwspinlock.
+ * Usually early board code will be calling this function in order to
+ * reserve specific hwspinlock ids for predefined purposes.
+ *
+ * Should be called from a process context (might sleep)
+ *
+ * Returns the address of the assigned hwspinlock, or NULL on error
+ */
+struct hwspinlock *devm_hwspin_lock_request_specific(struct device *dev,
+						     unsigned int id)
+{
+	struct hwspinlock **ptr, *hwlock;
+
+	ptr = devres_alloc(devm_hwspin_lock_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	hwlock = hwspin_lock_request_specific(id);
+	if (!IS_ERR(hwlock)) {
+		*ptr = hwlock;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return hwlock;
+}
+EXPORT_SYMBOL_GPL(devm_hwspin_lock_request_specific);
+
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Hardware spinlock interface");
 MODULE_AUTHOR("Ohad Ben-Cohen <ohad@wizery.com>");
diff --git a/include/linux/hwspinlock.h b/include/linux/hwspinlock.h
index 2b6f389..dfd0593 100644
--- a/include/linux/hwspinlock.h
+++ b/include/linux/hwspinlock.h
@@ -67,6 +67,10 @@ int __hwspin_lock_timeout(struct hwspinlock *, unsigned int, int,
 int __hwspin_trylock(struct hwspinlock *, int, unsigned long *);
 void __hwspin_unlock(struct hwspinlock *, int, unsigned long *);
 int of_hwspin_lock_get_id_byname(struct device_node *np, const char *name);
+int devm_hwspin_lock_free(struct device *dev, struct hwspinlock *hwlock);
+struct hwspinlock *devm_hwspin_lock_request(struct device *dev);
+struct hwspinlock *devm_hwspin_lock_request_specific(struct device *dev,
+						     unsigned int id);
 
 #else /* !CONFIG_HWSPINLOCK */
 
@@ -132,6 +136,24 @@ int of_hwspin_lock_get_id_byname(struct device_node *np, const char *name)
 	return 0;
 }
 
+static inline
+int devm_hwspin_lock_free(struct device *dev, struct hwspinlock *hwlock)
+{
+	return 0;
+}
+
+static inline struct hwspinlock *devm_hwspin_lock_request(struct device *dev)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline
+struct hwspinlock *devm_hwspin_lock_request_specific(struct device *dev,
+						     unsigned int id)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 #endif /* !CONFIG_HWSPINLOCK */
 
 /**
-- 
1.7.9.5

