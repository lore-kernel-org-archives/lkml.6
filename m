Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44159C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08600206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NGviik8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08600206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731766AbeKMT3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 14:29:53 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37670 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731705AbeKMT3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 14:29:53 -0500
Received: by mail-pl1-f195.google.com with SMTP id p6-v6so5725841pll.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 01:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j2JyFnxfc9aHSuky4bLHJBe9XPEREtznYojqN3ObI+Q=;
        b=NGviik8+bzXbcCNkcgdfPYJXYylosVi5F8CJHbUjNMqF899uZwUrT0MMBHAc23tkSE
         EPmDAw6zhzf9owgX76G20SpTr1RCdb3qVUAU/cnGMLYKUJht6ULX6krudWvd93Jbyazc
         bXbNVazOmjF2IaMRoZVd2WaSQ8deJuWM4lXPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j2JyFnxfc9aHSuky4bLHJBe9XPEREtznYojqN3ObI+Q=;
        b=ih9DInYGUy+RB/pdPnJUMe8Mys3vudwlq38uXK2E9maglnzr+9LUbCsG83il7xbIwP
         kHJDYOfrn6dl4AW437qS4wXlg708JmTPQfqVg0Vpp1hM4zDtZpl9CvKuvenq0TfFUbAg
         kupaK7IWlYBgTEt2PYy5/fS1En+8oGMdDy9BKBxEZPi3qesh9J9X4YlPDnvfm3R30+i4
         J8vlshoyId/KmJex4oBnH4kmIpL/zbdxCBdsO7TBpXwd/fveyS+ARBIQ8wqShABfpDV8
         CWlTdPNVXUXSJKTb6IJ9GdlIsgiTgwmiWaOO69tiJK8QVYUKdo3f7MILJ1qQA5JRYO4O
         zPsw==
X-Gm-Message-State: AGRZ1gJv0ERwUYk+uxuCxT9D89FIvVg4aHvLuPqteD3MhZsCCAIQyvIP
        rlQ34iKLHKnU1sbJ4WBE3noJJQ==
X-Google-Smtp-Source: AJdET5cdCpJK2G6zWEG5Od2rvW/7j3UiC9xr7ybZDfx7JQJJxc1DZ5QWx/18iY5t9BJrFKIf+l68Xw==
X-Received: by 2002:a17:902:2c03:: with SMTP id m3mr727866plb.6.1542101559259;
        Tue, 13 Nov 2018 01:32:39 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id u6sm19902462pgr.79.2018.11.13.01.32.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Nov 2018 01:32:38 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-alpha@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v3 3/5] alpha: add __NR_syscalls along with NR_SYSCALLS
Date:   Tue, 13 Nov 2018 15:01:51 +0530
Message-Id: <1542101513-22010-4-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542101513-22010-1-git-send-email-firoz.khan@linaro.org>
References: <1542101513-22010-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NR_SYSCALLS macro holds the number of system call exist
in alpha architecture. We have to change the value of NR-
_SYSCALLS, if we add or delete a system call.

One of the patch in this patch series has a script which
will generate a uapi header based on syscall.tbl file.
The syscall.tbl file contains the total number of system
calls information. So we have two option to update NR_SY-
CALLS value.

1. Update NR_SYSCALLS in asm/unistd.h manually by count-
   ing the no.of system calls. No need to update NR_SYS-
   CALLS until we either add a new system call or delete
   existing system call.

2. We can keep this feature it above mentioned script,
   that will count the number of syscalls and keep it in
   a generated file. In this case we don't need to expli-
   citly update NR_SYSCALLS in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I
added the __NR_syscalls macro in uapi/asm/unistd.h along
with NR_SYSCALLS asm/unistd.h. The macro __NR_syscalls
also added for making the name convention same across all
architecture. While __NR_syscalls isn't strictly part of
the uapi, having it as part of the generated header to
simplifies the implementation. We also need to enclose
this macro with #ifdef __KERNEL__ to avoid side effects.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/alpha/include/asm/unistd.h      | 2 +-
 arch/alpha/include/uapi/asm/unistd.h | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/include/asm/unistd.h b/arch/alpha/include/asm/unistd.h
index 4f0ceb3..21b706a 100644
--- a/arch/alpha/include/asm/unistd.h
+++ b/arch/alpha/include/asm/unistd.h
@@ -4,7 +4,7 @@
 
 #include <uapi/asm/unistd.h>
 
-#define NR_SYSCALLS			523
+#define NR_SYSCALLS	__NR_syscalls
 
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_OLD_READDIR
diff --git a/arch/alpha/include/uapi/asm/unistd.h b/arch/alpha/include/uapi/asm/unistd.h
index 47c65f1..ab40aa6 100644
--- a/arch/alpha/include/uapi/asm/unistd.h
+++ b/arch/alpha/include/uapi/asm/unistd.h
@@ -465,4 +465,8 @@
 #define __NR_pwritev2			521
 #define __NR_statx			522
 
+#ifdef __KERNEL__
+#define __NR_syscalls			523
+#endif
+
 #endif /* _UAPI_ALPHA_UNISTD_H */
-- 
1.9.1

