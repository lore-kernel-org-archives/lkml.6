Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753042AbeDLKO7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 06:14:59 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:39367 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752840AbeDLKOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 06:14:22 -0400
X-Google-Smtp-Source: AIpwx494/mfWo8uv3z2AXnKnwMXEv2WyhHjIGfJJKNtnMAxhGFrn4SYBoNHyfS0sTSFrcZSk5xIua/qWcQ==
MIME-Version: 1.0
Date: Thu, 12 Apr 2018 12:13:49 +0200
In-Reply-To: <20180412101350.210547-1-tweek@google.com>
Message-Id: <20180412101350.210547-4-tweek@google.com>
References: <20180412101350.210547-1-tweek@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Subject: [PATCH v2 3/4] tpm: Move shared eventlog functions to common.c
From: Thiebaud Weksteen <tweek@google.com>
To: jarkko.sakkinen@linux.intel.com, nayna@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        tweek@google.com
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thiebaud Weksteen <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functions and structures specific to TPM1 are renamed from tpm* to tpm1*.

Signed-off-by: Thiebaud Weksteen <tweek@google.com>
Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/Makefile          |   4 +-
 drivers/char/tpm/eventlog/common.c | 195 ++++++++++++++++++++++++++++
 drivers/char/tpm/eventlog/tpm1.c   | 197 +++--------------------------
 drivers/char/tpm/tpm.h             |   2 +
 4 files changed, 214 insertions(+), 184 deletions(-)
 create mode 100644 drivers/char/tpm/eventlog/common.c

diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index 5dcf5bd35a3d..4e9c33ca1f8f 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -4,8 +4,8 @@
 #
 obj-$(CONFIG_TCG_TPM) += tpm.o
 tpm-y := tpm-interface.o tpm-dev.o tpm-sysfs.o tpm-chip.o tpm2-cmd.o \
-	 tpm-dev-common.o tpmrm-dev.o eventlog/tpm1.o eventlog/tpm2.o \
-         tpm2-space.o
+	 tpm-dev-common.o tpmrm-dev.o eventlog/common.o eventlog/tpm1.o \
+	 eventlog/tpm2.o tpm2-space.o
 tpm-$(CONFIG_ACPI) += tpm_ppi.o eventlog/acpi.o
 tpm-$(CONFIG_EFI) += eventlog/efi.o
 tpm-$(CONFIG_OF) += eventlog/of.o
