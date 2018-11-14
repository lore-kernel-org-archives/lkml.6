Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF544C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993CB22360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 993CB22360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387430AbeKOBiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:38:18 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32766 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727731AbeKOBiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:38:18 -0500
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id AB69273AC78B8;
        Wed, 14 Nov 2018 15:34:31 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.153)
 by smtpsuk.huawei.com (10.201.108.37) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 14 Nov 2018 15:34:23 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <jarkko.sakkinen@linux.intel.com>, <zohar@linux.ibm.com>,
        <david.safford@ge.com>, <monty.wiseman@ge.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v5 2/7] tpm: remove definition of TPM2_ACTIVE_PCR_BANKS
Date:   Wed, 14 Nov 2018 16:31:03 +0100
Message-ID: <20181114153108.12907-3-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114153108.12907-1-roberto.sassu@huawei.com>
References: <20181114153108.12907-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.153]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tcg_efi_specid_event and tcg_pcr_event2 declaration contains static arrays
for a list of hash algorithms used for event logs and event log digests.

However, according to TCG EFI Protocol Specification, these arrays have
variable sizes. Setting the array size to zero or 3 does not make any
difference, because the parser has to adjust the offset depending on the
actual array size to access structure members after the static arrays.

Thus, this patch removes the declaration of TPM2_ACTIVE_PCR_BANKS and sets
the array size to zero.

Fixes: 4d23cc323cdb ("tpm: add securityfs support for TPM 2.0 firmware
event log")

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/tpm_eventlog.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index 20d9da77fc11..3d5d162f09cc 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -8,7 +8,6 @@
 #define TCG_EVENT_NAME_LEN_MAX	255
 #define MAX_TEXT_EVENT		1000	/* Max event string length */
 #define ACPI_TCPA_SIG		"TCPA"	/* 0x41504354 /'TCPA' */
-#define TPM2_ACTIVE_PCR_BANKS	3
 
 #define EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2 0x1
 #define EFI_TCG2_EVENT_LOG_FORMAT_TCG_2   0x2
@@ -90,7 +89,7 @@ struct tcg_efi_specid_event {
 	u8 spec_errata;
 	u8 uintnsize;
 	u32 num_algs;
-	struct tcg_efi_specid_event_algs digest_sizes[TPM2_ACTIVE_PCR_BANKS];
+	struct tcg_efi_specid_event_algs digest_sizes[0];
 	u8 vendor_info_size;
 	u8 vendor_info[0];
 } __packed;
@@ -117,7 +116,7 @@ struct tcg_pcr_event2 {
 	u32 pcr_idx;
 	u32 event_type;
 	u32 count;
-	struct tpm2_digest digests[TPM2_ACTIVE_PCR_BANKS];
+	struct tpm2_digest digests[0];
 	struct tcg_event_field event;
 } __packed;
 
-- 
2.17.1

