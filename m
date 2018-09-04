Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B43C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE6620659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE6620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbeIDW2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 18:28:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726304AbeIDW2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 18:28:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AC2B3DFF3;
        Tue,  4 Sep 2018 18:01:57 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-111.ams2.redhat.com [10.36.116.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F011D63F25;
        Tue,  4 Sep 2018 18:01:55 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH 4.19 regression fix] printk: For early boot messages check loglevel when flushing the buffer
Date:   Tue,  4 Sep 2018 20:01:54 +0200
Message-Id: <20180904180154.845-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 04 Sep 2018 18:01:57 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 04 Sep 2018 18:01:57 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'hdegoede@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 375899cddcbb ("printk: make sure to print log on console."), moved
the checking of the loglevel of messages from flush time to the actual
log time.

This introduces one problem, some early boot messages are printed before
parse_early_param() gets called and thus before kernel commandline options
such as quiet, loglevel and ignore_loglevel are parsed.

This causes e.g. the following messages to get printed on x86 systems,
despite the presence of the "quiet" option:

[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
...
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x0000000874ffffff] usable

This commit fixes this by setting a new LOG_CHK_LEVEL on early boot
messages and doing the loglevel check for these while flushing as before.

Cc: Petr Mladek <pmladek@suse.com>
Cc: Maninder Singh <maninder1.s@samsung.com>
Fixes: 375899cddcbb ("printk: make sure to print log on console.")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 kernel/printk/printk.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fd6f8ed28e01..c5ffd46239a0 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -355,6 +355,7 @@ enum log_flags {
 	LOG_NEWLINE	= 2,	/* text ended with a newline */
 	LOG_PREFIX	= 4,	/* text started with a prefix */
 	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
+	LOG_CHK_LEVEL	= 16,	/* check log level during flush */
 };
 
 struct printk_log {
@@ -1881,7 +1882,10 @@ int vprintk_store(int facility, int level,
 	if (dict)
 		lflags |= LOG_PREFIX|LOG_NEWLINE;
 
-	if (suppress_message_printing(level))
+	/* During early boot loglevel is not setup yet, check it later */
+	if (early_boot_irqs_disabled)
+		lflags |= LOG_CHK_LEVEL;
+	else if (suppress_message_printing(level))
 		lflags |= LOG_NOCONS;
 
 	return log_output(facility, level, lflags,
@@ -2368,7 +2372,9 @@ void console_unlock(void)
 			break;
 
 		msg = log_from_idx(console_idx);
-		if (msg->flags & LOG_NOCONS) {
+		if ((msg->flags & LOG_NOCONS) ||
+		    ((msg->flags & LOG_CHK_LEVEL) &&
+				suppress_message_printing(msg->level))) {
 			/*
 			 * Skip record if !ignore_loglevel, and
 			 * record has level above the console loglevel.
-- 
2.19.0.rc0

