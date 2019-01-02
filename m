Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF71C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CADAF218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E5HYm087"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbfABPxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 10:53:21 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41694 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730274AbfABPxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 10:53:20 -0500
Received: by mail-pl1-f193.google.com with SMTP id u6so14661817plm.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 07:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O3oktLmRrcQkvmGvrxjx/dlqIUCFKJqlZmJSB7MMuho=;
        b=E5HYm0870CVQ2Sz23+5HgLFQL03S7BaU2DchIc3AZWi8MWElfbNhLyliMCVlK7U0Im
         GaByMtoisgQcpMUXeFLwLb5f9Ph5MM2tZMbmqPschfougJH5OP2WokaS97w1wfyY0MLS
         1w/sdhNTD0u9Vk24cdn+tj9FWUqmPhvI2G4Ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O3oktLmRrcQkvmGvrxjx/dlqIUCFKJqlZmJSB7MMuho=;
        b=sNgimweMmNh4ObDW2fo9vQVLNEye1/m1s1H9bLZqf65bxEWytCpjx6OYZd2oRWdxab
         lZyjVzb/cy15fl0o/VoD2ml44Pkbp1QsDlzOBqCLhMi07ZMgtfoNlM7dPxT4JUgzXIEh
         sUKoojixL7A+I7HKHymo/qMcMN6mKAV0gvhrMtAMHk73OpVKlZj0DYiuMnSkFSDhL0d+
         n/bf4OAjwCM3HM7B9nIGoG2YFaW5U0ExRmwaxlAIKnJBrVPs11AM8RC5KbDuZWAZfFu3
         ahQehv3Fj0VrR2ktrLrm7H+UZYA53gdUOp8lIKGRRPFov/CITFFBCcS35lY6OQMYB2Km
         iESw==
X-Gm-Message-State: AJcUukdIVSh2jIaZvEvIXyiEmui28AZhWlHq/fJjT1NAa/dD4MgZFvj1
        wGUvxnokEEfkCnBQ70ekZYY6eg==
X-Google-Smtp-Source: ALg8bN4L8jvO5/vcHBxt8Z+DUY13fWy9homFS1Qc5dfr0yy6JOQYXt+jQ90H0MvGGFDBxMfEYo8Hzg==
X-Received: by 2002:a17:902:722:: with SMTP id 31mr44165479pli.271.1546444399500;
        Wed, 02 Jan 2019 07:53:19 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id n7sm95242637pff.36.2019.01.02.07.53.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jan 2019 07:53:19 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     "David S . Miller" <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>, sparclinux@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 1/3] sparc: remove nargs from __SYSCALL
Date:   Wed,  2 Jan 2019 21:22:51 +0530
Message-Id: <1546444373-21386-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546444373-21386-1-git-send-email-firoz.khan@linaro.org>
References: <1546444373-21386-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __SYSCALL macro's arguments are system call number,
system call entry name and number of arguments for the
system call.

Argument- nargs in __SYSCALL(nr, entry, nargs) is neither
calculated nor used anywhere. So it would be better to
keep the implementaion as  __SYSCALL(nr, entry). This will
unifies the implementation with some other architetures
too.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/sparc/kernel/syscalls/syscalltbl.sh | 4 ++--
 arch/sparc/kernel/systbls_32.S           | 2 +-
 arch/sparc/kernel/systbls_64.S           | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/syscalls/syscalltbl.sh b/arch/sparc/kernel/syscalls/syscalltbl.sh
index 77cf014..ffe954b 100644
--- a/arch/sparc/kernel/syscalls/syscalltbl.sh
+++ b/arch/sparc/kernel/syscalls/syscalltbl.sh
@@ -13,10 +13,10 @@ emit() {
 	t_entry="$3"
 
 	while [ $t_nxt -lt $t_nr ]; do
-		printf "__SYSCALL(%s, sys_nis_syscall, )\n" "${t_nxt}"
+		printf "__SYSCALL(%s,sys_nis_syscall)\n" "${t_nxt}"
 		t_nxt=$((t_nxt+1))
 	done
-	printf "__SYSCALL(%s, %s, )\n" "${t_nxt}" "${t_entry}"
+	printf "__SYSCALL(%s,%s)\n" "${t_nxt}" "${t_entry}"
 }
 
 grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
diff --git a/arch/sparc/kernel/systbls_32.S b/arch/sparc/kernel/systbls_32.S
index ab9e4d5..391a49a 100644
--- a/arch/sparc/kernel/systbls_32.S
+++ b/arch/sparc/kernel/systbls_32.S
@@ -9,7 +9,7 @@
  * Copyright (C) 1995 Adrian M. Rodriguez (adrian@remus.rutgers.edu)
  */
 
-#define __SYSCALL(nr, entry, nargs) .long entry
+#define __SYSCALL(nr, entry)	.long entry
 	.data
 	.align 4
 	.globl sys_call_table
diff --git a/arch/sparc/kernel/systbls_64.S b/arch/sparc/kernel/systbls_64.S
index a27394b..08ce7cb 100644
--- a/arch/sparc/kernel/systbls_64.S
+++ b/arch/sparc/kernel/systbls_64.S
@@ -10,7 +10,7 @@
  * Copyright (C) 1995 Adrian M. Rodriguez (adrian@remus.rutgers.edu)
  */
 
-#define __SYSCALL(nr, entry, nargs) .word entry
+#define __SYSCALL(nr, entry)	.word entry
 	.text
 	.align	4
 #ifdef CONFIG_COMPAT
-- 
1.9.1

