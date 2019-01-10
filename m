Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245D1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA8120665
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gWHJvSv9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbfAJM0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:26:14 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38555 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbfAJM0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:26:12 -0500
Received: by mail-pf1-f193.google.com with SMTP id q1so5243379pfi.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 04:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zfINy+UqI7Z90bTr73imVbYxd5qisc4ZIYp6v90nl7A=;
        b=gWHJvSv9l+TZgMOjeLzS9yvXAXxcIcOYDxBy7uVbFlcThhM0/14qo6wzD9lQOBmtoJ
         rzTLghFtCFnPju1GcFSQIn9eMOP3PBbJEEB9UuTxxcjdcs0oVJ/tK3VuOtWNkjSFzlli
         bqq7sxy6nlYUSJsxOAbNd6OrYgSTuabRqn4fU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zfINy+UqI7Z90bTr73imVbYxd5qisc4ZIYp6v90nl7A=;
        b=RkEl/fnrwOg3p2mPoNFk8fK6otI5wp3qmq2crzyH2+0a6PpsnfVWC5hLHefyqOAIdd
         S5eVYEPT/Q8T3fXyP1zo0bKIEKex6GjOR97OjeGyDPgnKUIxoKz7NUzWqJPc7ix0dvJK
         1OEQQyldKTDIbXUn26UZl4nNLzP7R1xS1VmtpYNSPLTLdObUkEdh6YwTYfHNtrDCZ4eL
         iH22Ert78OgN7JEbtzH10Cgh/0UcLU4CGOxlo66AEYFeL6ejLSUx0bKkfcF+SisuhbjH
         WxL/qMi3Po3+EhDdCCfONBsRxSNc8clwDCO+Datp07rwSppUAyxcSJESR9TjuvJ9DnPy
         6+3A==
X-Gm-Message-State: AJcUukcF2LZpx5jdjCAiyw69WH0runLI0DiD/8XjLvhc+SEh8+Cv5+w5
        5qgx1IMp4LeQHI2YADhT0sV6QA==
X-Google-Smtp-Source: ALg8bN6V3QfmhHuHOozEcv//NSiqOP81+7l0c26tyq5FRTibamije4Sk6QRc/BGuoq50beRTXfZwog==
X-Received: by 2002:a62:de06:: with SMTP id h6mr10325201pfg.158.1547123170864;
        Thu, 10 Jan 2019 04:26:10 -0800 (PST)
Received: from localhost.localdomain ([117.196.233.251])
        by smtp.gmail.com with ESMTPSA id m67sm142985541pfb.25.2019.01.10.04.26.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Jan 2019 04:26:10 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jens.wiklander@linaro.org,
        mpm@selenic.com, herbert@gondor.apana.org.au, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        daniel.thompson@linaro.org, ard.biesheuvel@linaro.org,
        bhsharma@redhat.com, tee-dev@lists.linaro.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 4/4] hwrng: add OP-TEE based rng driver
Date:   Thu, 10 Jan 2019 17:54:57 +0530
Message-Id: <1547123097-16431-5-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547123097-16431-1-git-send-email-sumit.garg@linaro.org>
References: <1547123097-16431-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On ARM SoC's with TrustZone enabled, peripherals like entropy sources
might not be accessible to normal world (linux in this case) and rather
accessible to secure world (OP-TEE in this case) only. So this driver
aims to provides a generic interface to OP-TEE based random number
generator service.

This driver registers on TEE bus to interact with OP-TEE based rng
device/service.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 MAINTAINERS                        |   5 +
 drivers/char/hw_random/Kconfig     |  15 ++
 drivers/char/hw_random/Makefile    |   1 +
 drivers/char/hw_random/optee-rng.c | 272 +++++++++++++++++++++++++++++++++++++
 4 files changed, 293 insertions(+)
 create mode 100644 drivers/char/hw_random/optee-rng.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 32d44447..502733c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11260,6 +11260,11 @@ M:	Jens Wiklander <jens.wiklander@linaro.org>
 S:	Maintained
 F:	drivers/tee/optee/
 
+OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
+M:	Sumit Garg <sumit.garg@linaro.org>
+S:	Maintained
+F:	drivers/char/hw_random/optee-rng.c
+
 OPA-VNIC DRIVER
 M:	Dennis Dalessandro <dennis.dalessandro@intel.com>
 M:	Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index dac895d..25a7d8f 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -424,6 +424,21 @@ config HW_RANDOM_EXYNOS
 	  will be called exynos-trng.
 
 	  If unsure, say Y.
+
+config HW_RANDOM_OPTEE
+	tristate "OP-TEE based Random Number Generator support"
+	depends on OPTEE
+	default HW_RANDOM
+	help
+	  This  driver provides support for OP-TEE based Random Number
+	  Generator on ARM SoCs where hardware entropy sources are not
+	  accessible to normal world (Linux).
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called optee-rng.
+
+	  If unsure, say Y.
+
 endif # HW_RANDOM
 
 config UML_RANDOM
