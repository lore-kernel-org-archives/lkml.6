Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47E5C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A30C218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UvBut2rs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbfABPxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 10:53:31 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34786 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730301AbfABPx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 10:53:29 -0500
Received: by mail-pf1-f193.google.com with SMTP id h3so15356929pfg.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 07:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/6QIRkSywJIAMa7P20oR43mtkBtoVMs6c6JfHglievg=;
        b=UvBut2rsd5wSSYOe0iapCEq1qfsXDQFns6i8u9tKA2rggBxhyfrXM8m4l3d2ZEDpa9
         gypCnTqf08i9JwLUoBDx3zlmV77nxJ7KR9bjyRCycudqeda7Fqp4hqbavk3TOvDZRJuY
         dnoRQpsnQoPxurB8+XcinSUd5VYILZFFkAUCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/6QIRkSywJIAMa7P20oR43mtkBtoVMs6c6JfHglievg=;
        b=Qkt449Re7THk53qYX8AB83LuYX8dDeHcRH+yMTLmtRWaXeq/dLtGkLjjvR9KY6aqIc
         tz6zp4HOTFTzkAQZPC0HaHti0f61efFea5o2h9X6aQ6agBOeEZpocj91Zygo9WB/mCAt
         8sEH9qJY4Za9pMC1Ep/OaCVA3sVBzFE0Kqeb3POppN76Yi6Clsx5/yVAcxXhr5S0seGe
         41a3vplGUu8EOuzUZu3DiXMQNES91FTxOjPGVrD9HIpYdWF8CC+MBXf1kngliw48Opaf
         uNVY0mK2c/SbWiwjoDHuch7lJ7iR3bl7FppAYxrlsxMZwx9IX5+AMqXPTaPf3lSaWYzj
         MfmA==
X-Gm-Message-State: AJcUuke/HFibELuC4d6ZMj7VZYHcNJ2eACINBhUd2RzmW89LdCK7uFaN
        kMk1Cv+5JA+TMDAj9CaX06WOgvLixPk=
X-Google-Smtp-Source: ALg8bN6g1EDKB1Eas6Ui7hLVjWVa+W43Dk55+6+9gLfNI8ukBswU9VBqty+ciSlQGrB/5NC2t1LyIw==
X-Received: by 2002:a62:8d4f:: with SMTP id z76mr46207397pfd.2.1546444408523;
        Wed, 02 Jan 2019 07:53:28 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id n7sm95242637pff.36.2019.01.02.07.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jan 2019 07:53:28 -0800 (PST)
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
Subject: [PATCH 3/3] sparc: generate uapi header and system call table files
Date:   Wed,  2 Jan 2019 21:22:53 +0530
Message-Id: <1546444373-21386-4-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546444373-21386-1-git-send-email-firoz.khan@linaro.org>
References: <1546444373-21386-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unified system call table generation script must be run to
generate unistd_32/64.h and syscall_table_32/64/c32.h files.
This patch will have changes which will invokes the script.

This patch will generate unistd_32/64.h and syscall_table-
_32/64/c32.h files by the syscall table generation script
invoked by parisc/Makefile and the generated files against
the removed files must be identical.

The generated uapi header file will be included in uapi/-
asm/unistd.h and generated system call table header file
will be included by kernel/systbls_32/64.S file.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/sparc/kernel/syscalls/Makefile      | 11 ++++++++--
 arch/sparc/kernel/syscalls/syscallhdr.sh | 36 --------------------------------
 arch/sparc/kernel/syscalls/syscalltbl.sh | 36 --------------------------------
 3 files changed, 9 insertions(+), 74 deletions(-)
 delete mode 100644 arch/sparc/kernel/syscalls/syscallhdr.sh
 delete mode 100644 arch/sparc/kernel/syscalls/syscalltbl.sh

diff --git a/arch/sparc/kernel/syscalls/Makefile b/arch/sparc/kernel/syscalls/Makefile
index c22a21c..e24272d 100644
--- a/arch/sparc/kernel/syscalls/Makefile
+++ b/arch/sparc/kernel/syscalls/Makefile
@@ -6,8 +6,9 @@ _dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')	\
 	  $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
 
 syscall := $(srctree)/$(src)/syscall.tbl
