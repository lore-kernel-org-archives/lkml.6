Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7396ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C3F21477
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Air49CyY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C3F21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbeJRGbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:31:40 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:38007 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbeJRGbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:31:38 -0400
Received: by mail-ed1-f48.google.com with SMTP id c1-v6so26418661ede.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 15:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eyynqJuJVIWno7SP4WJLk1vGE9NWCrid9lrnLL31ZdU=;
        b=Air49CyY9Fx9HQvay4WiPUJNXIBmiZjast9GXtRMPrBrZeywq7VzOn7CvTnafft14N
         E5FYERfsD1LyRiJxNgcua7nqQdbmGpAZyzxBHTLtYUkVQXRUNa9jcdN4VXxCbFa+PNAr
         EIFJK829gWqmNY5Xj0igF06UXP/NP5ntcoKmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eyynqJuJVIWno7SP4WJLk1vGE9NWCrid9lrnLL31ZdU=;
        b=QQ4iNujLk/M4WAj2uJuzorVQ8kIEv3xb1zqV0CByrDJXbYMyy0t+wAMKCSNgqhLtA6
         bwjUUDtGbIFujZPe9pzT+9bhUTyKLZ8D1wmAZ3iUQTJDcrSn06wQF/xG7MUVsjb82B2K
         wRjyRrFK7xm3u1sQDM6t5bioD5YEeqGGsol7ajdxAH9juYB/GcmFAD8a7X00e6ZSiFT/
         KCQWAoROpeLLSYXidKWXGSqWxHefYrZ2HDceoAVd15ay2y+25I3U9JFRwe/NHNGLJYMm
         9OV4zJxbpsZLkQq1iHFgY1WgcTnkNQm7TfvAihcQmeQ8o6aF8xEDFx5xq/yjdQSg3cCc
         +mvw==
X-Gm-Message-State: ABuFfohalbahFYRjHLnSJWRp+efQMKXnOQDYHxNABk4O/jayiIebkuqc
        swZ4vSPKDYcOcvFUo8M9mbQBzlJ07E0=
X-Google-Smtp-Source: ACcGV62WmlDr1ZHqtNrJx93vAv5G69jrYXRAyja1SXiWBPWz0dOdgMAsBnYuQBmJ2Qh5/3qChsu0vw==
X-Received: by 2002:a17:906:c28f:: with SMTP id r15-v6mr27442596ejz.188.1539815629769;
        Wed, 17 Oct 2018 15:33:49 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id e30-v6sm7001555edd.25.2018.10.17.15.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Oct 2018 15:33:49 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [POC 11/12] x86-64: implement _rai_bucket_shift
Date:   Thu, 18 Oct 2018 00:33:31 +0200
Message-Id: <20181017223332.11964-11-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181017223332.11964-1-linux@rasmusvillemoes.dk>
References: <20181017223332.11964-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only slightly tricky issue is that for implementing the thunk, we
need some temporary registers (with %ecx being one of them), and we
don't know whether the hash input and/or destination register collide
with whichever we choose. One _could_ attempt text parsing in asm in
order to find a safe set of temps, but they would need to be restored
anyway.

So instead, just pick %edx and %ecx, and start by pushing them on the
stack. Then compute the result we need, push that to the stack, restore
%edx and %ecx, and finally pop the result into the destination
register (which may be %rdx or %rcx or any other) and adjust the stack
pointer.

The patched code does need to do a shr, so I don't think there's a way
around the cc clobber.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/x86/include/asm/rai.S | 59 ++++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/rai.h | 21 +++++++++++++-
 arch/x86/kernel/rai.c      | 13 +++++++++
 3 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/rai.S b/arch/x86/include/asm/rai.S
index f42cdd8db876..144697e146b6 100644
--- a/arch/x86/include/asm/rai.S
+++ b/arch/x86/include/asm/rai.S
@@ -54,5 +54,64 @@
 	.popsection
 .endm /* rai_load */
 
