Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2875BC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A414A21712
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nIimAQsf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A414A21712
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeI1DIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 23:08:24 -0400
Received: from mail-it1-f201.google.com ([209.85.166.201]:56532 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbeI1DIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 23:08:24 -0400
Received: by mail-it1-f201.google.com with SMTP id i188-v6so159430itf.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 13:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ELeHpNLN3fEYycvF2r1VryQWixx5CGAZIMwHEWZKhKQ=;
        b=nIimAQsfGznz9Mll9zTy0Vp9Ss9P8BSMjQHNbRFTdBUJpsp2Rsw6N+i396SHQ47uRM
         NHkvvIJdPKoPk+CNL0ARSK6mqZ8Lh91ajeSBiZxoLAGWmKir9RmcSPjWuDRAISN7OgpP
         6mFbWpeMgHicvlA0yjTsYeD9pBJ+Pm9LO+ZQmAjE4/dM6p3S3GbCrJNsF+2SscZWzyOf
         RbX6ysMeht0SdOJcbqlV5InA62J6cotrkIYjNdCHVGSb57YYUroqGvAFqlJ8MokRKrEc
         5JFrybuOFdyhatAHdH4rLZfdKGn0gIzGREgb63yuGcljqYeDroIzwE5/PoFECN3jn+gI
         XleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ELeHpNLN3fEYycvF2r1VryQWixx5CGAZIMwHEWZKhKQ=;
        b=sUfayjOmL8qXRLoLf3tUKccysE4G4u74w1stVmkEOQASr7lhrvvkQpnlWdllt+l7Z3
         KLSmzx8QAhVZSeh4fL9/E0VA9P2A5ilFjPDKpKBBaze2BwbQxX00ziICc4oZwG5BxW2q
         ztvzPe97gIZHCZQ4BWEluDGdAbXqCha3b0UZW5Y30eeS3RKQ1mALAFnxDIYaXsBvuBMd
         97atHPJSWSsqqp+dM+36VvWIA6JDRqNkddhgxRQSjeZ21ZpSrPS22QYwYDWbjzOSi6YO
         eO3mYwocy20QEEyur7qw/psH83zUra68vgRrFuFO/oDApsMJbsNEkOsM58N5YG/8AQQX
         carg==
X-Gm-Message-State: ABuFfoikA6+hH0/CZtht6WSeELf44un19RVarie6R8Nm3QDGQAQi8+q5
        zFAUy4WBJRS2pKgbjXEAduMIzsRq7xAG+3cpdXE=
X-Google-Smtp-Source: ACcGV62b7f9DgJVuPfzwGUVll9/20UNg1zPUaK6lA/bpJ+uWpvFpyBjKxaxLlf1U5QpNyMEPTS98Z8xHKS/g3UwGMnA=
X-Received: by 2002:a24:7991:: with SMTP id z139-v6mr245880itc.2.1538081295535;
 Thu, 27 Sep 2018 13:48:15 -0700 (PDT)
Date:   Thu, 27 Sep 2018 13:47:58 -0700
Message-Id: <20180927204800.32210-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v2] x86/boot: define CC_HAVE_ASM_GOTO
From:   ndesaulniers@google.com
To:     bp@alien8.de, mingo@redhat.com, tglx@linutronix.de
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Early prototypes of Clang with asm goto support produce 6 instances of
the following warning:

In file included from arch/x86/boot/compressed/misc.h:20:
In file included from ./include/linux/elf.h:5:
In file included from ./arch/x86/include/asm/elf.h:8:
In file included from ./include/linux/thread_info.h:38:
In file included from ./arch/x86/include/asm/thread_info.h:53:
./arch/x86/include/asm/cpufeature.h:150:2: warning: "Compiler lacks
ASM_GOTO support. Add -D __BPF_TRACING__ to your compiler arguments"
[-W#warnings]
your compiler arguments"
 ^

Since 6 files under arch/x86/boot/compressed/ include
arch/x86/boot/compressed/misc.h AND
arch/x86/boot/compressed/Makefile happens to redefine KBUILD_CFLAGS,
which set these variables in the top level MAKEFILE.

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
v1 -> v2:
  Updated commit message to provide more context as per Borislav.

 arch/x86/boot/compressed/Makefile | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 28764dacf018..158c0b4e178a 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -56,6 +56,13 @@ KBUILD_LDFLAGS += $(shell $(LD) --help 2>&1 | grep -q "\-z noreloc-overflow" \
 endif
 LDFLAGS_vmlinux := -T
 
+# check for 'asm goto'
+ifeq ($(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-goto.sh $(CC) $(KBUILD_CFLAGS)), y)
+  CC_HAVE_ASM_GOTO := 1
+  KBUILD_CFLAGS += -DCC_HAVE_ASM_GOTO
+  KBUILD_AFLAGS += -DCC_HAVE_ASM_GOTO
+endif
+
 hostprogs-y	:= mkpiggy
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include
 
-- 
2.19.0.605.g01d371f741-goog

