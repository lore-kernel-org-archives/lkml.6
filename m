Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELuk8YcQnfIeQS3cVzi9DacKRno8lrIrjRSRsDjLmPCckhJKkDqcTIJ5ZMYCci2qKc3TKNPy
ARC-Seal: i=1; a=rsa-sha256; t=1520296008; cv=none;
        d=google.com; s=arc-20160816;
        b=wlrIQRx5UvfoHGJbqO4qYvw/rS+9O6h6X06vnwFadJ3JQYZp/PBeAzd0fjmR8R5Urz
         xIZcxiWYjIKbYjc8DZ2b0FDG71APoElrSaVlnU23+QUY2B8S1wYB0cjWhEw9b6Oi1PNE
         ikOI2HLAz5O0X00OrRJACaFHYNOPf7b60+m3EXBdYThOfxx9JIdjs8QJ8g864yrl6T2z
         6nDenmypFSyw8d4B4U6fxlvJWOJXLS3wobZp6rGnwz4v6fLdGXUIOV3I0KRVDKf6KTxf
         r6a2+vzep7KPQ32yAcms66H7QB3af3axmlDLdKSZoRCkGpCzfS/yjGkTUBDe3VjAHug0
         aEgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=QQc2cgXTaincKDmalJY5apVwnkdis0a1rFBgV6JAKYU=;
        b=AapaDNyDWEMV5Eq6tKHnU5W+e7+f4mPM+srjYdcJNwcplXbMnH3uvYsyMOHUuVZkOV
         AFpuiyv6FRbG6f0fChMKFfKG6xHKW9Jdxb2AsLu+Si74/A1kfy/IIisLbEsZqsRd96ZL
         /JyHnIxhQ9PT+/x+zfIuiWpdKXik/sTfX0QBe74B3+8jHXERVVviYB0SjnwbJc6GpiRs
         VaqeXNQU3/f+jmX9G+DE8f6oz0jT7LGbOn/nIEM3Ao5r59SWVc3+0eH0QltXtuxsQmYv
         QkSgbXQr1PlYJrH2KiJGT63GDWG38O8eMlKR24nAwnP8cFfYr11RpMSrCEuy3U078rhY
         qVmQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=HSq1zjgu;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=HSq1zjgu;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 52/65] x86/kaiser: Check boottime cmdline params
Date: Mon,  5 Mar 2018 19:25:25 -0500
Message-Id: <20180306002538.1761-53-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=802
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145907340062853?=
X-GMAIL-MSGID: =?utf-8?q?1594145907340062853?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Borislav Petkov <bp@suse.de>

AMD (and possibly other vendors) are not affected by the leak
KAISER is protecting against.

Keep the "nopti" for traditional reasons and add pti=<on|off|auto>
like upstream.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit e405a064bd7d6eca88935342ddb71057a9d6ceab)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 Documentation/kernel-parameters.txt |  6 ++++
 arch/x86/mm/kaiser.c                | 59 ++++++++++++++++++++++++++-----------
 2 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index c1f3dbed0021..f6c046f03905 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2972,6 +2972,12 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 	pt.		[PARIDE]
 			See Documentation/blockdev/paride.txt.
 
+	pti=		[X86_64]
+			Control KAISER user/kernel address space isolation:
+			on - enable
+			off - disable
+			auto - default setting
+
 	pty.legacy_count=
 			[KNL] Number of legacy pty's. Overwrites compiled-in
 			default number.
diff --git a/arch/x86/mm/kaiser.c b/arch/x86/mm/kaiser.c
index a724496a5852..88b4526d57a5 100644
--- a/arch/x86/mm/kaiser.c
+++ b/arch/x86/mm/kaiser.c
@@ -16,6 +16,7 @@
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/desc.h>
+#include <asm/cmdline.h>
 
 int kaiser_enabled __read_mostly = 1;
 EXPORT_SYMBOL(kaiser_enabled);	/* for inlined TLB flush functions */
@@ -264,6 +265,43 @@ static void __init kaiser_init_all_pgds(void)
 	WARN_ON(__ret);							\
 } while (0)
 
+void __init kaiser_check_boottime_disable(void)
+{
+	bool enable = true;
+	char arg[5];
+	int ret;
+
+	ret = cmdline_find_option(boot_command_line, "pti", arg, sizeof(arg));
+	if (ret > 0) {
+		if (!strncmp(arg, "on", 2))
+			goto enable;
+
+		if (!strncmp(arg, "off", 3))
+			goto disable;
+
+		if (!strncmp(arg, "auto", 4))
+			goto skip;
+	}
+
+	if (cmdline_find_option_bool(boot_command_line, "nopti"))
+		goto disable;
+
+skip:
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+		goto disable;
+
+enable:
+	if (enable)
+		setup_force_cpu_cap(X86_FEATURE_KAISER);
+
+	return;
+
+disable:
+	pr_info("Kernel/User page tables isolation: disabled\n");
+	kaiser_enabled = 0;
+	setup_clear_cpu_cap(X86_FEATURE_KAISER);
+}
+
 /*
  * If anything in here fails, we will likely die on one of the
  * first kernel->user transitions and init will die.  But, we
@@ -275,12 +313,10 @@ void __init kaiser_init(void)
 {
 	int cpu;
 
-	if (!kaiser_enabled) {
-		setup_clear_cpu_cap(X86_FEATURE_KAISER);
-		return;
-	}
+	kaiser_check_boottime_disable();
 
-	setup_force_cpu_cap(X86_FEATURE_KAISER);
+	if (!kaiser_enabled)
+		return;
 
 	kaiser_init_all_pgds();
 
@@ -424,16 +460,3 @@ void kaiser_flush_tlb_on_return_to_user(void)
 			X86_CR3_PCID_USER_FLUSH | KAISER_SHADOW_PGD_OFFSET);
 }
 EXPORT_SYMBOL(kaiser_flush_tlb_on_return_to_user);
-
-static int __init x86_nokaiser_setup(char *s)
-{
-	/* nopti doesn't accept parameters */
-	if (s)
-		return -EINVAL;
-
-	kaiser_enabled = 0;
-	pr_info("Kernel/User page tables isolation: disabled\n");
-
-	return 0;
-}
-early_param("nopti", x86_nokaiser_setup);
-- 
2.16.2
