Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2387FC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62B52086C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbfBAKQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 05:16:46 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32853 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726116AbfBAKQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 05:16:46 -0500
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id A77251751B49428219F5;
        Fri,  1 Feb 2019 10:16:44 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.141)
 by smtpsuk.huawei.com (10.201.108.32) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 1 Feb 2019 10:16:38 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <jarkko.sakkinen@linux.intel.com>, <zohar@linux.ibm.com>,
        <david.safford@ge.com>, <monty.wiseman@ge.com>,
        <matthewgarrett@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v9 4/6] tpm: move tpm_chip definition to include/linux/tpm.h
Date:   Fri, 1 Feb 2019 11:06:39 +0100
Message-ID: <20190201100641.26936-5-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201100641.26936-1-roberto.sassu@huawei.com>
References: <20190201100641.26936-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.141]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tpm_chip structure contains the list of PCR banks currently allocated
in the TPM. When support for crypto agility will be added to the TPM
driver, users of the driver have to provide a digest for each allocated
bank to tpm_pcr_extend(). With this patch, they can obtain the PCR bank
algorithms directly from chip->allocated_banks.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 drivers/char/tpm/tpm.h | 100 ++---------------------------------------
 include/linux/tpm.h    |  90 +++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+), 96 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 64d93d26087f..001a626ca4c3 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -25,30 +25,22 @@
 
 #include <linux/module.h>
 #include <linux/delay.h>
-#include <linux/fs.h>
-#include <linux/hw_random.h>
 #include <linux/mutex.h>
 #include <linux/sched.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/tpm.h>
-#include <linux/acpi.h>
-#include <linux/cdev.h>
 #include <linux/highmem.h>
 #include <linux/tpm_eventlog.h>
-#include <crypto/hash_info.h>
 
 #ifdef CONFIG_X86
 #include <asm/intel-family.h>
 #endif
 
