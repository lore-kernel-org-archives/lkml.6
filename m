Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB16C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2FF522419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:36:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2FF522419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387634AbeKOBka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:40:30 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32770 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727731AbeKOBka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:40:30 -0500
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 780692FF2BF5;
        Wed, 14 Nov 2018 15:36:43 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.153)
 by smtpsuk.huawei.com (10.201.108.37) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 14 Nov 2018 15:36:39 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <jarkko.sakkinen@linux.intel.com>, <zohar@linux.ibm.com>,
        <david.safford@ge.com>, <monty.wiseman@ge.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v5 6/7] tpm: ensure that the output of PCR read contains the correct digest size
Date:   Wed, 14 Nov 2018 16:31:07 +0100
Message-ID: <20181114153108.12907-7-roberto.sassu@huawei.com>
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

This patch protects against data corruption that could happen in the bus,
by checking that that the digest size returned by the TPM during a PCR read
matches the size of the algorithm passed to tpm2_pcr_read().

This check is performed after information about the PCR banks has been
retrieved.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: stable@vger.kernel.org
---
 drivers/char/tpm/tpm2-cmd.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index acaaab72ef2e..974465f04b78 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -179,15 +179,29 @@ struct tpm2_pcr_read_out {
 int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 		  struct tpm_digest *digest_struct, u16 *digest_size_ptr)
 {
+	int i;
 	int rc;
 	struct tpm_buf buf;
 	struct tpm2_pcr_read_out *out;
 	u8 pcr_select[TPM2_PCR_SELECT_MIN] = {0};
 	u16 digest_size;
+	u16 expected_digest_size = 0;
 
 	if (pcr_idx >= TPM2_PLATFORM_PCR)
 		return -EINVAL;
 
+	if (!digest_size_ptr) {
+		for (i = 0; i < chip->nr_allocated_banks &&
+		     chip->allocated_banks[i].alg_id != digest_struct->alg_id;
+		     i++)
+			;
+
+		if (i == chip->nr_allocated_banks)
+			return -EINVAL;
+
+		expected_digest_size = chip->allocated_banks[i].digest_size;
+	}
+
 	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_PCR_READ);
 	if (rc)
 		return rc;
@@ -207,7 +221,8 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 
 	out = (struct tpm2_pcr_read_out *)&buf.data[TPM_HEADER_SIZE];
 	digest_size = be16_to_cpu(out->digest_size);
-	if (digest_size > sizeof(digest_struct->digest)) {
+	if (digest_size > sizeof(digest_struct->digest) ||
+	    (!digest_size_ptr && digest_size != expected_digest_size)) {
 		rc = -EINVAL;
 		goto out;
 	}
-- 
2.17.1

