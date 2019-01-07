Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4A0C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE323217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6Qodm12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfAGJym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:54:42 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46012 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfAGJym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:54:42 -0500
Received: by mail-pf1-f194.google.com with SMTP id g62so21595331pfd.12;
        Mon, 07 Jan 2019 01:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gl6JpnGihjv/yRPtfDAwaNiw30s/+rXs7lnW+RiVw+w=;
        b=U6Qodm12+cmlexUOT+YapWAX2O5MFLD6yCfZD4FQowvprNss0HTBEY4L6LYeyAHpIy
         XJcDIAH0RnRaqYwhSZcs4Pz0l5R/A6jKujsARSYNCgyw0fGNlV4loKbqpjuCHh/P6lm0
         /ErYaQCMcrU4n062Ztd6jSfcrsW7fcA527GdOVTKdgvyZ9lVLTrhE1KuvZhLpY/306V+
         r8WZ0wQSb7C3t+oipNDmm+NcjQN24qZGM9LULW40JagNw0R2mL+853X0c+TOjbfIF/9N
         CWM3Mbmq8p5l+TbUzIx9DtfrD7DIUwk24c3ef3MnohD2Nqp6aObXK+Go5ZYT0hh9236i
         8cjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gl6JpnGihjv/yRPtfDAwaNiw30s/+rXs7lnW+RiVw+w=;
        b=cRHPjBkfd+s6A9Pjla53dVi+aa0/SY7tvL/84ZgLPrmVy23OuW/b6FpkTgLTFQeAMd
         EG7KnMleDq7/PL8n8XEXamBtNOzgo7s7vkmhuIniSy30zzpbTsyHOJ+K+P8VN7OAsvQE
         BpBItl0LbHvsy6gN2/W0sBIdMunor2ALI+XojS8l393whTEggbwaFeiMr4XGbrT1vvjQ
         y2KIxhNeqlHBhpbznDYY0Z15yjZHGFzClsiW88ityJ2Ej+MHOla/NTvOutZdmnuz6X5d
         V3VZ84CLmWGwReWpxf3A2I2T+bVVGD7tt3KUlDkMSaxaPDyw3CNqZeK7CH9tuKbdHsTZ
         4VnA==
X-Gm-Message-State: AJcUukd9eUCNZTziXm4I+sMYyKgWxcbWOGkOfmSoPqI8A6pZRrCYpE85
        P+Ueb2Z295a0BbkuMI37v86/Kycg
X-Google-Smtp-Source: ALg8bN66x4cl+p6acAKfk7Yva+b6Qp6UE6Yxqc4sl3TnnBCbt+8HP+sKsh9NByyfM9POB/iNlNbJAA==
X-Received: by 2002:a63:2d82:: with SMTP id t124mr10305065pgt.260.1546854880915;
        Mon, 07 Jan 2019 01:54:40 -0800 (PST)
Received: from localhost.localdomain ([175.223.14.193])
        by smtp.gmail.com with ESMTPSA id i2sm35848569pfi.66.2019.01.07.01.54.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 01:54:40 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] ia64: tweak BREAK_LOGLEVEL and RESTORE_LOGLEVEL
Date:   Mon,  7 Jan 2019 18:54:33 +0900
Message-Id: <20190107095433.6497-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 91bd1e129379..06fb40f5c2d6 100644
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
+			loglevel_save = __console_loglevel;	\
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

