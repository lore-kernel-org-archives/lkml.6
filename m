Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9CDC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9C82087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wnkJ+PWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9C82087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbeJEEkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:40:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726570AbeJEEkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:40:24 -0400
Received: from localhost (unknown [198.217.64.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5DE52084D;
        Thu,  4 Oct 2018 21:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538689506;
        bh=TBDH52oXLGpbJqeoXn5KDMMnjVm25f9U8ZQrhDPkHIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=wnkJ+PWMIALHGow8GbHnMYmEUTkxwN6wjE6ivi9zP7KqXilyyzRzIYatZAA1TJNiJ
         Z4mNGXzh8fRi8fY6jgSSLeFe3NBjc4ZeIqpYEjwpIGfTfyPD+IqzSgcRRPD0UF26gA
         ol8c/o0I1t7HIRjZZFIyP8rJfUTcc0vYXbRL1EVE=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 1/3] x86/vdso: Remove "memory" clobbers in the vDSO syscall fallbacks
Date:   Thu,  4 Oct 2018 14:44:43 -0700
Message-Id: <3a7438f5fb2422ed881683d2ccffd7f987b2dc44.1538689401.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1538689401.git.luto@kernel.org>
References: <cover.1538689401.git.luto@kernel.org>
In-Reply-To: <cover.1538689401.git.luto@kernel.org>
References: <cover.1538689401.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a vDSO clock function falls back to the syscall, no special
barriers or ordering is needed, and the syscall fallbacks don't
clobber any memory that is not explicitly listed in the asm
constraints.  Remove the "memory" clobber.

This causes minor changes to the generated code, but otherwise has
no obvious performance impact.  I think it's nice to have, though,
since it may help the optimizer in the future.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/vdso/vclock_gettime.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index b7ccbff26a3f..18c8a78d1ec9 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -45,7 +45,7 @@ notrace static long vdso_fallback_gettime(long clock, struct timespec *ts)
 	long ret;
 	asm ("syscall" : "=a" (ret), "=m" (*ts) :
 	     "0" (__NR_clock_gettime), "D" (clock), "S" (ts) :
-	     "memory", "rcx", "r11");
+	     "rcx", "r11");
 	return ret;
 }
 
@@ -62,7 +62,7 @@ notrace static long vdso_fallback_gettime(long clock, struct timespec *ts)
 		"mov %%edx, %%ebx \n"
 		: "=a" (ret), "=m" (*ts)
 		: "0" (__NR_clock_gettime), [clock] "g" (clock), "c" (ts)
-		: "memory", "edx");
+		: "edx");
 	return ret;
 }
 
-- 
2.17.1

