Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F170C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD65218CD
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OIiEqvn8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbfABO4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 09:56:51 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44737 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbfABO4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 09:56:50 -0500
Received: by mail-pf1-f196.google.com with SMTP id u6so15271358pfh.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 06:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PE7tuPVD5ji389rrnaCznzLxbmlbwQF30eStDamFN0I=;
        b=OIiEqvn8P3Gv2S9b//iL2+G1CwFUU985SGmKBytRaaODKFSpllQnYB6g+zJdesH/kH
         4vpLyyq/WJBwYzhxcO61pyK39hYavWXri4rBilsICuUs4rxCNVdnO6Ewl7SKlvx74meu
         74ztBJEPmk2GWXZGcfBj7bq3WGVk4xmN4zShE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PE7tuPVD5ji389rrnaCznzLxbmlbwQF30eStDamFN0I=;
        b=A8vCR+MLCNgjo9wLy1wVNGSHtrI/Ot6HKbXydR9io9ajmNPwe11tOd5iKAjfnwpoKA
         jYRNMVZmHJm4B0YWI5IcLSjccfi4C0uqme7748MNAW9E9WhdbxePVwARKlzyDDk1hATM
         kNkvHUwAThByWq+5WJTluydw4wYFNyQBIdGhF07KMQv6zlE3VvsnRpZxAbMkJ7Y0tEO6
         cFw2sQfekErWoodqpmbbBymNNMRlgtBFuR+pnUyasYtrAGRTLujedIw8RyyPHA5JKwf2
         xwZmcpGR7ViHkZBECK2fi2uU55RkBO4XDvTHLEexjAzgJokEmTUUGbalbcybsL3DGLX9
         azSQ==
X-Gm-Message-State: AJcUukcM7ppJvxhkl0Ky2ncMqjuoKZl8pZE/W2I6oTwoCnhS8+VGDkW+
        0jJEbLhxxrWbsbtl+qW5ICALCw==
X-Google-Smtp-Source: ALg8bN61X9RMFtoxayM0/1Og3lLQI+KIiBGAao2V4BKlZCBlJtWbiz/47NR0f0cVVe7y7oDRMuxtgw==
X-Received: by 2002:a63:7e1a:: with SMTP id z26mr30008986pgc.216.1546441009526;
        Wed, 02 Jan 2019 06:56:49 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5sm96745685pfz.149.2019.01.02.06.56.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jan 2019 06:56:49 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 1/2] mips: remove nargs from __SYSCALL
Date:   Wed,  2 Jan 2019 20:26:17 +0530
Message-Id: <1546440978-19569-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546440978-19569-1-git-send-email-firoz.khan@linaro.org>
References: <1546440978-19569-1-git-send-email-firoz.khan@linaro.org>
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
 arch/mips/kernel/scall32-o32.S          | 2 +-
 arch/mips/kernel/scall64-n32.S          | 2 +-
 arch/mips/kernel/scall64-n64.S          | 2 +-
 arch/mips/kernel/scall64-o32.S          | 2 +-
 arch/mips/kernel/syscalls/syscalltbl.sh | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index d9434cd..b449b68 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -217,7 +217,7 @@ einval: li	v0, -ENOSYS
 #define sys_sched_getaffinity	mipsmt_sys_sched_getaffinity
 #endif /* CONFIG_MIPS_MT_FPAFF */
 
-#define __SYSCALL(nr, entry, nargs)	PTR entry
+#define __SYSCALL(nr, entry) 	PTR entry
 	.align	2
 	.type	sys_call_table, @object
 EXPORT(sys_call_table)
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index c761ddf..35d8c86 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -101,7 +101,7 @@ not_n32_scall:
 
 	END(handle_sysn32)
 
-#define __SYSCALL(nr, entry, nargs) PTR entry
+#define __SYSCALL(nr, entry)	PTR entry
 	.type	sysn32_call_table, @object
 EXPORT(sysn32_call_table)
 #include <asm/syscall_table_64_n32.h>
diff --git a/arch/mips/kernel/scall64-n64.S b/arch/mips/kernel/scall64-n64.S
index 727fb8a..23b2e2b 100644
--- a/arch/mips/kernel/scall64-n64.S
+++ b/arch/mips/kernel/scall64-n64.S
@@ -109,7 +109,7 @@ illegal_syscall:
 	j	n64_syscall_exit
 	END(handle_sys64)
 
-#define __SYSCALL(nr, entry, nargs) PTR entry
+#define __SYSCALL(nr, entry)	PTR entry
 	.align	3
 	.type	sys_call_table, @object
 EXPORT(sys_call_table)
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index f158c58..e229155 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -213,7 +213,7 @@ einval: li	v0, -ENOSYS
 	jr	ra
 	END(sys32_syscall)
 
-#define __SYSCALL(nr, entry, nargs) PTR entry
+#define __SYSCALL(nr, entry)	PTR entry
 	.align	3
 	.type	sys32_call_table,@object
 EXPORT(sys32_call_table)
diff --git a/arch/mips/kernel/syscalls/syscalltbl.sh b/arch/mips/kernel/syscalls/syscalltbl.sh
index acd338d..1e25707 100644
--- a/arch/mips/kernel/syscalls/syscalltbl.sh
+++ b/arch/mips/kernel/syscalls/syscalltbl.sh
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
-- 
1.9.1

