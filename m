Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A78C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F00A206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjBMgFMJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbfAGOxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:53:08 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38915 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfAGOxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 09:53:08 -0500
Received: by mail-pf1-f193.google.com with SMTP id r136so274006pfc.6;
        Mon, 07 Jan 2019 06:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gbUbaFp0/lGttbZtf5mjlQK3Weann7eHKviq2kqFajk=;
        b=IjBMgFMJlLgNUV2K1xbqWSv2A4TRFI6QLxc1lnK8lNhL33uTGrlRz+SlXCzn3pNmrw
         j5lCsUq7iJcQgRT/2n3F4oKiFG0zIjC4ZWHq0kl1EZfFehI+BwDYFZ55rOfvhAxfggpy
         tq3rDiI9KqKaUF0xt6/hea/F2wFUha2dpxDiQByt1B1c828VNNAQ9+Hi/DkE+Ei4xVis
         Ch7vWnDZKe2sR/2ZpM2eQJOZqA7AvkjbZ8rwffvOZnnGzr4uEgIJyOZL2xUvrvyR4EKQ
         +hGpHcdgIdXyC7Hb8Q2farK0bsIXY+mxE9Xs58HDa+q/B2Ar88uGW1bT15ql4JeipdMH
         SlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gbUbaFp0/lGttbZtf5mjlQK3Weann7eHKviq2kqFajk=;
        b=c2KG5GIB+RVzlgtj801XucLq0JN6+iGWalm0u5xaheyx6VnXB+OEoszaRqILmuxE2D
         +LXR19ulPAAKdNGlsGm6jhBe6YaFWo/s7yfaPfWyNYVYYDitjwFFBMTCCMI52olfOuVh
         c5xME5sCg0EHGwCqCqqal4Ucag8tloDdlK5p7aGt4gfXYXPJTKA4hU52OUPfxhe7/zUj
         xYvg5/U9mwlSrl51LSOee3i+kQfsiL+IMr2o17nGalPxqVloxQcgNZCZRHm8j7eO61Ci
         oK2Vz2Bm4BBfOebW0h1sD80C7SYncpkVLt1VOUr1NmzNyo4bmSmyYPo4IuJE7Te8M7mH
         E9+A==
X-Gm-Message-State: AJcUukcZfNo9dEOx+4sTieoOn6pZRF5SpxZdFPJzTHDcpgSK2BeeG0Ig
        8h/eCrXaZOjaZiBO5Oteaozeh6dl
X-Google-Smtp-Source: ALg8bN7YwnsVYZfmApPYiDG8k8vCXhE2eLNpPFQpjIA9wmGMN1huVpmjfNzCkM4dtbWusw/wtWJahg==
X-Received: by 2002:a62:ae04:: with SMTP id q4mr36096235pff.126.1546872787066;
        Mon, 07 Jan 2019 06:53:07 -0800 (PST)
Received: from localhost.localdomain ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id x27sm123153763pfe.178.2019.01.07.06.53.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 06:53:06 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [PATCHv2] ia64: tweak BREAK_LOGLEVEL and RESTORE_LOGLEVEL
Date:   Mon,  7 Jan 2019 23:52:58 +0900
Message-Id: <20190107145258.22918-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107095433.6497-1-sergey.senozhatsky@gmail.com>
References: <20190107095433.6497-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>

a) Do not pass console_loglevel to macros, use console_loglevel directly.
b) Use CONSOLE_LOGLEVEL_MOTORMOUTH instead of a naked number
c) Use bust_spinlocks() to set/clear oops_in_progress
d) Fix checkpatch error: Macros with multiple statements should be
                         enclosed in a do - while loop

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 arch/ia64/kernel/mca.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/arch/ia64/kernel/mca.c b/arch/ia64/kernel/mca.c
index 91bd1e129379..940f34db97d3 100644
--- a/arch/ia64/kernel/mca.c
+++ b/arch/ia64/kernel/mca.c
@@ -188,19 +188,23 @@ static unsigned int mlogbuf_finished = 0;
 static unsigned long mlogbuf_timestamp = 0;
 
 static int loglevel_save = -1;
-#define BREAK_LOGLEVEL(__console_loglevel)		\
-	oops_in_progress = 1;				\
-	if (loglevel_save < 0)				\
-		loglevel_save = __console_loglevel;	\
-	__console_loglevel = 15;
-
-#define RESTORE_LOGLEVEL(__console_loglevel)		\
-	if (loglevel_save >= 0) {			\
-		__console_loglevel = loglevel_save;	\
-		loglevel_save = -1;			\
-	}						\
-	mlogbuf_finished = 0;				\
-	oops_in_progress = 0;
+#define BREAK_LOGLEVEL()					\
+	do {							\
+		bust_spinlocks(1);				\
+		if (loglevel_save < 0)				\
+			loglevel_save = console_loglevel;	\
+		console_loglevel = CONSOLE_LOGLEVEL_MOTORMOUTH;	\
+	} while (0)
+
+#define RESTORE_LOGLEVEL()					\
+	do {							\
+		if (loglevel_save >= 0) {			\
+			console_loglevel = loglevel_save;	\
+			loglevel_save = -1;			\
+		}						\
+		mlogbuf_finished = 0;				\
+		bust_spinlocks(0);				\
+	} while (0)
 
 /*
  * Push messages into buffer, print them later if not urgent.
@@ -287,7 +291,7 @@ EXPORT_SYMBOL(ia64_mlogbuf_dump);
  */
 static void ia64_mlogbuf_finish(int wait)
 {
-	BREAK_LOGLEVEL(console_loglevel);
+	BREAK_LOGLEVEL();
 
 	spin_lock_init(&mlogbuf_rlock);
 	ia64_mlogbuf_dump();
@@ -1616,7 +1620,7 @@ default_monarch_init_process(struct notifier_block *self, unsigned long val, voi
 	 * To enable show_stack from INIT, we use oops_in_progress which should
 	 * be used in real oops. This would cause something wrong after INIT.
 	 */
-	BREAK_LOGLEVEL(console_loglevel);
+	BREAK_LOGLEVEL();
 	ia64_mlogbuf_dump_from_init();
 
 	printk(KERN_ERR "Processes interrupted by INIT -");
@@ -1641,7 +1645,7 @@ default_monarch_init_process(struct notifier_block *self, unsigned long val, voi
 		read_unlock(&tasklist_lock);
 	}
 	/* FIXME: This will not restore zapped printk locks. */
-	RESTORE_LOGLEVEL(console_loglevel);
+	RESTORE_LOGLEVEL();
 	return NOTIFY_DONE;
 }
 
-- 
2.20.1

