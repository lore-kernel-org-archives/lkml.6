Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA20ECE564
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869B62148E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n+fRHQPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 869B62148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbeIPFwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 01:52:07 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34483 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728155AbeIPFwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 01:52:06 -0400
Received: by mail-pl1-f194.google.com with SMTP id f6-v6so5797948plo.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 17:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zeggc8Kiynho06cDkTryazBV33kA+k93YFXTk1NTHxE=;
        b=n+fRHQPNFIEyQSUgerwlgNYFTaYj0z+FtziG+F6z4+r+JvjA7rKMwB5iB1uPZQ1uU8
         bJLiQeH0C43tHO1DFiMy3ZXskRlsrmToLTabFDjV+oNBm68dCjMPjzBi3banlD2YC4Jn
         5yuPw0nPyqLG+6QQzxRzSdOgDivImhEV0GUY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zeggc8Kiynho06cDkTryazBV33kA+k93YFXTk1NTHxE=;
        b=tkHObSNcD1lsTK82EqoRBtD6ZnSGvu8SCg69L0+acEQij3HNBPM+HlbmAM7zRYgTVW
         M69TNGOjSjXnHvHag4427QOB8baOATAVloyLijvEX8ikaSoj3B8YF6p5XhZjFRlqK3nx
         o7HDfUSvTT6laKoXJrmyqsMkNS/yHqQkd7f3fzAsxllfH5V1a7by7XU+t+zqvtGrijEZ
         7tlBxvfpd9WvpUT6WGu9DxeLxzEF6+ZzRweJ9dPLSmxWO66L5J58jrj68asRqGheTuwC
         KJMAc6uMntMyE8EeBWJbCJca8rT9Ryo0rUZ9pP+EhrPWyss1H1rtiUcKIgvlmcrI4/PH
         AwQw==
X-Gm-Message-State: APzg51DJiRA7T3ZSD4uacCgupFlrU14uiGD10SMAa/rfJHFE+ZK5iqiY
        MXoaUfPseYiZnFeD2TAMz2sKDw==
X-Google-Smtp-Source: ANB0VdZ3fB56o4JhLOV4rwkEjzCwZ4SwxVOvomYOIy0duBMizZzJE01RGhQz/YuMFyER7sbgx3qdxQ==
X-Received: by 2002:a17:902:925:: with SMTP id 34-v6mr18626764plm.307.1537057870320;
        Sat, 15 Sep 2018 17:31:10 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id h132-v6sm15349747pfc.100.2018.09.15.17.31.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Sep 2018 17:31:08 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-arch@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>
Subject: [PATCH 05/18] vmlinux.lds.h: Move LSM_TABLE into INIT_DATA
Date:   Sat, 15 Sep 2018 17:30:46 -0700
Message-Id: <20180916003059.1046-6-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180916003059.1046-1-keescook@chromium.org>
References: <20180916003059.1046-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the struct lsm_info table is not an initcall, we can just move it
into INIT_DATA like all the other tables.

Cc: linux-arch@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arc/kernel/vmlinux.lds.S        |  1 -
 arch/arm/kernel/vmlinux-xip.lds.S    |  1 -
 arch/arm64/kernel/vmlinux.lds.S      |  1 -
 arch/h8300/kernel/vmlinux.lds.S      |  1 -
 arch/microblaze/kernel/vmlinux.lds.S |  2 --
 arch/powerpc/kernel/vmlinux.lds.S    |  2 --
 arch/um/include/asm/common.lds.S     |  2 --
 arch/xtensa/kernel/vmlinux.lds.S     |  1 -
 include/asm-generic/vmlinux.lds.h    | 24 +++++++++++-------------
 9 files changed, 11 insertions(+), 24 deletions(-)

diff --git a/arch/arc/kernel/vmlinux.lds.S b/arch/arc/kernel/vmlinux.lds.S
index f35ed578e007..8fb16bdabdcf 100644
--- a/arch/arc/kernel/vmlinux.lds.S
+++ b/arch/arc/kernel/vmlinux.lds.S
@@ -71,7 +71,6 @@ SECTIONS
 		INIT_SETUP(L1_CACHE_BYTES)
 		INIT_CALLS
 		CON_INITCALL
-		SECURITY_INITCALL
 	}
 
 	.init.arch.info : {
diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 3593d5c1acd2..8c74037ade22 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -96,7 +96,6 @@ SECTIONS
 		INIT_SETUP(16)
 		INIT_CALLS
 		CON_INITCALL
-		SECURITY_INITCALL
 		INIT_RAM_FS
 	}
 
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 605d1b60469c..7d23d591b03c 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -166,7 +166,6 @@ SECTIONS
 		INIT_SETUP(16)
 		INIT_CALLS
 		CON_INITCALL