-syshdr := $(srctree)/$(src)/syscallhdr.sh
-systbl := $(srctree)/$(src)/syscalltbl.sh
+syshdr := $(srctree)/scripts/syscallhdr.sh
+sysnr := $(srctree)/scripts/syscallnr.sh
+systbl := $(srctree)/scripts/syscalltbl.sh
 
 quiet_cmd_syshdr = SYSHDR  $@
       cmd_syshdr = $(CONFIG_SHELL) '$(syshdr)' '$<' '$@'	\
@@ -15,6 +16,12 @@ quiet_cmd_syshdr = SYSHDR  $@
 		   '$(syshdr_pfx_$(basetarget))'		\
 		   '$(syshdr_offset_$(basetarget))'
 
+quiet_cmd_sysnr = SYSNR  $@
+      cmd_sysnr = $(CONFIG_SHELL) '$(sysnr)' '$<' '$@'		\
+		  '$(sysnr_abis_$(basetarget))'			\
+		  '$(sysnr_pfx_$(basetarget))'			\
+		  '$(sysnr_offset_$(basetarget))'
+
 quiet_cmd_systbl = SYSTBL  $@
       cmd_systbl = $(CONFIG_SHELL) '$(systbl)' '$<' '$@'	\
 		   '$(systbl_abis_$(basetarget))'		\
diff --git a/arch/sparc/kernel/syscalls/syscallhdr.sh b/arch/sparc/kernel/syscalls/syscallhdr.sh
deleted file mode 100644
index 626b574..0000000
--- a/arch/sparc/kernel/syscalls/syscallhdr.sh
+++ /dev/null
@@ -1,36 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-in="$1"
-out="$2"
-my_abis=`echo "($3)" | tr ',' '|'`
-prefix="$4"
-offset="$5"
-
-fileguard=_UAPI_ASM_SPARC_`basename "$out" | sed \
-	-e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
-	-e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
-grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
-	printf "#ifndef %s\n" "${fileguard}"
-	printf "#define %s\n" "${fileguard}"
-	printf "\n"
-
-	nxt=0
-	while read nr abi name entry compat ; do
-		if [ -z "$offset" ]; then
-			printf "#define __NR_%s%s\t%s\n" \
-				"${prefix}" "${name}" "${nr}"
-		else
-			printf "#define __NR_%s%s\t(%s + %s)\n" \
-				"${prefix}" "${name}" "${offset}" "${nr}"
-		fi
-		nxt=$((nr+1))
-	done
-
-	printf "\n"
-	printf "#ifdef __KERNEL__\n"
-	printf "#define __NR_syscalls\t%s\n" "${nxt}"
-	printf "#endif\n"
-	printf "\n"
-	printf "#endif /* %s */" "${fileguard}"
-) > "$out"
diff --git a/arch/sparc/kernel/syscalls/syscalltbl.sh b/arch/sparc/kernel/syscalls/syscalltbl.sh
deleted file mode 100644
index ffe954b..0000000
--- a/arch/sparc/kernel/syscalls/syscalltbl.sh
+++ /dev/null
@@ -1,36 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-in="$1"
-out="$2"
-my_abis=`echo "($3)" | tr ',' '|'`
-my_abi="$4"
-offset="$5"
-
-emit() {
-	t_nxt="$1"
-	t_nr="$2"
-	t_entry="$3"
-
-	while [ $t_nxt -lt $t_nr ]; do
-		printf "__SYSCALL(%s,sys_nis_syscall)\n" "${t_nxt}"
-		t_nxt=$((t_nxt+1))
-	done
-	printf "__SYSCALL(%s,%s)\n" "${t_nxt}" "${t_entry}"
-}
-
-grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
-	nxt=0
-	if [ -z "$offset" ]; then
-		offset=0
-	fi
-
-	while read nr abi name entry compat ; do
-		if [ "$my_abi" = "c32" ] && [ ! -z "$compat" ]; then
-			emit $((nxt+offset)) $((nr+offset)) $compat
-		else
-			emit $((nxt+offset)) $((nr+offset)) $entry
-		fi
-		nxt=$((nr+1))
-	done
-) > "$out"
-- 
1.9.1

