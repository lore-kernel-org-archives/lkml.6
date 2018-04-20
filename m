Return-Path: <Matt.Redfearn@mips.com>
X-Google-Smtp-Source: AIpwx48Jgl6oZi4MUFu43DHGdNM8y+/VQgKVgJ2QAHNXCvOsqUk2mqgzREO1cSXxJRVESs5laYIU
ARC-Seal: i=1; a=rsa-sha256; t=1524219842; cv=none;
        d=google.com; s=arc-20160816;
        b=MZhR4zpKISNyhujrmH0xrQ25ZJPMsFRkMH3JbIHSWhC2FSFGHskxgc95nJYY45tbS3
         H8jQyIh46dwhkW6NNzNxa9SXYkshuGu14A6Hcbo+WVpEQVhzwpiDJDhJo9sVPmAMEcqD
         /9u0K+qFm0fV+0KivO1pm6B2YOoPLIoupucYYVOMYtF8XQIsc+ujz7mcRTaBq0uLLTEC
         LzZvnWTrI14K8hXc8ZP8OMYeKLWpz9gvhVtI6mAozkAdGBcjlCdPFPEg64i8KfADYrAP
         M5f23hW5b2OHfqadWDoUnoTxk3J4N2nTKluxrAq2kgjhRbslupE3G0rChImI9d9hJoMX
         yUTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=GS34jFl7smnN+NjtFQB7dALQDBQBaP0C1q1pWmTANdc=;
        b=DyZdBCIP+2YTtgHUnF6pbVXn0k9xURflgC3r/ZZrwMYqgDS7Vol5akit7f6qjFsjrK
         u9kRkxksbHeDmzaB18sTdIpB4d7W3m2gmR5XbAEaQGdxHdiSol5jG+2Z6/L//vPIDbq+
         BznIdVCz2JWcRQYMEm0MMNOR22yE3Prr66klTdl7VG6YZ55ezPlfBYwhDlGBYVdWHSSF
         N9Ttlg1A+Qz+WidY4wGtn9Oi4MBEemDMPTamdPpr8MbXF0lgRtaVURvDn2s4RZoIQNFR
         9RKgUXFlaL5QlnWIL7eSZ4j36DnDFKDXibVGW9wkBF2Qt+S64dI3dD9SYmmLWsotUTmJ
         yg2g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of matt.redfearn@mips.com designates 64.235.154.211 as permitted sender) smtp.mailfrom=Matt.Redfearn@mips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of matt.redfearn@mips.com designates 64.235.154.211 as permitted sender) smtp.mailfrom=Matt.Redfearn@mips.com
From: Matt Redfearn <matt.redfearn@mips.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
	Florian Fainelli <f.fainelli@gmail.com>
CC: <linux-mips@linux-mips.org>, Matt Redfearn <matt.redfearn@mips.com>,
	Huacai Chen <chenhc@lemote.com>, <linux-kernel@vger.kernel.org>, Paul Burton
	<paul.burton@mips.com>, Kate Stewart <kstewart@linuxfoundation.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Maciej W. Rozycki"
	<macro@mips.com>
Subject: [PATCH v3 1/7] MIPS: Probe for MIPS MT perf counters per TC
Date: Fri, 20 Apr 2018 11:23:03 +0100
Message-ID: <1524219789-31241-2-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524219789-31241-1-git-send-email-matt.redfearn@mips.com>
References: <1524219789-31241-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1524219830-321459-15390-33906-1
X-BESS-VER: 2018.5-r1804181636
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.192193
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598260345146824674?=
X-GMAIL-MSGID: =?utf-8?q?1598260345146824674?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Processors implementing the MIPS MT ASE may have performance counters
implemented per core or per TC. Processors implemented by MIPS
Technologies signify presence per TC through a bit in the implementation
specific Config7 register. Currently the code which probes for their
presence blindly reads a magic number corresponding to this bit, despite
it potentially having a different meaning in the CPU implementation.

