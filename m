Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC4BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBE721852
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297964;
	bh=Xd9jrPcYoD6gZGjraHBZjuqPZkA04GlDsG8yVsXw66w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pA0GB5Huau1L/lDJnqI4ndQTo4QsTKvl5FNiz1J3fdiOFDhjhXIYTJacMJGOQyIPt
	 FjGa/r2KfnJWv34N2kZYYlYRB8e/zTmStRCG20dwvXErvoA2h6gRjPkqF4ZLXsIzlb
	 AeinOzaQ4zdyVihqujA5HAfKJQoGFDFakr5h6TDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732027AbeLTJ0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:26:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:50300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732016AbeLTJZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:25:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6115220656;
        Thu, 20 Dec 2018 09:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297959;
        bh=Xd9jrPcYoD6gZGjraHBZjuqPZkA04GlDsG8yVsXw66w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aeOfgnMZeiqP6jG9q1oG7usThdUhkT+4zU+Ro+plTkPbmQ9OPvCK7E5RaFYox3eSN
         2M55P28e6SUY22dUQBKaignTeyw+7Q+/kURgOxIqRR5zSt/JR5dYwF4+Q01cfmtzg2
         fiEar5dQAue5GxEbXkFze1HDo2zYteaXAMo5gE80=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Meelis Roos <mroos@linux.ee>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Gi-Oh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCH 4.14 19/72] x86/build: Fix compiler support check for CONFIG_RETPOLINE
Date:   Thu, 20 Dec 2018 10:18:18 +0100
Message-Id: <20181220085923.092006934@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085922.332225035@linuxfoundation.org>
References: <20181220085922.332225035@linuxfoundation.org>
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

From: Masahiro Yamada <yamada.masahiro@socionext.com>

commit 25896d073d8a0403b07e6dec56f58e6c33678207 upstream.

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
Cc: Gi-Oh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/Makefile |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -241,9 +241,6 @@ KBUILD_CFLAGS += -fno-asynchronous-unwin
 
 # Avoid indirect branches in kernel to deal with Spectre
 ifdef CONFIG_RETPOLINE
-ifeq ($(RETPOLINE_CFLAGS),)
-  $(error You are building kernel with non-retpoline compiler, please update your compiler.)
-endif
   KBUILD_CFLAGS += $(RETPOLINE_CFLAGS)
 endif
 
@@ -260,6 +257,13 @@ archprepare:
 ifeq ($(CONFIG_KEXEC_FILE),y)
 	$(Q)$(MAKE) $(build)=arch/x86/purgatory arch/x86/purgatory/kexec-purgatory.c
 endif
+ifdef CONFIG_RETPOLINE
+ifeq ($(RETPOLINE_CFLAGS),)
+	@echo "You are building kernel with non-retpoline compiler." >&2
+	@echo "Please update your compiler." >&2
+	@false
+endif
+endif
 
 ###
 # Kernel objects


