Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id t/6dGY4jGlvCYwAAmS7hNA
	; Fri, 08 Jun 2018 06:34:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 56331607E4; Fri,  8 Jun 2018 06:34:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C2B3160275;
	Fri,  8 Jun 2018 06:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C2B3160275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751604AbeFHGev (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 02:34:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:60498 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751276AbeFHGet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 02:34:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B8EFDAEC4;
        Fri,  8 Jun 2018 06:34:48 +0000 (UTC)
From: Miroslav Benes <mbenes@suse.cz>
To: keescook@chromium.org
Cc: linux@rasmusvillemoes.dk, luc.vanoostenryck@gmail.com,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH] compiler-gcc.h: don't set COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW for sparse
Date: Fri,  8 Jun 2018 08:34:41 +0200
Message-Id: <20180608063441.8562-1-mbenes@suse.cz>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <CAGXu5j+XFR7BtYPU6G4CeLFREWevN+GC1FPX1hPAYA1LRBM9Bg@mail.gmail.com>
References: <CAGXu5j+XFR7BtYPU6G4CeLFREWevN+GC1FPX1hPAYA1LRBM9Bg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse errors out with

./include/linux/overflow.h:254:13: error: undefined identifier '__builtin_mul_overflow'
./include/linux/overflow.h:254:13: error: incorrect type in conditional
./include/linux/overflow.h:254:13:    got void
./include/linux/overflow.h:256:13: error: undefined identifier '__builtin_add_overflow'
./include/linux/overflow.h:256:13: error: incorrect type in conditional
./include/linux/overflow.h:256:13:    got void

Sparse has not acquired generic overflow builtins yet, so don't set
COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW for it.

Signed-off-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/compiler-gcc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index f1a7492a5cc8..15e55b89e952 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -344,6 +344,6 @@
  */
 #define uninitialized_var(x) x = x
 
-#if GCC_VERSION >= 50100
+#if GCC_VERSION >= 50100 && !defined(__CHECKER__)
 #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
 #endif
-- 
2.17.0
