Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8EBC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35F828048
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:10:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E35F828048
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935940AbeF2PKa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:10:30 -0400
Received: from mga04.intel.com ([192.55.52.120]:50596 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935602AbeF2PKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:10:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 08:10:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,285,1526367600"; 
   d="scan'208";a="52885362"
Received: from tmuluk-mobl4.ger.corp.intel.com (HELO localhost) ([10.249.254.88])
  by orsmga007.jf.intel.com with ESMTP; 29 Jun 2018 08:10:11 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] tpm: require to compile as part of the kernel
Date:   Fri, 29 Jun 2018 18:10:02 +0300
Message-Id: <20180629151005.10899-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not allow to compile TPM core as a module. TPM defines a root of
trust for integrity and keyring subsystems and should be always
available and not be loaded from the user space. There is no a
reasonable use case for a loadable module existing.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/Kconfig | 2 +-
 include/linux/tpm.h      | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 18c81cbe4704..9728771aecbd 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -3,7 +3,7 @@
 #
 
 menuconfig TCG_TPM
-	tristate "TPM Hardware Support"
+	bool "TPM Hardware Support"
 	depends on HAS_IOMEM
 	select SECURITYFS
 	select CRYPTO
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 4609b94142d4..cefa61b12891 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -50,8 +50,7 @@ struct tpm_class_ops {
 	void (*clk_enable)(struct tpm_chip *chip, bool value);
 };
 
-#if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
-
+#if defined(CONFIG_TCG_TPM)
 extern int tpm_is_tpm2(struct tpm_chip *chip);
 extern int tpm_pcr_read(struct tpm_chip *chip, int pcr_idx, u8 *res_buf);
 extern int tpm_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash);
-- 
2.17.1

