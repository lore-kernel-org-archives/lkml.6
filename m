Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90A1C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852FD20838
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JT+fIGxz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 852FD20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbeJaS2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:28:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41599 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbeJaS2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:28:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id x12-v6so15639424wrw.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 02:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2uKBBGkCNMoGjJfIY95Fh+s9tnlSDO4scNahnS2PGqY=;
        b=JT+fIGxzFE1oZ0o9/cuu8TmJdAOZGpwaGOYW4FfGgFbycJnB1k5HfvnFTwtwS5k+8H
         F/KY7au1njJwObf7X8BEGeBgVjct/1s1BsJZSodgBbAPqSuJCA1qTIdKLqLGIqGv12ej
         cs3mFxt3OZlg2x7Q4W2IZpIH32S7rvkSEfol4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2uKBBGkCNMoGjJfIY95Fh+s9tnlSDO4scNahnS2PGqY=;
        b=s5YPFsPwoVsIdnNulijgEknOsc69+Z+k9X2MaMIqxudeoULc7FR/DoKS5uU0Z4OmVb
         mSTAYf7BF4OWmkk5PO1vI23RS0aYWrG9opFGg7YRsF+UQ5vSDbKYcHgkAty5uisWs1EJ
         ztIv8MgRVoOXVkCanWgTT2fsOZwGbxzc5wq+XAR0XDoL6Lr4NpisA1FhJhlhpq6Qg7BH
         7/4pHb1BRgRJEk7wXuvLI2B7bGN2ua1SXQd5ETiCtSZpEWoezq1ndd58Lcfv2aWECw7p
         GwXIqBfbs8PT9qmq9AunNtk3BV6CH2H32QQd6mYanHrjfrGF9DGP/2RlBGQg3DE2+AYt
         V62w==
X-Gm-Message-State: AGRZ1gJl+hVQe++XZcFSJnppEjwOfNQQ0zMunDYUdqRC8WZISorpH3KU
        KKwBgDQ5w2y2JT7C9KBEy4VcwA==
X-Google-Smtp-Source: AJdET5d4OGLv6czcLPclqwS8Icqyl9uCHrMTILaKN30Dysw+gywqquyKp4fU3qvqryMiz7y4qrgfWA==
X-Received: by 2002:a5d:4e01:: with SMTP id p1-v6mr2116103wrt.320.1540978258587;
        Wed, 31 Oct 2018 02:30:58 -0700 (PDT)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:1086:999:fd1b:8629:a7fc:68b])
        by smtp.gmail.com with ESMTPSA id w14-v6sm10737377wrt.73.2018.10.31.02.30.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Oct 2018 02:30:58 -0700 (PDT)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alexandre.torgue@st.com
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 5/5] hwspinlock: Add test module
Date:   Wed, 31 Oct 2018 10:30:32 +0100
Message-Id: <20181031093032.20386-6-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181031093032.20386-1-benjamin.gaignard@st.com>
References: <20181031093032.20386-1-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a test module to perform simple unitary tests on hwspinlock.
It doesn't cover all the possibles cases but at least allow to test
that very basic features are working.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/hwspinlock/Kconfig           |   9 +++
 drivers/hwspinlock/Makefile          |   1 +
 drivers/hwspinlock/hwspinlock_test.c | 132 +++++++++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+)
 create mode 100644 drivers/hwspinlock/hwspinlock_test.c

diff --git a/drivers/hwspinlock/Kconfig b/drivers/hwspinlock/Kconfig
index e1a20b460590..f340ebb4d1f7 100644
--- a/drivers/hwspinlock/Kconfig
+++ b/drivers/hwspinlock/Kconfig
@@ -68,3 +68,12 @@ config HWSPINLOCK_STM32
 	  Say y here to support the STM32 Hardware Spinlock device.
 
 	  If unsure, say N.
+
+config HWSPINLOCK_TEST
+	tristate "hwspinlock test module"
+	depends on HWSPINLOCK && m
+	default n
+	help
+	  Select M here if you want to build hwspinlock test module
+
+	  If unsure, say N.
diff --git a/drivers/hwspinlock/Makefile b/drivers/hwspinlock/Makefile
index c0a9505b4dcf..e6b3d0212fe0 100644
--- a/drivers/hwspinlock/Makefile
+++ b/drivers/hwspinlock/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_HWSPINLOCK_SIRF)		+= sirf_hwspinlock.o
 obj-$(CONFIG_HWSPINLOCK_SPRD)		+= sprd_hwspinlock.o
 obj-$(CONFIG_HSEM_U8500)		+= u8500_hsem.o
 obj-$(CONFIG_HWSPINLOCK_STM32)		+= stm32_hwspinlock.o
