Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D52C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277BF20820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K63pyOxM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277BF20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbeKAW4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:56:50 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40514 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728743AbeKAW4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:56:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id o14-v6so9068787pgv.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 06:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QL4HBtXy2kdUzZVg3cM04W+gwHD2rDZgr2KGTmJMb5w=;
        b=K63pyOxMrHb+GRMxlnKfjNGblG+PKrLj5vy7bj9zVvXM9VQk7uwiwWxQd/wW1q/cfY
         SxWLQ9vYiYkIXyMvv41gSQGGtq26Laybx38qne5w/xiqtYg1DfYgj9E/pdTqE4LI1/RK
         t7aiViG1AP8Wv9aeXvW9hGa0wk4nxFCyJHhbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QL4HBtXy2kdUzZVg3cM04W+gwHD2rDZgr2KGTmJMb5w=;
        b=pt5dPR7RjzdpK7uoic79/8mJzFqvMNA7mEEwXqimmI78Sd6WNERgZn8xUJK4933Nr1
         DcFyItFo3nm+W9BPIr4HbbU9d+qzxscUIcNVIR6CzJtEmFuG62g2j5FcaukV80FxAzWO
         RK0pt8qDr95qvUMaopB+pnWb2w0YTDagrzKZcTt4LbVXM0McA4SdE65xE3EXWLMyxmvC
         Gxxiyp/oIH6bcJ9TkMmpIfnnK09ExfPztl+IZit/mioyAjbXCMQOfMJRkpA72LBjA6UJ
         tIwplcC/VrY5zZx1YvH/tAVmkoyVJVGW41R+IZbD1BH38VH7dCyuZRh7HClpWVat1ZDd
         eKYQ==
X-Gm-Message-State: AGRZ1gIvBCBv2n5+LaV2L2QUnbwHq4NMet9Di3Ziykz3Jl4qhYiF1Cny
        iLna0uhIqR8O+YUimYg3RTsoAw==
X-Google-Smtp-Source: AJdET5cOBtuJzSisXDhMGeywuttr5+t+ireBl5kAx4XFMVc73eLAUqwV0/QJAyfseh7Wmhd9MsoRQg==
X-Received: by 2002:a62:50ca:: with SMTP id g71-v6mr7795039pfj.62.1541080425106;
        Thu, 01 Nov 2018 06:53:45 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([106.51.104.211])
        by smtp.gmail.com with ESMTPSA id 131-v6sm2224716pfa.120.2018.11.01.06.53.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Nov 2018 06:53:44 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v2 1/4] sparc: move __IGNORE* entries to non uapi header
Date:   Thu,  1 Nov 2018 19:23:08 +0530
Message-Id: <1541080391-3890-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541080391-3890-1-git-send-email-firoz.khan@linaro.org>
References: <1541080391-3890-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the __IGNORE* entries are resides in the uapi header
file move to non uapi header asm/unistd.h as it is not
used by any user space applications.

It is correct to keep __IGNORE* entry in non uapi header
asm/unistd.h while uapi/asm/unistd.h must hold information
only useful for user space applications.

One of the patch in this patch series will generate uapi
header file. The information which directly used by the
user space application must be present in uapi file.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/sparc/include/asm/unistd.h      | 16 ++++++++++++++++
 arch/sparc/include/uapi/asm/unistd.h | 16 ----------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/sparc/include/asm/unistd.h b/arch/sparc/include/asm/unistd.h
index b2a6a95..6dfd752 100644
--- a/arch/sparc/include/asm/unistd.h
+++ b/arch/sparc/include/asm/unistd.h
@@ -45,4 +45,20 @@
 #define __ARCH_WANT_COMPAT_SYS_SENDFILE
 #endif
 
+#ifdef __32bit_syscall_numbers__
+/* Sparc 32-bit only has the "setresuid32", "getresuid32" variants,
+ * it never had the plain ones and there is no value to adding those
+ * old versions into the syscall table.
+ */
+#define __IGNORE_setresuid
+#define __IGNORE_getresuid
+#define __IGNORE_setresgid
+#define __IGNORE_getresgid
+#endif
+
+/* Sparc doesn't have protection keys. */
+#define __IGNORE_pkey_mprotect
+#define __IGNORE_pkey_alloc
+#define __IGNORE_pkey_free
+
 #endif /* _SPARC_UNISTD_H */
diff --git a/arch/sparc/include/uapi/asm/unistd.h b/arch/sparc/include/uapi/asm/unistd.h
index 09acf0d..6e59037 100644
--- a/arch/sparc/include/uapi/asm/unistd.h
+++ b/arch/sparc/include/uapi/asm/unistd.h
@@ -433,20 +433,4 @@
 /* Bitmask values returned from kern_features system call.  */
 #define KERN_FEATURE_MIXED_MODE_STACK	0x00000001
 
-#ifdef __32bit_syscall_numbers__
-/* Sparc 32-bit only has the "setresuid32", "getresuid32" variants,
- * it never had the plain ones and there is no value to adding those
- * old versions into the syscall table.
- */
-#define __IGNORE_setresuid
-#define __IGNORE_getresuid
-#define __IGNORE_setresgid
-#define __IGNORE_getresgid
-#endif
-
-/* Sparc doesn't have protection keys. */
-#define __IGNORE_pkey_mprotect
-#define __IGNORE_pkey_alloc
-#define __IGNORE_pkey_free
-
 #endif /* _UAPI_SPARC_UNISTD_H */
-- 
1.9.1