diff --git a/drivers/char/tpm/eventlog/common.c b/drivers/char/tpm/eventlog/common.c
new file mode 100644
index 000000000000..54934b5a1566
--- /dev/null
+++ b/drivers/char/tpm/eventlog/common.c
@@ -0,0 +1,195 @@
+/*
+ * Copyright (C) 2005, 2012 IBM Corporation
+ *
+ * Authors:
+ *	Kent Yoder <key@linux.vnet.ibm.com>
+ *	Seiji Munetoh <munetoh@jp.ibm.com>
+ *	Stefan Berger <stefanb@us.ibm.com>
+ *	Reiner Sailer <sailer@watson.ibm.com>
+ *	Kylene Hall <kjhall@us.ibm.com>
+ *	Nayna Jain <nayna@linux.vnet.ibm.com>
+ *
+ * Access to the event log created by a system's firmware / BIOS
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ */
+
+#include <linux/seq_file.h>
+#include <linux/fs.h>
+#include <linux/security.h>
+#include <linux/module.h>
+#include <linux/tpm_eventlog.h>
+
+#include "../tpm.h"
+
+
+static int tpm_bios_measurements_open(struct inode *inode,
+					    struct file *file)
+{
+	int err;
+	struct seq_file *seq;
+	struct tpm_chip_seqops *chip_seqops;
+	const struct seq_operations *seqops;
+	struct tpm_chip *chip;
+
+	inode_lock(inode);
+	if (!inode->i_private) {
+		inode_unlock(inode);
+		return -ENODEV;
+	}
+	chip_seqops = (struct tpm_chip_seqops *)inode->i_private;
+	seqops = chip_seqops->seqops;
+	chip = chip_seqops->chip;
+	get_device(&chip->dev);
+	inode_unlock(inode);
+
+	/* now register seq file */
+	err = seq_open(file, seqops);
+	if (!err) {
+		seq = file->private_data;
+		seq->private = chip;
+	}
+
+	return err;
+}
+
+static int tpm_bios_measurements_release(struct inode *inode,
+					 struct file *file)
+{
+	struct seq_file *seq = (struct seq_file *)file->private_data;
+	struct tpm_chip *chip = (struct tpm_chip *)seq->private;
+
+	put_device(&chip->dev);
+
+	return seq_release(inode, file);
+}
+
+static const struct file_operations tpm_bios_measurements_ops = {
+	.owner = THIS_MODULE,
+	.open = tpm_bios_measurements_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = tpm_bios_measurements_release,
+};
+
+static int tpm_read_log(struct tpm_chip *chip)
+{
+	int rc;
+
+	if (chip->log.bios_event_log != NULL) {
+		dev_dbg(&chip->dev,
+			"%s: ERROR - event log already initialized\n",
+			__func__);
+		return -EFAULT;
+	}
+
+	rc = tpm_read_log_acpi(chip);
+	if (rc != -ENODEV)
+		return rc;
+
+	rc = tpm_read_log_efi(chip);
+	if (rc != -ENODEV)
+		return rc;
+
+	return tpm_read_log_of(chip);
+}
+
+/*
+ * tpm_bios_log_setup() - Read the event log from the firmware
+ * @chip: TPM chip to use.
+ *
+ * If an event log is found then the securityfs files are setup to
+ * export it to userspace, otherwise nothing is done.
+ *
+ * Returns -ENODEV if the firmware has no event log or securityfs is not
+ * supported.
+ */
+int tpm_bios_log_setup(struct tpm_chip *chip)
+{
+	const char *name = dev_name(&chip->dev);
+	unsigned int cnt;
+	int log_version;
+	int rc = 0;
+
+	rc = tpm_read_log(chip);
+	if (rc < 0)
+		return rc;
+	log_version = rc;
+
+	cnt = 0;
+	chip->bios_dir[cnt] = securityfs_create_dir(name, NULL);
+	/* NOTE: securityfs_create_dir can return ENODEV if securityfs is
+	 * compiled out. The caller should ignore the ENODEV return code.
+	 */
+	if (IS_ERR(chip->bios_dir[cnt]))
+		goto err;
+	cnt++;
+
+	chip->bin_log_seqops.chip = chip;
+	if (log_version == EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
+		chip->bin_log_seqops.seqops =
+			&tpm2_binary_b_measurements_seqops;
+	else
+		chip->bin_log_seqops.seqops =
+			&tpm1_binary_b_measurements_seqops;
+
+
+	chip->bios_dir[cnt] =
+	    securityfs_create_file("binary_bios_measurements",
+				   0440, chip->bios_dir[0],
+				   (void *)&chip->bin_log_seqops,
+				   &tpm_bios_measurements_ops);
+	if (IS_ERR(chip->bios_dir[cnt]))
+		goto err;
+	cnt++;
+
+	if (!(chip->flags & TPM_CHIP_FLAG_TPM2)) {
+
+		chip->ascii_log_seqops.chip = chip;
+		chip->ascii_log_seqops.seqops =
+			&tpm1_ascii_b_measurements_seqops;
+
+		chip->bios_dir[cnt] =
+			securityfs_create_file("ascii_bios_measurements",
+					       0440, chip->bios_dir[0],
+					       (void *)&chip->ascii_log_seqops,
+					       &tpm_bios_measurements_ops);
+		if (IS_ERR(chip->bios_dir[cnt]))
+			goto err;
+		cnt++;
+	}
+
+	return 0;
+
+err:
+	rc = PTR_ERR(chip->bios_dir[cnt]);
+	chip->bios_dir[cnt] = NULL;
+	tpm_bios_log_teardown(chip);
+	return rc;
+}
+
+void tpm_bios_log_teardown(struct tpm_chip *chip)
+{
+	int i;
+	struct inode *inode;
+
+	/* securityfs_remove currently doesn't take care of handling sync
+	 * between removal and opening of pseudo files. To handle this, a
+	 * workaround is added by making i_private = NULL here during removal
+	 * and to check it during open(), both within inode_lock()/unlock().
+	 * This design ensures that open() either safely gets kref or fails.
+	 */
+	for (i = (TPM_NUM_EVENT_LOG_FILES - 1); i >= 0; i--) {
+		if (chip->bios_dir[i]) {
+			inode = d_inode(chip->bios_dir[i]);
+			inode_lock(inode);
+			inode->i_private = NULL;
+			inode_unlock(inode);
+			securityfs_remove(chip->bios_dir[i]);
+		}
+	}
+}
diff --git a/drivers/char/tpm/eventlog/tpm1.c b/drivers/char/tpm/eventlog/tpm1.c
index d6aea3ca950e..8f30316e9bb6 100644
--- a/drivers/char/tpm/eventlog/tpm1.c
+++ b/drivers/char/tpm/eventlog/tpm1.c
@@ -71,7 +71,7 @@ static const char* tcpa_pc_event_id_strings[] = {
 };
 
 /* returns pointer to start of pos. entry of tcg log */
-static void *tpm_bios_measurements_start(struct seq_file *m, loff_t *pos)
+static void *tpm1_bios_measurements_start(struct seq_file *m, loff_t *pos)
 {
 	loff_t i;
 	struct tpm_chip *chip = m->private;
@@ -118,7 +118,7 @@ static void *tpm_bios_measurements_start(struct seq_file *m, loff_t *pos)
 	return addr;
 }
 
-static void *tpm_bios_measurements_next(struct seq_file *m, void *v,
+static void *tpm1_bios_measurements_next(struct seq_file *m, void *v,
 					loff_t *pos)
 {
 	struct tcpa_event *event = v;
@@ -149,7 +149,7 @@ static void *tpm_bios_measurements_next(struct seq_file *m, void *v,
 	return v;
 }
 
-static void tpm_bios_measurements_stop(struct seq_file *m, void *v)
+static void tpm1_bios_measurements_stop(struct seq_file *m, void *v)
 {
 }
 
@@ -232,7 +232,7 @@ static int get_event_name(char *dest, struct tcpa_event *event,
 
 }
 
-static int tpm_binary_bios_measurements_show(struct seq_file *m, void *v)
+static int tpm1_binary_bios_measurements_show(struct seq_file *m, void *v)
 {
 	struct tcpa_event *event = v;
 	struct tcpa_event temp_event;
@@ -261,18 +261,7 @@ static int tpm_binary_bios_measurements_show(struct seq_file *m, void *v)
 
 }
 
-static int tpm_bios_measurements_release(struct inode *inode,
-					 struct file *file)
-{
-	struct seq_file *seq = (struct seq_file *)file->private_data;
-	struct tpm_chip *chip = (struct tpm_chip *)seq->private;
-
-	put_device(&chip->dev);
-
-	return seq_release(inode, file);
-}
-
-static int tpm_ascii_bios_measurements_show(struct seq_file *m, void *v)
+static int tpm1_ascii_bios_measurements_show(struct seq_file *m, void *v)
 {
 	int len = 0;
 	char *eventname;
@@ -305,172 +294,16 @@ static int tpm_ascii_bios_measurements_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static const struct seq_operations tpm_ascii_b_measurements_seqops = {
-	.start = tpm_bios_measurements_start,
-	.next = tpm_bios_measurements_next,
-	.stop = tpm_bios_measurements_stop,
-	.show = tpm_ascii_bios_measurements_show,
+const struct seq_operations tpm1_ascii_b_measurements_seqops = {
+	.start = tpm1_bios_measurements_start,
+	.next = tpm1_bios_measurements_next,
+	.stop = tpm1_bios_measurements_stop,
+	.show = tpm1_ascii_bios_measurements_show,
 };
 
-static const struct seq_operations tpm_binary_b_measurements_seqops = {
-	.start = tpm_bios_measurements_start,
-	.next = tpm_bios_measurements_next,
-	.stop = tpm_bios_measurements_stop,
-	.show = tpm_binary_bios_measurements_show,
-};
-
-static int tpm_bios_measurements_open(struct inode *inode,
-					    struct file *file)
-{
-	int err;
-	struct seq_file *seq;
-	struct tpm_chip_seqops *chip_seqops;
-	const struct seq_operations *seqops;
-	struct tpm_chip *chip;
-
-	inode_lock(inode);
-	if (!inode->i_private) {
-		inode_unlock(inode);
-		return -ENODEV;
-	}
-	chip_seqops = (struct tpm_chip_seqops *)inode->i_private;
-	seqops = chip_seqops->seqops;
-	chip = chip_seqops->chip;
-	get_device(&chip->dev);
-	inode_unlock(inode);
-
-	/* now register seq file */
-	err = seq_open(file, seqops);
-	if (!err) {
-		seq = file->private_data;
-		seq->private = chip;
-	}
-
-	return err;
-}
-
-static const struct file_operations tpm_bios_measurements_ops = {
-	.owner = THIS_MODULE,
-	.open = tpm_bios_measurements_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = tpm_bios_measurements_release,
+const struct seq_operations tpm1_binary_b_measurements_seqops = {
+	.start = tpm1_bios_measurements_start,
+	.next = tpm1_bios_measurements_next,
+	.stop = tpm1_bios_measurements_stop,
+	.show = tpm1_binary_bios_measurements_show,
 };
-
-static int tpm_read_log(struct tpm_chip *chip)
-{
-	int rc;
-
-	if (chip->log.bios_event_log != NULL) {
-		dev_dbg(&chip->dev,
-			"%s: ERROR - event log already initialized\n",
-			__func__);
-		return -EFAULT;
-	}
-
-	rc = tpm_read_log_acpi(chip);
-	if (rc != -ENODEV)
-		return rc;
-
-	rc = tpm_read_log_efi(chip);
-	if (rc != -ENODEV)
-		return rc;
-
-	return tpm_read_log_of(chip);
-}
-
-/*
- * tpm_bios_log_setup() - Read the event log from the firmware
- * @chip: TPM chip to use.
- *
- * If an event log is found then the securityfs files are setup to
- * export it to userspace, otherwise nothing is done.
- *
- * Returns -ENODEV if the firmware has no event log or securityfs is not
- * supported.
- */
-int tpm_bios_log_setup(struct tpm_chip *chip)
-{
-	const char *name = dev_name(&chip->dev);
-	unsigned int cnt;
-	int log_version;
-	int rc = 0;
-
-	rc = tpm_read_log(chip);
-	if (rc < 0)
-		return rc;
-	log_version = rc;
-
-	cnt = 0;
-	chip->bios_dir[cnt] = securityfs_create_dir(name, NULL);
-	/* NOTE: securityfs_create_dir can return ENODEV if securityfs is
-	 * compiled out. The caller should ignore the ENODEV return code.
-	 */
-	if (IS_ERR(chip->bios_dir[cnt]))
-		goto err;
-	cnt++;
-
-	chip->bin_log_seqops.chip = chip;
-	if (log_version == EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
-		chip->bin_log_seqops.seqops =
-			&tpm2_binary_b_measurements_seqops;
-	else
-		chip->bin_log_seqops.seqops =
-			&tpm_binary_b_measurements_seqops;
-
-
-	chip->bios_dir[cnt] =
-	    securityfs_create_file("binary_bios_measurements",
-				   0440, chip->bios_dir[0],
-				   (void *)&chip->bin_log_seqops,
-				   &tpm_bios_measurements_ops);
-	if (IS_ERR(chip->bios_dir[cnt]))
-		goto err;
-	cnt++;
-
-	if (!(chip->flags & TPM_CHIP_FLAG_TPM2)) {
-
-		chip->ascii_log_seqops.chip = chip;
-		chip->ascii_log_seqops.seqops =
-			&tpm_ascii_b_measurements_seqops;
-
-		chip->bios_dir[cnt] =
-			securityfs_create_file("ascii_bios_measurements",
-					       0440, chip->bios_dir[0],
-					       (void *)&chip->ascii_log_seqops,
-					       &tpm_bios_measurements_ops);
-		if (IS_ERR(chip->bios_dir[cnt]))
-			goto err;
-		cnt++;
-	}
-
-	return 0;
-
-err:
-	rc = PTR_ERR(chip->bios_dir[cnt]);
-	chip->bios_dir[cnt] = NULL;
-	tpm_bios_log_teardown(chip);
-	return rc;
-}
-
-void tpm_bios_log_teardown(struct tpm_chip *chip)
-{
-	int i;
-	struct inode *inode;
-
-	/* securityfs_remove currently doesn't take care of handling sync
-	 * between removal and opening of pseudo files. To handle this, a
-	 * workaround is added by making i_private = NULL here during removal
-	 * and to check it during open(), both within inode_lock()/unlock().
-	 * This design ensures that open() either safely gets kref or fails.
-	 */
-	for (i = (TPM_NUM_EVENT_LOG_FILES - 1); i >= 0; i--) {
-		if (chip->bios_dir[i]) {
-			inode = d_inode(chip->bios_dir[i]);
-			inode_lock(inode);
-			inode->i_private = NULL;
-			inode_unlock(inode);
-			securityfs_remove(chip->bios_dir[i]);
-		}
-	}
-}
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index f895fba4e20d..a583c5001904 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -580,6 +580,8 @@ int tpm2_prepare_space(struct tpm_chip *chip, struct tpm_space *space, u32 cc,
 int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space,
 		      u32 cc, u8 *buf, size_t *bufsiz);
 
+extern const struct seq_operations tpm1_ascii_b_measurements_seqops;
+extern const struct seq_operations tpm1_binary_b_measurements_seqops;
 extern const struct seq_operations tpm2_binary_b_measurements_seqops;
 
 #if defined(CONFIG_ACPI)
-- 
2.17.0.484.g0c8726318c-goog
