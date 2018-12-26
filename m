Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00920C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF952214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864147;
	bh=UDGFIj+PsKt8EpufAl+8zNCHk3mhjPrvTUt5T2h0ZGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R7By3b278j7X9Er0/A7xBziKtje/XkdszDzpGRz8WyZA9IpKvwsEYwvTLt2nByp7Q
	 doiGPVAaLTZR1Bav/g5T+hr6U5hYRCqrYUIxCMmme/hY4dbljPJtHfulyWdi+rQs7j
	 CXf9kWf81c0e1cVQ24DGG2vq9uujderOBp83ocEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbeLZWm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:42:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:41962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729470AbeLZWlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:41:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B228921901;
        Wed, 26 Dec 2018 22:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864090;
        bh=UDGFIj+PsKt8EpufAl+8zNCHk3mhjPrvTUt5T2h0ZGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E7hjKNpbdq1mjBP6PmSYov9OycAAY2WUVkDz+583Osyp377oQxSdqFMtXykPQ8sXp
         y1gagwvZVhv9W9hXbOb976jIK0rH6ACrK6O0451aR7GiPYNabGSDjPFmdyRpifL93J
         yiBADGW2h/OcSc7PjkzBdgqSHgB4qQegWboHdDdA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 52/59] kbuild: fix false positive warning/error about missing libelf
Date:   Wed, 26 Dec 2018 17:38:32 -0500
Message-Id: <20181226223839.150262-52-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223839.150262-1-sashal@kernel.org>
References: <20181226223839.150262-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

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
index 280c7193e246..f72fb4b403b7 100644
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

