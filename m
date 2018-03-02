Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELswPnS31nrztq5cSWNgn97uYMRwlZ8Zd2l0J0NFp9Pu7rj2ZFNnr14oTHBPiozXLHls0HjM
ARC-Seal: i=1; a=rsa-sha256; t=1519981011; cv=none;
        d=google.com; s=arc-20160816;
        b=GOajtpPkPkKf8zWzv0LBFIH+iBCmkC59Kqvyn46kAaKWorxPpqcIUbOZIZevmtUi93
         digdMt32zj5wFiyeJbu+Dk9RNg8kRK/ZY/i3F3qTW6RrlbEV3F1nuRIVDNBeDLyafIJk
         v5Djl/7HBOQBVzeY0PpZg6/MyeV/5zmTnKG4rNSYU5mGbhJmEVUiXanfwHHVpafvn0Dx
         WKY2v9yW94WsAr1f7Y4i25ShKiv1xylxL3Q9uboiNi8ZpJwZC9+k379eWHKXbtjqtQ9w
         hVF1KO0rTHhGvolNJ4L6RO6qcWHXK0z4A2pNSqq7OQFIN6nh97jhisrywOI4o1BGpiBT
         2lzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pHMDeFVSsaOFNbja8Mtot7EzRuguNl2m4syWloIqTsQ=;
        b=tnWemx9FaOvO+RAhSa/KM/BBBNN0NNEHBnT1qCzVxuE+ZVEE6ZrqO1LsJJyE5ZwFb+
         VfWzz2wuk317HcGWvGYnNafP8rSCGA52uVFD28zgm0ljXyTFNvHjRgSkGmsxS6uphRLI
         1cNjqxkQG+SkCwdr1coL/37p8nruXo7/KEoB+nvI0BdxsiPBjc3saUDrLWcyLbmqgdO/
         lNNC9o/C6UfCt/MIaETnVDPwqMK0sN20dfBLtNnAPcZ893Sg9uKeUjEmTdTthjaGEa+K
         FWozAMq1kvHF4+8R7tn2j5TeWMFAB/T3eIqubS4OKaTR+H8+GYM04WbUPNNVixWneKy3
         x7AQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	James Hogan <jhogan@kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-mips@linux-mips.org,
	linux-crypto@vger.kernel.org,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 24/56] lib/mpi: Fix umul_ppmm() for MIPS64r6
Date: Fri,  2 Mar 2018 09:51:10 +0100
Message-Id: <20180302084450.814588166@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815446124575806?=
X-GMAIL-MSGID: =?utf-8?q?1593815608716694065?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <jhogan@kernel.org>


[ Upstream commit bbc25bee37d2b32cf3a1fab9195b6da3a185614a ]

Current MIPS64r6 toolchains aren't able to generate efficient
DMULU/DMUHU based code for the C implementation of umul_ppmm(), which
performs an unsigned 64 x 64 bit multiply and returns the upper and
lower 64-bit halves of the 128-bit result. Instead it widens the 64-bit
inputs to 128-bits and emits a __multi3 intrinsic call to perform a 128
x 128 multiply. This is both inefficient, and it results in a link error
since we don't include __multi3 in MIPS linux.

For example commit 90a53e4432b1 ("cfg80211: implement regdb signature
checking") merged in v4.15-rc1 recently broke the 64r6_defconfig and
64r6el_defconfig builds by indirectly selecting MPILIB. The same build
errors can be reproduced on older kernels by enabling e.g. CRYPTO_RSA:

lib/mpi/generic_mpih-mul1.o: In function `mpihelp_mul_1':
lib/mpi/generic_mpih-mul1.c:50: undefined reference to `__multi3'
lib/mpi/generic_mpih-mul2.o: In function `mpihelp_addmul_1':
lib/mpi/generic_mpih-mul2.c:49: undefined reference to `__multi3'
lib/mpi/generic_mpih-mul3.o: In function `mpihelp_submul_1':
lib/mpi/generic_mpih-mul3.c:49: undefined reference to `__multi3'
lib/mpi/mpih-div.o In function `mpihelp_divrem':
lib/mpi/mpih-div.c:205: undefined reference to `__multi3'
lib/mpi/mpih-div.c:142: undefined reference to `__multi3'

Therefore add an efficient MIPS64r6 implementation of umul_ppmm() using
inline assembly and the DMULU/DMUHU instructions, to prevent __multi3
calls being emitted.

Fixes: 7fd08ca58ae6 ("MIPS: Add build support for the MIPS R6 ISA")
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-mips@linux-mips.org
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/mpi/longlong.h |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

--- a/lib/mpi/longlong.h
+++ b/lib/mpi/longlong.h
@@ -671,7 +671,23 @@ do {						\
 	**************  MIPS/64  **************
 	***************************************/
 #if (defined(__mips) && __mips >= 3) && W_TYPE_SIZE == 64
-#if (__GNUC__ >= 5) || (__GNUC__ >= 4 && __GNUC_MINOR__ >= 4)
+#if defined(__mips_isa_rev) && __mips_isa_rev >= 6
+/*
+ * GCC ends up emitting a __multi3 intrinsic call for MIPS64r6 with the plain C
+ * code below, so we special case MIPS64r6 until the compiler can do better.
+ */
+#define umul_ppmm(w1, w0, u, v)						\
+do {									\
+	__asm__ ("dmulu %0,%1,%2"					\
+		 : "=d" ((UDItype)(w0))					\
+		 : "d" ((UDItype)(u)),					\
+		   "d" ((UDItype)(v)));					\
+	__asm__ ("dmuhu %0,%1,%2"					\
+		 : "=d" ((UDItype)(w1))					\
+		 : "d" ((UDItype)(u)),					\
+		   "d" ((UDItype)(v)));					\
+} while (0)
+#elif (__GNUC__ >= 5) || (__GNUC__ >= 4 && __GNUC_MINOR__ >= 4)
 #define umul_ppmm(w1, w0, u, v) \
 do {									\
 	typedef unsigned int __ll_UTItype __attribute__((mode(TI)));	\
