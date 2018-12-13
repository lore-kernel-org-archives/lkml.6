Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDC6C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07DF920811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07DF920811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbeLMKdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:33:40 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32812 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728017AbeLMKdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:33:39 -0500
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 8866BDE12DE1C;
        Thu, 13 Dec 2018 10:33:36 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.153)
 by smtpsuk.huawei.com (10.201.108.48) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 13 Dec 2018 10:33:31 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <jarkko.sakkinen@linux.intel.com>, <zohar@linux.ibm.com>,
        <david.safford@ge.com>, <monty.wiseman@ge.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v7 2/5] tpm: add _head suffix to tcg_efi_specid_event and tcg_pcr_event2
Date:   Thu, 13 Dec 2018 11:29:42 +0100
Message-ID: <20181213102945.30946-3-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213102945.30946-1-roberto.sassu@huawei.com>
References: <20181213102945.30946-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.153]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TCG defines two structures, TCG_EfiSpecIDEventStruct and TCG_PCR_EVENT2,
which contain variable-sized arrays in the middle of the definition.

Since these structures are not suitable for type casting, this patch
removes structure members after the variable-sized arrays and adds the
_head suffix to the structure name, to indicate that the renamed structures
do not contain all fields defined by TCG.

Lastly, given that variable-sized arrays are now in the last position, and
given that the size of the arrays cannot be determined in advance, this
patch also sets the size of those arrays to zero and removes the definition
of TPM2_ACTIVE_PCR_BANKS.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Nayna Jain <nayna@linux.ibm.com>
---
 drivers/char/tpm/eventlog/tpm2.c | 12 ++++++------
 include/linux/tpm_eventlog.h     | 12 ++++--------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/char/tpm/eventlog/tpm2.c b/drivers/char/tpm/eventlog/tpm2.c
index 1b8fa9de2cac..d8b77133a83a 100644
--- a/drivers/char/tpm/eventlog/tpm2.c
+++ b/drivers/char/tpm/eventlog/tpm2.c
@@ -37,10 +37,10 @@
  *
  * Returns size of the event. If it is an invalid event, returns 0.
  */
-static int calc_tpm2_event_size(struct tcg_pcr_event2 *event,
+static int calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 				struct tcg_pcr_event *event_header)
 {
-	struct tcg_efi_specid_event *efispecid;
+	struct tcg_efi_specid_event_head *efispecid;
 	struct tcg_event_field *event_field;
 	void *marker;
 	void *marker_start;
@@ -55,7 +55,7 @@ static int calc_tpm2_event_size(struct tcg_pcr_event2 *event,
 	marker = marker + sizeof(event->pcr_idx) + sizeof(event->event_type)
 		+ sizeof(event->count);
 
-	efispecid = (struct tcg_efi_specid_event *)event_header->event;
+	efispecid = (struct tcg_efi_specid_event_head *)event_header->event;
 
 	/* Check if event is malformed. */
 	if (event->count > efispecid->num_algs)
@@ -95,7 +95,7 @@ static void *tpm2_bios_measurements_start(struct seq_file *m, loff_t *pos)
 	void *addr = log->bios_event_log;
 	void *limit = log->bios_event_log_end;
 	struct tcg_pcr_event *event_header;
-	struct tcg_pcr_event2 *event;
+	struct tcg_pcr_event2_head *event;
 	size_t size;
 	int i;
 
@@ -136,7 +136,7 @@ static void *tpm2_bios_measurements_next(struct seq_file *m, void *v,
 					 loff_t *pos)
 {
 	struct tcg_pcr_event *event_header;
-	struct tcg_pcr_event2 *event;
+	struct tcg_pcr_event2_head *event;
 	struct tpm_chip *chip = m->private;
 	struct tpm_bios_log *log = &chip->log;
 	void *limit = log->bios_event_log_end;
@@ -180,7 +180,7 @@ static int tpm2_binary_bios_measurements_show(struct seq_file *m, void *v)
 	struct tpm_chip *chip = m->private;
 	struct tpm_bios_log *log = &chip->log;
 	struct tcg_pcr_event *event_header = log->bios_event_log;
-	struct tcg_pcr_event2 *event = v;
+	struct tcg_pcr_event2_head *event = v;
 	void *temp_ptr;
 	size_t size;
 
diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index 20d9da77fc11..f47342361e87 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -8,7 +8,6 @@
 #define TCG_EVENT_NAME_LEN_MAX	255
 #define MAX_TEXT_EVENT		1000	/* Max event string length */
 #define ACPI_TCPA_SIG		"TCPA"	/* 0x41504354 /'TCPA' */
-#define TPM2_ACTIVE_PCR_BANKS	3
 
 #define EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2 0x1
 #define EFI_TCG2_EVENT_LOG_FORMAT_TCG_2   0x2
@@ -82,7 +81,7 @@ struct tcg_efi_specid_event_algs {
 	u16 digest_size;
 } __packed;
 
-struct tcg_efi_specid_event {
+struct tcg_efi_specid_event_head {
 	u8 signature[16];
 	u32 platform_class;
 	u8 spec_version_minor;
@@ -90,9 +89,7 @@ struct tcg_efi_specid_event {
 	u8 spec_errata;
 	u8 uintnsize;
 	u32 num_algs;
-	struct tcg_efi_specid_event_algs digest_sizes[TPM2_ACTIVE_PCR_BANKS];
-	u8 vendor_info_size;
-	u8 vendor_info[0];
+	struct tcg_efi_specid_event_algs digest_sizes[];
 } __packed;
 
 struct tcg_pcr_event {
@@ -113,12 +110,11 @@ struct tpm2_digest {
 	u8 digest[SHA512_DIGEST_SIZE];
 } __packed;
 
-struct tcg_pcr_event2 {
+struct tcg_pcr_event2_head {
 	u32 pcr_idx;
 	u32 event_type;
 	u32 count;
-	struct tpm2_digest digests[TPM2_ACTIVE_PCR_BANKS];
-	struct tcg_event_field event;
+	struct tpm2_digest digests[];
 } __packed;
 
 #endif
-- 
2.17.1

