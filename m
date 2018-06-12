Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 66BEFC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D48208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D48208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934849AbeFLAdT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 20:33:19 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43654 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934800AbeFLAcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 20:32:52 -0400
Received: by mail-pl0-f65.google.com with SMTP id c41-v6so13287252plj.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 17:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rgx81okqi/dPGjCxYFjeGB9OoHrzfYU2VBaGw23rhug=;
        b=qQ5y+lZ4RbMMkfJE3Wv97kuDh38uQn7Tek21Xfx93jmxJiEshOeA8POk5GLIRbVf/4
         tEHJBYQmvyqZuSmc14Fu3T4PT8Bk8Yxj1P8kYQ4QwJVz80lm+zFVszkUJoiyjoxJEGb/
         8jlTSYbjuXvvUyl4jixLoa528Rex3UBLix4KOBrbDD4xqLgVUO2izRD7BOewcRN/EBiK
         8mGP0PHmijavTeA3P35qIfecRXWttlAs5LOSBoIi7F8Y+IM3vKOOLjjXFISRDo2bQPPX
         F89q3hLd/QaDjMPIjU9IraVUFNXPeozaaQK/51U5OVn42bIsO/XY0rGzqviuWL+hVSV6
         dmOA==
X-Gm-Message-State: APt69E03BsGzc/rg2vjgwrNVjYHWlZte0eYUnObx4zT18DOKDArLNAdw
        ISFRXTxMMshKzz3s2RKlkX4TJQ==
X-Google-Smtp-Source: ADUXVKKixuYY4A7br4AVxgHvIIdpBNRQLV41p7n/PGvXmCa01UcK0fIZANEljdHXoPMhSDPCwj6QsA==
X-Received: by 2002:a17:902:5a3:: with SMTP id f32-v6mr1402338plf.109.1528763572349;
        Mon, 11 Jun 2018 17:32:52 -0700 (PDT)
Received: from localhost.net ([2601:602:9802:a8dc::27e5])
        by smtp.gmail.com with ESMTPSA id c12-v6sm40866112pfi.177.2018.06.11.17.32.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 17:32:50 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>, mjw@fedoraproject.org,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Nick Clifton <nickc@redhat.com>,
        Cary Coutant <ccoutant@gmail.com>, linux-kbuild@vger.kernel.org
Subject: [PATCHv4 2/3] kbuild: Introduce build-salt linker section and config option
Date:   Mon, 11 Jun 2018 17:32:23 -0700
Message-Id: <20180612003224.3658-3-labbott@redhat.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180612003224.3658-1-labbott@redhat.com>
References: <20180612003224.3658-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The build id generated from --build-id can be generated in several different
ways, with the default being the sha1 on the output of the linked file. For
distributions, it can be useful to make sure this ID is unique, even if the
actual file contents don't change. The easiest way to do this is to insert
a section with some data.

Introduce a macro to insert a linker section which will be filled
with a hex value. This will ensure the build id can be changed just via
a config option. Users who don't care about this can leave the
default value and strip the section.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 include/asm-generic/vmlinux.lds.h | 6 ++++++
 init/Kconfig                      | 9 +++++++++
 scripts/module-common.lds.S       | 4 ++++
 3 files changed, 19 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index e373e2e10f6a..4af7e683aad2 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -830,6 +830,12 @@
 #define PERCPU_DECRYPTED_SECTION
 #endif
 
+#define	BUILD_SALT							\
+	. = ALIGN(32);							\
+	.salt : AT(ADDR(.salt) - LOAD_OFFSET) {				\
+	  LONG(0xffaa5500);						\
+	  . = ALIGN(32);						\
+	} = CONFIG_BUILD_ID_SALT					\
 
 /*
  * Default discarded sections.
diff --git a/init/Kconfig b/init/Kconfig
index d2b8b2ea097e..eb92ccfe4ecb 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1967,3 +1967,12 @@ config ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 # <asm/syscall_wrapper.h>.
 config ARCH_HAS_SYSCALL_WRAPPER
 	def_bool n
+
+config BUILD_ID_SALT
+	hex "Build ID Salt"
+	default 0x12345678
+	help
+	   The build ID is used to link binaries and their debug info. Setting
+	   this option will use the value in the calculation of the build id.
+	   This is mostly useful for distributions which want to ensure the
+	   build is unique between builds. It's safe to leave the default.
diff --git a/scripts/module-common.lds.S b/scripts/module-common.lds.S
index d61b9e8678e8..3c8410270ac1 100644
--- a/scripts/module-common.lds.S
+++ b/scripts/module-common.lds.S
@@ -3,6 +3,9 @@
  * Archs are free to supply their own linker scripts.  ld will
  * combine them automatically.
  */
+
+#include <asm-generic/vmlinux.lds.h>
+
 SECTIONS {
 	/DISCARD/ : {
 		*(.discard)
@@ -23,4 +26,5 @@ SECTIONS {
 	.init_array		0 : ALIGN(8) { *(SORT(.init_array.*)) *(.init_array) }
 
 	__jump_table		0 : ALIGN(8) { KEEP(*(__jump_table)) }
+	BUILD_SALT
 }
-- 
2.18.0.rc1

