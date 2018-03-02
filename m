Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuvXWRZ/YHBXL+/SKNE1TSZktpW49Mg9OW4cdaDHbmBnu0pdzwHmdm89wKDvUCY6uxgkpEs
ARC-Seal: i=1; a=rsa-sha256; t=1519980957; cv=none;
        d=google.com; s=arc-20160816;
        b=lPAjbi83lQ/XoO0QLJ8GEXzmOWydicTAiO9UW2TVdTe7r3xuWKVqLZldx+i5oCjzBK
         nfpXno9oddQYaoRodfjKHI6rLSghfiAZD9DhwTwEJzqrsmmgMaLQ5vnsOoF8vBZ/8aXe
         X1jjxSd/eG/LaaOXFa0ySwEJWoJKEUdmZuP24BFAOYiLr0lmR2AuzYkxD5qgjmP71Cdd
         6ogfaKTe2dUYeOtzMwaQf3hMHfeVeB4/EHHarfziyqugQcd+n6q4yzL2kvypOEDIzKoa
         eSLwH/gR6ORBb4mddgz4Ndb2QRa8VsEyfEKlhLdLzStBltYE9IYyhfvoAqOY+zFwgVqA
         oNjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Jvzgl5aO0L6Ep1FxE6IC/5ky38vTiCCILhFsGnojsI4=;
        b=sa0zl4t+2ftJ1DMv4uavX9niiLBv961cm3LoVMJRVxEJr2NTc+TmeQh3v/iNxpaLxn
         ie1rob13no6bHs/oxZUeYWCznVNUayIKE5PgPtaDgm14IxV20v+k7tytl2AijE/rOAfa
         fjwWKO/FS4aaVUQJHXy40WhIB909/6ySbZL9ZnSTAyeBIdjlw8Hdbdaorj9GRS6QkTHR
         zGlVApcbEK8DOhKcbwBrDUK90j49Ox+tpuJhL1l06wGs1nyqU34cec3Ev1y+AvrXPaOZ
         +bntSe9sUEU4YkrAES+KP55ZpjAjdZPAQTbhG2wob4vnIvkFJwVGPevRNnyjarU5vg/k
         IZxA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	James Hogan <jhogan@kernel.org>,
	Waldemar Brodkorb <wbx@openadk.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	"Maciej W. Rozycki" <macro@mips.com>,
	Matthew Fortune <matthew.fortune@mips.com>,
	Florian Fainelli <florian@openwrt.org>,
	linux-mips@linux-mips.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.4 34/34] MIPS: Implement __multi3 for GCC7 MIPS64r6 builds
Date: Fri,  2 Mar 2018 09:51:30 +0100
Message-Id: <20180302084438.206438236@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084435.842679610@linuxfoundation.org>
References: <20180302084435.842679610@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815551950805083?=
X-GMAIL-MSGID: =?utf-8?q?1593815551950805083?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <jhogan@kernel.org>

commit ebabcf17bcd7ce968b1631ebe08236275698f39b upstream.

GCC7 is a bit too eager to generate suboptimal __multi3 calls (128bit
multiply with 128bit result) for MIPS64r6 builds, even in code which
doesn't explicitly use 128bit types, such as the following:

unsigned long func(unsigned long a, unsigned long b)
{
	return a > (~0UL) / b;
}

Which GCC rearanges to:

return (unsigned __int128)a * (unsigned __int128)b > 0xffffffffffffffff;

Therefore implement __multi3, but only for MIPS64r6 with GCC7 as under
normal circumstances we wouldn't expect any calls to __multi3 to be
generated from kernel code.

Reported-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: James Hogan <jhogan@kernel.org>
Tested-by: Waldemar Brodkorb <wbx@openadk.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Maciej W. Rozycki <macro@mips.com>
Cc: Matthew Fortune <matthew.fortune@mips.com>
Cc: Florian Fainelli <florian@openwrt.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/17890/
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/lib/Makefile |    3 +-
 arch/mips/lib/libgcc.h |   17 +++++++++++++++
 arch/mips/lib/multi3.c |   54 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 1 deletion(-)

--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -15,4 +15,5 @@ obj-$(CONFIG_CPU_R3000)		+= r3k_dump_tlb
 obj-$(CONFIG_CPU_TX39XX)	+= r3k_dump_tlb.o
 
 # libgcc-style stuff needed in the kernel
-obj-y += ashldi3.o ashrdi3.o bswapsi.o bswapdi.o cmpdi2.o lshrdi3.o ucmpdi2.o
+obj-y += ashldi3.o ashrdi3.o bswapsi.o bswapdi.o cmpdi2.o lshrdi3.o multi3.o \
+	 ucmpdi2.o
--- a/arch/mips/lib/libgcc.h
+++ b/arch/mips/lib/libgcc.h
@@ -9,10 +9,18 @@ typedef int word_type __attribute__ ((mo
 struct DWstruct {
 	int high, low;
 };
+
+struct TWstruct {
+	long long high, low;
+};
 #elif defined(__LITTLE_ENDIAN)
 struct DWstruct {
 	int low, high;
 };
+
+struct TWstruct {
+	long long low, high;
+};
 #else
 #error I feel sick.
 #endif
@@ -22,4 +30,13 @@ typedef union {
 	long long ll;
 } DWunion;
 
+#if defined(CONFIG_64BIT) && defined(CONFIG_CPU_MIPSR6)
+typedef int ti_type __attribute__((mode(TI)));
+
+typedef union {
+	struct TWstruct s;
+	ti_type ti;
+} TWunion;
+#endif
+
 #endif /* __ASM_LIBGCC_H */
--- /dev/null
+++ b/arch/mips/lib/multi3.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/export.h>
+
+#include "libgcc.h"
+
+/*
+ * GCC 7 suboptimally generates __multi3 calls for mips64r6, so for that
+ * specific case only we'll implement it here.
+ *
+ * See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82981
+ */
+#if defined(CONFIG_64BIT) && defined(CONFIG_CPU_MIPSR6) && (__GNUC__ == 7)
+
+/* multiply 64-bit values, low 64-bits returned */
+static inline long long notrace dmulu(long long a, long long b)
+{
+	long long res;
+
+	asm ("dmulu %0,%1,%2" : "=r" (res) : "r" (a), "r" (b));
+	return res;
+}
+
+/* multiply 64-bit unsigned values, high 64-bits of 128-bit result returned */
+static inline long long notrace dmuhu(long long a, long long b)
+{
+	long long res;
+
+	asm ("dmuhu %0,%1,%2" : "=r" (res) : "r" (a), "r" (b));
+	return res;
+}
+
+/* multiply 128-bit values, low 128-bits returned */
+ti_type notrace __multi3(ti_type a, ti_type b)
+{
+	TWunion res, aa, bb;
+
+	aa.ti = a;
+	bb.ti = b;
+
+	/*
+	 * a * b =           (a.lo * b.lo)
+	 *         + 2^64  * (a.hi * b.lo + a.lo * b.hi)
+	 *        [+ 2^128 * (a.hi * b.hi)]
+	 */
+	res.s.low = dmulu(aa.s.low, bb.s.low);
+	res.s.high = dmuhu(aa.s.low, bb.s.low);
+	res.s.high += dmulu(aa.s.high, bb.s.low);
+	res.s.high += dmulu(aa.s.low, bb.s.high);
+
+	return res.ti;
+}
+EXPORT_SYMBOL(__multi3);
+
+#endif /* 64BIT && CPU_MIPSR6 && GCC7 */