diff --git a/drivers/char/hw_random/Makefile b/drivers/char/hw_random/Makefile
index e35ec3c..7c9ef4a 100644
--- a/drivers/char/hw_random/Makefile
+++ b/drivers/char/hw_random/Makefile
@@ -38,3 +38,4 @@ obj-$(CONFIG_HW_RANDOM_CAVIUM) += cavium-rng.o cavium-rng-vf.o
 obj-$(CONFIG_HW_RANDOM_MTK)	+= mtk-rng.o
 obj-$(CONFIG_HW_RANDOM_S390) += s390-trng.o
 obj-$(CONFIG_HW_RANDOM_KEYSTONE) += ks-sa-rng.o
+obj-$(CONFIG_HW_RANDOM_OPTEE) += optee-rng.o
diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/hw_random/optee-rng.c
new file mode 100644
index 0000000..ebfe1f2c
--- /dev/null
+++ b/drivers/char/hw_random/optee-rng.c
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018-2019 Linaro Ltd.
+ */
+
+#include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/hw_random.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/tee_drv.h>
+#include <linux/uuid.h>
+
+#define DRIVER_NAME "optee-rng"
+
+#define TEE_ERROR_HEALTH_TEST_FAIL	0x00000001
+
+/*
+ * TA_CMD_GET_ENTROPY - Get Entropy from RNG
+ *
+ * param[0] (inout memref) - Entropy buffer memory reference
+ * param[1] unused
+ * param[2] unused
+ * param[3] unused
+ *
+ * Result:
+ * TEE_SUCCESS - Invoke command success
+ * TEE_ERROR_BAD_PARAMETERS - Incorrect input param
+ * TEE_ERROR_NOT_SUPPORTED - Requested entropy size greater than size of pool
+ * TEE_ERROR_HEALTH_TEST_FAIL - Continuous health testing failed
+ */
+#define TA_CMD_GET_ENTROPY		0x0
+
+/*
+ * TA_CMD_GET_RNG_INFO - Get RNG information
+ *
+ * param[0] (out value) - value.a: RNG data-rate in bytes per second
+ *                        value.b: Quality/Entropy per 1024 bit of data
+ * param[1] unused
+ * param[2] unused
+ * param[3] unused
+ *
+ * Result:
+ * TEE_SUCCESS - Invoke command success
+ * TEE_ERROR_BAD_PARAMETERS - Incorrect input param
+ */
+#define TA_CMD_GET_RNG_INFO		0x1
+
+#define MAX_ENTROPY_REQ_SZ		(4 * 1024)
+
+static struct tee_context *ctx;
+static struct tee_shm *entropy_shm_pool;
+static u32 ta_rng_data_rate;
+static u32 ta_rng_session_id;
+
+static size_t get_optee_rng_data(void *buf, size_t req_size)
+{
+	u32 ret = 0;
+	u8 *rng_data = NULL;
+	size_t rng_size = 0;
+	struct tee_ioctl_invoke_arg inv_arg = {0};
+	struct tee_param param[4] = {0};
+
+	/* Invoke TA_CMD_GET_RNG function of Trusted App */
+	inv_arg.func = TA_CMD_GET_ENTROPY;
+	inv_arg.session = ta_rng_session_id;
+	inv_arg.num_params = 4;
+
+	/* Fill invoke cmd params */
+	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT;
+	param[0].u.memref.shm = entropy_shm_pool;
+	param[0].u.memref.size = req_size;
+	param[0].u.memref.shm_offs = 0;
+
+	ret = tee_client_invoke_func(ctx, &inv_arg, param);
+	if ((ret < 0) || (inv_arg.ret != 0)) {
+		pr_err("TA_CMD_GET_ENTROPY invoke function error: %x\n",
+		       inv_arg.ret);
+		return 0;
+	}
+
+	rng_data = tee_shm_get_va(entropy_shm_pool, 0);
+	if (IS_ERR(rng_data)) {
+		pr_err("tee_shm_get_va failed\n");
+		return 0;
+	}
+
+	rng_size = param[0].u.memref.size;
+	memcpy(buf, rng_data, rng_size);
+
+	return rng_size;
+}
+
+static int optee_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
+{
+	u8 *data = buf;
+	size_t read = 0, rng_size = 0;
+	int timeout = 1;
+
+	if (max > MAX_ENTROPY_REQ_SZ)
+		max = MAX_ENTROPY_REQ_SZ;
+
+	while (read == 0) {
+		rng_size = get_optee_rng_data(data, (max - read));
+
+		data += rng_size;
+		read += rng_size;
+
+		if (wait) {
+			if (timeout-- == 0)
+				return read;
+			msleep((1000 * (max - read)) / ta_rng_data_rate);
+		} else {
+			return read;
+		}
+	}
+
+	return read;
+}
+
+static int optee_rng_init(struct hwrng *rng)
+{
+	entropy_shm_pool = tee_shm_alloc(ctx, MAX_ENTROPY_REQ_SZ,
+					 TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
+	if (IS_ERR(entropy_shm_pool)) {
+		pr_err("tee_shm_alloc failed\n");
+		return PTR_ERR(entropy_shm_pool);
+	}
+
+	return 0;
+}
+
+static void optee_rng_cleanup(struct hwrng *rng)
+{
+	tee_shm_free(entropy_shm_pool);
+}
+
+static struct hwrng optee_rng = {
+	.name		= DRIVER_NAME,
+	.init		= optee_rng_init,
+	.cleanup	= optee_rng_cleanup,
+	.read		= optee_rng_read,
+};
+
+static int get_optee_rng_info(void)
+{
+	u32 ret = 0;
+	struct tee_ioctl_invoke_arg inv_arg = {0};
+	struct tee_param param[4] = {0};
+
+	/* Invoke TA_CMD_GET_RNG function of Trusted App */
+	inv_arg.func = TA_CMD_GET_RNG_INFO;
+	inv_arg.session = ta_rng_session_id;
+	inv_arg.num_params = 4;
+
+	/* Fill invoke cmd params */
+	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
+
+	ret = tee_client_invoke_func(ctx, &inv_arg, param);
+	if ((ret < 0) || (inv_arg.ret != 0)) {
+		pr_err("TA_CMD_GET_RNG_INFO invoke function error: %x\n",
+		       inv_arg.ret);
+		return -EINVAL;
+	}
+
+	ta_rng_data_rate = param[0].u.value.a;
+	optee_rng.quality = param[0].u.value.b;
+
+	return 0;
+}
+
+static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
+{
+	if (ver->impl_id == TEE_IMPL_ID_OPTEE)
+		return 1;
+	else
+		return 0;
+}
+
+static int optee_rng_probe(struct device *dev)
+{
+	struct tee_client_device *rng_device = to_tee_client_device(dev);
+	int ret = 0, err = -ENODEV;
+	struct tee_ioctl_open_session_arg sess_arg = {0};
+
+	/* Open context with TEE driver */
+	ctx = tee_client_open_context(NULL, optee_ctx_match, NULL, NULL);
+	if (IS_ERR(ctx))
+		return -ENODEV;
+
+	/* Open session with hwrng Trusted App */
+	memcpy(sess_arg.uuid, rng_device->id.uuid.b, TEE_IOCTL_UUID_LEN);
+	sess_arg.clnt_login = TEE_IOCTL_LOGIN_PUBLIC;
+	sess_arg.num_params = 0;
+
+	ret = tee_client_open_session(ctx, &sess_arg, NULL);
+	if ((ret < 0) || (sess_arg.ret != 0)) {
+		pr_err("tee_client_open_session failed, error: %x\n",
+		       sess_arg.ret);
+		err = -EINVAL;
+		goto out_ctx;
+	}
+	ta_rng_session_id = sess_arg.session;
+
+	err = get_optee_rng_info();
+	if (err)
+		goto out_sess;
+
+	err = hwrng_register(&optee_rng);
+	if (err) {
+		pr_err("registering failed (%d)\n", err);
+		goto out_sess;
+	}
+
+	return 0;
+
+out_sess:
+	tee_client_close_session(ctx, ta_rng_session_id);
+out_ctx:
+	tee_client_close_context(ctx);
+
+	return err;
+}
+
+static int optee_rng_remove(struct device *dev)
+{
+	tee_client_close_session(ctx, ta_rng_session_id);
+	tee_client_close_context(ctx);
+	hwrng_unregister(&optee_rng);
+
+	return 0;
+}
+
+const struct tee_client_device_id optee_rng_id_table[] = {
+	{UUID_INIT(0xab7a617c, 0xb8e7, 0x4d8f,
+		   0x83, 0x01, 0xd0, 0x9b, 0x61, 0x03, 0x6b, 0x64)},
+	{}
+};
+
+static struct tee_client_driver optee_rng_driver = {
+	.id_table	= optee_rng_id_table,
+	.driver		= {
+		.name		= DRIVER_NAME,
+		.bus		= &tee_bus_type,
+		.probe		= optee_rng_probe,
+		.remove		= optee_rng_remove,
+	},
+};
+
+static int __init mod_init(void)
+{
+	int rc;
+
+	rc = driver_register(&optee_rng_driver.driver);
+	if (rc)
+		pr_warn("driver registration failed, err: %d", rc);
+
+	return rc;
+}
+
+static void __exit mod_exit(void)
+{
+	driver_unregister(&optee_rng_driver.driver);
+}
+
+module_init(mod_init);
+module_exit(mod_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Sumit Garg <sumit.garg@linaro.org>");
+MODULE_DESCRIPTION("OP-TEE based random number generator driver");
-- 
2.7.4