Since CPU features are generally detected by cpu-probe.c, perform the
detection here instead. Introduce cpu_set_mt_per_tc_perf which checks
the bit in config7 and call it from MIPS CPUs known to implement this
bit and the MT ASE, specifically, the 34K, 1004K and interAptiv.

Once the presence of the per-tc counter is indicated in cpu_data, tests
for it can be updated to use this flag.

Suggested-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

---

Changes in v3:
New patch to detect feature presence in cpu-probe.c

Changes in v2: None

 arch/mips/include/asm/cpu.h      |  2 ++
 arch/mips/include/asm/mipsregs.h |  5 +++++
 arch/mips/kernel/cpu-probe.c     | 12 ++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index d39324c4adf1..5b9d02ef4f60 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -418,6 +418,8 @@ enum cpu_type_enum {
 				MBIT_ULL(54)	/* CPU shares FTLB RAM with another */
 #define MIPS_CPU_SHARED_FTLB_ENTRIES \
 				MBIT_ULL(55)	/* CPU shares FTLB entries with another */
+#define MIPS_CPU_MT_PER_TC_PERF_COUNTERS \
+				MBIT_ULL(56)	/* CPU has perf counters implemented per TC (MIPSMT ASE) */
 
 /*
  * CPU ASE encodings
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 858752dac337..a4baaaa02bc8 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -684,6 +684,11 @@
 #define MIPS_CONF7_IAR		(_ULCAST_(1) << 10)
 #define MIPS_CONF7_AR		(_ULCAST_(1) << 16)
 
+/* Config7 Bits specific to MIPS Technologies. */
+
+/* Performance counters implemented Per TC */
+#define MTI_CONF7_PTC		(_ULCAST_(1) << 19)
+
 /* WatchLo* register definitions */
 #define MIPS_WATCHLO_IRW	(_ULCAST_(0x7) << 0)
 
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index cf3fd549e16d..1241c2a23d90 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -414,6 +414,14 @@ static int __init ftlb_disable(char *s)
 
 __setup("noftlb", ftlb_disable);
 
+/*
+ * Check if the CPU has per tc perf counters
+ */
+static inline void cpu_set_mt_per_tc_perf(struct cpuinfo_mips *c)
+{
+	if (read_c0_config7() & MTI_CONF7_PTC)
+		c->options |= MIPS_CPU_MT_PER_TC_PERF_COUNTERS;
+}
 
 static inline void check_errata(void)
 {
@@ -1569,6 +1577,7 @@ static inline void cpu_probe_mips(struct cpuinfo_mips *c, unsigned int cpu)
 		c->cputype = CPU_34K;
 		c->writecombine = _CACHE_UNCACHED;
 		__cpu_name[cpu] = "MIPS 34Kc";
+		cpu_set_mt_per_tc_perf(c);
 		break;
 	case PRID_IMP_74K:
 		c->cputype = CPU_74K;
@@ -1589,6 +1598,7 @@ static inline void cpu_probe_mips(struct cpuinfo_mips *c, unsigned int cpu)
 		c->cputype = CPU_1004K;
 		c->writecombine = _CACHE_UNCACHED;
 		__cpu_name[cpu] = "MIPS 1004Kc";
+		cpu_set_mt_per_tc_perf(c);
 		break;
 	case PRID_IMP_1074K:
 		c->cputype = CPU_1074K;
@@ -1598,10 +1608,12 @@ static inline void cpu_probe_mips(struct cpuinfo_mips *c, unsigned int cpu)
 	case PRID_IMP_INTERAPTIV_UP:
 		c->cputype = CPU_INTERAPTIV;
 		__cpu_name[cpu] = "MIPS interAptiv";
+		cpu_set_mt_per_tc_perf(c);
 		break;
 	case PRID_IMP_INTERAPTIV_MP:
 		c->cputype = CPU_INTERAPTIV;
 		__cpu_name[cpu] = "MIPS interAptiv (multi)";
+		cpu_set_mt_per_tc_perf(c);
 		break;
 	case PRID_IMP_PROAPTIV_UP:
 		c->cputype = CPU_PROAPTIV;
-- 
2.7.4
