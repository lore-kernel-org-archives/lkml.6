Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBFFC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30BD2147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gT4vW4tQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbfAGOxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:53:41 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44467 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbfAGOxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 09:53:40 -0500
Received: by mail-pl1-f193.google.com with SMTP id e11so246020plt.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 06:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qribx+gqAo/t4LskQU55eR6fPQXJgUz1Qy4Xg5x2OCo=;
        b=gT4vW4tQu9TNvj7pFGXrIWNRbZbY6iA7ypL9RYQ0jmwd+T7DP3diVC8S6lC6iIwRmO
         iDyPgS4X1CA7+vOS6t1GQz+P2zG2glast45xM+0vG3o8Rbx/3OzT0CoePpoNjPDS0oVq
         Pl2RqgEBCdjNXaRH8J0HMpOJkmYn5qz+HEANQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qribx+gqAo/t4LskQU55eR6fPQXJgUz1Qy4Xg5x2OCo=;
        b=DVPmeHKmHKseiHezmIXAwDUavFErDCnPLWecax8wkenoF29BW7YEhJPk/x1sTOZ5Q4
         L2iMrGzAjDbfsuqI4kaPguSzo2w3cUosfy7UaWv3rD+N6/7rZKxdKCRB2X5+E35kJ35c
         XS6GSnaivujg+puYlHExegujNIBLdFF/ANy5lEQhiCTnie9COhRQ+910Y2EzWq2d7DkM
         jBf5aPL7cpZuI3ZwpSJfKBAOigDjC2+gC3V+fE7TktdeQiMAfX6dMOh1rXuk42XnO9WF
         X4M+SWvK3MyZ/JaXSrbf7cF4UOUNPL+Jp0Rqam23TdqvtDmWNYJDPMHa+0EwB13mrhGF
         +wQg==
X-Gm-Message-State: AJcUukcRB1Th4hoNbzBPcmgO7Ec9l2D9ZvT9bO7FRXZeYyxV5Reg09YA
        fpvHCxmxb3XBQ7uIiYbvDW2qUg==
X-Google-Smtp-Source: ALg8bN6+xFPQUYGEdwsGNd3uAxSLx72nvFjOUb0KhRCgtkUyboe4xD5TyWslHQPgd+rsz35qCzm4Wg==
X-Received: by 2002:a17:902:9047:: with SMTP id w7mr62018164plz.270.1546872819948;
        Mon, 07 Jan 2019 06:53:39 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id o84sm121145584pfi.172.2019.01.07.06.53.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Jan 2019 06:53:39 -0800 (PST)
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
Subject: [PATCH 3/3] c6x: generate uapi and kapi headers
Date:   Mon,  7 Jan 2019 20:22:46 +0530
Message-Id: <1546872766-3354-4-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546872766-3354-1-git-send-email-firoz.khan@linaro.org>
References: <1546872766-3354-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unified system call table generation script need to be invoked
to generated the uapi and kapi headers. The Makefile changes
present in this patch will invoke the scripts and generate uapi
and kapi header files.

The generated files - unistd_*.h and syscall_table_*.h files
will be included by unistd.h and sys_c6x.c files by replacing
asm-generic/unistd.h file.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/c6x/Makefile                  |  3 +++
 arch/c6x/include/asm/Kbuild        |  1 +
 arch/c6x/include/uapi/asm/Kbuild   |  1 +
 arch/c6x/include/uapi/asm/unistd.h | 14 +++++++++-----
 arch/c6x/kernel/sys_c6x.c          |  3 ++-
 5 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/c6x/Makefile b/arch/c6x/Makefile
index b7aa854..acc9c91 100644
--- a/arch/c6x/Makefile
+++ b/arch/c6x/Makefile
@@ -53,6 +53,9 @@ dtbImage.%: vmlinux
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
 
+archheaders:
+	$(Q)$(MAKE) $(build)=arch/c6x/kernel/syscalls all
+
 define archhelp
   @echo '  vmlinux.bin     - Binary kernel image (arch/$(ARCH)/boot/vmlinux.bin)'
   @echo '  dtbImage.<dt>   - ELF image with $(arch)/boot/dts/<dt>.dts linked in'
diff --git a/arch/c6x/include/asm/Kbuild b/arch/c6x/include/asm/Kbuild
index 33a2c94..3d551e6 100644
--- a/arch/c6x/include/asm/Kbuild
+++ b/arch/c6x/include/asm/Kbuild
@@ -1,3 +1,4 @@
+generated-y += syscall_table.h
 generic-y += atomic.h
 generic-y += barrier.h
 generic-y += bugs.h
diff --git a/arch/c6x/include/uapi/asm/Kbuild b/arch/c6x/include/uapi/asm/Kbuild
index 6c6f630..28823e3 100644
--- a/arch/c6x/include/uapi/asm/Kbuild
+++ b/arch/c6x/include/uapi/asm/Kbuild
@@ -1,5 +1,6 @@
 include include/uapi/asm-generic/Kbuild.asm
 
+generated-y += unistd_32.h
 generic-y += kvm_para.h
 generic-y += shmparam.h
 generic-y += ucontext.h
diff --git a/arch/c6x/include/uapi/asm/unistd.h b/arch/c6x/include/uapi/asm/unistd.h
index 9e9ffe5..4633005 100644
--- a/arch/c6x/include/uapi/asm/unistd.h
+++ b/arch/c6x/include/uapi/asm/unistd.h
@@ -20,9 +20,13 @@
 #define __ARCH_WANT_SYS_CLONE
 #define __ARCH_NOMMU
 
-/* Use the standard ABI for syscalls. */
-#include <asm-generic/unistd.h>
+#include <asm/bitsperlong.h>
 
-/* C6X-specific syscalls. */
-#define __NR_cache_sync	(__NR_arch_specific_syscall + 0)
-__SYSCALL(__NR_cache_sync, sys_cache_sync)
+#ifndef __SYSCALL
+#define __SYSCALL(x, y)
+#endif
+
+#if __BITS_PER_LONG == 32
+#define __NR_cache_sync	__NR_arch_specific_syscall0
+#include <asm/unistd_32.h>
+#endif
diff --git a/arch/c6x/kernel/sys_c6x.c b/arch/c6x/kernel/sys_c6x.c
index a742ae25..3e4b4e4 100644
--- a/arch/c6x/kernel/sys_c6x.c
+++ b/arch/c6x/kernel/sys_c6x.c
@@ -70,5 +70,6 @@ asmlinkage int sys_cache_sync(unsigned long s, unsigned long e)
  */
 void *sys_call_table[__NR_syscalls] = {
 	[0 ... __NR_syscalls-1] = sys_ni_syscall,
-#include <asm/unistd.h>
+#define sys_arch_specific_syscall0	sys_cache_sync
+#include <asm/syscall_table.h>
 };
-- 
1.9.1

