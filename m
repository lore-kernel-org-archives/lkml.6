Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtkRiPTN77Dr9zNnkZZkrBeOS28swGf3YXbo/9fbJov7oLEnnz6lOuf5y0+LCksy1pJLuhD
ARC-Seal: i=1; a=rsa-sha256; t=1519981299; cv=none;
        d=google.com; s=arc-20160816;
        b=jU3f2UqGd4w3YKyEG0GRtUtMtEUtg0OPoGc2EMJyxrrwBBRJmAua1rrIAwzpjK3Fzv
         OqR6JrjQqg/AAxzduC7efONniX5v7pr5ZEGEMbFixSEpl5uPzjHG4Omm8m8iJ1pwnN1j
         k+E1Dvzhfwq5cmKPFeBpkV4SDz4jQyNV7QKnFWfF6FkP2H3l3hjlQHraNSrhxuBsum59
         h0x+v5cSXO4wTI8Czn9i/ICqpBI2PpN7AVIkVAmZWahAqg01jFH7VhF+ljhq7DJOgTti
         gWN7o0a/R/o0tmYQfIYf7sqhQ3KYUF+7dgYxYK8Jt3bbax7XDVm3TunGk+vx0UpM5ZI/
         ILqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Smks3/BYWN160j51Vt5+/pwQYQ8mx23DFKLn5G5EUaQ=;
        b=ZHat+02EltOAZP8/OAOu9ed37irpHvld9f4RvrCM3T9jOgQgOc+IhjFNxjzCcSBiqs
         YDjPo3Jxv28bQZCCICxCcqIC6wxEN2GZJ/36TLuMfA4N2XoW8HDT7ONdUuPNMPoJd35x
         PHLv3q9x4PiZFcl9uRdvuI8WS/xlRMeeCwt8iS3hio1pv7trVBng8GgMaeW4NLBgjzSu
         bEmHGohtiDdixib/O/SAd8ef4xqEXWr8DC+2hUJc/G1Ew0zYnUbrq+T6yg8zsMtUvEA5
         t0Vqw9x4NRQB2z76M6KX/SEJpP6CFir8u4YdMuI5s8YTFxm+2LnNUMH6EC7tdJ3dlwnR
         Ucvg==
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
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 050/115] lib/mpi: Fix umul_ppmm() for MIPS64r6
Date: Fri,  2 Mar 2018 09:50:53 +0100
Message-Id: <20180302084505.903142217@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815446124575806?=
X-GMAIL-MSGID: =?utf-8?q?1593815910804181105?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
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
