Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id FDnfCDcQGVuDFwAAmS7hNA
	; Thu, 07 Jun 2018 11:01:31 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2BB78608CD; Thu,  7 Jun 2018 11:01:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A1BCD60115;
	Thu,  7 Jun 2018 11:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A1BCD60115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753601AbeFGLB3 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 07:01:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:36273 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751974AbeFGLB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 07:01:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2A51AAC3A;
        Thu,  7 Jun 2018 11:01:26 +0000 (UTC)
Date: Thu, 7 Jun 2018 13:01:25 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: keescook@chromium.org
cc: linux-kernel@vger.kernel.org
Subject: sparse warnings in overflow.h
Message-ID: <alpine.LSU.2.21.1806071258310.7958@pobox.suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Kees,

sparse (make C=1) gives me this warnings today...

./include/linux/overflow.h:254:13: error: undefined identifier '__builtin_mul_overflow'
./include/linux/overflow.h:254:13: error: incorrect type in conditional
./include/linux/overflow.h:254:13:    got void
./include/linux/overflow.h:256:13: error: undefined identifier '__builtin_add_overflow'
./include/linux/overflow.h:256:13: error: incorrect type in conditional
./include/linux/overflow.h:256:13:    got void

This hunk obviously fixes it, but I'm really not sure if it is a proper 
fix.

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

Any idea?

Regards,
Miroslav
