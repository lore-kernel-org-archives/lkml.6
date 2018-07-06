Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82891C6778A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 00:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477D3240BE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 00:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 477D3240BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753777AbeGFAty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 20:49:54 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:41341 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753640AbeGFAtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 20:49:49 -0400
Received: by mail-qt0-f194.google.com with SMTP id y20-v6so8710478qto.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 17:49:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9/3S/vPBOZS1zms2ZTLLj6WKkzEDN0Zg6ke7GEjcPBY=;
        b=G1HZrvp4umSlSPI/dRl92329JrkJ1+sq4EdvmR9l43kGt5Mj7Wfyi33iLqPpVBumkK
         PqUj9aiCHAx2zLnHAiYf9EU0IHMWsbdoG6tFro1dKY/kZTJCU7BXRvLVJB4JBgDHczo+
         VDcCGzY6suLDBuqsmvpoUtL23+/tDbXabmy0jUVkjaY2fziNbBxBabgxKXsYAo5IsphC
         BzMIgNfRys0447m2M5VTt64PEOeXTu+Blqhl9UGV9PEedzDLATyMveu0jBJnvrIUzNco
         Mt+yBw+PCbM3nyrkN+Iydp0WLDvCvsMoZSQ8WaljC/Rcu5sUlS8Pz3t8FN1BM7cmhH8L
         3eBA==
X-Gm-Message-State: APt69E2z4pzzuiVdcvsGPc5ZlrpkEEQkg1AhK4l7/yCScO7lKtKl2uVG
        tqMlccay9u3PFEpqGelpPq/pZg==
X-Google-Smtp-Source: AAOMgpfskgVpIDN7evcrY3+vEsYJcz6P/GjCsVGJT3xLCLbbMVrgf2U7JYjB9i+XbRj/k99f/e/Klw==
X-Received: by 2002:a0c:87e5:: with SMTP id 34-v6mr6888001qvk.30.1530838188933;
        Thu, 05 Jul 2018 17:49:48 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::f0c1])
        by smtp.gmail.com with ESMTPSA id q67-v6sm4675205qkb.16.2018.07.05.17.49.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 17:49:47 -0700 (PDT)
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
Subject: [PATCHv6 1/4] kbuild: Add build salt to the kernel and modules
Date:   Thu,  5 Jul 2018 17:49:37 -0700
Message-Id: <20180706004940.32587-2-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180706004940.32587-1-labbott@redhat.com>
References: <20180706004940.32587-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In Fedora, the debug information is packaged separately (foo-debuginfo) and
can be installed separately. There's been a long standing issue where only
one version of a debuginfo info package can be installed at a time. There's
been an effort for Fedora for parallel debuginfo to rectify this problem.

Part of the requirement to allow parallel debuginfo to work is that build ids
are unique between builds. The existing upstream rpm implementation ensures
this by re-calculating the build-id using the version and release as a
seed. This doesn't work 100% for the kernel because of the vDSO which is
its own binary and doesn't get updated when embedded.

Fix this by adding some data in an ELF note for both the kernel and modules.
The data is controlled via a Kconfig option so distributions can set it
to an appropriate value to ensure uniqueness between builds.

Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v6: Added more detail to the commit text about why exactly this feature
is useful. Default string now ""
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
index 041f3a022122..d39b31484c52 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -107,6 +107,15 @@ config LOCALVERSION_AUTO
 
 	  which is done within the script "scripts/setlocalversion".)
 
+config BUILD_SALT
+       string "Build ID Salt"
+       default ""
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

