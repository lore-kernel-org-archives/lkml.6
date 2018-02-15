Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227ya2Ib0IBNFc5iNcUPwUSKhxg9eSgxu99gB1lXWNI9pGk2x8OH7oSYjKrllVGf5F8A2B9G
ARC-Seal: i=1; a=rsa-sha256; t=1518709349; cv=none;
        d=google.com; s=arc-20160816;
        b=r3tVeEH/xvKfCyGA4aotvBoLv+lIlKvAHw7WtryHYd3tD+lSCoSY98zBciWrXDR4gn
         n2UPlEvgTPa9bshxGZvlyzVOI6JJmuXe8WMoWZSODakcotyS5MjWAX1y9mkuIABo/CLv
         gr5ocSdc8cKOexuaUBVQx58Bu8lYtPQIZo5qXH+kftvKioWTTNzLPEvJXEfgQUG0vZbk
         U6G6K+9CGSwX27Zu/5GWrCi51R5SVCqJyy6hz7l8zkvLB045XtxNJnSD80egeHgJ2+En
         UGuwuQovOlbOqCC4db6IBJT2vgutLnUE7SXJ/OJJh8nwonYCF/uCOlVrUrUmDvbOZmuW
         Gq4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gsXLJhbDk6T0h4U20cW0wXUv48IuG4nRd5bRXL2GEtg=;
        b=wJ2u89/q4b6Ls6dtZYTxtfT8U1OpanfkhD+1rkxsrkUYv60RX2123BNSajQ32SUunJ
         om7cGX7ITWLp8z+gv+3d1P6fXcogILJy9dVul7aSUJkVT4b55ggZrxQJ12R2THnHTyAC
         bg1pscEANQkfMXxjjO8RCltFyAcPC0pmaIACugh0o5uIw5KeTgCSWRJ09r2tf9x2cS6U
         sDU2x+b03PYaaj/nX7l3abr5tm5rk3IyzQT1uWQ+irKPck3Iygtk2AD/G+ueYLxi05H2
         82uB6TaDmnA/B0eLlIzwUsChUHREEXGYGpS8tocIkrTT9EjKC6BxSDo5g7pF0i25PcBi
         1OXQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.15 050/202] [Variant 1/Spectre-v1] arm64: Implement array_index_mask_nospec()
Date: Thu, 15 Feb 2018 16:15:50 +0100
Message-Id: <20180215151715.832275307@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481517842010608?=
X-GMAIL-MSGID: =?utf-8?q?1592482174797298507?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robin Murphy <robin.murphy@arm.com>


Commit 022620eed3d0 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/barrier.h |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -41,6 +41,27 @@
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
