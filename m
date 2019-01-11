Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DEAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE9E720874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218904;
	bh=taOGbMQh93TdgIuuP76DZUmHoUOHqRuPen9Zr962Kzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nh8AO0dJh2OTjoVZvGTZHSYdCnrF0oH0AN6LgKBZz8M1bcq7OmL3IBGx/bOE/CzCv
	 3oXDAzHoPvHzN+CbM/r6iAt1i57TjJOOqzzb1sNKTDdEaDDjfsSmnT54fYntN4InwR
	 +W/THi0sOx2N1MfbkiRftUhIWOU2jdvHMzFWBaOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390165AbfAKPBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:01:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:51822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388799AbfAKOb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:31:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 915272063F;
        Fri, 11 Jan 2019 14:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217117;
        bh=taOGbMQh93TdgIuuP76DZUmHoUOHqRuPen9Zr962Kzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NavOgN0TFMz14rQnYMcjERX2WnjXOuHERbSlhhvt9RTnojL6xHrt8H5HDREVLNmVO
         UcyRvpRQRFFwpjQZrSx/qErKPMHXlMCEVd3WZ3+w6gBL7HUqsvnt6VSCUgeEr8J82p
         NCelFneNZzXnALHqYSFdoHhCI0+cFbdJ0FUBtoyw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Qian Cai <cai@lca.pw>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 048/105] kbuild: fix false positive warning/error about missing libelf
Date:   Fri, 11 Jan 2019 15:14:19 +0100
Message-Id: <20190111131107.141377119@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ef7cfd00b2caf6edeb7f169682b64be2d0a798cf ]

For the same reason as commit 25896d073d8a ("x86/build: Fix compiler
support check for CONFIG_RETPOLINE"), you cannot put this $(error ...)
into the parse stage of the top Makefile.

Perhaps I'd propose a more sophisticated solution later, but this is
the best I can do for now.

Link: https://lkml.org/lkml/2017/12/25/211
Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Reported-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
Reported-by: Qian Cai <cai@lca.pw>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Tested-by: Qian Cai <cai@lca.pw>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index be4d1f25cb29..2de4072bcc90 100644
--- a/Makefile
+++ b/Makefile
@@ -954,11 +954,6 @@ ifdef CONFIG_STACK_VALIDATION
   ifeq ($(has_libelf),1)
     objtool_target := tools/objtool FORCE
   else
-    ifdef CONFIG_UNWINDER_ORC
-      $(error "Cannot generate ORC metadata for CONFIG_UNWINDER_ORC=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel")
-    else
-      $(warning "Cannot use CONFIG_STACK_VALIDATION=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel")
-    endif
     SKIP_STACK_VALIDATION := 1
     export SKIP_STACK_VALIDATION
   endif
@@ -1102,6 +1097,14 @@ uapi-asm-generic:
 
 PHONY += prepare-objtool
 prepare-objtool: $(objtool_target)
+ifeq ($(SKIP_STACK_VALIDATION),1)
+ifdef CONFIG_UNWINDER_ORC
+	@echo "error: Cannot generate ORC metadata for CONFIG_UNWINDER_ORC=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel" >&2
+	@false
+else
+	@echo "warning: Cannot use CONFIG_STACK_VALIDATION=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel" >&2
+endif
+endif
 
 # Check for CONFIG flags that require compiler support. Abort the build
 # after .config has been processed, but before the kernel build starts.
-- 
2.19.1



