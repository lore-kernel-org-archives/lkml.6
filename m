Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C43C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1612087F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IhSrxQMu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C1612087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbeLMJIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:08:22 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42610 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeLMJIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:08:22 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so756003plp.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 01:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YFkH6BiVFMb84PF3sgPw/qdfk9RQVU5JUMVa27R0rjA=;
        b=IhSrxQMuCOQLwK9hBOPySYeyDIBdlRzA71tgiq8HpRugLsZ1KbEeLsR9uBw+6szAPJ
         r2haCgnE0UaswOHrXGx84k/W5pWswFr57YryDLfmx9IQAs+1XN0mmGV/39HhrweqZsQe
         iDA4dT5b6g0nFVvriIGFdSiY5P7HWfPezlrs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YFkH6BiVFMb84PF3sgPw/qdfk9RQVU5JUMVa27R0rjA=;
        b=I9AZKImfB9D6ZPGwXo4i6uJRzkjBQyVkF9oGNun7FXN79jl72jeLAnr9mKAcyF41eO
         /VO5AY+QWpedJuAOiELbf0N5LQi/fQaYJmJRzts4GSTbhcumpC/dys3T8EGBIxz/cSY/
         If8sfzhsMhZTnNEIHGIK+I4PHbPmcN4R6clqcbhE2fAlShEmj+QsC7Dazx3SMvYsjRg/
         vUBo/WQpk3MW4WmoK3UDbV5xxq0IK5L6CQiSfdd7R+V3dis/YfzGNI4RvDTuGGaYo/pC
         KQG7b6DWQ6zjTmpGoq+fMo89NyWbAzYlGsgzY/d4iVKRSe1XaLb5zcXC5wx7oIatEuT5
         nN1w==
X-Gm-Message-State: AA+aEWaXPeSQSXJ29RG6hBgjNOOv9p7R0i2Mta0OwsnOTor8jRZ1SQ3X
        GLYVdemU5dwbMWNsHnYRfRUaxg==
X-Google-Smtp-Source: AFSGD/Ul8NvKUUsNBub/mHPHzQzSMP/KfkK/7kkP2pxtNTJbApTALdzMP9BoAIjbht5I0EW25Y/DPg==
X-Received: by 2002:a17:902:3281:: with SMTP id z1mr23322684plb.296.1544692101486;
        Thu, 13 Dec 2018 01:08:21 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id m11sm1650533pgh.51.2018.12.13.01.08.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Dec 2018 01:08:20 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v5 1/7] mips: add __NR_syscalls along with __NR_Linux_syscalls
Date:   Thu, 13 Dec 2018 14:37:33 +0530
Message-Id: <1544692059-9728-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544692059-9728-1-git-send-email-firoz.khan@linaro.org>
References: <1544692059-9728-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__NR_Linux_syscalls macro holds the number of system call
exist in mips architecture. We have to change the value of
__NR_Linux_syscalls, if we add or delete a system call.

One of the patch in this patch series has a script which
will generate a uapi header based on syscall.tbl file.
The syscall.tbl file contains the total number of system
calls information. So we have two option to update __NR-
_Linux_syscalls value.

1. Update __NR_Linux_syscalls in asm/unistd.h manually
   by counting the no.of system calls. No need to update
   __NR_Linux_syscalls until we either add a new system
   call or delete existing system call.

2. We can keep this feature it above mentioned script,
   that will count the number of syscalls and keep it in
   a generated file. In this case we don't need to expli-
   citly update __NR_Linux_syscalls in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I
added the __NR_syscalls macro in uapi/asm/unistd.h along
with __NR_Linux_syscalls. The macro __NR_syscalls also
added for making the name convention same across all
architecture. While __NR_syscalls isn't strictly part of
the uapi, having it as part of the generated header to
simplifies the implementation. We also need to enclose
this macro with #ifdef __KERNEL__ to avoid side effects.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/mips/include/uapi/asm/unistd.h | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
index f25dd1d..6914be5 100644
--- a/arch/mips/include/uapi/asm/unistd.h
+++ b/arch/mips/include/uapi/asm/unistd.h
@@ -391,11 +391,14 @@
 #define __NR_rseq			(__NR_Linux + 367)
 #define __NR_io_pgetevents		(__NR_Linux + 368)
 
+#ifdef __KERNEL__
+#define __NR_syscalls			368
+#endif
 
 /*
  * Offset of the last Linux o32 flavoured syscall
  */
-#define __NR_Linux_syscalls		368
+#define __NR_Linux_syscalls		__NR_syscalls
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
@@ -738,10 +741,14 @@
 #define __NR_rseq			(__NR_Linux + 327)
 #define __NR_io_pgetevents		(__NR_Linux + 328)
 
+#ifdef __KERNEL__
+#define __NR_syscalls			328
+#endif
+
 /*
  * Offset of the last Linux 64-bit flavoured syscall
  */
-#define __NR_Linux_syscalls		328
+#define __NR_Linux_syscalls		__NR_syscalls
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
@@ -1088,10 +1095,14 @@
 #define __NR_rseq			(__NR_Linux + 331)
 #define __NR_io_pgetevents		(__NR_Linux + 332)
 
+#ifdef __KERNEL__
+#define __NR_syscalls			332
+#endif
+
 /*
  * Offset of the last N32 flavoured syscall
  */
-#define __NR_Linux_syscalls		332
+#define __NR_Linux_syscalls		__NR_syscalls
 
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
-- 
1.9.1

