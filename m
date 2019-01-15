Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A102C43612
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A982085A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="cc/+VoBv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfAOHVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 02:21:08 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:46279 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfAOHVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 02:21:07 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x0F7JTTt025896;
        Tue, 15 Jan 2019 16:19:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x0F7JTTt025896
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547536770;
        bh=08AbJJ8hBVDBXX2UF9mFjcRwzLGQ7QhyPVH8V6BPlIc=;
        h=From:To:Cc:Subject:Date:From;
        b=cc/+VoBvxW4OZPcv2ix8I5JuxXptMd/3lF5mNIh5YELemVL1guzdqCSdqtZ1o8t9/
         bi56yFu2Q+LvL4cacgvMAfVg6bFOseR4SJ9XDvvBb/Uynov0dsdYpZueuMekdaKJMK
         VE2zw6LIg/Rn1xzkzIhTAZCmRi42bi2NiOPEfDo9HkI+xI23PgEEWhE+nbVwU3fdbO
         jg3bnzwB25WmVBN5NVJQcb4yxrnl8TDXDlXEGPRrV2QZ5Y+AnGzOOPJMSFqUN/QDgr
         PTgg3eRb6Og435J+KADBC8w+QfjAS1U7EuAmPjMpJib1PA4t3YMT4JI8IVMcggQr6C
         dahgHqucL4exg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Samuel Holland <samuel@sholland.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-stable # v4 . 20" <stable@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: mark prepare0 as PHONY to fix external module build
Date:   Tue, 15 Jan 2019 16:19:00 +0900
Message-Id: <1547536740-1572-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c3ff2a5193fa ("powerpc/32: add stack protector support")
caused kernel panic on PowerPC if an external module is used with
CONFIG_STACKPROTECTOR because the 'prepare' target was not executed
for the external module build.

Commit e07db28eea38 ("kbuild: fix single target build for external
module") turned it into a build error because the 'prepare' target is
now executed but the 'prepare0' target is missing for the external
module build.

External module on arm/arm64 with CONFIG_STACKPROTECTOR_PER_TASK is
also broken in the same way.

Move 'PHONY += prepare0' to the common place. Make is fine with missing
rule for phony targets.

I minimize the change so it can be easily backported to 4.20.x

To fix v4.20 for external modules of PowerPC, please backport
e07db28eea38 ("kbuild: fix single target build for external module"),
and then this commit.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=201891
Fixes: e07db28eea38 ("kbuild: fix single target build for external module")
Fixes: c3ff2a5193fa ("powerpc/32: add stack protector support")
Fixes: 189af4657186 ("ARM: smp: add support for per-task stack canaries")
Fixes: 0a1213fa7432 ("arm64: enable per-task stack canaries")
Cc: linux-stable <stable@vger.kernel.org> # v4.20
Reported-by: Samuel Holland <samuel@sholland.org>
Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 499b968..789b332 100644
--- a/Makefile
+++ b/Makefile
@@ -955,6 +955,7 @@ ifdef CONFIG_STACK_VALIDATION
   endif
 endif
 
+PHONY += prepare0
 
 ifeq ($(KBUILD_EXTMOD),)
 core-y		+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/
@@ -1061,8 +1062,7 @@ scripts: scripts_basic scripts_dtc
 # archprepare is used in arch Makefiles and when processed asm symlink,
 # version.h and scripts_basic is processed / created.
 
-# Listed in dependency order
-PHONY += prepare archprepare prepare0 prepare1 prepare2 prepare3
+PHONY += prepare archprepare prepare1 prepare2 prepare3
 
 # prepare3 is used to check if we are building in a separate output directory,
 # and if so do:
-- 
2.7.4

