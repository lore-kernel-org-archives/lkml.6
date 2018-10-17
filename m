Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A5EECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F9321473
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="WhyZKqL5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F9321473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbeJRGb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:31:29 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40094 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeJRGb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:31:29 -0400
Received: by mail-ed1-f65.google.com with SMTP id r1-v6so26424475edd.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 15:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AundlnETdPac4xvhDRjsgdvex9/IrvteaWUKjQaagI8=;
        b=WhyZKqL5GSkwgjXT/n6/DYhgKBRBrTBSYx451s9YR1lOCkYjDX/c3sGtACdYVlc4iV
         YNbbS9rMX4xKykZiUGmJDFvIIA9fF8c8ZrnlwkaM//Gt6FnN/6satXyKQxwquEixn0og
         nX5DZhc7tEy9VJuoH7H8G1QnEsIkTF7pIsZ7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AundlnETdPac4xvhDRjsgdvex9/IrvteaWUKjQaagI8=;
        b=sq3bcilHhdJjtr+zcXc138cIjJOOYEQ31eR6trsY/7MyuK+I7r2oUBuxVLCTy1IhMJ
         5GQ/RzuSHJ0p7vIFmE3E9YvQ+IOaeAnYM5wLJ1XLBrvFZj7JWYVH9qa4kRkch9wsD3Fl
         I88AZmfseF+cVazfrDTVtPIPcyuQFsNK1zVukqrfjowUAz3Josbv2Z11SNUqTAlaRI9t
         KmyKkbL9ka99G8yTme1U8JVRmLsuKtfi4Njf1aHxiYU20JAw5yCHT1ZQih0h7eBCVbgS
         tQV14C7ubO0igWRhuF2S9Ia4rvWSTdmDJMEJ669VQfHI98e6NKdrLcn3EQKbu4fnzrkY
         a+qw==
X-Gm-Message-State: ABuFfoggYKiMDQESOyCnbLdBalwEnK+smwcYZ/ejJhCzCXINCS0gplL6
        nKo3s3n8cBl9E6SPU5rO2D72JT66/ms=
X-Google-Smtp-Source: ACcGV62+HUziUWgOSdlfYrLsVeBArDmWkH2BE7xrWET/27TShlfutY2aqJLjXsRvDJDiY61CSeN9JA==
X-Received: by 2002:a50:94d2:: with SMTP id t18-v6mr1781442eda.86.1539815619711;
        Wed, 17 Oct 2018 15:33:39 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id e30-v6sm7001555edd.25.2018.10.17.15.33.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Oct 2018 15:33:39 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [POC 01/12] Accessing __ro_after_init variables as immediates
Date:   Thu, 18 Oct 2018 00:33:21 +0200
Message-Id: <20181017223332.11964-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[This is on top of 58d20fcbd005 "Merge branch 'x86/grub2'" from the -tip
tree, to have the macros.S mechanism available].

One can replace various uses of variables that are initialized at init
and then never changed, so that the code never actually loads the
variable from memory. Instead, the value of the variable gets encoded as
an immediate operand. For example, many code paths do something like

  p = kmem_cache_alloc(foo_cachep, GFP_KERNEL)

where foo_cachep is some global variable that is set in an init
function. The theory is that one can avoid the cost of a D$ miss by
having the cpu load the value of foo_cachep directly into %rdi from the
instruction stream. There's no way around the I$ cost of running a piece
of code.

For system hash tables there are typically two __ro_after_init variables
in play, the base and either a shift (e.g. dcache) or a
mask (e.g. futex). In both cases, one can implement the entire
computation of the relevant hash bucket using just the hash value as
input.

For now, this just aims at giving a POC implementation of the above
access patterns for x86-64, but one can rather easily identify other
patterns one might want to support. For example, pgdir_shift could give
rise to implementing rai_shl() and rai_shr(), and rai_and() is also an
obvious candidate.

Going a bit further, and no longer restricting to __ro_after_init
variables, one can imagine implementing rai_gt(), rai_leq() etc. via asm
goto, to allow comparisons to sysctl limits. But while that might be
able to reuse some of this infrastructure, one would need some way to
trigger (another) .text update from the sysctl handler.

I'm not enforcing that referenced variables are actually
__ro_after_init, partly because many of the obvious subjects are merely
__read_mostly, partly to be able to change some test variables
deliberately and see that the rai_load still returns the initial value.

The prefix rai_ is probably awful, but seemed to be an available
three-letter acronym. Suggestions for better naming are much welcome.

Implementation-wise, each access to a rai variable that should be
patched shortly after init needs to be annotated using one of the rai_*
macros. Doing anything more automatic would likely require a gcc plugin,
and I'm not sure all read accesses to rai variables from non-init code
should necessarily be patched. I'd really like kmalloc(128, GFP_KERNEL)
to do a rai_load() of the appropriate kmalloc cache, but it's likely one runs
into some __builtin_constant_p trouble.

