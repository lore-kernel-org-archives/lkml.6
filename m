Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E010C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD372218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eZ+N62KN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbfABPiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 10:38:01 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43333 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730190AbfABPh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 10:37:59 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so14659975plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 07:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RGqgaRXD6Ws2lx1y4vB0VL720ZVcv6fzuotxHip3TgQ=;
        b=eZ+N62KNyNKNjyjADYlggcmziP2/W0w3GpO1D2/SkMEgoWGo79Gco5+laDORNhPDP9
         da2xjenXp34iC77kgbPmwPsxR9tPum7JAiBx2e2uZWaMFYRluJVta1QXG9y1t7NUwKvU
         M+1tJkNELG8OPpCPw8RmyxRGCYhfIC9VsVimM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RGqgaRXD6Ws2lx1y4vB0VL720ZVcv6fzuotxHip3TgQ=;
        b=YieDttkdgLE0tta2SfYwZWjLguC0fN/M00V0ebsJ3LTG+qDLktN/g/4QcBZ/7iz+8J
         7hPk2tEe3uZ4phoJr95a4IjEdR2qmhyeMVbgUNvpFm2InuGp3UzFIFfQtYn956c4hdT8
         GEgT3WGkfQQa5WXrwNhbFS3lS16EsvSB+St2WlJaD3NTsF5S0Av6/DPU9SXBffsINhgk
         Pr2eKgQWvhT7MeohawHkN+JY0g+eg1qQ3fvCrKUR4dHfQI3RoCU+ltGhJvc95uMczG4K
         UMsp2B+S+8RfWCn798TrQLV02OvG0A9sgVkQcPv3OPCyPuQgm3f5i2+0uno52s26E46T
         7rKg==
X-Gm-Message-State: AJcUukfgzol1JAXUGFUlxTpo4h4NrT6fT+qpJWBT04+xpTzzcOUeg7GJ
        AhkWS+FmeHuIDMxDLxixoW+/xA==
X-Google-Smtp-Source: ALg8bN4IgPngY7Qr4wBMjRrH3fIbzASltXa6ywM6BLEvqeEPtGnOJP+1pvgLcdb3M/VUQFPpR2JpnQ==
X-Received: by 2002:a17:902:14b:: with SMTP id 69mr44301439plb.52.1546443477605;
        Wed, 02 Jan 2019 07:37:57 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id c4sm108500721pfm.151.2019.01.02.07.37.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jan 2019 07:37:57 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-sh@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 2/2] sh: generate uapi header and syscall table header files
Date:   Wed,  2 Jan 2019 21:07:25 +0530
Message-Id: <1546443445-21075-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546443445-21075-1-git-send-email-firoz.khan@linaro.org>
References: <1546443445-21075-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unified system call table generation script must be run to
generate unistd_32.h and syscall_table.h files. This patch
will have changes which will invokes the script.

This patch will generate unistd_32.h and syscall_table.h
files by the syscall table generation script invoked by
sh/Makefile and the generated files against the removed
files must be identical.

The generated uapi header file will be included in uapi/-
asm/unistd.h and generated system call table header file
will be included by kernel/syscall_32.S file.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/sh/kernel/syscalls/Makefile      | 11 +++++++++--
 arch/sh/kernel/syscalls/syscallhdr.sh | 36 -----------------------------------
 arch/sh/kernel/syscalls/syscalltbl.sh | 32 -------------------------------
 3 files changed, 9 insertions(+), 70 deletions(-)
 delete mode 100644 arch/sh/kernel/syscalls/syscallhdr.sh
 delete mode 100644 arch/sh/kernel/syscalls/syscalltbl.sh

diff --git a/arch/sh/kernel/syscalls/Makefile b/arch/sh/kernel/syscalls/Makefile
index 659faef..75c7421 100644
--- a/arch/sh/kernel/syscalls/Makefile
+++ b/arch/sh/kernel/syscalls/Makefile
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
diff --git a/arch/sh/kernel/syscalls/syscallhdr.sh b/arch/sh/kernel/syscalls/syscallhdr.sh
deleted file mode 100644
index 1de0334..0000000
--- a/arch/sh/kernel/syscalls/syscallhdr.sh
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
-fileguard=_UAPI_ASM_SH_`basename "$out" | sed \
-	-e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
-	-e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
-grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
-	printf "#ifndef %s\n" "${fileguard}"
-	printf "#define %s\n" "${fileguard}"
-	printf "\n"
-
-	nxt=0
-	while read nr abi name entry ; do
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
diff --git a/arch/sh/kernel/syscalls/syscalltbl.sh b/arch/sh/kernel/syscalls/syscalltbl.sh
deleted file mode 100644
index 904b8e6..0000000
--- a/arch/sh/kernel/syscalls/syscalltbl.sh
+++ /dev/null
@@ -1,32 +0,0 @@
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
-		printf "__SYSCALL(%s,sys_ni_syscall)\n" "${t_nxt}"
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
-	while read nr abi name entry ; do
-		emit $((nxt+offset)) $((nr+offset)) $entry
-		nxt=$((nr+1))
-	done
-) > "$out"
-- 
1.9.1

