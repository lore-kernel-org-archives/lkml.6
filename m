Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77961C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4765B218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aQ9JBnY8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbfABPXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 10:23:31 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38668 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729988AbfABPX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 10:23:27 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so15306897pfi.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 07:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RFjQaaMOaV7so1q6PSW0dhpBMNj0R1n04Zjk4Uk3EJA=;
        b=aQ9JBnY8cFyfAcqzwHyNAElbN+tYLozRwcLqfvClaYdCGVnk7EMFHWfbYgKTkmYwrW
         HY6xK8Lf+9vbTlLB/sL9p9bjcar2yhKouRCI3qhsjd2SqgolTOTzKco6M9LNZ3wGZ9nj
         /cSU+GD/v2E54j8F4mnBN0PJ6i6lHR/pZYD6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RFjQaaMOaV7so1q6PSW0dhpBMNj0R1n04Zjk4Uk3EJA=;
        b=PEuHzM0dE2AyRspPeEBb5aqqygfzDGIYsbEEvk+rq6Q2o7GyMRS8grRe8WaCtjzy3A
         erqsuEoUsPfhxeRDq/wzIoG5N+tj76z0FFHLbP9EyGLn06WwZEMQE8bzxEqPdbp3DT8I
         Dk4z1Ndvy9hoD9BuzFhjdeyc6RNnycJJometwoIOVTtsEHJi+yZGdOeXyvoifBcE+p8p
         71l4uMy7anu8/04lSerQ9GpCDuueR3D9RqUDsxd61M6K7WMdXmtRqu+0CCxPZHzhwoES
         yXv3HlZ8sBV0OKWjamT1bvGKBdKJ6O6d9gTghSr3JwlJIAHILjI0C/ioE65x/EYVgyfs
         dFbg==
X-Gm-Message-State: AA+aEWah+gpJn/lcuBPUm8pgFc1EATrwg3rTJW7YuUg4nmMkt6VvjHIh
        ABIDIddw2oJ6sBjlb0wO2dn8wg==
X-Google-Smtp-Source: AFSGD/WvMNXLEkG6clWi9bRNwOl+sSWGcv9uMr3qkMv7VinI49q0kRXsIUMjzPLJSU1qtzrH97D80A==
X-Received: by 2002:a62:d701:: with SMTP id b1mr43924712pfh.34.1546442606697;
        Wed, 02 Jan 2019 07:23:26 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id m20sm67719647pgv.93.2019.01.02.07.23.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jan 2019 07:23:26 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        linux-ia64@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 2/2] ia64: generate uapi header and system call table files
Date:   Wed,  2 Jan 2019 20:52:47 +0530
Message-Id: <1546442567-20637-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546442567-20637-1-git-send-email-firoz.khan@linaro.org>
References: <1546442567-20637-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unified system call table generation script must be run to
generate unistd_64.h and syscall_table.h files. This patch
will have changes which will invokes the script.

This patch will generate unistd_64.h and syscall_table.h
files by the syscall table generation script invoked by
ia64/Makefile and the generated files against the removed
files must be identical.

The generated uapi header file will be included in uapi/-
asm/unistd.h and generated system call table header file
will be included by kernel/entry.S file.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/ia64/kernel/syscalls/Makefile      | 11 ++++++++--
 arch/ia64/kernel/syscalls/syscallhdr.sh | 36 ---------------------------------
 arch/ia64/kernel/syscalls/syscalltbl.sh | 32 -----------------------------
 3 files changed, 9 insertions(+), 70 deletions(-)
 delete mode 100644 arch/ia64/kernel/syscalls/syscallhdr.sh
 delete mode 100644 arch/ia64/kernel/syscalls/syscalltbl.sh

diff --git a/arch/ia64/kernel/syscalls/Makefile b/arch/ia64/kernel/syscalls/Makefile
index 813a58c..094f186 100644
--- a/arch/ia64/kernel/syscalls/Makefile
+++ b/arch/ia64/kernel/syscalls/Makefile
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
diff --git a/arch/ia64/kernel/syscalls/syscallhdr.sh b/arch/ia64/kernel/syscalls/syscallhdr.sh
deleted file mode 100644
index 0c2d2c7..0000000
--- a/arch/ia64/kernel/syscalls/syscallhdr.sh
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
-fileguard=_UAPI_ASM_IA64_`basename "$out" | sed \
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
diff --git a/arch/ia64/kernel/syscalls/syscalltbl.sh b/arch/ia64/kernel/syscalls/syscalltbl.sh
deleted file mode 100644
index 904b8e6..0000000
--- a/arch/ia64/kernel/syscalls/syscalltbl.sh
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

