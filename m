Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F593C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307A920836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 307A920836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937696AbeFSL5a (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 07:57:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40222 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757217AbeFSL53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 07:57:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 647927DAC4;
        Tue, 19 Jun 2018 11:57:28 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-75.ams2.redhat.com [10.36.116.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 86FF02026D68;
        Tue, 19 Jun 2018 11:57:27 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] printk: Make CONSOLE_LOGLEVEL_QUIET configurable
Date:   Tue, 19 Jun 2018 13:57:26 +0200
Message-Id: <20180619115726.3098-1-hdegoede@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 19 Jun 2018 11:57:28 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 19 Jun 2018 11:57:28 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'hdegoede@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal of passing the "quiet" option to the kernel is for the kernel
to be quiet unless something really is wrong.

Sofar passing quiet has been (mostly) equivalent to passing
loglevel=4 on the kernel commandline. Which means to show any messages
with a level of KERN_ERR or higher severity on the console.

In practice this often does not result in a quiet boot though, since
there are many false-positive or otherwise harmless error messages printed,
defeating the purpose of the quiet option. Esp. the ACPICA code is really
bad wrt this, but there are plenty of others too.

This commit makes CONSOLE_LOGLEVEL_QUIET configurable.

This for example will allow distros which want quiet to really mean quiet
to set CONSOLE_LOGLEVEL_QUIET so that only messages with a higher severity
then KERN_ERR (CRIT, ALERT, EMERG) get printed, avoiding an endless game
of whack-a-mole silencing harmless error messages.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 include/linux/printk.h |  6 +++---
 lib/Kconfig.debug      | 11 +++++++++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 6d7e800affd8..18602bb3eca8 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -50,15 +50,15 @@ static inline const char *printk_skip_headers(const char *buffer)
 /* We show everything that is MORE important than this.. */
 #define CONSOLE_LOGLEVEL_SILENT  0 /* Mum's the word */
 #define CONSOLE_LOGLEVEL_MIN	 1 /* Minimum loglevel we let people use */
-#define CONSOLE_LOGLEVEL_QUIET	 4 /* Shhh ..., when booted with "quiet" */
 #define CONSOLE_LOGLEVEL_DEBUG	10 /* issue debug messages */
 #define CONSOLE_LOGLEVEL_MOTORMOUTH 15	/* You can't shut this one up */
 
 /*
- * Default used to be hard-coded at 7, we're now allowing it to be set from
- * kernel config.
+ * Default used to be hard-coded at 7, quiet used to be hardcoded at 4,
+ * we're now allowing both to be set from kernel config.
  */
 #define CONSOLE_LOGLEVEL_DEFAULT CONFIG_CONSOLE_LOGLEVEL_DEFAULT
+#define CONSOLE_LOGLEVEL_QUIET	 CONFIG_CONSOLE_LOGLEVEL_QUIET
 
 extern int console_printk[];
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 8838d1158d19..0d1c48dd22a9 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -30,6 +30,17 @@ config CONSOLE_LOGLEVEL_DEFAULT
 	  usage in the kernel. That is controlled by the MESSAGE_LOGLEVEL_DEFAULT
 	  option.
 
+config CONSOLE_LOGLEVEL_QUIET
+	int "quiet console loglevel (1-15)"
+	range 1 15
+	default "4"
+	help
+	  loglevel to use when "quiet" is passed on the kernel commandline.
+
+	  When "quiet" is passed on the kernel commandline this loglevel
+	  will be used as the loglevel. IOW passing "quiet" will be the
+	  equivalent of passing "loglevel=<CONSOLE_LOGLEVEL_QUIET>"
+
 config MESSAGE_LOGLEVEL_DEFAULT
 	int "Default message log level (1-7)"
 	range 1 7
-- 
2.17.1

