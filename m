Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A913C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340D220872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732442AbfAKMp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 07:45:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:51930 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729913AbfAKMpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 07:45:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 764D4AE3E;
        Fri, 11 Jan 2019 12:45:24 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH] sysrq: Restore original console_loglevel when sysrq disabled
Date:   Fri, 11 Jan 2019 13:45:15 +0100
Message-Id: <20190111124515.11017-1-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sysrq header line is printed with an increased loglevel
to provide users some positive feedback.

The original loglevel is not restored when the sysrq operation
is disabled. This bug was introduced in 2.6.12 (pre-git-history)
by the commit ("Allow admin to enable only some of the Magic-Sysrq
functions").

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 drivers/tty/sysrq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 1f03078ec352..2e4e184cfaa6 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -553,6 +553,7 @@ void __handle_sysrq(int key, bool check_mask)
 			op_p->handler(key);
 		} else {
 			pr_cont("This sysrq operation is disabled.\n");
+			console_loglevel = orig_log_level;
 		}
 	} else {
 		pr_cont("HELP : ");
-- 
2.13.7

