Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7751C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 04:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A877E20835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 04:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hPpOjYSV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A877E20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeJKLvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 07:51:00 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35613 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbeJKLu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 07:50:59 -0400
Received: by mail-pg1-f194.google.com with SMTP id v133-v6so3534501pgb.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 21:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uCe8GDuDIsW/oywTVVyhSQ6yR7tNM4OEAIIVzFvTQ8s=;
        b=hPpOjYSVjWj5QqFPNKKVes0E3Z0l2Mw36Vo/xwjOR18ks3qZ+boyD+BFXZ7/Iglm+G
         V3+zwimixLlMG1sg0T5HhqYwoSNM5pdfP6gKr1eklWTT9mTtXU768U4mOiO9HReIdFf+
         moRktkDYccBIbOaRUqgGFdmbt8nxySgXt3FrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uCe8GDuDIsW/oywTVVyhSQ6yR7tNM4OEAIIVzFvTQ8s=;
        b=mXh8zPuPVMLWiUMuQe5p7XY+7+fIA16TPYu17hQa2aZ7LJnouBTBpVBqHA486V3zi1
         CkzxwtPZOzAumaUPYBfIbkMPxPfMMlRGJFyhdcFqfksLr9Icbefn5InekOml5KHsIPYR
         14tist8ZsIbZC2mYFTji0GtvYMMQuSLjZXrAZZBiy07kxk6SkfRHg4E38ZHRilcK7IJ/
         64NWGOSksraGR0ZRQYqfeoR3Q142InftHqbBI+k98p38mNBRXDAUIxmp2EGfUkDc7lzZ
         opp3B7E3j7lmwABtPtZ+blDBV86ifrKZS3se6Go7Ar2s2LOaxT3E1/gWc7uio4dvgxk5
         +s4Q==
X-Gm-Message-State: ABuFfohIPSTNBvN160FeKe9XfcRB4dSd9YvJ3XkTe1gzfYreyAdmfTt5
        Upk0MWQJncFJbxfVbToXeZjqNg==
X-Google-Smtp-Source: ACcGV603ALGTW4jnRWJTqSRX27rE1OBXMj8RG2xJB3Za/fx6vYclhUU3X4gt40KT7yc3xYa5PBapAw==
X-Received: by 2002:a62:4ec9:: with SMTP id c192-v6mr37319155pfb.221.1539231935764;
        Wed, 10 Oct 2018 21:25:35 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id n63-v6sm26113748pfn.9.2018.10.10.21.25.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Oct 2018 21:25:35 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v3 2/7] ia64: replace NR_syscalls macro from asm/unistd.h
Date:   Thu, 11 Oct 2018 09:54:50 +0530
Message-Id: <1539231895-4118-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539231895-4118-1-git-send-email-firoz.khan@linaro.org>
References: <1539231895-4118-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NR_syscalls macro holds the number of system call exist in IA64
architecture. This macro is currently the part of asm/unistd.h
file. We have to change the value of NR_syscalls, if we add or
delete a system call.

One of the patch in this patch series has a script which will
generate a uapi header based on syscall.tbl file. The syscall.tbl
file contains the number of system call information. So we have
two option to update NR_syscalls value.

1. Update NR_syscalls in asm/unistd.h manually by counting the
   no.of system calls. No need to update NR_syscalls until we
   either add a new system call or delete an existing system
   call.

2. We can keep this feature it above mentioned script, that'll
   count the number of syscalls and keep it in a generated file.
   In this case we don't need to explicitly update NR_syscalls
   in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I come up
with another macro - __NR_syscalls which will be updated by the
script and it will be present in uapi/asm/unistd.h. The macro
name changed form NR_syscalls to __NR_syscalls for making the
name convention same across all architecture. While __NR_syscalls
isn't strictly part of the uapi, having it as part of the generated
header to simplifies the implementation. We also need to enclose
this macro with #ifdef __KERNEL__ to avoid side effects.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/ia64/include/asm/unistd.h      | 4 +---
 arch/ia64/include/uapi/asm/unistd.h | 4 ++++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/ia64/include/asm/unistd.h b/arch/ia64/include/asm/unistd.h
index ffb705d..397b143 100644
--- a/arch/ia64/include/asm/unistd.h
+++ b/arch/ia64/include/asm/unistd.h
@@ -10,9 +10,7 @@
 
 #include <uapi/asm/unistd.h>
 
-
-
-#define NR_syscalls			326 /* length of syscall table */
+#define NR_syscalls		__NR_syscalls /* length of syscall table */
 
 /*
  * The following defines stop scripts/checksyscalls.sh from complaining about
diff --git a/arch/ia64/include/uapi/asm/unistd.h b/arch/ia64/include/uapi/asm/unistd.h
index 4d590c9..4186dc2 100644
--- a/arch/ia64/include/uapi/asm/unistd.h
+++ b/arch/ia64/include/uapi/asm/unistd.h
@@ -341,4 +341,8 @@
 #define __NR_preadv2			1348
 #define __NR_pwritev2			1349
 
+#ifdef __KERNEL__
+#define __NR_syscalls			326
+#endif
+
 #endif /* _UAPI_ASM_IA64_UNISTD_H */
-- 
1.9.1

