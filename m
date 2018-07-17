Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B56FECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48352145D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BFIqFaV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48352145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731584AbeGQL5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:57:31 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44539 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731256AbeGQL5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:57:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1-v6so307831pgp.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 04:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=f95cnvAKHz2LDIUfrbxH7/UwasS/e/nMiJeOdptmf04=;
        b=BFIqFaV7DoWqeGOMnrMJXE8GnLVNDr/wPRbqwAHtK8nHBHWSuElEfL/YcTQQ0hEcfM
         l6j5XOBTxvron0FHINhiXFfd4sgyih9dWceJ+IW21X7auqAucGp9MftF7i78tXkV+M/e
         h76XQ8OD4Ox1Xayt1TA7h1eNjAU28DeWKAJFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=f95cnvAKHz2LDIUfrbxH7/UwasS/e/nMiJeOdptmf04=;
        b=pv+557pyWuUF3hM14FP2R23Fcq6a+nxdYPXt0xOg74pX8SREDGWWYy90ahqYYcVX1D
         HWBR19pXsi90o89IOp9/oA47l2C6vW4GE3iaBfFxm+iQPuVfKxScNOnR6kS38ej2dOkx
         G/l64fuH2jkySOBcreoYg1RnHVB/z6gUr5da04SWrdGhwhTRAIdP53wDDcAeZih54Vdq
         C4Skbi2aNOABcLlD5eC607Ws05mKzK5VeRojSEl4UKQxXpYOddGgJ/KCjQqDYWy6GZuy
         QWdVEIJOJtGs2J9ARVgWbvEqE4YeZfTXW4VSBKaRhLzTo736ASjitwoV70I7gO84b07s
         qKzg==
X-Gm-Message-State: AOUpUlGk6eZJC2tiRk0QT6BE5ie/8Kb02FE108TS1y7MQlVZU6kkTVCd
        mTOlwY+je215h6kd0zY0RiLXiA==
X-Google-Smtp-Source: AAOMgpd0xV9fl0ZT24yhJr7aAgzxgkqwSOsCmwkK/i1vd8qujXyQpC5VBi3Z2bljdih0sk00kUfsqw==
X-Received: by 2002:a63:8848:: with SMTP id l69-v6mr1161273pgd.377.1531826719616;
        Tue, 17 Jul 2018 04:25:19 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id y3-v6sm1391207pge.29.2018.07.17.04.25.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jul 2018 04:25:19 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     ysato@users.sourceforge.jp, dalias@libc.org, corbet@lwn.net
Cc:     baolin.wang@linaro.org, arnd@arndb.de, broonie@kernel.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 4/4] sh: remove board_time_init() callback
Date:   Tue, 17 Jul 2018 19:24:27 +0800
Message-Id: <0ad306a7d410d3695c7869bf081efaa71e956ae4.1531826106.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <bb0912b9725f192179cc94ef8c3f6702fc078e11.1531826106.git.baolin.wang@linaro.org>
References: <bb0912b9725f192179cc94ef8c3f6702fc078e11.1531826106.git.baolin.wang@linaro.org>
In-Reply-To: <bb0912b9725f192179cc94ef8c3f6702fc078e11.1531826106.git.baolin.wang@linaro.org>
References: <bb0912b9725f192179cc94ef8c3f6702fc078e11.1531826106.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The only remaining user of board_time_init() is the of-generic
machine, and that just calls the global timer_init() function.
Calling that one has no effect on non-DT platforms, so we can
simply call it unconditionally in place of board_time_init().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 Documentation/sh/new-machine.txt |    8 --------
 arch/sh/boards/of-generic.c      |    8 --------
 arch/sh/include/asm/rtc.h        |    1 -
 arch/sh/kernel/time.c            |    5 +----
 4 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/Documentation/sh/new-machine.txt b/Documentation/sh/new-machine.txt
index f035416..e0961a66 100644
--- a/Documentation/sh/new-machine.txt
+++ b/Documentation/sh/new-machine.txt
@@ -116,7 +116,6 @@ might look something like:
  * arch/sh/boards/vapor/setup.c - Setup code for imaginary board
  */
 #include <linux/init.h>
-#include <asm/rtc.h> /* for board_time_init() */
 
 const char *get_system_type(void)
 {
@@ -132,13 +131,6 @@ int __init platform_setup(void)
 	 * this board.
 	 */
 
-  	/* 
-	 * Presume all FooTech boards have the same broken timer,
-	 * and also presume that we've defined foo_timer_init to
-	 * do something useful.
-	 */
-  	board_time_init = foo_timer_init;
-
 	/* Start-up imaginary PCI ... */
 
 	/* And whatever else ... */
diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
index 46b2481..ee74ff1 100644
--- a/arch/sh/boards/of-generic.c
+++ b/arch/sh/boards/of-generic.c
@@ -116,18 +116,10 @@ static void __init sh_of_mem_reserve(void)
 	early_init_fdt_scan_reserved_mem();
 }
 
-static void __init sh_of_time_init(void)
-{
-	pr_info("SH generic board support: scanning for clocksource devices\n");
-	timer_probe();
-}
-
 static void __init sh_of_setup(char **cmdline_p)
 {
 	struct device_node *root;
 
-	board_time_init = sh_of_time_init;
-
 	sh_mv.mv_name = "Unknown SH model";
 	root = of_find_node_by_path("/");
 	if (root) {
diff --git a/arch/sh/include/asm/rtc.h b/arch/sh/include/asm/rtc.h
index fe55fbb..69dbae2 100644
--- a/arch/sh/include/asm/rtc.h
+++ b/arch/sh/include/asm/rtc.h
@@ -3,7 +3,6 @@
 #define _ASM_RTC_H
 
 void time_init(void);
-extern void (*board_time_init)(void);
 
 #define RTC_CAP_4_DIGIT_YEAR	(1 << 0)
 
diff --git a/arch/sh/kernel/time.c b/arch/sh/kernel/time.c
index eb0a912..a29eb98 100644
--- a/arch/sh/kernel/time.c
+++ b/arch/sh/kernel/time.c
@@ -22,8 +22,6 @@
 #include <asm/clock.h>
 #include <asm/rtc.h>
 
-void (*board_time_init)(void);
-
 static void __init sh_late_time_init(void)
 {
 	/*
@@ -41,8 +39,7 @@ static void __init sh_late_time_init(void)
 
 void __init time_init(void)
 {
-	if (board_time_init)
-		board_time_init();
+	timer_init();
 
 	clk_init();
 
-- 
1.7.9.5

