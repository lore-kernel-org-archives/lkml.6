Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB869C6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 04:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929C420833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 04:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 929C420833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbeKCNSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 09:18:52 -0400
Received: from mga04.intel.com ([192.55.52.120]:10915 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbeKCNSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 09:18:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Nov 2018 21:08:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,458,1534834800"; 
   d="scan'208";a="271027108"
Received: from unknown (HELO localhost) ([10.249.254.143])
  by orsmga005.jf.intel.com with ESMTP; 02 Nov 2018 21:08:53 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/6] tpm: access command header through struct in  tpm_try_transmit()
Date:   Sat,  3 Nov 2018 06:08:17 +0200
Message-Id: <20181103040820.23360-4-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181103040820.23360-1-jarkko.sakkinen@linux.intel.com>
References: <20181103040820.23360-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of accessing fields of the command header through offsets to
the raw buffer, it is a better idea to use the header struct pointer
that is already used elsewhere in the function.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm-interface.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 967de254b156..dd97a17243e3 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -190,8 +190,8 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 	if (bufsiz > TPM_BUFSIZE)
 		bufsiz = TPM_BUFSIZE;
 
-	count = be32_to_cpu(*((__be32 *) (buf + 2)));
-	ordinal = be32_to_cpu(*((__be32 *) (buf + 6)));
+	count = be32_to_cpu(header->length);
+	ordinal = be32_to_cpu(header->return_code);
 	if (count == 0)
 		return -ENODATA;
 	if (count > bufsiz) {
-- 
2.19.1

