Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3915FC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCCAF2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3aCEXEB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCCAF2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbeJZENq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 00:13:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46714 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbeJZENq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 00:13:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id i4-v6so10490466wrr.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 12:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=N2nxlAPwxCY787lzi2fWINFuw6kMiTtSA+BaIRlVVdE=;
        b=B3aCEXEBcnTh6hVvbSe8++jfEO58GbUBdhE07mb2CDc9QdD7yQD3g7pr8+xSEfkfkW
         fOC+pjCrnlmXl3GEyF0i9UYoW0ODouZZA0OnGc4E0gL6HEd6TbHbX+WWaN/NWeFb5okl
         hlyR5FOqZmirSzmK4FE5U6lDI9hCpINB0XDP3DbR2rhdmiIsG17c9fzRMcMxMG1KCLAE
         6F1RmLq3dE+GZRQDHOGs2Seguu5uteqasmK9HXYSGuwq2PDo1dt9Rlioak19ooWfS/sE
         GiWW71HTuYOVA4H2096WpIpUXnqTr2sIv6K8npreYh+MG24vgjFOeCTfCXEJc9Aaay/4
         RTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=N2nxlAPwxCY787lzi2fWINFuw6kMiTtSA+BaIRlVVdE=;
        b=HEsTlutpUKOOTBu1jDLCWBnAE+ndrVu39l0TfxHXPSEwfsaGQarxlDGXIKCPwE3K/1
         dzNPNcT08n9be/Kk5YJ3+GJQTDewiNab970xetp+2pqoomE7i4ViMpcrycf/xRkqj9NU
         0THIEEY6RPs4ZDpzY3mCgh7eu7iNeTBKsTeZ5D+L972KpB1WHcITfoI/tM37mlkRuiIL
         t9k1g9+QEKsFpPtZ7ZjgcaN5rmgDOeLME/5h1VISjiGSfa9uf60SVgRucG+AG3rg58H1
         SVfjg4FByh5Xr2Sy4psJuM/m0eVIWE+jut7YDAvgYdf33TfzM7asndbb4RAwdRqf+FnW
         msaQ==
X-Gm-Message-State: AGRZ1gKAk+hzcz6ifUEQABySf8C7+jLaq3AbIGMnJ+vocrGrqpMKZpWg
        P/Fj+MWbl9dnlg7Z6Ef2G7stY1OxpUA=
X-Google-Smtp-Source: AJdET5fqJmb1hdL3SOuArmN8qV3ScpNIYbeEhijlIgyb9YE7yTg8dp6X/CMeTVW557/eeCEHVJvb0Q==
X-Received: by 2002:adf:8c09:: with SMTP id z9-v6mr440384wra.82.1540496378656;
        Thu, 25 Oct 2018 12:39:38 -0700 (PDT)
Received: from dell.be.48ers.dk ([94.185.135.34])
        by smtp.gmail.com with ESMTPSA id j6-v6sm3207547wmd.29.2018.10.25.12.39.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 12:39:37 -0700 (PDT)
Received: from peko by dell.be.48ers.dk with local (Exim 4.89)
        (envelope-from <peko@dell.be.48ers.dk>)
        id 1gFlTk-0006OU-Gv; Thu, 25 Oct 2018 21:39:36 +0200
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc:     Peter Korsgaard <peter@korsgaard.com>
Subject: [RESEND PATCH v2] ttyprintk: make the printk log level configurable
Date:   Thu, 25 Oct 2018 21:39:34 +0200
Message-Id: <20181025193934.24534-1-peter@korsgaard.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some use cases it is handy to use a different printk log level than the
default (info) for the messages written to ttyprintk, so add a Kconfig
option similar to what we have for default console loglevel.

Signed-off-by: Peter Korsgaard <peter@korsgaard.com>
---
Changes since v1:
- Leave [U] prefix in printk invocation and drop space before it as
  suggested by Joe Perces.

 drivers/char/Kconfig     | 8 ++++++++
 drivers/char/ttyprintk.c | 4 +++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index ce277ee0a28a..14a7f023f20b 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -66,6 +66,14 @@ config TTY_PRINTK
 
 	  If unsure, say N.
 
+config TTY_PRINTK_LEVEL
+	depends on TTY_PRINTK
+	int "ttyprintk log level (1-7)"
+	range 1 7
+	default "6"
+	help
+	  Printk log level to use for ttyprintk messages.
+
 config PRINTER
 	tristate "Parallel printer support"
 	depends on PARPORT
diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
index 67549ce88cc9..88808dbba486 100644
--- a/drivers/char/ttyprintk.c
+++ b/drivers/char/ttyprintk.c
@@ -37,6 +37,8 @@ static struct ttyprintk_port tpk_port;
  */
 #define TPK_STR_SIZE 508 /* should be bigger then max expected line length */
 #define TPK_MAX_ROOM 4096 /* we could assume 4K for instance */
+#define TPK_PREFIX KERN_SOH __stringify(CONFIG_TTY_PRINTK_LEVEL)
+
 static int tpk_curr;
 
 static char tpk_buffer[TPK_STR_SIZE + 4];
@@ -45,7 +47,7 @@ static void tpk_flush(void)
 {
 	if (tpk_curr > 0) {
 		tpk_buffer[tpk_curr] = '\0';
-		pr_info("[U] %s\n", tpk_buffer);
+		printk(TPK_PREFIX "[U] %s\n", tpk_buffer);
 		tpk_curr = 0;
 	}
 }
-- 
2.11.0

