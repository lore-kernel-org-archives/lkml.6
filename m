Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36761C00449
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 00:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF12321471
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 00:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QGYZ4aBu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF12321471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbeJBHfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:35:41 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50887 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbeJBHfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:35:40 -0400
Received: by mail-it1-f194.google.com with SMTP id j81-v6so1000371ite.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 17:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BNwJMOTTBg+xIR0Zs6W8eU/Z+0Zh4DQ+gRWYfOJdHJk=;
        b=QGYZ4aBukEzkUbplpIyJcVFIRfuHhUExWt9u+/VhfugsKltmM+jOi13nMdW8aM+fnV
         hW+6zqZKIKLx3MssgYOWd91KaIDaXHZzbkOJJYvDRvY92ByERskBXOFo9SjNrKykFNy3
         cQ/EH6zN9Uw4GxBJKEaG3MmZ5DthqSto91x+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BNwJMOTTBg+xIR0Zs6W8eU/Z+0Zh4DQ+gRWYfOJdHJk=;
        b=uPXHvXjsrVhhQLQ+gN7oh4flxuXnLtwsV8Ux44NvrLqLXS6RQl1t/dqTRYl2ZofR9M
         OecY8+vFp1Ah44fepJJYbwr4xTEtjLOqLq0Sp/LMLozbVinFbVBnid2j/bWreqHLk9r1
         WNjKjlrdrv6pnIOSxcazXppTNU2Ik3QMXEOzm+7lVPOpNcQipESq+xKVdq5oIRut/Vm6
         HAcwccFagZQ1dRY7n3UmXRdTHxRGBQQEpw7PjqqzznuttjPKFyRHcBuKJFh4lOT6nFfV
         jwkj43USwLzA3agvDYqjUf1NB2CLuLu4uLOmYAAC4WYOGf3GxLf7xHlyveLJ18kLNBZb
         sNgQ==
X-Gm-Message-State: ABuFfoj86sCNdhj/Jz73tSdtLRrFijEz/8KGqMnA53MuRwvv7dxRNMUc
        VbvNVa6HzBAArlh85QWJy8i+9A==
X-Google-Smtp-Source: ACcGV60hsZXAm0a9TDrq7HKVx3o3uvo37XZN4cfDrGLtkfSQvQW8f2t4HrDeF27oZljz/fBg55Rquw==
X-Received: by 2002:a63:10c:: with SMTP id 12-v6mr12224849pgb.62.1538441711433;
        Mon, 01 Oct 2018 17:55:11 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id c79-v6sm16930363pfc.92.2018.10.01.17.55.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 17:55:08 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH security-next v4 03/32] LSM: Rename .security_initcall section to .lsm_info
Date:   Mon,  1 Oct 2018 17:54:36 -0700
Message-Id: <20181002005505.6112-4-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181002005505.6112-1-keescook@chromium.org>
References: <20181002005505.6112-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for switching from initcall to just a regular set of
pointers in a section, rename the internal section name.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: James Morris <james.morris@microsoft.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
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

