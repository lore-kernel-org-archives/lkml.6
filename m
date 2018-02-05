Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225g95tfPfpooeMesu1eT6qO9yCNlw3KvSeN1WfXTZIjVvAAnkFzC2IB74IRVLmDbDE6ePWp
ARC-Seal: i=1; a=rsa-sha256; t=1517855090; cv=none;
        d=google.com; s=arc-20160816;
        b=j1gj4/CI9YkleLYIEix64garkPi3dj7GLjUxIh1I6dzg1ATbThJZJbH6chBQVOZ+jh
         ML4CR0Yn5Y6W81ferskJQ78fpvEpKkXRCbJuEj+/zxcG5Eh6Gn4vuIigpjyxo+FzeVIK
         l0T5bgbfaj9wQIFKvYX5plK056FztY4gSiTdJbSMgOqFzXGTelGzDgj64LnCjbO1bd0z
         cd/gC2dbAhjfuHQXRhNTu8ijfFKKC5FRqea1j4YWbFThjz8gA3QkS/ihMHONSuFZQsgI
         PmyjxWoN7ZebfeWd1ziCfAo+Ic0gb3bUh8Q2+SRNZqkI7pB/KERfx4Dz2JY6ODkQ92MW
         DOTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=z9voLxXjpcT2afM1BRANvl2Vq3zNkw6KN3ZAvrR+EHM=;
        b=ynRGvrSf8MCD+2ONk5/TbWmNNYWN41gyzlu4e8Z7TCkFOd4x3jhuufsVb+JTZjTyOt
         +niVFZeyJH1AUNpx7FwxtApWyyXeGAxxXuleQF58SWm23RrzbJ9SSrFDf7Q51pIFyXoM
         8u9MyXqVsKfr2SsHwKvuJa/gTvH8YXQDg1ihgc9EB/cnWd+UgcyrzpwZsbdChDz04xWZ
         j+T6OwQ1bxTXFB1MKkhObh7cZRT9NOG8dll2i83TvkG7zJ3PRcsoqE+1g/hmnqJkQDcZ
         fPfaDQutHFl8yPZ0vOwyuqJoPEzM0zXGRFSOUV3P9ijGL6Lt0zwRE4vIGoGvehjF54Ie
         cDYw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	KarimAllah Ahmed <karahmed@amazon.de>,
	David Woodhouse <dwmw@amazon.co.uk>,
	gnomes@lxorguk.ukuu.org.uk,
	ak@linux.intel.com,
	ashok.raj@intel.com,
	dave.hansen@intel.com,
	arjan@linux.intel.com,
	torvalds@linux-foundation.org,
	peterz@infradead.org,
	bp@alien8.de,
	pbonzini@redhat.com,
	tim.c.chen@linux.intel.com,
	gregkh@linux-foundation.org
Subject: [PATCH 4.15 10/60] x86/speculation: Add basic IBPB (Indirect Branch Prediction Barrier) support
Date: Mon,  5 Feb 2018 10:22:43 -0800
Message-Id: <20180205182214.345100728@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586337251647983?=
X-GMAIL-MSGID: =?utf-8?q?1591586418951883508?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse dwmw@amazon.co.uk

commit 20ffa1caecca4db8f79fe665acdeaa5af815a24d

Expose indirect_branch_prediction_barrier() for use in subsequent patches.

[ tglx: Add IBPB status to spectre_v2 sysfs file ]

Co-developed-by: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: ak@linux.intel.com
Cc: ashok.raj@intel.com
Cc: dave.hansen@intel.com
Cc: arjan@linux.intel.com
Cc: torvalds@linux-foundation.org
Cc: peterz@infradead.org
Cc: bp@alien8.de
Cc: pbonzini@redhat.com
Cc: tim.c.chen@linux.intel.com
Cc: gregkh@linux-foundation.org
Link: https://lkml.kernel.org/r/1516896855-7642-8-git-send-email-dwmw@amazon.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/include/asm/cpufeatures.h   |    2 ++
 arch/x86/include/asm/nospec-branch.h |   13 +++++++++++++
 arch/x86/kernel/cpu/bugs.c           |   10 +++++++++-
 3 files changed, 24 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -210,6 +210,8 @@
 #define X86_FEATURE_MBA			( 7*32+18) /* Memory Bandwidth Allocation */
 #define X86_FEATURE_RSB_CTXSW		( 7*32+19) /* Fill RSB on context switches */
 
+#define X86_FEATURE_IBPB		( 7*32+21) /* Indirect Branch Prediction Barrier enabled*/
+
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW		( 8*32+ 0) /* Intel TPR Shadow */
 #define X86_FEATURE_VNMI		( 8*32+ 1) /* Intel Virtual NMI */
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -218,5 +218,18 @@ static inline void vmexit_fill_RSB(void)
 #endif
 }
 
+static inline void indirect_branch_prediction_barrier(void)
+{
+	asm volatile(ALTERNATIVE("",
+				 "movl %[msr], %%ecx\n\t"
+				 "movl %[val], %%eax\n\t"
+				 "movl $0, %%edx\n\t"
+				 "wrmsr",
+				 X86_FEATURE_IBPB)
+		     : : [msr] "i" (MSR_IA32_PRED_CMD),
+			 [val] "i" (PRED_CMD_IBPB)
+		     : "eax", "ecx", "edx", "memory");
+}
+
 #endif /* __ASSEMBLY__ */
 #endif /* __NOSPEC_BRANCH_H__ */
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -263,6 +263,13 @@ retpoline_auto:
 		setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
 		pr_info("Filling RSB on context switch\n");
 	}
+
+	/* Initialize Indirect Branch Prediction Barrier if supported */
+	if (boot_cpu_has(X86_FEATURE_SPEC_CTRL) ||
+	    boot_cpu_has(X86_FEATURE_AMD_PRED_CMD)) {
+		setup_force_cpu_cap(X86_FEATURE_IBPB);
+		pr_info("Enabling Indirect Branch Prediction Barrier\n");
+	}
 }
 
 #undef pr_fmt
@@ -292,7 +299,8 @@ ssize_t cpu_show_spectre_v2(struct devic
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
 		return sprintf(buf, "Not affected\n");
 
-	return sprintf(buf, "%s%s\n", spectre_v2_strings[spectre_v2_enabled],
+	return sprintf(buf, "%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
+		       boot_cpu_has(X86_FEATURE_IBPB) ? ", IPBP" : "",
 		       spectre_v2_bad_module ? " - vulnerable module loaded" : "");
 }
 #endif
