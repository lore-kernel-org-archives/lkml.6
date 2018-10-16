Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AA0C169D4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A77E205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="zn1dGnan"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A77E205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbeJPRBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:01:38 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:57571 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbeJPRBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:01:37 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w9G9BLLv029692;
        Tue, 16 Oct 2018 18:11:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w9G9BLLv029692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539681083;
        bh=bXpviXkYAhvFT7qG6xXXNbPHFseOjHvbyF4Xhb2IpBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zn1dGnanzsIvhFqKk6xLja7en9LBahNuNgeJN7L/sUhQGIADqRV19Dwju/lZ7yj7c
         FJ815cyptAXC/wIoILrUDhKdtvHfl8Ow0fIjOMb5F+1yj/YSh1UENJ5P3I1PG6B9hZ
         5tZQA+P1phhE3BAULEJB4oAtGMt1Tpj4/n2uU5uyGsdHlnrRFBfBiqAk1nT6o5hTMU
         /KOuh/47kD6h2tGmc+2/Nkx71OYInSFhSMU6PLGvc1bJeIROVU+atuxGI8Uw3/jz/Q
         dw0NJ9Bt7irfbb6UOm2AMj152Hm1w8DAgUJ39PXeqwqybE/QAZ36xFNoeNsiRZrbtM
         dtOncDU/HwwbA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Borislav Petkov <bp@suse.de>, Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] kbuild: provide a new place to check necessary host tools
Date:   Tue, 16 Oct 2018 18:10:51 +0900
Message-Id: <1539681053-24388-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539681053-24388-1-git-send-email-yamada.masahiro@socionext.com>
References: <1539681053-24388-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling CONFIG options often requires additional features, like
target compiler capabilities, host tools, etc.

As for the target compiler capabilities, Kconfig is able to add
proper dependencies. For example,

  config STACKPROTECTOR
          ...
          depends on $(cc-option,-fstack-protector)

The CONFIG option is simply disabled if unsupported by the compiler.
This seems sensible since otherwise, there is no way to avoid the
build error.

In the discussion [1], doing similar for host tools was unacceptable.
Build errors caused by missing host tools are easy to fix; just
install them to your build machine. So, let the build fail instead
of disabling CONFIG options silently.

We already have such checks in random places in makefiles. What I
do not like is that people tend to do that in the top Makefile.

The top Makefile is too cluttered, and what is worse, $(error ...)
functions in the top Makefile could be false positive. (Please note
the top Makefile includes the stale include/config/auto.conf before
syncconfig updates it.)

This adds a new file scripts/Makefile.toolcheck to check additional
tools depending on the kernel configuration. This check is run
immediately after syncconfig, i.e., when a user attempts to build
something with a new set of CONFIG options.

[1] https://patchwork.kernel.org/patch/10516049/

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile                   |  1 +
 scripts/Makefile.toolcheck | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 scripts/Makefile.toolcheck

diff --git a/Makefile b/Makefile
index bf3786e..23a204a 100644
--- a/Makefile
+++ b/Makefile
@@ -633,6 +633,7 @@ $(KCONFIG_CONFIG) include/config/auto.conf.cmd: ;
 # include/config/auto.conf (which mirrors .config).
 include/config/%.conf: $(KCONFIG_CONFIG) include/config/auto.conf.cmd
 	$(Q)$(MAKE) -f $(srctree)/Makefile syncconfig
+	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.toolcheck
 else
 # External modules and some install targets need include/generated/autoconf.h
 # and include/config/auto.conf but do not care if they are up-to-date.
diff --git a/scripts/Makefile.toolcheck b/scripts/Makefile.toolcheck
new file mode 100644
index 0000000..f3c165d
--- /dev/null
+++ b/scripts/Makefile.toolcheck
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: GPL-2.0
+# ===========================================================================
+# Host tools check
+# ===========================================================================
+#
+# Some additional tools might be required depending on the kernel configuration.
+# Check if they are installed on the host machine, and if missing, error out
+# with a user-friendly message.
+
+include include/config/auto.conf
+
+__toolcheck:
+	@:
+
+PHONY += $(toolcheck-y)
+__toolcheck: $(toolcheck-y)
+
+define populate_toolcheck
+__toolcheck: check_$(1)
+PHONY += check_$(1)
+check_$(1):
+	$(Q){ $(chk_$(1)); } >/dev/null 2>&1 || {	\
+		echo "*" >&2;				\
+		for msg in $(msg_$(1));			\
+		do					\
+			echo "* $$$${msg}" >&2;		\
+		done;					\
+		echo "*" >&2;				\
+		/bin/false;				\
+	}
+endef
+
+$(foreach c, $(toolcheck-y), $(eval $(call populate_toolcheck,$(c))))
+
+.PHONY: $(PHONY)
-- 
2.7.4

