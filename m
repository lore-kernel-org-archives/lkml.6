Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51BAC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C356218CD
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jHfbseUN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbfABO44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 09:56:56 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43488 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729700AbfABO4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 09:56:55 -0500
Received: by mail-pg1-f196.google.com with SMTP id v28so14681644pgk.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 06:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AZpMXadv7N+HBsKpir5Le3ZPxvZAqE7DPpdjcjx0uwU=;
        b=jHfbseUNtttCualNw9t94SDtdc8ElaepYh15xpb0kpx9V6TEQciFQFV9kWnPGeNb4C
         ae8jwZxAGJf51YD8k35hl+RNVN1XQrYrRZh1EE5KbrFLLFJwLosmS4DNc0I0Lxg5pw0X
         UhyV/kuS40hJjkcQ7yXy9kt3jii5/tLvIiqD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AZpMXadv7N+HBsKpir5Le3ZPxvZAqE7DPpdjcjx0uwU=;
        b=FA2p4nad4FWXRAcLqPdeyyTc9vmV2EBQ/1EhycBCzBx1x7tAzBqpzdWnj9fb/RvMkw
         Wm4rVIyajER69rD7S0u8Xo9V0g96Akgp9xq2jdTcqkUN2pDK4/kLF9mkDnkZEits9uLk
         qgD6lFojeYF6DunkiI0CXkF7x5h8NIyfEscpwFiQSRK1QEHd3egVbX+YMzo+FfO+KaRg
         fAsW+r1jiJ6ZcTighzSdmfArjoHyW1TmbfWpNl7HnPeloexnximOtmkJ8nCTe+pKuy+X
         kgojUTWlIaFzB3J/oMRrDr2dnfC+hNADIVPM2kiRJTJXBFBxzj+P0/fQQQ2nmlkfAQoi
         VHwA==
X-Gm-Message-State: AJcUukcWVXCbp7SwtckyIj6gLJeZ4RnOCj7f2RSuReiBqEL4c+BdZmjr
        YibqkJZ4MOYzvlSiOEMUsP+1CA==
X-Google-Smtp-Source: ALg8bN56XOiDOzIdVrMZJ+3UnqqTIDC7fLYzWWoYJS9cVpsNG8kAcoR1fLuNP35wtAsMIwq+1E5gkg==
X-Received: by 2002:a63:d450:: with SMTP id i16mr41308693pgj.246.1546441014589;
        Wed, 02 Jan 2019 06:56:54 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5sm96745685pfz.149.2019.01.02.06.56.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jan 2019 06:56:54 -0800 (PST)
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
Subject: [PATCH 2/2] mips: generate uapi header and system call table files
Date:   Wed,  2 Jan 2019 20:26:18 +0530
Message-Id: <1546440978-19569-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546440978-19569-1-git-send-email-firoz.khan@linaro.org>
References: <1546440978-19569-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unified system call table generation script must be run
to generate unistd_(nr_)n64/n32/o32.h and syscall_table-
_32_o32/64_n64/64_n32/64-o32.h files. This patch will
have changes which will invokes the script.

This patch will generate unistd_(nr_)n64/n32/o32.h and
syscall_table_32_o32/64_n64/64-n32/64-o32.h files by the
syscall table generation script invoked by parisc/Make-
file and the generated files against the removed files
must be identical.

The generated uapi header file will be included in uapi/-
asm/unistd.h and generated system call table header file
will be included by kernel/scall32-o32/64-n64/64-n32/-
64-o32.Sfile.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/mips/kernel/syscalls/Makefile      |  6 +++---
 arch/mips/kernel/syscalls/syscallhdr.sh | 37 ---------------------------------
 arch/mips/kernel/syscalls/syscallnr.sh  | 28 -------------------------
 arch/mips/kernel/syscalls/syscalltbl.sh | 36 --------------------------------
 4 files changed, 3 insertions(+), 104 deletions(-)
 delete mode 100644 arch/mips/kernel/syscalls/syscallhdr.sh
 delete mode 100644 arch/mips/kernel/syscalls/syscallnr.sh
 delete mode 100644 arch/mips/kernel/syscalls/syscalltbl.sh

diff --git a/arch/mips/kernel/syscalls/Makefile b/arch/mips/kernel/syscalls/Makefile
index a3d4bec..8b7013e 100644
--- a/arch/mips/kernel/syscalls/Makefile
+++ b/arch/mips/kernel/syscalls/Makefile
@@ -8,9 +8,9 @@ _dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')	\
 syscalln32 := $(srctree)/$(src)/syscall_n32.tbl
 syscalln64 := $(srctree)/$(src)/syscall_n64.tbl
 syscallo32 := $(srctree)/$(src)/syscall_o32.tbl
-syshdr := $(srctree)/$(src)/syscallhdr.sh
-sysnr := $(srctree)/$(src)/syscallnr.sh
-systbl := $(srctree)/$(src)/syscalltbl.sh
+syshdr := $(srctree)/scripts/syscallhdr.sh
+sysnr := $(srctree)/scripts/syscallnr.sh
+systbl := $(srctree)/scripts/syscalltbl.sh
 
 quiet_cmd_syshdr = SYSHDR  $@
       cmd_syshdr = $(CONFIG_SHELL) '$(syshdr)' '$<' '$@'	\
diff --git a/arch/mips/kernel/syscalls/syscallhdr.sh b/arch/mips/kernel/syscalls/syscallhdr.sh
deleted file mode 100644
index d2bcfa8..0000000
--- a/arch/mips/kernel/syscalls/syscallhdr.sh
+++ /dev/null
@@ -1,37 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-in="$1"
-out="$2"
-my_abis=`echo "($3)" | tr ',' '|'`
-prefix="$4"
-offset="$5"
-
-fileguard=_UAPI_ASM_MIPS_`basename "$out" | sed \
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
-	printf "\n"
-) > "$out"
diff --git a/arch/mips/kernel/syscalls/syscallnr.sh b/arch/mips/kernel/syscalls/syscallnr.sh
deleted file mode 100644
index 60bbdb3..0000000
--- a/arch/mips/kernel/syscalls/syscallnr.sh
+++ /dev/null
@@ -1,28 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-in="$1"
-out="$2"
-my_abis=`echo "($3)" | tr ',' '|'`
-prefix="$4"
-offset="$5"
-
-fileguard=_UAPI_ASM_MIPS_`basename "$out" | sed \
-	-e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
-	-e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
-grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
-	printf "#ifndef %s\n" "${fileguard}"
-	printf "#define %s\n" "${fileguard}"
-	printf "\n"
-
-	nxt=0
-	while read nr abi name entry compat ; do
-		nxt=$((nr+1))
-	done
-
-	printf "#define __NR_%s_Linux\t%s\n" "${prefix}" "${offset}"
-	printf "#define __NR_%s_Linux_syscalls\t%s\n" "${prefix}" "${nxt}"
-	printf "\n"
-	printf "#endif /* %s */" "${fileguard}"
-	printf "\n"
-) > "$out"
diff --git a/arch/mips/kernel/syscalls/syscalltbl.sh b/arch/mips/kernel/syscalls/syscalltbl.sh
deleted file mode 100644
index 1e25707..0000000
--- a/arch/mips/kernel/syscalls/syscalltbl.sh
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
-	while read nr abi name entry compat ; do
-		if [ "$my_abi" = "64_o32" ] && [ ! -z "$compat" ]; then
-			emit $((nxt+offset)) $((nr+offset)) $compat
-		else
-			emit $((nxt+offset)) $((nr+offset)) $entry
-		fi
-		nxt=$((nr+1))
-	done
-) > "$out"
-- 
1.9.1