-		SECURITY_INITCALL
 		INIT_RAM_FS
 		*(.init.rodata.* .init.bss)	/* from the EFI stub */
 	}
diff --git a/arch/h8300/kernel/vmlinux.lds.S b/arch/h8300/kernel/vmlinux.lds.S
index 35716a3048de..49f716c0a1df 100644
--- a/arch/h8300/kernel/vmlinux.lds.S
+++ b/arch/h8300/kernel/vmlinux.lds.S
@@ -56,7 +56,6 @@ SECTIONS
 	__init_begin = .;
 	INIT_TEXT_SECTION(4)
 	INIT_DATA_SECTION(4)
-	SECURITY_INIT
 	__init_end = .;
 	_edata = . ;
 	_begin_data = LOADADDR(.data);
diff --git a/arch/microblaze/kernel/vmlinux.lds.S b/arch/microblaze/kernel/vmlinux.lds.S
index 289d0e7f3e3a..e1f3e8741292 100644
--- a/arch/microblaze/kernel/vmlinux.lds.S
+++ b/arch/microblaze/kernel/vmlinux.lds.S
@@ -117,8 +117,6 @@ SECTIONS {
 		CON_INITCALL
 	}
 
-	SECURITY_INIT
-
 	__init_end_before_initramfs = .;
 
 	.init.ramfs : AT(ADDR(.init.ramfs) - LOAD_OFFSET) {
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 07ae018e550e..105a976323aa 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -212,8 +212,6 @@ SECTIONS
 		CON_INITCALL
 	}
 
-	SECURITY_INIT
-
 	. = ALIGN(8);
 	__ftr_fixup : AT(ADDR(__ftr_fixup) - LOAD_OFFSET) {
 		__start___ftr_fixup = .;
diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/asm/common.lds.S
index 7adb4e6b658a..4049f2c46387 100644
--- a/arch/um/include/asm/common.lds.S
+++ b/arch/um/include/asm/common.lds.S
@@ -53,8 +53,6 @@
 	CON_INITCALL
   }
 
-  SECURITY_INIT
-
   .exitcall : {
 	__exitcall_begin = .;
 	*(.exitcall.exit)
diff --git a/arch/xtensa/kernel/vmlinux.lds.S b/arch/xtensa/kernel/vmlinux.lds.S
index a1c3edb8ad56..b727b18a68ac 100644
--- a/arch/xtensa/kernel/vmlinux.lds.S
+++ b/arch/xtensa/kernel/vmlinux.lds.S
@@ -197,7 +197,6 @@ SECTIONS
     INIT_SETUP(XCHAL_ICACHE_LINESIZE)
     INIT_CALLS
     CON_INITCALL
-    SECURITY_INITCALL
     INIT_RAM_FS
   }
 
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5079a969e612..b31ea8bdfef9 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -203,6 +203,15 @@
 #define EARLYCON_TABLE()
 #endif
 
+#ifdef CONFIG_SECURITY
+#define LSM_TABLE()	. = ALIGN(8);					\
+			__start_lsm_info = .;				\
+			KEEP(*(.lsm_info.init))				\
+			__end_lsm_info = .;
+#else
+#define LSM_TABLE()
+#endif
+
 #define ___OF_TABLE(cfg, name)	_OF_TABLE_##cfg(name)
 #define __OF_TABLE(cfg, name)	___OF_TABLE(cfg, name)
 #define OF_TABLE(cfg, name)	__OF_TABLE(IS_ENABLED(cfg), name)
@@ -597,7 +606,8 @@
 	IRQCHIP_OF_MATCH_TABLE()					\
 	ACPI_PROBE_TABLE(irqchip)					\
 	ACPI_PROBE_TABLE(timer)						\
-	EARLYCON_TABLE()
+	EARLYCON_TABLE()						\
+	LSM_TABLE()
 
 #define INIT_TEXT							\
 	*(.init.text .init.text.*)					\
@@ -786,17 +796,6 @@
 		KEEP(*(.con_initcall.init))				\
 		__con_initcall_end = .;
 
-#define SECURITY_INITCALL						\
-		__start_lsm_info = .;					\
-		KEEP(*(.lsm_info.init))					\
-		__end_lsm_info = .;
-
-/* Older linker script style for security init. */
-#define SECURITY_INIT							\
-	.lsm_info.init : AT(ADDR(.lsm_info.init) - LOAD_OFFSET) {	\
-		LSM_INFO						\
-	}
-
 #ifdef CONFIG_BLK_DEV_INITRD
 #define INIT_RAM_FS							\
 	. = ALIGN(4);							\
@@ -963,7 +962,6 @@
 		INIT_SETUP(initsetup_align)				\
 		INIT_CALLS						\
 		CON_INITCALL						\
-		SECURITY_INITCALL					\
 		INIT_RAM_FS						\
 	}
 
-- 
2.17.1

