Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33E8C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A64B20844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfBEKvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 05:51:47 -0500
Received: from mga14.intel.com ([192.55.52.115]:4825 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbfBEKvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 05:51:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 02:51:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,563,1539673200"; 
   d="scan'208";a="144297739"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.172])
  by fmsmga001.fm.intel.com with ESMTP; 05 Feb 2019 02:51:44 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        stable@vger.kernel.org, James Morris <jmorris@namei.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH v3] tpm/tpm_crb: Avoid unaligned reads in crb_recv()
Date:   Tue,  5 Feb 2019 12:51:36 +0200
Message-Id: <20190205105136.3086-1-jarkko.sakkinen@linux.intel.com>
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
Cc: James Morris <jmorris@namei.org>
Cc: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>
Fixes: 30fc8d138e91 ("tpm: TPM 2.0 CRB Interface")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
v3:
* Fix typo i.e. %s/reminding/remaining/g
v2:
* There was a trailing double colon in the end of the short summary.
* Check requested and expected length against TPM_HEADER_SIZE.
* Add some explanatory comments to crb_recv().
 drivers/char/tpm/tpm_crb.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 36952ef98f90..ee4df7815912 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -287,19 +287,29 @@ static int crb_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
 	unsigned int expected;
 
-	/* sanity check */
-	if (count < 6)
+	/* A sanity check that the upper layer wants to get at least the header
+	 * as that is the minimum size for any TPM response.
+	 */
+	if (count < TPM_HEADER_SIZE)
 		return -EIO;
 
+	/* If this bit is set, according to the spec, the TPM is in unrecovable
+	 * condition.
+	 */
 	if (ioread32(&priv->regs_t->ctrl_sts) & CRB_CTRL_STS_ERROR)
 		return -EIO;
 
-	memcpy_fromio(buf, priv->rsp, 6);
-	expected = be32_to_cpup((__be32 *) &buf[2]);
-	if (expected > count || expected < 6)
+	/* Read 8 bytes (not just 6 bytes, which would cover the response length
+	 * field) in order to make sure that the remaining memory accesses will
+	 * be aligned.
+	 */
+	memcpy_fromio(buf, priv->rsp, 8);
+
+	expected = be32_to_cpup((__be32 *)&buf[2]);
+	if (expected > count || expected < TPM_HEADER_SIZE)
 		return -EIO;
 
-	memcpy_fromio(&buf[6], &priv->rsp[6], expected - 6);
+	memcpy_fromio(&buf[8], &priv->rsp[8], expected - 8);
 
 	return expected;
 }
-- 
2.19.1

