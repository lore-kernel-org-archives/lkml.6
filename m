Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1DFC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F96D214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KpGrnpXY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F96D214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbeIYGXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 02:23:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34718 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeIYGXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 02:23:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id d19-v6so10129043pgv.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 17:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cNG+Umuz8gpkckvoqmDpsZNoaXz/lpbhmjoKCpcjv4Y=;
        b=KpGrnpXY7MINlKWpGt5BXbDHO2GvERi8UG+BL1sFeX6+LAlBRvetoUINt4i3bxgoqL
         SWgN4N8DBij2no/GeUWSrAbmER+zL57BTpEbLEn0l47Lr6tKTDvGudZT57zgRPm3Wh1K
         tBO+kGXja7DhQ7zYraTVyRyoGc+XsxZSTXb08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cNG+Umuz8gpkckvoqmDpsZNoaXz/lpbhmjoKCpcjv4Y=;
        b=hdN43EAI/EP0qrdULLrSdIvjI32pFv5Ckl0GpVA7nONB44bEhWodgUAvKSJSsi0Pmg
         3+KZdX5UDlxaX1L9hGT1zRRQMgLtZxkrLwZR8YUwg+nboHxkarOk9ZathCan1K/3EyaI
         xbiZDixUCGfCkwRepxZLrso8gt604ouTi4vJgau4lhUxiqCXtJp0WgKHg6DrHPgVgTHp
         P7E6JhTPFFgjAfE1pG2qI9/XquAsJjLNfx1avRmZYrcxTOrJK4ztckw4uinV+OlsNVge
         +GRR/Y7o11xahPpIQ3CIlLac1XqC84Eq4J6Z6hH3PBp2cY3w/u4riNYA2TYNvwVF0Y3q
         tfEg==
X-Gm-Message-State: ABuFfohgSFvUFr5QEI04Q7SMJte1UiQd+VcKr665cTjFxC3LifV0Vui0
        enJQPd7/A9XRZt2MmY6SxFflbA==
X-Google-Smtp-Source: ACcGV61Czj5lcS7tU939B82fcWd1tGZ0LZh2lnxQ0accq1zipJYOa70Q10U4Iahal0QI9rrhzCS1Ng==
X-Received: by 2002:a65:4b88:: with SMTP id t8-v6mr909082pgq.239.1537834719316;
        Mon, 24 Sep 2018 17:18:39 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id r12-v6sm540112pfh.79.2018.09.24.17.18.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 17:18:37 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH security-next v3 03/29] LSM: Rename .security_initcall section to .lsm_info
Date:   Mon, 24 Sep 2018 17:18:06 -0700
Message-Id: <20180925001832.18322-4-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925001832.18322-1-keescook@chromium.org>
References: <20180925001832.18322-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for switching from initcall to just a regular set of
pointers in a section, rename the internal section name.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-arch@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/vmlinux.lds.h | 10 +++++-----
 include/linux/init.h              |  4 ++--
 security/security.c               |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 934a45395547..5079a969e612 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -787,14 +787,14 @@
 		__con_initcall_end = .;
 
 #define SECURITY_INITCALL						\
-		__security_initcall_start = .;				\
-		KEEP(*(.security_initcall.init))			\
-		__security_initcall_end = .;
+		__start_lsm_info = .;					\
+		KEEP(*(.lsm_info.init))					\
+		__end_lsm_info = .;
 
 /* Older linker script style for security init. */
 #define SECURITY_INIT							\
-	.security_initcall.init : AT(ADDR(.security_initcall.init) - LOAD_OFFSET) { \
-		SECURITY_INITCALL					\
+	.lsm_info.init : AT(ADDR(.lsm_info.init) - LOAD_OFFSET) {	\
+		LSM_INFO						\
 	}
 
 #ifdef CONFIG_BLK_DEV_INITRD
diff --git a/include/linux/init.h b/include/linux/init.h
index 2538d176dd1f..77636539e77c 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -133,7 +133,7 @@ static inline initcall_t initcall_from_entry(initcall_entry_t *entry)
 #endif
 
 extern initcall_entry_t __con_initcall_start[], __con_initcall_end[];
-extern initcall_entry_t __security_initcall_start[], __security_initcall_end[];
+extern initcall_entry_t __start_lsm_info[], __end_lsm_info[];
 
 /* Used for contructor calls. */
 typedef void (*ctor_fn_t)(void);
@@ -236,7 +236,7 @@ extern bool initcall_debug;
 	static exitcall_t __exitcall_##fn __exit_call = fn
 
 #define console_initcall(fn)	___define_initcall(fn,, .con_initcall)
-#define security_initcall(fn)	___define_initcall(fn,, .security_initcall)
+#define security_initcall(fn)	___define_initcall(fn,, .lsm_info)
 
 struct obs_kernel_param {
 	const char *str;
diff --git a/security/security.c b/security/security.c
index 4cbcf244a965..892fe6b691cf 100644
--- a/security/security.c
+++ b/security/security.c
@@ -51,9 +51,9 @@ static void __init do_security_initcalls(void)
 	initcall_t call;
 	initcall_entry_t *ce;
 
-	ce = __security_initcall_start;
+	ce = __start_lsm_info;
 	trace_initcall_level("security");
-	while (ce < __security_initcall_end) {
+	while (ce < __end_lsm_info) {
 		call = initcall_from_entry(ce);
 		trace_initcall_start(call);
 		ret = call();
-- 
2.17.1

