Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+OtVVsuRuXNflkR1wUAOcyqZgIm3NQynHq2vUfFvYXT/U/6DWfcJlB9nkRCTnrvILgA3lq
ARC-Seal: i=1; a=rsa-sha256; t=1523981289; cv=none;
        d=google.com; s=arc-20160816;
        b=PMvklK0WpvGONFAkryQlLDdS8F6osp8WtNXmyPTB5Y9r9aT77AfAACKeASOGadW5Be
         2PQ2s3ANENdANJjOV6BPSfMaX1QieXkEnsL+lsKRG8u3ON/PKV/7QmK5y0dhDhsL/AJY
         OFOdZP32OUcD2AFuh/36ZSXLAENayJ79pPZ6abHIUvBjDRUJimu8k2wuX6IPPMxGykl9
         adiw7T8dbQSepcXxwaqtepn+MOvz2DjdyvXIMXKfdWvmg5khcYQmUi2B3nBZMOheh/Ob
         9Wdg0gbkZDFz10rg2yr39rOIlE/LCdt0Nw/epyNL6fTWEMzULh3yW0qmWiimCG6Dfn5u
         7wOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MC4vd2Zb6FgIfLvCgpjSCfeSSnk/At+Rb5zcOG+WLkY=;
        b=VwHGtOoSh+vKm5IMYDrNeyVSdwKzu60K7Qg47la5/wUfS7cycID91JWx9wr3euD4QM
         jForbG6RxqNYxK75I2R7c9e6WDZQ8l2CtaaFxSsh/fvlza1ZICBbnkUDdhQjSRzROweP
         Dsmvkgfnx4Kv2b2Yj3Ue5ljTpLj2mp3MdIt87Lc7PeqLPtcML9vEhKC/r8rlwIb2AaEs
         fqT4IwQ54nOQkw7A1GB048JDEy7J2U/LnU8jFSFHPhNA1gVMcnOx0QWN4gG//axt6gX4
         QqRv4iAh7+IAM5ZLy002CaDnRo0CjB0UH9xUvaqIaSwa+/CXpF34P9exlOylfnDkGn8N
         I65g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Greg Hackmann <ghackmann@google.com>
Subject: [PATCH 4.9 11/66] arm64: Implement array_index_mask_nospec()
Date: Tue, 17 Apr 2018 17:58:44 +0200
Message-Id: <20180417155646.325304070@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598010204368381214?=
X-GMAIL-MSGID: =?utf-8?q?1598010204368381214?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>


From: Robin Murphy <robin.murphy@arm.com>

commit 022620eed3d0bc4bf2027326f599f5ad71c2ea3f upstream.

Provide an optimised, assembly implementation of array_index_mask_nospec()
for arm64 so that the compiler is not in a position to transform the code
in ways which affect its ability to inhibit speculation (e.g. by introducing
conditional branches).

This is similar to the sequence used by x86, modulo architectural differences
in the carry/borrow flags.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/barrier.h |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -40,6 +40,27 @@
 #define dma_rmb()	dmb(oshld)
 #define dma_wmb()	dmb(oshst)
 
+/*
+ * Generate a mask for array_index__nospec() that is ~0UL when 0 <= idx < sz
+ * and 0 otherwise.
+ */
+#define array_index_mask_nospec array_index_mask_nospec
+static inline unsigned long array_index_mask_nospec(unsigned long idx,
+						    unsigned long sz)
+{
+	unsigned long mask;
+
+	asm volatile(
+	"	cmp	%1, %2\n"
+	"	sbc	%0, xzr, xzr\n"
+	: "=r" (mask)
+	: "r" (idx), "Ir" (sz)
+	: "cc");
+
+	csdb();
+	return mask;
+}
+
 #define __smp_mb()	dmb(ish)
 #define __smp_rmb()	dmb(ishld)
 #define __smp_wmb()	dmb(ishst)
