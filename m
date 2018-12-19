Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AF3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D9B218D0
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbeLSORw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 09:17:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:41298 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728426AbeLSORw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 09:17:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 40BD2AD6F;
        Wed, 19 Dec 2018 14:17:50 +0000 (UTC)
From:   Miroslav Benes <mbenes@suse.cz>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        jpoimboe@redhat.com, jeyu@kernel.org, jikos@kernel.org
Cc:     pmladek@suse.com, linux-kbuild@vger.kernel.org,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH] kbuild: use -flive-patching when CONFIG_LIVEPATCH is enabled
Date:   Wed, 19 Dec 2018 15:17:44 +0100
Message-Id: <20181219141744.32392-1-mbenes@suse.cz>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 9 introduces a new option, -flive-patching. It disables certain
optimizations which could make a compilation unsafe for later live
patching of the running kernel.

The option is used only if CONFIG_LIVEPATCH is enabled and $(CC)
supports it.

Signed-off-by: Miroslav Benes <mbenes@suse.cz>
---
 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index a0650bf79606..53f5ab810efe 100644
--- a/Makefile
+++ b/Makefile
@@ -778,6 +778,10 @@ KBUILD_CFLAGS_KERNEL	+= $(call cc-option,-ffunction-sections,)
 KBUILD_CFLAGS_KERNEL	+= $(call cc-option,-fdata-sections,)
 endif
 
+ifdef CONFIG_LIVEPATCH
+KBUILD_CFLAGS += $(call cc-option, -flive-patching=inline-clone)
+endif
+
 # arch Makefile may override CC so keep this after arch Makefile is included
 NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
 
-- 
2.19.2