+	/*
+	 * For convenience, and because it should not cause that much
+	 * worse code gen, we tie the hash to an output register, to
+	 * avoid it being given in the same register where we must
+	 * place the actual output. Since the hash output is unused,
+	 * gcc is free to pick that register for anything immediately
+	 * afterwards.
+	 */
+.macro rai_bucket_shift dst, hash, hashq, base, shift
+	.pushsection .rai_templ, "aw"
+10:	movabs $0x1234567812345678, \dst
+	/*
+	 * Actually, the hash output contains the shifted hash
+	 * value. But I don't think there's a way to inform gcc about
+	 * that, and I don't know how useful it would be anyway. So in
+	 * the thunk below, we don't do anything to have the same
+	 * property, though it would be doable.
+	 */
+	shr $6, \hash
+	lea (\dst, \hashq, 8), \dst
+11:
+	.popsection
+
+	.pushsection .text.rai_thunk, "ax"
+20:	/* dst and hash are registers, we can clobber hash */
+	push %rdx
+	push %rcx
+	mov \hash, %edx
+	mov \shift(%rip), %ecx
+	shr %cl,%edx
+	/* move the shifted value into \hash, so the below works regardless of whether \dst is %rdx or not */
+	mov %edx, \hash
+	mov \base(%rip), \dst
+	lea (\dst, \hashq, 8), \dst
+	/* We have our final value. */
+	push \dst
+	/* Now restore %rdx and %rcx, then finally restore \dst and adjust the stack pointer */
+	mov 0x8(%rsp), %rcx
+	mov 0x10(%rsp), %rdx
+	pop \dst
+	add $0x10, %rsp
+	jmp 32f
+21:
+	.popsection
+	/* The part that goes into .text */
+30:	jmp 20b
+31:	.skip -(((11b - 10b)-(31b - 30b)) > 0)*((11b - 10b)-(31b - 30b)), 0x90
+32:
+
+	.pushsection .rai_data, "a"
+40:
+	rai_entry RAI_BUCKET_SHIFT_8_4_4 30b 32b 10b 11b 20b
+	.quad \base   /* .bucket_shift.base_addr */
+	.quad \shift  /* .bucket_shift.shift_addr */
+41:
+	rai_entry_pad 40b 41b
+	.popsection
+.endm /* rai_bucket_shift */
+
 
 #endif
diff --git a/arch/x86/include/asm/rai.h b/arch/x86/include/asm/rai.h
index b57494c98d0f..c9726d1e40ed 100644
--- a/arch/x86/include/asm/rai.h
+++ b/arch/x86/include/asm/rai.h
@@ -3,8 +3,9 @@
 
 #define RAI_LOAD_4 0
 #define RAI_LOAD_8 1
+#define RAI_BUCKET_SHIFT_8_4_4 2
 
-#define STRUCT_RAI_ENTRY_SIZE 32
+#define STRUCT_RAI_ENTRY_SIZE 40
 
 /* Put the asm macros in a separate file for easier editing. */
 #include <asm/rai.S>
@@ -23,6 +24,10 @@ struct rai_entry {
 		struct {
 			void *addr;
 		} load;
+		struct {
+			void *base_addr;
+			void *shift_addr;
+		} bucket_shift;
 	};
 };
 _Static_assert(sizeof(struct rai_entry) == STRUCT_RAI_ENTRY_SIZE,
@@ -48,6 +53,20 @@ _Static_assert(sizeof(struct rai_entry) == STRUCT_RAI_ENTRY_SIZE,
 		ret__;							\
 	})
 
+#define _rai_bucket_shift(base, shift, hash) ({				\
+		typeof(base) ret__;					\
+		typeof(hash) unused__;					\
+		if (sizeof(*(base)) == 8 && sizeof(shift) == 4		\
+		    && sizeof(hash) == 4)				\
+			asm("rai_bucket_shift %0 %1 %q1 %c3 %c4"	\
+			    : "=r" (ret__), "=r" (unused__)		\
+			    : "1" (hash), "i" (&(base)), "i" (&(shift))	\
+			    : "cc");					\
+		else							\
+			ret__ = _rai_bucket_shift_fallback(base, shift, hash); \
+		ret__;							\
+	})
+
 #endif /* !__ASSEMBLY */
 
 #endif /* _ASM_X86_RAI_H */
diff --git a/arch/x86/kernel/rai.c b/arch/x86/kernel/rai.c
index c4284ce7478f..3aa2e3b2c31b 100644
--- a/arch/x86/kernel/rai.c
+++ b/arch/x86/kernel/rai.c
@@ -32,6 +32,19 @@ rai_patch_one(const struct rai_entry *r)
 		memcpy(templ + r->templ_len - sizeof(*imm), imm, sizeof(*imm));
 		break;
 	}
+	case RAI_BUCKET_SHIFT_8_4_4: {
+		const u32 *shiftp = r->bucket_shift.shift_addr;
+		const u64 *basep = r->bucket_shift.base_addr;
+		/*
+		 * This should be made more robust. For now, assume we
+		 * have a 10-byte movabs followed by a 3-byte shr. And
+		 * while *shiftp is 4 bytes wide, we just need the
+		 * LSB.
+		 */
+		memcpy(templ + 2, basep, sizeof(*basep));
+		memcpy(templ + 12, shiftp, 1);
+		break;
+	}
 	default:
 		WARN_ONCE(1, "unhandled RAI type %d\n", r->type);
 		return;
-- 
2.19.1.6.gbde171bbf5

