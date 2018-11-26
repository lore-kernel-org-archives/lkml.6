Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93285C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5996F2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrMpPjZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5996F2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbeKZVs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:48:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:57010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726475AbeKZVs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:48:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 963412089F;
        Mon, 26 Nov 2018 10:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229684;
        bh=kLTwNFLZ3Vvb47hJdaUo11wwl7ME+guwx/v7ZqxXwkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QrMpPjZ69O44YBSCRDgj6LQ3xrMFBublHKdPg7rLOPZydlNRC1L96jN5zx4rFOXjb
         w1u1VwmyBSkYCtTGQl4XtJoQAwuE3ghF1HKN4goUyfEgrFLCRwN/l/mxGUaPFsBN0+
         28a5sg6dPmUz7pLm3fzottOy3FzB1B8TxvCjtXms=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Michal Marek <mmarek@suse.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.4 32/70] kbuild: Add __cc-option macro
Date:   Mon, 26 Nov 2018 11:50:47 +0100
Message-Id: <20181126105049.873076377@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105046.722096341@linuxfoundation.org>
References: <20181126105046.722096341@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Kaehlcke <mka@chromium.org>

commit 9f3f1fd299768782465cb32cdf0dd4528d11f26b upstream.

cc-option uses KBUILD_CFLAGS and KBUILD_CPPFLAGS when it determines
whether an option is supported or not. This is fine for options used to
build the kernel itself, however some components like the x86 boot code
use a different set of flags.

Add the new macro __cc-option which is a more generic version of
cc-option with additional parameters. One parameter is the compiler
with which the check should be performed, the other the compiler options
to be used instead KBUILD_C*FLAGS.

Refactor cc-option and hostcc-option to use __cc-option and move
hostcc-option to scripts/Kbuild.include.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Michal Marek <mmarek@suse.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
[nc: Fix conflicts due to lack of CC_OPTION_CFLAGS and hostcc-option
     wasn't added until v4.8 so no point including it in this tree]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Makefile               |    2 +-
 scripts/Kbuild.include |    9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -303,7 +303,7 @@ CONFIG_SHELL := $(shell if [ -x "$$BASH"
 
 HOSTCC       = gcc
 HOSTCXX      = g++
-HOSTCFLAGS   = -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer -std=gnu89
+HOSTCFLAGS   := -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer -std=gnu89
 HOSTCXXFLAGS = -O2
 
 # Decide whether to build built-in, modular, or both.
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -108,11 +108,16 @@ as-option = $(call try-run,\
 as-instr = $(call try-run,\
 	printf "%b\n" "$(1)" | $(CC) $(KBUILD_AFLAGS) -c -x assembler -o "$$TMP" -,$(2),$(3))
 
+# __cc-option
+# Usage: MY_CFLAGS += $(call __cc-option,$(CC),$(MY_CFLAGS),-march=winchip-c6,-march=i586)
+__cc-option = $(call try-run,\
+	$(1) -Werror $(2) $(3) -c -x c /dev/null -o "$$TMP",$(3),$(4))
+
 # cc-option
 # Usage: cflags-y += $(call cc-option,-march=winchip-c6,-march=i586)
 
-cc-option = $(call try-run,\
-	$(CC) -Werror $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) $(1) -c -x c /dev/null -o "$$TMP",$(1),$(2))
+cc-option = $(call __cc-option, $(CC),\
+	$(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS),$(1),$(2))
 
 # cc-option-yn
 # Usage: flag := $(call cc-option-yn,-march=winchip-c6)


