Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7BBC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C6B206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/WlHMMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C6B206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbeKGHjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:39:06 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:47041 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbeKGHjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:39:06 -0500
Received: by mail-ed1-f68.google.com with SMTP id f8-v6so11786441edt.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 14:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=N2nxlAPwxCY787lzi2fWINFuw6kMiTtSA+BaIRlVVdE=;
        b=C/WlHMMKOYEcEgEjRo2Yg7UrEFUFBwMB1djO2ApqWUwh5x7cBJq/MTMlHo2pQmKysM
         XI9tZK0Q70rQ//Pu56TUvXr7IiWzbIhC/lxbVT5vVLjLh6Pkd3hMsBBViLCYXEFV1onN
         bvPAErslPfA5Vf/Z49uLIkXOFW6kc1gm5nqAla9CyrESf+m3/B4UhBDp7j5AQ1nOdxiR
         6VZ1d4aMw5JRII/fFhVZSCZqz7VI+ch4NibIYFLOQJ4PH2j7LV0CscV+4VVtUM3NxK3M
         SIy7HtWZSvIlJrgLxT+bz+rfpJswo5/KzFxHp2KfkX5n9mqrDrsBkdeGaxf9MWRfFmad
         ymsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=N2nxlAPwxCY787lzi2fWINFuw6kMiTtSA+BaIRlVVdE=;
        b=qBdX3yH5tqgocfZYz9pUsWS/WMhsrsc56KviM/LHjB6VcQNkEEAq51vZr5Sx8/hO+T
         RSZv8/cRjn2NdX0SJMpkUVla6ZORVqZO7khnm2BFPIklYpT2FzdJkyiXnJwVONCt8Tyt
         tKyX+vWw6BTZUGZAJk49QNmEmEbKx33NsD6z83NXZ73aWiE6kufhin9NdC6pN61F5VMX
         rBhd+aOn/TbatbxGlHoJx+jHfmXicqLKWjSMmQalHLtif4I/sroP095lYVqR4emYr78Y
         ah87gTs8vGVInVmJxLXs/VGbwmkAzGWOSaDQvrhL73Rl1OBuZBaLU9iv8JSODWtBcD0Y
         ds0g==
X-Gm-Message-State: AGRZ1gKsccdmSWsy1AJAa76s1t5uASS4R5RY9Fh47D4UU/7eAVWy7SOn
        jSs0ZQL+8QiF1wdMJoT79ka6PUVX
X-Google-Smtp-Source: AJdET5esmLT6h771Ho/ikdxW+dkaiOrUxJj+ZF8b/nTujyTGmZzYenkWI6cqkvvE4klB08z8LAWiMA==
X-Received: by 2002:a17:906:7a4e:: with SMTP id i14-v6mr9201046ejo.16.1541542301748;
        Tue, 06 Nov 2018 14:11:41 -0800 (PST)
Received: from dell.be.48ers.dk (d51a5bc31.access.telenet.be. [81.165.188.49])
        by smtp.gmail.com with ESMTPSA id t29-v6sm2176595edd.53.2018.11.06.14.11.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 14:11:40 -0800 (PST)
Received: from peko by dell.be.48ers.dk with local (Exim 4.89)
        (envelope-from <peko@dell.be.48ers.dk>)
        id 1gK9ZT-0003yf-W5; Tue, 06 Nov 2018 23:11:39 +0100
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc:     Peter Korsgaard <peter@korsgaard.com>
Subject: [RESEND PATCH v2] ttyprintk: make the printk log level configurable
Date:   Tue,  6 Nov 2018 23:11:37 +0100
Message-Id: <20181106221137.15218-1-peter@korsgaard.com>
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

