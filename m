Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A011CC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7963B20880
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbfA2TND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:13:03 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51135 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfA2TNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 14:13:02 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0TJCuuO2061986
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 29 Jan 2019 11:12:56 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0TJCuFb2061983;
        Tue, 29 Jan 2019 11:12:56 -0800
Date:   Tue, 29 Jan 2019 11:12:56 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Greg Kroah-Hartman <tipbot@zytor.com>
Message-ID: <tip-ae503ab04913794b12e1939caa75aa091062a1b3@git.kernel.org>
Cc:     tglx@linutronix.de, gregkh@linuxfoundation.org, sboyd@kernel.org,
        john.stultz@linaro.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: gregkh@linuxfoundation.org, tglx@linutronix.de, sboyd@kernel.org,
          john.stultz@linaro.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <20190122152151.16139-43-gregkh@linuxfoundation.org>
References: <20190122152151.16139-43-gregkh@linuxfoundation.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] timekeeping/debug: No need to check return value
 of debugfs_create functions
Git-Commit-ID: ae503ab04913794b12e1939caa75aa091062a1b3
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ae503ab04913794b12e1939caa75aa091062a1b3
Gitweb:     https://git.kernel.org/tip/ae503ab04913794b12e1939caa75aa091062a1b3
Author:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
AuthorDate: Tue, 22 Jan 2019 16:21:42 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 29 Jan 2019 20:08:41 +0100

timekeeping/debug: No need to check return value of debugfs_create functions

When calling debugfs functions, there is no need to ever check the return
value.  The function can work or not, but the code logic should never do
something different based on this.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Link: https://lkml.kernel.org/r/20190122152151.16139-43-gregkh@linuxfoundation.org

---
 kernel/time/timekeeping_debug.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/kernel/time/timekeeping_debug.c b/kernel/time/timekeeping_debug.c
index 86489950d690..b73e8850e58d 100644
--- a/kernel/time/timekeeping_debug.c
+++ b/kernel/time/timekeeping_debug.c
@@ -37,15 +37,8 @@ DEFINE_SHOW_ATTRIBUTE(tk_debug_sleep_time);
 
 static int __init tk_debug_sleep_time_init(void)
 {
-	struct dentry *d;
-
-	d = debugfs_create_file("sleep_time", 0444, NULL, NULL,
-		&tk_debug_sleep_time_fops);
-	if (!d) {
-		pr_err("Failed to create sleep_time debug file\n");
-		return -ENOMEM;
-	}
-
+	debugfs_create_file("sleep_time", 0444, NULL, NULL,
+			    &tk_debug_sleep_time_fops);
 	return 0;
 }
 late_initcall(tk_debug_sleep_time_init);