At each such access, we create four pieces of data: A template with the
right instructions for patching in, but with dummy immediates; a thunk
which may be slow and stupid, but which computes the correct result
until patching is done (and which is also used as an int3 handler), and
which is careful not to clobber any registers; a short piece of .text
that simply jumps to the thunk, plus nops to make room for the full
template; and finally a struct describing the type of access, the
variables involved and where to find the template, thunk and instruction
to be patched. I'm sure some of this metadata can eventually be
discarded with __initdata, but for now I'm just keeping it simple. It's
not a big deal when there's only a handful of core users, but if the
kmalloc() thing gets implemented, we're going to have lots more
rai_entry's.

I have no idea how to benchmark this, or if it is worth it at all. Any
micro-benchmark would probably just keep the variable in L1 cache, but
if one accesses the variable sufficiently rarely that it's no longer in
L1, that extra cache miss is hardly noticable.

Comments? Flames?

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/rai.h | 83 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 include/linux/rai.h

diff --git a/include/linux/rai.h b/include/linux/rai.h
new file mode 100644
index 000000000000..e839454000ee
--- /dev/null
+++ b/include/linux/rai.h
@@ -0,0 +1,83 @@
+#ifndef _LINUX_RAI_H
+#define _LINUX_RAI_H
+
+/*
+ * These document the behaviour any arch implementation of _rai_*
+ * should have, and can be used by those in cases the arch does not
+ * want to handle (e.g. _rai_load of a 2-byte quantity).
+ */
+#define _rai_load_fallback(var)                       (var)
+#define _rai_bucket_shift_fallback(base, shift, hash) (&(base)[(hash) >> (shift)])
+#define _rai_bucket_mask_fallback(base, mask, hash)   (&(base)[(hash) & (mask)])
+
+#ifdef CONFIG_ARCH_HAS_RAI
+#include <asm/rai.h>
+void update_rai_access(void);
+#else
+static inline void update_rai_access(void) {}
+#endif
+
+#ifdef MODULE /* don't bother with modules for now */
+#undef _rai_load
+#undef _rai_bucket_shift
+#undef _rai_bucket_mask
+#endif
+
+/* Make sure all _rai_* are defined. */
+#ifndef _rai_load
+#define _rai_load _rai_load_fallback
+#endif
+#ifndef _rai_bucket_shift
+#define _rai_bucket_shift _rai_bucket_shift_fallback
+#endif
+#ifndef _rai_bucket_mask
+#define _rai_bucket_mask _rai_bucket_mask_fallback
+#endif
+
+
+/* 
+ * The non-underscored rai_* are property of this header, so that it
+ * can do tricks like defining debugging versions. Usually, it just
+ * defines rai_foo as _rai_foo, with the latter being guaranteed to be
+ * defined by the above logic.
+ */
+#if defined(CONFIG_RAI_DEBUG)
+
+#include <bug.h>
+
+#define rai_warn(what, expect, got)					\
+	WARN_ONCE(expect != got,					\
+		  "%s:%d: %s() returned %*phN, expected %*phN\n",	\
+		  __FILE__, __LINE__, what,				\
+		  (int)sizeof(got), &(got),				\
+		  (int)sizeof(expect), &(expect))
+
+#define rai_load(var) ({						\
+		typeof(var) v1 = _rai_load_fallback(var);		\
+		typeof(var) v2 = _rai_load(var);			\
+		rai_warn("rai_load", v1, v2);				\
+		(v1); /* chicken */					\
+	})
+
+#define rai_bucket_shift(base, shift, hash) ({				\
+		typeof(hash) h = (hash);				\
+		typeof(base) b1 = _rai_bucket_shift_fallback(base, shift, h); \
+		typeof(base) b2 = _rai_bucket_shift(base, shift, h);	\
+		rai_warn("rai_bucket_shift", b1, b2);			\
+		(b1);							\
+	})
+
+#define rai_bucket_mask(base, mask, hash) ({				\
+		typeof(hash) h = (hash);				\
+		typeof(base) b1 = _rai_bucket_mask_fallback(base, mask, h); \
+		typeof(base) b2 = _rai_bucket_mask(base, mask, h);	\
+		rai_warn("rai_bucket_mask", b1, b2);			\
+		(b1);							\
+	})
+#else
+#define rai_load         _rai_load
+#define rai_bucket_shift _rai_bucket_shift
+#define rai_bucket_mask  _rai_bucket_mask
+#endif
+
+#endif /* _LINUX_RAI_H */
-- 
2.19.1.6.gbde171bbf5

