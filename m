Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6691C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B822084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732254AbfAKQUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 11:20:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:40532 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730717AbfAKQUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 11:20:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 58D81B020;
        Fri, 11 Jan 2019 16:20:48 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH 2/3] sysrq: Remove duplicated sysrq message
Date:   Fri, 11 Jan 2019 17:20:37 +0100
Message-Id: <20190111162038.19771-3-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190111162038.19771-1-pmladek@suse.com>
References: <20190111162038.19771-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 97f5f0cd8cd0a0544 ("Input: implement SysRq as a separate input
handler") added pr_fmt() definition. It caused a duplicated message
prefix in the sysrq header messages, for example:

[  177.053931] sysrq: SysRq : Show backtrace of all active CPUs
[  742.864776] sysrq: SysRq : HELP : loglevel(0-9) reboot(b) crash(c)

Fixes: 97f5f0cd8cd0a05 ("Input: implement SysRq as a separate input handler")
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 drivers/tty/sysrq.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 2e4e184cfaa6..fa0ce7dd9e24 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -539,7 +539,6 @@ void __handle_sysrq(int key, bool check_mask)
 	 */
 	orig_log_level = console_loglevel;
 	console_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
-	pr_info("SysRq : ");
 
         op_p = __sysrq_get_key_op(key);
         if (op_p) {
@@ -548,15 +547,15 @@ void __handle_sysrq(int key, bool check_mask)
 		 * should not) and is the invoked operation enabled?
 		 */
 		if (!check_mask || sysrq_on_mask(op_p->enable_mask)) {
-			pr_cont("%s\n", op_p->action_msg);
+			pr_info("%s\n", op_p->action_msg);
 			console_loglevel = orig_log_level;
 			op_p->handler(key);
 		} else {
-			pr_cont("This sysrq operation is disabled.\n");
+			pr_info("This sysrq operation is disabled.\n");
 			console_loglevel = orig_log_level;
 		}
 	} else {
-		pr_cont("HELP : ");
+		pr_info("HELP : ");
 		/* Only print the help msg once per handler */
 		for (i = 0; i < ARRAY_SIZE(sysrq_key_table); i++) {
 			if (sysrq_key_table[i]) {
-- 
2.13.7

