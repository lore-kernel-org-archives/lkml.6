Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD019C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD392087F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078529;
	bh=LAajhNqo+nIivN7JQLUtHC3LmcTIcX7EXQq3zWGyQzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rL6NJIVqctJFQ0PSY6gxskkyKqXYGHGLQ0AwXyfQ6C8nChrYqofoTK1B7c8EtaYoG
	 ka14kbqCEh0zODm3wAmxKgpuKDE+UIwkfb7b1TRHmkgSoebgtYK0b595/p7MkoQi/U
	 uJGOZ4eOlhVbmDJhnBwrMN5GIkH1wLeByJ//d+s0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbfAUNss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:48:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:58778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730003AbfAUNsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:48:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA5A02063F;
        Mon, 21 Jan 2019 13:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078521;
        bh=LAajhNqo+nIivN7JQLUtHC3LmcTIcX7EXQq3zWGyQzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=viGwfblDx14FYJlFPBRHvLZzu1FC9MxbU6nsvOuEV3ySSJto0jN4PSw/o6k9+U655
         C5xENlcFzmraXTfA2Z8dFd0Fgp3plmIn6WllbWIs6UPnN7oynf39Gqz8vj4eKmU8d9
         HKJLgNXp6LRc6xAvqOkS/I+LS2IRRgnkeRiXYY/o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.20 062/111] kbuild: mark prepare0 as PHONY to fix external module build
Date:   Mon, 21 Jan 2019 14:42:56 +0100
Message-Id: <20190121122503.046066608@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masahiro Yamada <yamada.masahiro@socionext.com>

commit e00d8880481497474792d28c14479a9fb6752046 upstream.

Commit c3ff2a5193fa ("powerpc/32: add stack protector support")
caused kernel panic on PowerPC when an external module is used with
CONFIG_STACKPROTECTOR because the 'prepare' target was not executed
for the external module build.

Commit e07db28eea38 ("kbuild: fix single target build for external
module") turned it into a build error because the 'prepare' target is
now executed but the 'prepare0' target is missing for the external
module build.

External module on arm/arm64 with CONFIG_STACKPROTECTOR_PER_TASK is
also broken in the same way.

Move 'PHONY += prepare0' to the common place. GNU Make is fine with
missing rule for phony targets. I also removed the comment which is
wrong irrespective of this commit.

I minimize the change so it can be easily backported to 4.20.x

To fix v4.20, please backport e07db28eea38 ("kbuild: fix single target
build for external module"), and then this commit.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=201891
Fixes: e07db28eea38 ("kbuild: fix single target build for external module")
Fixes: c3ff2a5193fa ("powerpc/32: add stack protector support")
Fixes: 189af4657186 ("ARM: smp: add support for per-task stack canaries")
Fixes: 0a1213fa7432 ("arm64: enable per-task stack canaries")
Cc: linux-stable <stable@vger.kernel.org> # v4.20
Reported-by: Samuel Holland <samuel@sholland.org>
Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Makefile |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -967,6 +967,7 @@ ifdef CONFIG_STACK_VALIDATION
   endif
 endif
 
+PHONY += prepare0
 
 ifeq ($(KBUILD_EXTMOD),)
 core-y		+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/
@@ -1075,8 +1076,7 @@ scripts: scripts_basic scripts_dtc asm-g
 # archprepare is used in arch Makefiles and when processed asm symlink,
 # version.h and scripts_basic is processed / created.
 
-# Listed in dependency order
-PHONY += prepare archprepare prepare0 prepare1 prepare2 prepare3
+PHONY += prepare archprepare prepare1 prepare2 prepare3
 
 # prepare3 is used to check if we are building in a separate output directory,
 # and if so do:


