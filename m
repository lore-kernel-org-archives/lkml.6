Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA54ECDE44
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE2B20664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE2B20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeJaAop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:44:45 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32704 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726792AbeJaAop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:44:45 -0400
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 13B9732EFFD8B;
        Tue, 30 Oct 2018 15:50:43 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.153)
 by smtpsuk.huawei.com (10.201.108.44) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Tue, 30 Oct 2018 15:50:37 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <jarkko.sakkinen@linux.intel.com>, <zohar@linux.ibm.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 1/5] tpm: change the end marker of the active_banks array to zero
Date:   Tue, 30 Oct 2018 16:47:07 +0100
Message-ID: <20181030154711.2782-2-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030154711.2782-1-roberto.sassu@huawei.com>
References: <20181030154711.2782-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.153]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the end marker of the active_banks array from
TPM2_ALG_ERROR to zero.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 drivers/char/tpm/tpm-interface.c | 2 +-
 drivers/char/tpm/tpm2-cmd.c      | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 1a803b0cf980..f7fc4b5ee239 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -1051,7 +1051,7 @@ int tpm_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash)
 		memset(digest_list, 0, sizeof(digest_list));
 
 		for (i = 0; i < ARRAY_SIZE(chip->active_banks) &&
-			    chip->active_banks[i] != TPM2_ALG_ERROR; i++) {
+			    chip->active_banks[i]; i++) {
 			digest_list[i].alg_id = chip->active_banks[i];
 			memcpy(digest_list[i].digest, hash, TPM_DIGEST_SIZE);
 			count++;
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index c31b490bd41d..046c9d8f3c1e 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -908,9 +908,6 @@ static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 	}
 
 out:
-	if (i < ARRAY_SIZE(chip->active_banks))
-		chip->active_banks[i] = TPM2_ALG_ERROR;
-
 	tpm_buf_destroy(&buf);
 
 	return rc;
-- 
2.17.1

