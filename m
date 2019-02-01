Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E74DC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25342080D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbfBALd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 06:33:58 -0500
Received: from mga12.intel.com ([192.55.52.136]:11876 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbfBALd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 06:33:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2019 03:33:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,548,1539673200"; 
   d="scan'208";a="139818063"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.172])
  by fmsmga002.fm.intel.com with ESMTP; 01 Feb 2019 03:33:53 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morris <jmorris@namei.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH] tpm/tpm_crb: Avoid unaligned reads in crb_recv():
Date:   Fri,  1 Feb 2019 13:19:49 +0200
Message-Id: <20190201111949.14881-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current approach to read first 6 bytes from the response and then tail
of the response, can cause the 2nd memcpy_fromio() to do an unaligned read
(e.g. read 32-bit word from address aligned to a 16-bits), depending on how
memcpy_fromio() is implemented. If this happens, the read will fail and the
memory controller will fill the read with 1's.

This was triggered by 170d13ca3a2f, which should be probably refined to
check and react to the address alignment. Before that commit, on x86
memcpy_fromio() turned out to be memcpy(). By a luck GCC has done the right
thing (from tpm_crb's perspective) for us so far, but we should not rely on
that. Thus, it makes sense to fix this also in tpm_crb, not least because
the fix can be then backported to stable kernels and make them more robust
when compiled in differing environments.

Cc: stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: James Morris <jmorris@namei.org>
Cc: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>
Fixes: 30fc8d138e91 ("tpm: TPM 2.0 CRB Interface")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm_crb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 36952ef98f90..7f47e43aa9f1 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -288,18 +288,18 @@ static int crb_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 	unsigned int expected;
 
 	/* sanity check */
-	if (count < 6)
+	if (count < 8)
 		return -EIO;
 
 	if (ioread32(&priv->regs_t->ctrl_sts) & CRB_CTRL_STS_ERROR)
 		return -EIO;
 
-	memcpy_fromio(buf, priv->rsp, 6);
+	memcpy_fromio(buf, priv->rsp, 8);
 	expected = be32_to_cpup((__be32 *) &buf[2]);
-	if (expected > count || expected < 6)
+	if (expected > count || expected < 8)
 		return -EIO;
 
-	memcpy_fromio(&buf[6], &priv->rsp[6], expected - 6);
+	memcpy_fromio(&buf[8], &priv->rsp[8], expected - 8);
 
 	return expected;
 }
-- 
2.17.1

