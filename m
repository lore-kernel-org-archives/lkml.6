Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D040C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE0B218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L7H8So9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbfABPTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 10:19:06 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42413 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730024AbfABPTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 10:19:04 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so14699717pga.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 07:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GABRy0pMwiMY1Dksx8weGXDMbDEwqCieHO+NUUKO31A=;
        b=L7H8So9azlrdkn9gBTVGbKmHBo7qZPvJTH8ZE6WiL5+RSvoBgaGttx7Ub7U39e1QQa
         uXgjwszQVIDzNV8RMNn/dp6Nc5supeTAKqMA3V4r7LvICPFAfM+iQh1gPK1R3WGO4hT9
         l/+O6tkCl3tOsdvDBmi4A0QiBengEb8sQjZeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GABRy0pMwiMY1Dksx8weGXDMbDEwqCieHO+NUUKO31A=;
        b=SWUibfTekfBa/i0OgSgznM/uDoGtRC0q0xHAx3IqbvnwZs0LKl9EVIhvKxo6kmYvDr
         VZNSPxGvJ5aRLJ/PI7wsMNd8my6vnpTAXtmW/5ZYjKvm9T+sA1DKMRdB4ChBk9Y5dp1m
         L0ykmcDO7BWtgq3kqTl+Wnit2lPF8c0Y+7dpx82TzK5DcWP4Su7lBlsy7hLB3RliKgLB
         a1V+hC4ScK6ckwMcXevklpPwmW5Th+Y2D+wcNQ+zGD/morjwNAY9rDUmnTb1fY1utTSD
         kMNAx7/Hal1Ct0PJUE+FgWOw6iALeg1YGJ+PYIbDO/QfsULo7CM4TZH0/YCzhD5OpEIM
         pzpw==
X-Gm-Message-State: AJcUukcYPTdgiam7DdA1AX7fh+3NWAB6lsu3b90XPBs9TPGHkTbqJC9Y
        WWylp9Rk2D8kP3i4r4QBnzWlgA==
X-Google-Smtp-Source: ALg8bN7GV+++iMY98s42srdyUs6+mFh/E8yuK2LRf0bu4GnX2YKgqGIDXe9vI7nXIk9sWbVsLCCNVQ==
X-Received: by 2002:a63:78cd:: with SMTP id t196mr13894985pgc.62.1546442344027;
        Wed, 02 Jan 2019 07:19:04 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id i2sm14726788pfi.66.2019.01.02.07.19.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jan 2019 07:19:03 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 1/2] m68k: remove nargs from __SYSCALL
Date:   Wed,  2 Jan 2019 20:48:38 +0530
Message-Id: <1546442319-20461-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546442319-20461-1-git-send-email-firoz.khan@linaro.org>
References: <1546442319-20461-1-git-send-email-firoz.khan@linaro.org>
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
 arch/m68k/kernel/syscalls/syscalltbl.sh | 4 ++--
 arch/m68k/kernel/syscalltable.S         | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/kernel/syscalls/syscalltbl.sh b/arch/m68k/kernel/syscalls/syscalltbl.sh
index 85d78d9..904b8e6 100644
--- a/arch/m68k/kernel/syscalls/syscalltbl.sh
+++ b/arch/m68k/kernel/syscalls/syscalltbl.sh
@@ -13,10 +13,10 @@ emit() {
 	t_entry="$3"
 
 	while [ $t_nxt -lt $t_nr ]; do
-		printf "__SYSCALL(%s, sys_ni_syscall, )\n" "${t_nxt}"
+		printf "__SYSCALL(%s,sys_ni_syscall)\n" "${t_nxt}"
 		t_nxt=$((t_nxt+1))
 	done
-	printf "__SYSCALL(%s, %s, )\n" "${t_nxt}" "${t_entry}"
+	printf "__SYSCALL(%s,%s)\n" "${t_nxt}" "${t_entry}"
 }
 
 grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
diff --git a/arch/m68k/kernel/syscalltable.S b/arch/m68k/kernel/syscalltable.S
index d329cc7..0082664 100644
--- a/arch/m68k/kernel/syscalltable.S
+++ b/arch/m68k/kernel/syscalltable.S
@@ -18,7 +18,7 @@
 #define sys_mmap2	sys_mmap_pgoff
 #endif
 
-#define __SYSCALL(nr, entry, nargs) .long entry
+#define __SYSCALL(nr, entry)	.long entry
 	.section .rodata
 ALIGN
 ENTRY(sys_call_table)
-- 
1.9.1

