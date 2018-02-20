Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbeBTLlo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 06:41:44 -0500
Received: from mga06.intel.com ([134.134.136.31]:35043 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750710AbeBTLln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 06:41:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,539,1511856000";
   d="scan'208";a="18923306"
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: linux-integrity@vger.kernel.org
Cc: Nayna Jain <nayna@linux.vnet.ibm.com>,
        Thiebaud Weksteen <tweek@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] tpm: use kmemdup() to copy the event log
Date: Tue, 20 Feb 2018 13:41:29 +0200
Message-Id: <20180220114129.9300-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced kmalloc() + memcpy() in tpm_eventlog_efi.c and
tpm_eventlog_of.c.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
v2: update also tpm_eventlog_of.c
 drivers/char/tpm/tpm_eventlog_efi.c | 3 +--
 drivers/char/tpm/tpm_eventlog_of.c  | 5 +----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/char/tpm/tpm_eventlog_efi.c b/drivers/char/tpm/tpm_eventlog_efi.c
index e3f9ffd341d2..57c8b3cc46be 100644
--- a/drivers/char/tpm/tpm_eventlog_efi.c
+++ b/drivers/char/tpm/tpm_eventlog_efi.c
@@ -50,10 +50,9 @@ int tpm_read_log_efi(struct tpm_chip *chip)
 	}
 
 	/* malloc EventLog space */
-	log->bios_event_log = kmalloc(log_size, GFP_KERNEL);
+	log->bios_event_log = kmemdup(log_tbl->log, log_size, GFP_KERNEL);
 	if (!log->bios_event_log)
 		goto err_memunmap;
-	memcpy(log->bios_event_log, log_tbl->log, log_size);
 	log->bios_event_log_end = log->bios_event_log + log_size;
 
 	tpm_log_version = log_tbl->version;
diff --git a/drivers/char/tpm/tpm_eventlog_of.c b/drivers/char/tpm/tpm_eventlog_of.c
index 96fd5646f866..c4b1d3049060 100644
--- a/drivers/char/tpm/tpm_eventlog_of.c
+++ b/drivers/char/tpm/tpm_eventlog_of.c
@@ -68,14 +68,11 @@ int tpm_read_log_of(struct tpm_chip *chip)
 		return -EIO;
 	}
 
-	log->bios_event_log = kmalloc(size, GFP_KERNEL);
+	log->bios_event_log = kmemdup(__va(base), size, GFP_KERNEL);
 	if (!log->bios_event_log)
 		return -ENOMEM;
-
 	log->bios_event_log_end = log->bios_event_log + size;
 
-	memcpy(log->bios_event_log, __va(base), size);
-
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
 		return EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
 	return EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
-- 
2.14.1