-enum tpm_const {
-	TPM_MINOR = 224,	/* officially assigned */
-	TPM_BUFSIZE = 4096,
-	TPM_NUM_DEVICES = 65536,
-	TPM_RETRY = 50,		/* 5 seconds */
-	TPM_NUM_EVENT_LOG_FILES = 3,
-};
+#define TPM_MINOR		224	/* officially assigned */
+#define TPM_BUFSIZE		4096
+#define TPM_NUM_DEVICES		65536
+#define TPM_RETRY		50	/* 5 seconds */
 
 enum tpm_timeout {
 	TPM_TIMEOUT = 5,	/* msecs */
@@ -65,16 +57,6 @@ enum tpm_addr {
 	TPM_ADDR = 0x4E,
 };
 
-/* Indexes the duration array */
-enum tpm_duration {
-	TPM_SHORT = 0,
-	TPM_MEDIUM = 1,
-	TPM_LONG = 2,
-	TPM_LONG_LONG = 3,
-	TPM_UNDEFINED,
-	TPM_NUM_DURATIONS = TPM_UNDEFINED,
-};
-
 #define TPM_WARN_RETRY          0x800
 #define TPM_WARN_DOING_SELFTEST 0x802
 #define TPM_ERR_DEACTIVATED     0x6
@@ -179,15 +161,6 @@ enum tpm2_cc_attrs {
 #define TPM_VID_WINBOND  0x1050
 #define TPM_VID_STM      0x104A
 
-#define TPM_PPI_VERSION_LEN		3
-
-struct tpm_space {
-	u32 context_tbl[3];
-	u8 *context_buf;
-	u32 session_tbl[3];
-	u8 *session_buf;
-};
-
 enum tpm_chip_flags {
 	TPM_CHIP_FLAG_TPM2		= BIT(1),
 	TPM_CHIP_FLAG_IRQ		= BIT(2),
@@ -196,71 +169,6 @@ enum tpm_chip_flags {
 	TPM_CHIP_FLAG_ALWAYS_POWERED	= BIT(5),
 };
 
-struct tpm_bios_log {
-	void *bios_event_log;
-	void *bios_event_log_end;
-};
-
-struct tpm_chip_seqops {
-	struct tpm_chip *chip;
-	const struct seq_operations *seqops;
-};
-
-struct tpm_chip {
-	struct device dev;
-	struct device devs;
-	struct cdev cdev;
-	struct cdev cdevs;
-
-	/* A driver callback under ops cannot be run unless ops_sem is held
-	 * (sometimes implicitly, eg for the sysfs code). ops becomes null
-	 * when the driver is unregistered, see tpm_try_get_ops.
-	 */
-	struct rw_semaphore ops_sem;
-	const struct tpm_class_ops *ops;
-
-	struct tpm_bios_log log;
-	struct tpm_chip_seqops bin_log_seqops;
-	struct tpm_chip_seqops ascii_log_seqops;
-
-	unsigned int flags;
-
-	int dev_num;		/* /dev/tpm# */
-	unsigned long is_open;	/* only one allowed */
-
-	char hwrng_name[64];
-	struct hwrng hwrng;
-
-	struct mutex tpm_mutex;	/* tpm is processing */
-
-	unsigned long timeout_a; /* jiffies */
-	unsigned long timeout_b; /* jiffies */
-	unsigned long timeout_c; /* jiffies */
-	unsigned long timeout_d; /* jiffies */
-	bool timeout_adjusted;
-	unsigned long duration[TPM_NUM_DURATIONS]; /* jiffies */
-	bool duration_adjusted;
-
-	struct dentry *bios_dir[TPM_NUM_EVENT_LOG_FILES];
-
-	const struct attribute_group *groups[3];
-	unsigned int groups_cnt;
-
-	u32 nr_allocated_banks;
-	struct tpm_bank_info *allocated_banks;
-#ifdef CONFIG_ACPI
-	acpi_handle acpi_dev_handle;
-	char ppi_version[TPM_PPI_VERSION_LEN + 1];
-#endif /* CONFIG_ACPI */
-
-	struct tpm_space work_space;
-	u32 nr_commands;
-	u32 *cc_attrs_tbl;
-
-	/* active locality */
-	int locality;
-};
-
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
 
 struct tpm_input_header {
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index afd022fc9d3d..f9fea1e4075e 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -22,6 +22,10 @@
 #ifndef __LINUX_TPM_H__
 #define __LINUX_TPM_H__
 
+#include <linux/hw_random.h>
+#include <linux/acpi.h>
+#include <linux/cdev.h>
+#include <linux/fs.h>
 #include <crypto/hash_info.h>
 
 #define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
@@ -75,6 +79,92 @@ struct tpm_class_ops {
 	void (*clk_enable)(struct tpm_chip *chip, bool value);
 };
 
+#define TPM_NUM_EVENT_LOG_FILES		3
+
+/* Indexes the duration array */
+enum tpm_duration {
+	TPM_SHORT = 0,
+	TPM_MEDIUM = 1,
+	TPM_LONG = 2,
+	TPM_LONG_LONG = 3,
+	TPM_UNDEFINED,
+	TPM_NUM_DURATIONS = TPM_UNDEFINED,
+};
+
+#define TPM_PPI_VERSION_LEN		3
+
+struct tpm_space {
+	u32 context_tbl[3];
+	u8 *context_buf;
+	u32 session_tbl[3];
+	u8 *session_buf;
+};
+
+struct tpm_bios_log {
+	void *bios_event_log;
+	void *bios_event_log_end;
+};
+
+struct tpm_chip_seqops {
+	struct tpm_chip *chip;
+	const struct seq_operations *seqops;
+};
+
+struct tpm_chip {
+	struct device dev;
+	struct device devs;
+	struct cdev cdev;
+	struct cdev cdevs;
+
+	/* A driver callback under ops cannot be run unless ops_sem is held
+	 * (sometimes implicitly, eg for the sysfs code). ops becomes null
+	 * when the driver is unregistered, see tpm_try_get_ops.
+	 */
+	struct rw_semaphore ops_sem;
+	const struct tpm_class_ops *ops;
+
+	struct tpm_bios_log log;
+	struct tpm_chip_seqops bin_log_seqops;
+	struct tpm_chip_seqops ascii_log_seqops;
+
+	unsigned int flags;
+
+	int dev_num;		/* /dev/tpm# */
+	unsigned long is_open;	/* only one allowed */
+
+	char hwrng_name[64];
+	struct hwrng hwrng;
+
+	struct mutex tpm_mutex;	/* tpm is processing */
+
+	unsigned long timeout_a; /* jiffies */
+	unsigned long timeout_b; /* jiffies */
+	unsigned long timeout_c; /* jiffies */
+	unsigned long timeout_d; /* jiffies */
+	bool timeout_adjusted;
+	unsigned long duration[TPM_NUM_DURATIONS]; /* jiffies */
+	bool duration_adjusted;
+
+	struct dentry *bios_dir[TPM_NUM_EVENT_LOG_FILES];
+
+	const struct attribute_group *groups[3];
+	unsigned int groups_cnt;
+
+	u32 nr_allocated_banks;
+	struct tpm_bank_info *allocated_banks;
+#ifdef CONFIG_ACPI
+	acpi_handle acpi_dev_handle;
+	char ppi_version[TPM_PPI_VERSION_LEN + 1];
+#endif /* CONFIG_ACPI */
+
+	struct tpm_space work_space;
+	u32 nr_commands;
+	u32 *cc_attrs_tbl;
+
+	/* active locality */
+	int locality;
+};
+
 #if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
 
 extern int tpm_is_tpm2(struct tpm_chip *chip);
-- 
2.17.1

