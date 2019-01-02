Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F83C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9835720656
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GIitmsin"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbfABPHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 10:07:42 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45899 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729853AbfABPHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 10:07:38 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so14687276pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 07:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BpdCkO4cmTj33UUTHGwsT4WjRV/iOfWi6Qr7bUc27sE=;
        b=GIitmsins5R8uwRYvO3WlhKg4IdAIReu53iCAMsOG4VxX0NVX3TOc6UD/biqn82mGp
         6EXh1luvYHJuToJk8c7rtEQJZM9TUko99GkxocDxSFM/Dbp1wUkbCdzJ/RnPmB8oxlgr
         fRao6BOBqtoiBa1UEIztlLbH06nFTuCV7He5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BpdCkO4cmTj33UUTHGwsT4WjRV/iOfWi6Qr7bUc27sE=;
        b=JWWFVo3tz2/jw0yKIK1nWiLmMxjtQnrdojynk0Jwss9w3KcgkLrzxyPnTS2Yw1NgTC
         U0NNYl01rLqYL9Vb/gasOqhaOCGJaRT43+5uWY/urYXVLz4TjeJPufBb8dgzwFuQ3ej5
         IjfpL3zje8EXzr9Iin5K2vuaZ1i7IOJIjZolBkHTXfD98oma27zfZSaeHQ7OFQJtZULG
         Mf7GXeiJgXEHFxX1DdXDh1BFE+q+FzADDmGuRzfLF22JC+bBU6fHygCh06oCfMUnO2aS
         0nyunKLwQCJ2/ev0tJrIj7+m+nyKCgHIQJbH4sj7QVoGYpB3nvby3p3ri1WKV5R5VsGa
         Ov0Q==
X-Gm-Message-State: AA+aEWZYqDYZyyVSBX89Q8QQ5rns87uith95uO6vXjq5sb2chf+lhbef
        cLFDFExrzK5XvSfnDZzW4hnGzg==
X-Google-Smtp-Source: AFSGD/UWJ9aHMegAO9E0nuerLwO4AbT9Dim3waqrpKP78AC7LV8BszwSyAQhvEGs3/H9NKjwEvy55w==
X-Received: by 2002:a62:d148:: with SMTP id t8mr45871258pfl.52.1546441657161;
        Wed, 02 Jan 2019 07:07:37 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id k24sm78458985pfj.13.2019.01.02.07.07.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jan 2019 07:07:36 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 2/2] alpha: generate uapi header and syscall table header files
Date:   Wed,  2 Jan 2019 20:36:59 +0530
Message-Id: <1546441619-19977-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546441619-19977-1-git-send-email-firoz.khan@linaro.org>
References: <1546441619-19977-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unified system call table generation script must be run to
generate unistd_32.h and syscall_table.h files. This patch
will have changes which will invokes the script.

This patch will generate unistd_32.h and syscall_table.h
files by the syscall table generation script invoked by
alpha/Makefile and the generated files against the removed
files must be identical.

The generated uapi header file will be included in uapi/-
asm/unistd.h and generated system call table header file
will be included by kernel/systbls.S file.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/alpha/kernel/syscalls/Makefile      | 11 ++++++++--
 arch/alpha/kernel/syscalls/syscallhdr.sh | 36 --------------------------------
 arch/alpha/kernel/syscalls/syscalltbl.sh | 32 ----------------------------
 3 files changed, 9 insertions(+), 70 deletions(-)
 delete mode 100644 arch/alpha/kernel/syscalls/syscallhdr.sh
 delete mode 100644 arch/alpha/kernel/syscalls/syscalltbl.sh

diff --git a/arch/alpha/kernel/syscalls/Makefile b/arch/alpha/kernel/syscalls/Makefile
index 659faef..75c7421 100644
--- a/arch/alpha/kernel/syscalls/Makefile
+++ b/arch/alpha/kernel/syscalls/Makefile
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
diff --git a/arch/alpha/kernel/syscalls/syscallhdr.sh b/arch/alpha/kernel/syscalls/syscallhdr.sh
deleted file mode 100644
index e5b99bd..0000000
--- a/arch/alpha/kernel/syscalls/syscallhdr.sh
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
-fileguard=_UAPI_ASM_ALPHA_`basename "$out" | sed \
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
diff --git a/arch/alpha/kernel/syscalls/syscalltbl.sh b/arch/alpha/kernel/syscalls/syscalltbl.sh
deleted file mode 100644
index 904b8e6..0000000
--- a/arch/alpha/kernel/syscalls/syscalltbl.sh
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

