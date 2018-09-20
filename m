Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8857EC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D2221528
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D2221528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732381AbeITHjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 03:39:54 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40781 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbeITHjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 03:39:54 -0400
Received: by mail-qk1-f193.google.com with SMTP id c126-v6so4169867qkd.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 18:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=jT2y+5cmpbBSSRFi948qu5ZJwUCJ4GquMGVdmjx1QBA=;
        b=Oh8ExWRBgM6cUuHzT+l/BQhnP81BHyyDMI3bJceGj4XxbO/Rb3vaO1gvrD4Y/Mw6KZ
         6JzuK2xMlYFbikoOfiBNCwjQCNEF4sTKt4/6vEpdMlttY3Xb28rfTLp48lhfkHINga3U
         Q+RZKjCXk2DmiWL7Er9gXuU+MdeTU9LvkBAwR/vNw+9frkK565JgFsjaWs+MQpT82KZe
         o27CrOxE6uTaJHkmJ+0Xg5/AHJ74qv2EBuCb3RwMrOj+qHRxTokvjC1xDMoVzx3nUh7f
         RTfVahGOBdQPit8eysYApTR+eq0VhrxOzEgSs3+2Har6gmTckVD416dKc3n6ELOdW/QC
         MG9g==
X-Gm-Message-State: APzg51B2QdmIi+jtdx+dcmJ2VgE7SH1LIvvAbSW7C/tynHS1WbmyOqvT
        wrHlpvsqTaXiSnJc4iiKdr4xhQ==
X-Google-Smtp-Source: ANB0Vdb8WZFu68s36xIHvUGBLiLyr78VTnpRlTykVDMITM4XrQOSPjYlD4+cQksXkvCrph6qW2olag==
X-Received: by 2002:ae9:f10c:: with SMTP id k12-v6mr25753704qkg.342.1537408747573;
        Wed, 19 Sep 2018 18:59:07 -0700 (PDT)
Received: from localhost.localdomain (50-207-253-10-static.hfc.comcastbusiness.net. [50.207.253.10])
        by smtp.gmail.com with ESMTPSA id w63-v6sm12438249qkc.52.2018.09.19.18.59.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 18:59:06 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Laura Abbott <labbott@redhat.com>, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] kgdboc: Fix warning with module build
Date:   Wed, 19 Sep 2018 18:59:01 -0700
Message-Id: <20180920015901.4639-1-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180919131208.07aa9c6b@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


After 2dd453168643 ("kgdboc: Fix restrict error"), kgdboc_option_setup is
now only used when built in, resulting in a warning when compiled as a
module:

drivers/tty/serial/kgdboc.c:134:12: warning: 'kgdboc_option_setup' defined but not used [-Wunused-function]
 static int kgdboc_option_setup(char *opt)
            ^~~~~~~~~~~~~~~~~~~

Move the function under the appropriate ifdef for builtin only.

Fixes: 2dd453168643 ("kgdboc: Fix restrict error")
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 drivers/tty/serial/kgdboc.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index e9a83bb5bee5..baeeeaec3f03 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -131,24 +131,6 @@ static void kgdboc_unregister_kbd(void)
 #define kgdboc_restore_input()
 #endif /* ! CONFIG_KDB_KEYBOARD */
 
-static int kgdboc_option_setup(char *opt)
-{
-	if (!opt) {
-		pr_err("config string not provided\n");
-		return -EINVAL;
-	}
-
-	if (strlen(opt) >= MAX_CONFIG_LEN) {
-		pr_err("config string too long\n");
-		return -ENOSPC;
-	}
-	strcpy(config, opt);
-
-	return 0;
-}
-
-__setup("kgdboc=", kgdboc_option_setup);
-
 static void cleanup_kgdboc(void)
 {
 	if (kgdb_unregister_nmi_console())
@@ -316,6 +298,25 @@ static struct kgdb_io kgdboc_io_ops = {
 };
 
 #ifdef CONFIG_KGDB_SERIAL_CONSOLE
+static int kgdboc_option_setup(char *opt)
+{
+	if (!opt) {
+		pr_err("config string not provided\n");
+		return -EINVAL;
+	}
+
+	if (strlen(opt) >= MAX_CONFIG_LEN) {
+		pr_err("config string too long\n");
+		return -ENOSPC;
+	}
+	strcpy(config, opt);
+
+	return 0;
+}
+
+__setup("kgdboc=", kgdboc_option_setup);
+
+
 /* This is only available if kgdboc is a built in for early debugging */
 static int __init kgdboc_early_init(char *opt)
 {
-- 
2.17.1

