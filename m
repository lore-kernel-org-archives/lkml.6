Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2D6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF5220823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="W8QRvm5G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfBVHk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 02:40:26 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:53324 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfBVHkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 02:40:22 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x1M7eEN4013122;
        Fri, 22 Feb 2019 16:40:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x1M7eEN4013122
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550821216;
        bh=EjgNKSfh8xtmbNhOrnDsrTe+nk2utBj1sqPU76jQ+JE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W8QRvm5GYUfOTZqBxI0sxCTeKRFOZD7FIl/LKktPFs0LMO6yAuN2DDcfOnWbiO8gc
         1n61jmAREu/7s5KsjKMyHrflanVNicsNDYf4nd3ejg+TmccySK3AmGKqxZPXPwevpo
         9SUNvxg1ZnMfBe/KI2annVsQNThjCqSIC21+jKLMcnqgzKxmgmWpy2kPjQFPEcEjTu
         UC9+g1230GZpqzKVqWLqv5yKBNmT8/+8hwsFANpkSR3lT2z9NtJueDWCiys+Kh0z1Y
         XqjZRBuVWzY0SMQ/JnrSKNgVcJEva/JUHxHrz6nY5nf53yxFw3fBdQi8SM51W8t//G
         MPWXuduUhqSng==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] kbuild: invoke syncconfig if include/config/auto.conf.cmd is missing
Date:   Fri, 22 Feb 2019 16:40:10 +0900
Message-Id: <1550821211-30324-5-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550821211-30324-1-git-send-email-yamada.masahiro@socionext.com>
References: <1550821211-30324-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If include/config/auto.conf.cmd is lost for some reasons, it is not
self-healing, so the top Makefile misses to run syncconfig.
Move include/config/auto.conf.cmd to the target side.

I used a pattern rule instead of a normal rule here although it is
a bit gross.

If the rule were written with a normal rule like this,

  include/config/auto.conf \
  include/config/auto.conf.cmd \
  include/config/tristate.conf: $(KCONFIG_CONFIG)
          $(Q)$(MAKE) -f $(srctree)/Makefile syncconfig

... syncconfig would be executed per target.

Using a pattern rule makes sure that syncconfig is executed just once
because Make assumes the recipe will create all of the targets.

Here is a quote from the GNU Make manual [1]:

"Pattern rules may have more than one target. Unlike normal rules,
this does not act as many different rules with the same prerequisites
and recipe. If a pattern rule has multiple targets, make knows that
the rule's recipe is responsible for making all of the targets. The
recipe is executed only once to make all the targets. When searching
for a pattern rule to match a target, the target patterns of a rule
other than the one that matches the target in need of a rule are
incidental: make worries only about giving a recipe and prerequisites
to the file presently in question. However, when this file's recipe is
run, the other targets are marked as having been updated themselves."

[1]: https://www.gnu.org/software/make/manual/html_node/Pattern-Intro.html

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - New patch

 Makefile | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 4d8516e..aa9ff68 100644
--- a/Makefile
+++ b/Makefile
@@ -629,12 +629,17 @@ ifeq ($(may-sync-config),1)
 -include include/config/auto.conf.cmd
 
 # To avoid any implicit rule to kick in, define an empty command
-$(KCONFIG_CONFIG) include/config/auto.conf.cmd: ;
+$(KCONFIG_CONFIG): ;
 
 # The actual configuration files used during the build are stored in
 # include/generated/ and include/config/. Update them if .config is newer than
 # include/config/auto.conf (which mirrors .config).
-include/config/%.conf: $(KCONFIG_CONFIG) include/config/auto.conf.cmd
+#
+# This exploits the 'multi-target pattern rule' trick.
+# The syncconfig should be executed only once to make all the targets.
+include/config/auto.% \
+include/config/auto.%.cmd \
+include/config/tristate.%: $(KCONFIG_CONFIG)
 	$(Q)$(MAKE) -f $(srctree)/Makefile syncconfig
 else
 # External modules and some install targets need include/generated/autoconf.h
-- 
2.7.4

