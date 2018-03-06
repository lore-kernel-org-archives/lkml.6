Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELsrak/sgam+EwH8+R8uJtUGKV9l0gDZ7HlevZU7WBViMgCAZixRcQVuz+Yhyo7xmdgFQviZ
ARC-Seal: i=1; a=rsa-sha256; t=1520295976; cv=none;
        d=google.com; s=arc-20160816;
        b=F973qSSJT2l/UCHkItvNxxu8HzfhigfC4Qe867k+igp378QQFNHcfWeY8ywlAdEov7
         qq10YpYxS2GksC1I38xzUbaDwFLPql4lBCwkNh/Y2Qi2Bp3ZPUXc7bZRu6TEp3F0S2/i
         a52/ppV55DmCqhbL3qAjjd/EHARIY0MylgF1Fk5KeZ20Euzzzt9oe/sQmp+qIvFwXkEe
         v/Eyu/gRF03XpxexHHlMJA1U4ukQXjxcqZJ0mPupX0CF8BdkxQI3/NUowYqGFpZTHnqI
         H/VdjQBbX/FrgByo2YUy1yZqoAJr7TtUGVRcf2tbs+uRINAlsC4WVPJmjLVA4Vf3O8I1
         Y+HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=mU51MuW1ll1fZko7UYoFvY0CElTeAURomXpb4XjeBtw=;
        b=TG/rEhGyhUqUbpeQ3O+mVTzXNGrauPXnSDbm7t7J6LB49QJpWF9uUW0eIozq6b0loh
         MT50168HQVS43d4HI9cWFuwjl7hLq9vAUEv/c9JUB5TjCXZs3Y6NI1S8333CzSTu8aq0
         Cep8B4MiUAWkJtBrfJs3WuXYKwEdMFuJDSTbyoN1taBMv+0/7ECsdSWYQuyotFJxrKIe
         VUetyNEJA8IBCeNDAAPuFBKDmt/1pSTbB+H+5GwTTVqJbCDWH+2cIaRX20p4CiWPe1VZ
         AkdlKrcXI1sST66kSIDn/RRIbt/daQgKWdntWcQvzkHSy1YeM+YlUqgGmWd8qosw/CoF
         bdxA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=oTFTJD1a;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=oTFTJD1a;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 18/65] x86/mm: Disable PCID on 32-bit kernels
Date: Mon,  5 Mar 2018 19:24:51 -0500
Message-Id: <20180306002538.1761-19-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145874652650360?=
X-GMAIL-MSGID: =?utf-8?q?1594145874652650360?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andy Lutomirski <luto@kernel.org>

commit cba4671af7550e008f7a7835f06df0763825bf3e upstream.

32-bit kernels on new hardware will see PCID in CPUID, but PCID can
only be used in 64-bit mode.  Rather than making all PCID code
conditional, just disable the feature on 32-bit builds.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Nadav Amit <nadav.amit@gmail.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/2e391769192a4d31b808410c383c6bf0734bc6ea.1498751203.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

(cherry picked from commit 78043e5b6fb2921d836b31f23e89e52925191153)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/include/asm/disabled-features.h | 4 +++-
 arch/x86/kernel/cpu/bugs.c               | 8 ++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index f226df064660..8b17c2ad1048 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -21,11 +21,13 @@
 # define DISABLE_K6_MTRR	(1<<(X86_FEATURE_K6_MTRR & 31))
 # define DISABLE_CYRIX_ARR	(1<<(X86_FEATURE_CYRIX_ARR & 31))
 # define DISABLE_CENTAUR_MCR	(1<<(X86_FEATURE_CENTAUR_MCR & 31))
+# define DISABLE_PCID		0
 #else
 # define DISABLE_VME		0
 # define DISABLE_K6_MTRR	0
 # define DISABLE_CYRIX_ARR	0
 # define DISABLE_CENTAUR_MCR	0
+# define DISABLE_PCID		(1<<(X86_FEATURE_PCID & 31))
 #endif /* CONFIG_X86_64 */
 
 /*
@@ -35,7 +37,7 @@
 #define DISABLED_MASK1	0
 #define DISABLED_MASK2	0
 #define DISABLED_MASK3	(DISABLE_CYRIX_ARR|DISABLE_CENTAUR_MCR|DISABLE_K6_MTRR)
-#define DISABLED_MASK4	0
+#define DISABLED_MASK4	(DISABLE_PCID)
 #define DISABLED_MASK5	0
 #define DISABLED_MASK6	0
 #define DISABLED_MASK7	0
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 03445346ee0a..4c7dd836304a 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -65,6 +65,14 @@ static void __init check_fpu(void)
 
 void __init check_bugs(void)
 {
+#ifdef CONFIG_X86_32
+	/*
+	 * Regardless of whether PCID is enumerated, the SDM says
+	 * that it can't be enabled in 32-bit mode.
+	 */
+	setup_clear_cpu_cap(X86_FEATURE_PCID);
+#endif
+
 	identify_boot_cpu();
 #ifndef CONFIG_SMP
 	pr_info("CPU: ");
-- 
2.16.2
