Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB36FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A97812133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LZJ0PUMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732379AbeLQKlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:41:23 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34195 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbeLQKlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 05:41:22 -0500
Received: by mail-pl1-f193.google.com with SMTP id w4so5954927plz.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 02:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XJq1AFUaGxDCB6jFqaj05hzzcUKv19kg30xJpzrgoLo=;
        b=LZJ0PUMZgwY1ciUTFaX7gsA3e2I0WwOiC7BvY6QLw5snWHh56g46LL3yRXFINvI8ic
         o+V7UjqxEU+Q78V+Io6IWK1o7ebT2/WStAUysb3NH/l7Txc+xz3WOYWVApn4aYRbVodS
         9NnEHZWEOtmmWVDmfP3ZpoTOq5mhh188hJ8F4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XJq1AFUaGxDCB6jFqaj05hzzcUKv19kg30xJpzrgoLo=;
        b=KBKNM4h38JyXpIr7KVi/FSZyK2ASCMO1V2/3Z5rac94qPbLzoNM4n5GStEZ26pKpCa
         GrYvKoF8sbIhJFkJoAq+iVS/i8y3vb+ezDWSVJqN9tdYVHlwEFqciM3y6LqvzMOlhj1H
         nzIM8ZOoIYJcZO6IsMZR5+lZDQUeWTRZv5ZfpnxMbP+D1sGcIESS5bryFxg2TmW64VR7
         7f3o0gfgRAOCO3lN2yXq7qhPM1yOZ7appFHWZBYy4CZhS3bsHksP8ywlZBEU7A40FLQ5
         N+GHPiHehcbJNtuZkCgppJf/18mMMF14B82rReEL1E0y9v4zGiU9xhg41AKd6pTmHxlc
         6scg==
X-Gm-Message-State: AA+aEWZYjDeREUjFmkvDlNMnfFYgDydm7M8ZjRWGNCmmLxQeP32ny8Os
        OKYpxr6xBlqlS79s+MDQXlT5KA==
X-Google-Smtp-Source: AFSGD/XTcxTt+L6eowfaDC4tb62nkOiq/talI4ku41aRYafntKlYhwggd6pmx6cg3vDM7ztEXbtocw==
X-Received: by 2002:a17:902:848d:: with SMTP id c13mr12309944plo.257.1545043282112;
        Mon, 17 Dec 2018 02:41:22 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id b27sm17224826pfh.113.2018.12.17.02.41.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Dec 2018 02:41:21 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linuxppc-dev@lists.ozlabs.org, sathnaga@linux.vnet.ibm.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Breno Leitao <leitao@debian.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v6 1/5] powerpc: add __NR_syscalls along with NR_syscalls
Date:   Mon, 17 Dec 2018 16:10:32 +0530
Message-Id: <1545043236-11649-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545043236-11649-1-git-send-email-firoz.khan@linaro.org>
References: <1545043236-11649-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NR_syscalls macro holds the number of system call exist
in powerpc architecture. We have to change the value of
NR_syscalls, if we add or delete a system call.

One of the patch in this patch series has a script which
will generate a uapi header based on syscall.tbl file.
The syscall.tbl file contains the number of system call
information. So we have two option to update NR_syscalls
value.

1. Update NR_syscalls in asm/unistd.h manually by count-
   ing the no.of system calls. No need to update NR_sys-
   calls until we either add a new system call or delete
   existing system call.

2. We can keep this feature in above mentioned script,
   that will count the number of syscalls and keep it in
   a generated file. In this case we don't need to expli-
   citly update NR_syscalls in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I
added the __NR_syscalls macro in uapi/asm/unistd.h along
with NR_syscalls asm/unistd.h. The macro __NR_syscalls
also added for making the name convention same across all
architecture. While __NR_syscalls isn't strictly part of
the uapi, having it as part of the generated header to
simplifies the implementation. We also need to enclose
this macro with #ifdef __KERNEL__ to avoid side effects.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/powerpc/include/asm/unistd.h      | 3 +--
 arch/powerpc/include/uapi/asm/unistd.h | 5 ++++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index b0de85b..a3c35e6 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -11,8 +11,7 @@
 
 #include <uapi/asm/unistd.h>
 
-
-#define NR_syscalls		389
+#define NR_syscalls	__NR_syscalls
 
 #define __NR__exit __NR_exit
 
diff --git a/arch/powerpc/include/uapi/asm/unistd.h b/arch/powerpc/include/uapi/asm/unistd.h
index 985534d..7195868 100644
--- a/arch/powerpc/include/uapi/asm/unistd.h
+++ b/arch/powerpc/include/uapi/asm/unistd.h
@@ -10,7 +10,6 @@
 #ifndef _UAPI_ASM_POWERPC_UNISTD_H_
 #define _UAPI_ASM_POWERPC_UNISTD_H_
 
-
 #define __NR_restart_syscall	  0
 #define __NR_exit		  1
 #define __NR_fork		  2
@@ -401,4 +400,8 @@
 #define __NR_rseq		387
 #define __NR_io_pgetevents	388
 
+#ifdef __KERNEL__
+#define __NR_syscalls		389
+#endif
+
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
-- 
1.9.1

