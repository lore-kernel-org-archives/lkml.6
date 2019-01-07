Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A4FC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753AB2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YYvVVXFJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbfAGOxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:53:23 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33772 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfAGOxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 09:53:22 -0500
Received: by mail-pg1-f195.google.com with SMTP id z11so255712pgu.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 06:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L8dzRK8u+9X5NB1F78wxGzgOGa50Hz3EXcEfF722qFs=;
        b=YYvVVXFJPr4luDn2L28Jh7AueGzbW9/98BeM/joCJHg+SeC5kq+Usaro50Z0Ietze1
         07g6V/oEEV6xJaMm6sg00x0FDB5XZm0SC3xEOAt1AOjkJ/m6d3NG3cgoxmTErXi2C8gQ
         QunI4SPt+XPtKtYBNzS/NopxpfD+li6p6+PaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L8dzRK8u+9X5NB1F78wxGzgOGa50Hz3EXcEfF722qFs=;
        b=AxefYvVEo/vvn+ABsY/dV/XxmBfZrcnEnZSmFPOws4kus270BQdHPQJwjKxlXXyy74
         Ok6s2/mzMd9qH1crh7wPMTTmnyl+dYrFlZxQVdrFNkBrAyCu39zu6gGro8ueQruBplmZ
         3fGiwZhOtkNbzW1lcZI6piq901cXAQ2T4Oc17KTUQoqsQ6yk33AjwVcOUKiYHMwuTyNf
         Cl02wdBwNOQWhBF9PxIadoW/uKA5P18V3v6BjyLbYacskYtjHzGTiciK7XD5Y4IPbRxc
         TO6VZF10zNMRjuq9emo0BK1tsxiVJtvYTlfQO3zA2rmdO2WU0fv062ZblV4wHlWjW7dt
         EFbQ==
X-Gm-Message-State: AJcUukfedTcuefoik9tffC37wVq2d9hraIuIGcArOWEib37ExAXLG5Ue
        DWj5ERMiJ+gSO7AmBEh5W8U56w==
X-Google-Smtp-Source: ALg8bN6MhFCMF6ytnOv0VgvCrgJaYdylIx4rPvucsInZ5YnGh0AYnTcruBOelDTYZmjzOYm4w4d+GQ==
X-Received: by 2002:a62:30c3:: with SMTP id w186mr63582883pfw.39.1546872802313;
        Mon, 07 Jan 2019 06:53:22 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id o84sm121145584pfi.172.2019.01.07.06.53.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Jan 2019 06:53:21 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-c6x-dev@linux-c6x.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 1/3] c6x: add Makefile to invoke syscall table generation script
Date:   Mon,  7 Jan 2019 20:22:44 +0530
Message-Id: <1546872766-3354-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546872766-3354-1-git-send-email-firoz.khan@linaro.org>
References: <1546872766-3354-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Makefile to invoke the system call table generation script
which is placed in scripts directory as a common location acc-
essible for all the architectures.

scripts/syscallhdr.sh will generate uapi header and scripts-
/syscalltbl.sh will generate kapi header respectively. There
is another scripts scripts/syscallnr.sh can generate total
number of syscall which doesn't invoke from this Makefile.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/c6x/kernel/syscalls/Makefile | 41 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 arch/c6x/kernel/syscalls/Makefile

diff --git a/arch/c6x/kernel/syscalls/Makefile b/arch/c6x/kernel/syscalls/Makefile
new file mode 100644
index 0000000..1865a80
--- /dev/null
+++ b/arch/c6x/kernel/syscalls/Makefile
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0
+kapi := arch/$(SRCARCH)/include/generated/asm
+uapi := arch/$(SRCARCH)/include/generated/uapi/asm
+
+_dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')	\
+	  $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
+
+syscall := $(srctree)/scripts/syscalls/syscall.tbl
+syshdr := $(srctree)/scripts/syscallhdr.sh
+systbl := $(srctree)/scripts/syscalltbl.sh
+
+quiet_cmd_syshdr = SYSHDR  $@
+      cmd_syshdr = $(CONFIG_SHELL) '$(syshdr)' '$<' '$@'	\
+		   '$(syshdr_abis_$(basetarget))'		\
+		   '$(syshdr_pfx_$(basetarget))'		\
+		   '$(syshdr_offset_$(basetarget))'
+
+quiet_cmd_systbl = SYSTBL  $@
+      cmd_systbl = $(CONFIG_SHELL) '$(systbl)' '$<' '$@'	\
+		   '$(systbl_abis_$(basetarget))'		\
+		   '$(systbl_abi_$(basetarget))'		\
+		   '$(systbl_offset_$(basetarget))'
+
+syshdr_abis_unistd_32 := common,32,rename,stat64,archs0
+$(uapi)/unistd_32.h: $(syscall) $(syshdr)
+	$(call if_changed,syshdr)
+
+systbl_abis_syscall_table := common,32,rename,stat64,archs0
+systbl_abi_syscall_table := 32
+$(kapi)/syscall_table.h: $(syscall) $(systbl)
+	$(call if_changed,systbl)
+
+uapisyshdr-y		+= unistd_32.h
+kapisyshdr-y		+= syscall_table.h
+
+targets	+= $(uapisyshdr-y) $(kapisyshdr-y)
+
+PHONY += all
+all: $(addprefix $(uapi)/,$(uapisyshdr-y))
+all: $(addprefix $(kapi)/,$(kapisyshdr-y))
+	@:
-- 
1.9.1

