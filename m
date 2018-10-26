Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791C5C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 05:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4C5207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 05:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T3ax6nsJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B4C5207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbeJZNpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 09:45:10 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40936 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbeJZNpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 09:45:10 -0400
Received: by mail-pl1-f195.google.com with SMTP id b9-v6so4598544pls.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 22:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S/KbYVLYlBJWhmcNmudeyLEr88M5mv3E/URnA16ciHE=;
        b=T3ax6nsJHqivyvL7QDfUUkqGEf2+73Yaa1cPt35Tsgi2m5HKFlBdptZeC4wQbtVyyH
         dxHYZesv58hmkSlQfci2myxfBWJaoPIwaixc2yLj+jcjwyTs/5kkCiTliGXbepwXcyIr
         kgeJZmVCuNLXq/05JujC3MZRjGWXxqh4C/KPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S/KbYVLYlBJWhmcNmudeyLEr88M5mv3E/URnA16ciHE=;
        b=KcQyonP8W9Tt6gz01xrwfZeMZWFzxrKnkLIDDg9TZmK360tRuLRM+XXYMk/DU4bBMb
         bsE+7c8UfxATPN2R+mGFyJ6bCcAD+88NK4YFdqGOTxWoeERbfOsn5kxl98MKSw5jp+kb
         BTqvU6ZtWE0JsZp2K/kHgCevqG2nGiWxYONkfzJXjcNkvsE3x3yYWynsGuI1OSrQnjHf
         DC4sOjwEo+W2OSz7rOOCSYUEfvKXHfEpoHPlOzwPleSmzIP17ohpAFSoWbDaSEk2K569
         AAf7nBmpl4ec/O05OIhOFq+ySLtf4iMndOW09xn37Ft5ZeiPdSXZpU2POokaVT9x1GNF
         ILqg==
X-Gm-Message-State: AGRZ1gKSLeAE+RhfiamxpwHrvdKLDnhPPVHqzm5UDVU7JsWxq/Z1B59z
        nkoAxNXxHu1vIrnjuFnnVR3rFg==
X-Google-Smtp-Source: AJdET5fzSHD2HHqAEHiMi2l4MtjIngrb2Ovn6bm2NNj96VkiZdQtA43yx/rIHMJYYSnCUfpLdbx+iw==
X-Received: by 2002:a17:902:bf41:: with SMTP id u1-v6mr2162135pls.10.1540530581408;
        Thu, 25 Oct 2018 22:09:41 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([49.207.61.165])
        by smtp.gmail.com with ESMTPSA id i135-v6sm3579822pfe.115.2018.10.25.22.09.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Oct 2018 22:09:40 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Michal Simek <monstr@monstr.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v3 1/3] microblaze: move __NR_syscalls macro from asm/unistd.h
Date:   Fri, 26 Oct 2018 10:39:10 +0530
Message-Id: <1540530552-3652-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540530552-3652-1-git-send-email-firoz.khan@linaro.org>
References: <1540530552-3652-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__NR_syscalls macro holds the number of system call exist
in microblaze architecture. We have to change the value of
__NR_syscalls, if we add or delete a system call.

One of the patch in this patch series has a script which
will generate a uapi header based on syscall.tbl file.
The syscall.tbl file contains the total number of system
calls information. So we have two option to update __NR-
_syscalls value.

1. Update __NR_syscalls in asm/unistd.h manually by count-
   ing the no.of system calls. No need to update NR_sys-
   calls until we either add a new system call or delete
   existing system call.

2. We can keep this feature it above mentioned script,
   that will count the number of syscalls and keep it in
   a generated file. In this case we don't need to expli-
   citly update __NR_syscalls in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I
moved the __NR_syscalls macro from asm/unistd.h to uapi-
/asm/unistd.h. While __NR_syscalls isn't strictly part of
the uapi, having it as part of the generated header to
simplifies the implementation. We also need to enclose
this macro with #ifdef __KERNEL__ to avoid side effects.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/microblaze/include/asm/unistd.h      | 2 --
 arch/microblaze/include/uapi/asm/unistd.h | 4 ++++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/microblaze/include/asm/unistd.h b/arch/microblaze/include/asm/unistd.h
index a62d094..e19550f 100644
--- a/arch/microblaze/include/asm/unistd.h
+++ b/arch/microblaze/include/asm/unistd.h
@@ -38,6 +38,4 @@
 
 #endif /* __ASSEMBLY__ */
 
-#define __NR_syscalls         401
-
 #endif /* _ASM_MICROBLAZE_UNISTD_H */
diff --git a/arch/microblaze/include/uapi/asm/unistd.h b/arch/microblaze/include/uapi/asm/unistd.h
index 7a9f16a..ed9c6f5 100644
--- a/arch/microblaze/include/uapi/asm/unistd.h
+++ b/arch/microblaze/include/uapi/asm/unistd.h
@@ -418,4 +418,8 @@
 #define __NR_io_pgetevents	399
 #define __NR_rseq		400
 
+#ifdef __KERNEL__
+#define __NR_syscalls         401
+#endif
+
 #endif /* _UAPI_ASM_MICROBLAZE_UNISTD_H */
-- 
1.9.1

