Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D08C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED7520870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676414;
	bh=hPz2H1LwqxCSB1L1gFS7ypqMj4GpL2hKfbGsuxsllpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dhShypVRKolvJuIpuRswPluLwzNFKd6EA7M9eMOXp/W9x8+m9eQfPUvGriVjrW4nC
	 GbCbWtZi6BTpUgiKCsUfspNkZAO/ac+ylnw9hKVYpGHnkCnwSLBMwEcL6TPtai9iXN
	 mnwWozktwVVEIlPFkBqSEmKEjWe4a8zyjE+07ty0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED7520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbeLMEqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:46:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:43360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728271AbeLMEaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:30:30 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91E5520880;
        Thu, 13 Dec 2018 04:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675429;
        bh=hPz2H1LwqxCSB1L1gFS7ypqMj4GpL2hKfbGsuxsllpo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LfMUTZH2WzTwUPTzgOf21W0MR0BJn9v8NPuO6S4oEYSOfLC00o9EDvbpal2q8d7Q5
         m7py4c0wC5+11ujKHO73AuAByvKaGnPcmtO478tH2TNJOuj6z8nI/rhRtpvCKt9juk
         Qj2eba5Jm+4jIiXirgIo1sDdfuB3mI33ZDkN2ZfU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 58/73] x86/build: Fix compiler support check for CONFIG_RETPOLINE
Date:   Wed, 12 Dec 2018 23:28:23 -0500
Message-Id: <20181213042838.75160-58-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit 25896d073d8a0403b07e6dec56f58e6c33678207 ]

It is troublesome to add a diagnostic like this to the Makefile
parse stage because the top-level Makefile could be parsed with
a stale include/config/auto.conf.

Once you are hit by the error about non-retpoline compiler, the
compilation still breaks even after disabling CONFIG_RETPOLINE.

The easiest fix is to move this check to the "archprepare" like
this commit did:

  829fe4aa9ac1 ("x86: Allow generating user-space headers without a compiler")

Reported-by: Meelis Roos <mroos@linux.ee>
Tested-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Fixes: 4cd24de3a098 ("x86/retpoline: Make CONFIG_RETPOLINE depend on compiler support")
Link: http://lkml.kernel.org/r/1543991239-18476-1-git-send-email-yamada.masahiro@socionext.com
Link: https://lkml.org/lkml/2018/12/4/206
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/Makefile | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 9298f0f3817a..b84f61bc5e7a 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -223,9 +223,6 @@ KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 
 # Avoid indirect branches in kernel to deal with Spectre
 ifdef CONFIG_RETPOLINE
-ifeq ($(RETPOLINE_CFLAGS),)
-  $(error You are building kernel with non-retpoline compiler, please update your compiler.)
-endif
   KBUILD_CFLAGS += $(RETPOLINE_CFLAGS)
 endif
 
@@ -303,6 +300,13 @@ ifndef CC_HAVE_ASM_GOTO
 	@echo Compiler lacks asm-goto support.
 	@exit 1
 endif
+ifdef CONFIG_RETPOLINE
+ifeq ($(RETPOLINE_CFLAGS),)
+	@echo "You are building kernel with non-retpoline compiler." >&2
+	@echo "Please update your compiler." >&2
+	@false
+endif
+endif
 
 archclean:
 	$(Q)rm -rf $(objtree)/arch/i386
-- 
2.19.1

