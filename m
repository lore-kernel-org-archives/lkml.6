Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA03C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222162081C
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 222162081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437459AbeKWAzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:55:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:33588 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389047AbeKWAzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:55:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 81C2FADE3;
        Thu, 22 Nov 2018 14:15:43 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH] s390: Remove obsolete bust_spinlock() implementation
Date:   Thu, 22 Nov 2018 15:15:29 +0100
Message-Id: <20181122141529.14933-1-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit cefc8be82403cf ("Consolidate bust_spinlocks()") kept
the s390-specific implementation because of the absence of CONFIG_VT.
In fact, the only difference was calling console_unblank() instead of
unblank_screen().

The common implementation in lib/bust_spinlocks.c started to call
unblank_screen() explicitly since the commit b61312d353da187
("oops handling: ensure that any oops is flushed to the mtdoops
console").

As a result, the custom implementation is not longer necessary.
And we could get all the other improvements of the common
implementation for free.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 arch/s390/mm/fault.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 2b8f32f56e0c..11613362c4e7 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -81,30 +81,6 @@ static inline int notify_page_fault(struct pt_regs *regs)
 	return ret;
 }
 
-
-/*
- * Unlock any spinlocks which will prevent us from getting the
- * message out.
- */
-void bust_spinlocks(int yes)
-{
-	if (yes) {
-		oops_in_progress = 1;
-	} else {
-		int loglevel_save = console_loglevel;
-		console_unblank();
-		oops_in_progress = 0;
-		/*
-		 * OK, the message is on the console.  Now we call printk()
-		 * without oops_in_progress set so that printk will give klogd
-		 * a poke.  Hold onto your hats...
-		 */
-		console_loglevel = 15;
-		printk(" ");
-		console_loglevel = loglevel_save;
-	}
-}
-
 /*
  * Find out which address space caused the exception.
  * Access register mode is impossible, ignore space == 3.
-- 
2.13.7

