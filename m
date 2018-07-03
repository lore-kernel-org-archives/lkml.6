Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C68C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173C3218C2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173C3218C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753510AbeGCXel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 19:34:41 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:40204 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbeGCXei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 19:34:38 -0400
Received: by mail-oi0-f66.google.com with SMTP id w126-v6so7222754oie.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 16:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JSiYJxVu4Lk+P/iYMSDC9lASMjQX+zcA6OF5z2ph/ww=;
        b=a95Jz88Y4H/hdC4LDOYGx6s6DLKS0Ze3kyh1UIQoYkeGTkv/1JJLEbKsnGoUpn+Egp
         gVajFMGjfRmz8+XgMiUQeqZ0JhJjI69B+26Db3gh8FN3jJPEotPXkTZLT9Yfg/M/4Rb1
         6Rxmps4qatce6ed7aB2O6PAB6XOwmcMwfL9JviNVLtuNR+fSqj+BnMMvopgBnPGfE4A5
         mYzo07i2eQIJeLn08ob2w13EFwH15nCFCr4FQMj6TDWwhE2x/KAdK53rC+cBWlH27T5L
         8iGV639y9RNJH1BFvI4glNdsJ8MD7qdXWDj9uFX230a6ytdApqUK2X/u/Be5b1x51pvU
         xyvQ==
X-Gm-Message-State: APt69E1PmbLTXPljuvN72TixNJEkXtGByMDxX8X8i0Dd47QlmQUMFeO6
        KlhWCnj/hb/bhyxjtN/Xmk1jbA==
X-Google-Smtp-Source: AAOMgpchIoMRSlaUTxrdAuAj5tDPAXcPw609bKZdPYqy4jkcwDBVmtRJdRIvqjJtIYJWZ6u2978aBw==
X-Received: by 2002:aca:dec6:: with SMTP id v189-v6mr1739997oig.98.1530660878014;
        Tue, 03 Jul 2018 16:34:38 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::f0c1])
        by smtp.gmail.com with ESMTPSA id h22-v6sm1828702otc.25.2018.07.03.16.34.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 16:34:36 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>, mjw@fedoraproject.org,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Nick Clifton <nickc@redhat.com>,
        Cary Coutant <ccoutant@gmail.com>,
        linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCHv5 1/4] kbuild: Add build salt to the kernel and modules
Date:   Tue,  3 Jul 2018 16:34:27 -0700
Message-Id: <20180703233430.14416-2-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180703233430.14416-1-labbott@redhat.com>
References: <20180703233430.14416-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The build id generated from --build-id can be generated in several different
ways, with the default being the sha1 on the output of the linked file. For
distributions, it can be useful to make sure this ID is unique, even if the
actual file contents don't change. The easiest way to do this is to insert
a section with some data.

Add an ELF note to both the kernel and module which contains some data based
off of a config option.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v5: I used S-o-b here since the majority of the code was written
already. Please feel free to change the tag if you think it's not
appropriate. I also tweaked this to take an ascii string instead of just
a hex value since this makes things much easier on the distribution
side.
---
 include/linux/build-salt.h | 20 ++++++++++++++++++++
 init/Kconfig               |  9 +++++++++
 init/version.c             |  3 +++
 scripts/mod/modpost.c      |  3 +++
 4 files changed, 35 insertions(+)
 create mode 100644 include/linux/build-salt.h

diff --git a/include/linux/build-salt.h b/include/linux/build-salt.h
new file mode 100644
index 000000000000..bb007bd05e7a
--- /dev/null
+++ b/include/linux/build-salt.h
@@ -0,0 +1,20 @@
+#ifndef __BUILD_SALT_H
+#define __BUILD_SALT_H
+
+#include <linux/elfnote.h>
+
+#define LINUX_ELFNOTE_BUILD_SALT       0x100
+
+#ifdef __ASSEMBLER__
+
+#define BUILD_SALT \
+       ELFNOTE(Linux, LINUX_ELFNOTE_BUILD_SALT, .asciz CONFIG_BUILD_SALT)
+
+#else
+
+#define BUILD_SALT \
+       ELFNOTE32("Linux", LINUX_ELFNOTE_BUILD_SALT, CONFIG_BUILD_SALT)
+
+#endif
+
+#endif /* __BUILD_SALT_H */
diff --git a/init/Kconfig b/init/Kconfig
index 041f3a022122..8de789f40db9 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -107,6 +107,15 @@ config LOCALVERSION_AUTO
 
 	  which is done within the script "scripts/setlocalversion".)
 
+config BUILD_SALT
+       string "Build ID Salt"
+       default "Linux"
+       help
+          The build ID is used to link binaries and their debug info. Setting
+          this option will use the value in the calculation of the build id.
+          This is mostly useful for distributions which want to ensure the
+          build is unique between builds. It's safe to leave the default.
+
 config HAVE_KERNEL_GZIP
 	bool
 
diff --git a/init/version.c b/init/version.c
index bfb4e3f4955e..ef4012ec4375 100644
--- a/init/version.c
+++ b/init/version.c
@@ -7,6 +7,7 @@
  */
 
 #include <generated/compile.h>
+#include <linux/build-salt.h>
 #include <linux/export.h>
 #include <linux/uts.h>
 #include <linux/utsname.h>
@@ -49,3 +50,5 @@ const char linux_proc_banner[] =
 	"%s version %s"
 	" (" LINUX_COMPILE_BY "@" LINUX_COMPILE_HOST ")"
 	" (" LINUX_COMPILER ") %s\n";
+
+BUILD_SALT;
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 1663fb19343a..dc6d714e4dcb 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2125,10 +2125,13 @@ static int check_modname_len(struct module *mod)
  **/
 static void add_header(struct buffer *b, struct module *mod)
 {
+	buf_printf(b, "#include <linux/build-salt.h>\n");
 	buf_printf(b, "#include <linux/module.h>\n");
 	buf_printf(b, "#include <linux/vermagic.h>\n");
 	buf_printf(b, "#include <linux/compiler.h>\n");
 	buf_printf(b, "\n");
+	buf_printf(b, "BUILD_SALT;\n");
+	buf_printf(b, "\n");
 	buf_printf(b, "MODULE_INFO(vermagic, VERMAGIC_STRING);\n");
 	buf_printf(b, "MODULE_INFO(name, KBUILD_MODNAME);\n");
 	buf_printf(b, "\n");
-- 
2.17.1

