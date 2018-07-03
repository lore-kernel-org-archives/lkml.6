Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A2CC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0AE924899
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0AE924899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754470AbeGCHEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:04:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45233 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754066AbeGCHEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:04:02 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1faFM0-0007u9-W5; Tue, 03 Jul 2018 07:04:01 +0000
From:   Colin King <colin.king@canonical.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] eeprom: idt_89hpesx: remove redundant variable csrval_len
Date:   Tue,  3 Jul 2018 08:04:00 +0100
Message-Id: <20180703070400.28165-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable csrval_len is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'csrval_len' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/misc/eeprom/idt_89hpesx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/misc/eeprom/idt_89hpesx.c b/drivers/misc/eeprom/idt_89hpesx.c
index 59dc24bb70ec..119eb05a5a91 100644
--- a/drivers/misc/eeprom/idt_89hpesx.c
+++ b/drivers/misc/eeprom/idt_89hpesx.c
@@ -938,7 +938,7 @@ static ssize_t idt_dbgfs_csr_write(struct file *filep, const char __user *ubuf,
 {
 	struct idt_89hpesx_dev *pdev = filep->private_data;
 	char *colon_ch, *csraddr_str, *csrval_str;
-	int ret, csraddr_len, csrval_len;
+	int ret, csraddr_len;
 	u32 csraddr, csrval;
 	char *buf;
 
@@ -974,12 +974,10 @@ static ssize_t idt_dbgfs_csr_write(struct file *filep, const char __user *ubuf,
 		csraddr_str[csraddr_len] = '\0';
 		/* Register value must follow the colon */
 		csrval_str = colon_ch + 1;
-		csrval_len = strnlen(csrval_str, count - csraddr_len);
 	} else /* if (str_colon == NULL) */ {
 		csraddr_str = (char *)buf; /* Just to shut warning up */
 		csraddr_len = strnlen(csraddr_str, count);
 		csrval_str = NULL;
-		csrval_len = 0;
 	}
 
 	/* Convert CSR address to u32 value */
-- 
2.17.1

