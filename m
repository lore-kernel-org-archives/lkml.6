Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752389AbeDLKOc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 06:14:32 -0400
Received: from mail-yb0-f202.google.com ([209.85.213.202]:56042 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752901AbeDLKO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 06:14:27 -0400
X-Google-Smtp-Source: AIpwx48zSYyzUvoXi/bZEVdX5RJpe94ApD6YlZT1PRIpBEF8fk5bbQl41eZieZbI2gtuoDU77KHpn22jbA==
MIME-Version: 1.0
Date: Thu, 12 Apr 2018 12:13:50 +0200
In-Reply-To: <20180412101350.210547-1-tweek@google.com>
Message-Id: <20180412101350.210547-5-tweek@google.com>
References: <20180412101350.210547-1-tweek@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Subject: [PATCH v2 4/4] tpm: Move eventlog declarations to its own header
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

Reduce the size of tpm.h by moving eventlog declarations to a separate
header.

Signed-off-by: Thiebaud Weksteen <tweek@google.com>
Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/eventlog/acpi.c   |  1 +
 drivers/char/tpm/eventlog/common.c |  2 +-
 drivers/char/tpm/eventlog/common.h | 35 ++++++++++++++++++++++++++++++
 drivers/char/tpm/eventlog/efi.c    |  1 +
 drivers/char/tpm/eventlog/of.c     |  1 +
 drivers/char/tpm/eventlog/tpm1.c   |  1 +
 drivers/char/tpm/eventlog/tpm2.c   |  1 +
 drivers/char/tpm/tpm.h             | 29 -------------------------
 8 files changed, 41 insertions(+), 30 deletions(-)
 create mode 100644 drivers/char/tpm/eventlog/common.h

diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
index 8476be2e9526..7c53b1973b62 100644
--- a/drivers/char/tpm/eventlog/acpi.c
+++ b/drivers/char/tpm/eventlog/acpi.c
@@ -28,6 +28,7 @@
 #include <linux/tpm_eventlog.h>
 
 #include "../tpm.h"
+#include "common.h"
 
 struct acpi_tcpa {
 	struct acpi_table_header hdr;
diff --git a/drivers/char/tpm/eventlog/common.c b/drivers/char/tpm/eventlog/common.c
index 54934b5a1566..5a8720df2b51 100644
--- a/drivers/char/tpm/eventlog/common.c
+++ b/drivers/char/tpm/eventlog/common.c
@@ -25,7 +25,7 @@
 #include <linux/tpm_eventlog.h>
 
 #include "../tpm.h"
-
+#include "common.h"
 
 static int tpm_bios_measurements_open(struct inode *inode,
 					    struct file *file)
diff --git a/drivers/char/tpm/eventlog/common.h b/drivers/char/tpm/eventlog/common.h
new file mode 100644
index 000000000000..47ff8136ceb5
--- /dev/null
+++ b/drivers/char/tpm/eventlog/common.h
@@ -0,0 +1,35 @@
+#ifndef __TPM_EVENTLOG_COMMON_H__
+#define __TPM_EVENTLOG_COMMON_H__
+
+#include "../tpm.h"
+
+extern const struct seq_operations tpm1_ascii_b_measurements_seqops;
+extern const struct seq_operations tpm1_binary_b_measurements_seqops;
+extern const struct seq_operations tpm2_binary_b_measurements_seqops;
+
+#if defined(CONFIG_ACPI)
+int tpm_read_log_acpi(struct tpm_chip *chip);
+#else
+static inline int tpm_read_log_acpi(struct tpm_chip *chip)
+{
+	return -ENODEV;
+}
+#endif
+#if defined(CONFIG_OF)
+int tpm_read_log_of(struct tpm_chip *chip);
+#else
+static inline int tpm_read_log_of(struct tpm_chip *chip)
+{
+	return -ENODEV;
+}
+#endif
+#if defined(CONFIG_EFI)
+int tpm_read_log_efi(struct tpm_chip *chip);
+#else
+static inline int tpm_read_log_efi(struct tpm_chip *chip)
+{
+	return -ENODEV;
+}
+#endif
+
+#endif
diff --git a/drivers/char/tpm/eventlog/efi.c b/drivers/char/tpm/eventlog/efi.c
index e1593c5271a4..68f1e7ee60ce 100644
--- a/drivers/char/tpm/eventlog/efi.c
+++ b/drivers/char/tpm/eventlog/efi.c
@@ -15,6 +15,7 @@
 #include <linux/tpm_eventlog.h>
 
 #include "../tpm.h"
+#include "common.h"
 
 /* read binary bios log from EFI configuration table */
 int tpm_read_log_efi(struct tpm_chip *chip)
diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
index d98c184d5c13..f8ad4c3ffe8e 100644
--- a/drivers/char/tpm/eventlog/of.c
+++ b/drivers/char/tpm/eventlog/of.c
@@ -20,6 +20,7 @@
 #include <linux/tpm_eventlog.h>
 
 #include "../tpm.h"
+#include "common.h"
 
 int tpm_read_log_of(struct tpm_chip *chip)
 {
diff --git a/drivers/char/tpm/eventlog/tpm1.c b/drivers/char/tpm/eventlog/tpm1.c
index 8f30316e9bb6..58c84784ba25 100644
--- a/drivers/char/tpm/eventlog/tpm1.c
+++ b/drivers/char/tpm/eventlog/tpm1.c
@@ -29,6 +29,7 @@
 #include <linux/tpm_eventlog.h>
 
 #include "../tpm.h"
+#include "common.h"
 
 
 static const char* tcpa_event_type_strings[] = {
diff --git a/drivers/char/tpm/eventlog/tpm2.c b/drivers/char/tpm/eventlog/tpm2.c
index f0723fa9ae14..1b8fa9de2cac 100644
--- a/drivers/char/tpm/eventlog/tpm2.c
+++ b/drivers/char/tpm/eventlog/tpm2.c
@@ -24,6 +24,7 @@
 #include <linux/tpm_eventlog.h>
 
 #include "../tpm.h"
+#include "common.h"
 
 /*
  * calc_tpm2_event_size() - calculate the event size, where event
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index a583c5001904..067f305e36f0 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -580,35 +580,6 @@ int tpm2_prepare_space(struct tpm_chip *chip, struct tpm_space *space, u32 cc,
 int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space,
 		      u32 cc, u8 *buf, size_t *bufsiz);
 
-extern const struct seq_operations tpm1_ascii_b_measurements_seqops;
-extern const struct seq_operations tpm1_binary_b_measurements_seqops;
-extern const struct seq_operations tpm2_binary_b_measurements_seqops;
-
-#if defined(CONFIG_ACPI)
-int tpm_read_log_acpi(struct tpm_chip *chip);
-#else
-static inline int tpm_read_log_acpi(struct tpm_chip *chip)
-{
-	return -ENODEV;
-}
-#endif
-#if defined(CONFIG_OF)
-int tpm_read_log_of(struct tpm_chip *chip);
-#else
-static inline int tpm_read_log_of(struct tpm_chip *chip)
-{
-	return -ENODEV;
-}
-#endif
-#if defined(CONFIG_EFI)
-int tpm_read_log_efi(struct tpm_chip *chip);
-#else
-static inline int tpm_read_log_efi(struct tpm_chip *chip)
-{
-	return -ENODEV;
-}
-#endif
-
 int tpm_bios_log_setup(struct tpm_chip *chip);
 void tpm_bios_log_teardown(struct tpm_chip *chip);
 #endif
-- 
2.17.0.484.g0c8726318c-goog
