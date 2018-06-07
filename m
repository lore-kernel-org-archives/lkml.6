Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Xmj/KXlFGVsvIAAAmS7hNA
	; Thu, 07 Jun 2018 14:47:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4FF006089E; Thu,  7 Jun 2018 14:47:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id AAA7A602FC;
	Thu,  7 Jun 2018 14:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AAA7A602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934962AbeFGOr2 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:47:28 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40804 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932741AbeFGOrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:47:25 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvba-0005a0-Ia; Thu, 07 Jun 2018 15:09:34 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb8-00035J-IV; Thu, 07 Jun 2018 15:09:06 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Borislav Petkov" <bp@alien8.de>,
        "Andy Lutomirski" <luto@kernel.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        "Will Deacon" <will.deacon@arm.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Arjan van de Ven" <arjan@linux.intel.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.465767219@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 258/410] nospec: Allow index argument to have
 const-qualified type
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

commit b98c6a160a057d5686a8c54c79cc6c8c94a7d0c8 upstream.

The last expression in a statement expression need not be a bare
variable, quoting gcc docs

  The last thing in the compound statement should be an expression
  followed by a semicolon; the value of this subexpression serves as the
  value of the entire construct.

and we already use that in e.g. the min/max macros which end with a
ternary expression.

This way, we can allow index to have const-qualified type, which will in
some cases avoid the need for introducing a local copy of index of
non-const qualified type. That, in turn, can prevent readers not
familiar with the internals of array_index_nospec from wondering about
the seemingly redundant extra variable, and I think that's worthwhile
considering how confusing the whole _nospec business is.

The expression _i&_mask has type unsigned long (since that is the type
of _mask, and the BUILD_BUG_ONs guarantee that _i will get promoted to
that), so in order not to change the type of the whole expression, add
a cast back to typeof(_i).

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org
Link: http://lkml.kernel.org/r/151881604837.17395.10812767547837568328.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/nospec.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -53,7 +53,6 @@ static inline unsigned long array_index_
 	BUILD_BUG_ON(sizeof(_i) > sizeof(long));			\
 	BUILD_BUG_ON(sizeof(_s) > sizeof(long));			\
 									\
-	_i &= _mask;							\
-	_i;								\
+	(typeof(_i)) (_i & _mask);					\
 })
 #endif /* _LINUX_NOSPEC_H */