+obj-$(CONFIG_HWSPINLOCK_TEST) 		+= hwspinlock_test.o
diff --git a/drivers/hwspinlock/hwspinlock_test.c b/drivers/hwspinlock/hwspinlock_test.c
new file mode 100644
index 000000000000..75819337e45a
--- /dev/null
+++ b/drivers/hwspinlock/hwspinlock_test.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) STMicroelectronics SA 2018
+ * Author: Benjamin Gaignard <benjamin.gaignard@st.com> for STMicroelectronics.
+ * License terms:  GNU General Public License (GPL), version 2
+ */
+
+#include <linux/hwspinlock.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#define TIMEOUT	50 /* ms */
+
+static void hwspin_lock_test_twice_request_specific(void)
+{
+	struct hwspinlock *lock0 = hwspin_lock_request_specific(0);
+	struct hwspinlock *lock1 = hwspin_lock_request_specific(1);
+
+	int ret;
+
+	if (!lock0 || !lock1) {
+		pr_warn("Can't request twice hwspin_lock\n");
+		return;
+	}
+
+	ret = hwspin_trylock(lock0);
+	if (ret)
+		pr_warn("Can't trylock requested hwspin_lock 0 (%d)\n", ret);
+
+	ret = hwspin_trylock(lock1);
+	if (ret)
+		pr_warn("Can't trylock requested hwspin_lock 1 (%d)\n", ret);
+
+	hwspin_unlock(lock0);
+	hwspin_unlock(lock1);
+
+	ret = hwspin_lock_free(lock0);
+	if (ret)
+		pr_warn("Can't free requested hwspin_lock 0\n");
+
+	ret = hwspin_lock_free(lock1);
+	if (ret)
+		pr_warn("Can't free requested hwspin_lock 0\n");
+}
+
+static void hwspin_lock_test_trylock(void)
+{
+	struct hwspinlock *lock = hwspin_lock_request();
+	int ret;
+
+	if (!lock) {
+		pr_warn("Can't request hwspin_lock\n");
+		return;
+	}
+
+	ret = hwspin_trylock(lock);
+	if (ret)
+		pr_warn("Can't trylock requested hwspin_lock (%d)\n", ret);
+
+	/* Try to lock a second time, this should failed */
+	ret = hwspin_trylock(lock);
+	if (ret != -EBUSY)
+		pr_warn("Getting twice the same lock ! (%d)\n", ret);
+
+	hwspin_unlock(lock);
+	ret = hwspin_lock_free(lock);
+	if (ret)
+		pr_warn("Can't free requested hwspin_lock 0\n");
+}
+
+static void hwspin_lock_test_request_specific(void)
+{
+	/*
+	 * Let's assume that any hwspin_lock driver would at least have one
+	 * lock at index 0
+	 */
+	struct hwspinlock *lock = hwspin_lock_request_specific(0);
+	int ret;
+
+	if (!lock) {
+		pr_warn("Can't request hwspin_lock 0\n");
+		return;
+	}
+
+	ret = hwspin_lock_timeout(lock, TIMEOUT);
+	if (ret)
+		pr_warn("Can't lock requested hwspin_lock 0 (%d)\n", ret);
+
+	hwspin_unlock(lock);
+	ret = hwspin_lock_free(lock);
+	if (ret)
+		pr_warn("Can't free requested hwspin_lock 0\n");
+}
+
+static void hwspin_lock_test_request(void)
+{
+	struct hwspinlock *lock = hwspin_lock_request();
+	int ret;
+
+	if (!lock) {
+		pr_warn("Can't request hwspin_lock\n");
+		return;
+	}
+
+	ret = hwspin_lock_timeout(lock, TIMEOUT);
+	if (ret)
+		pr_warn("Can't lock requested hwspin_lock (%d)\n", ret);
+
+	hwspin_unlock(lock);
+	ret = hwspin_lock_free(lock);
+	if (ret)
+		pr_warn("Can't free requested hwspin_lock\n");
+}
+
+/*
+ * Test hwspinlock user API when module is loaded
+ */
+static int __init hwspin_lock_test_init(void)
+{
+	pr_warn("Loading hwspinlock test module\n");
+	hwspin_lock_test_request();
+	hwspin_lock_test_request_specific();
+	hwspin_lock_test_trylock();
+	hwspin_lock_test_twice_request_specific();
+
+	return 0;
+}
+
+module_init(hwspin_lock_test_init);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Hardware spinlock test driver");
-- 
2.15.0

