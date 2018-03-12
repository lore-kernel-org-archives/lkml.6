Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELuqS0pvmrOU50JYGt4YWlC4RbWF2Xrle32SiNzBGaNV7PKx1IVinXmRfE57wQMG4sjKuAad
ARC-Seal: i=1; a=rsa-sha256; t=1520824119; cv=none;
        d=google.com; s=arc-20160816;
        b=gasFozg7OdDKe9I0+KB08PO9F1pRHO9wMjlBstO9V3bwa9ZVfR6mgG5Ma4lqHHfvnX
         9tkc9H99iGVWyRn8/jID7baBmZmN0Lgvk+PXDkM+ImiVylpRBQj+/i29JqtWyRAF9OE3
         XYut3wEYLA5Q0pQZZkz3ACEfiANDH0MN1GFluzhRVNTzVm6FNeh7ZuEC/eYHp/9Bfkj6
         ZcxB8jbGSJ/QsDXkcIiA3F0d5kR2IimywjKqpmwSe8RuLC7H9X7Mp8KMI6SdvWuZN90j
         KqFoAAcaXJ8i7tCkPuLwtkD68HpNdsukYjRZw4NcKujMCpobyVLvynEd1bm0tOAW+mn5
         X3tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=U2A/LfTpvr1s9bXWTZ6MZH2kaZr7SBFWTQaT4NawRaU=;
        b=zdz6UYCEOrn/SsLa3CmG+9E7J8oWcddcLCxS4wkWdabRvO/toVU6nkQq2yF6S0fe5Q
         y/dj2dKRhvXOFkXv7++G3FzKJa4cdc8xGyOn4MUmbboAScaW8T/6RORFhD0d2O/V2dp7
         gDro0KDN4UVMtecUE27yHjfVAuI6QmQkLF815ed7oezt0GR6dMgPQhIcnDvC1u6vA/Ok
         uHuLJetgd61qlhquICGVbZrfkKWz7sVE+hc+5k/uHeD3zp7I0rBtmlyDgiUoUEo/xf+z
         xRQ9oxN7AsDllAP02M+HEjmQ9pNAIK+mc1vps4XD/UrWkeAfk+kNvSoy0UOrmUoSVgDm
         FsNQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Ingo Molnar" <mingo@kernel.org>,
 "Borislav Petkov" <bp@alien8.de>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Eduardo Valentin" <eduval@amazon.com>,
 "Juergen Gross" <jgross@suse.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Denys Vlasenko" <dvlasenk@redhat.com>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "David Laight" <David.Laight@aculab.com>,
 "Rik van Riel" <riel@redhat.com>,
 "Brian Gerst" <brgerst@gmail.com>,
 keescook@google.com,
 "Dave Hansen" <dave.hansen@intel.com>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Will Deacon" <will.deacon@arm.com>,
 "Borislav Petkov" <bp@suse.de>,
 daniel.gruss@iaik.tugraz.at,
 "Borislav Petkov" <bpetkov@suse.de>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Greg KH" <gregkh@linuxfoundation.org>,
 hughd@google.com, aliguori@amazon.com,
 "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
 "Andy Lutomirski" <luto@kernel.org>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.893939599@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 04/76] x86/cpufeatures: Make CPU bugs sticky
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699671986206405?=
X-GMAIL-MSGID: =?utf-8?q?1594699671986206405?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 6cbd2171e89b13377261d15e64384df60ecb530e upstream.

There is currently no way to force CPU bug bits like CPU feature bits. That
makes it impossible to set a bug bit once at boot and have it stick for all
upcoming CPUs.

Extend the force set/clear arrays to handle bug bits as well.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Borislav Petkov <bpetkov@suse.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Laight <David.Laight@aculab.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Eduardo Valentin <eduval@amazon.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: aliguori@amazon.com
Cc: daniel.gruss@iaik.tugraz.at
Cc: hughd@google.com
Cc: keescook@google.com
Link: https://lkml.kernel.org/r/20171204150606.992156574@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/cpufeature.h | 2 ++
 arch/x86/include/asm/processor.h  | 4 ++--
 arch/x86/kernel/cpu/common.c      | 6 +++---
 3 files changed, 7 insertions(+), 5 deletions(-)

--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -286,6 +286,8 @@ extern const char * const x86_power_flag
 	set_bit(bit, (unsigned long *)cpu_caps_set);	\
 } while (0)
 
+#define setup_force_cpu_bug(bit) setup_force_cpu_cap(bit)
+
 #define cpu_has_fpu		boot_cpu_has(X86_FEATURE_FPU)
 #define cpu_has_vme		boot_cpu_has(X86_FEATURE_VME)
 #define cpu_has_de		boot_cpu_has(X86_FEATURE_DE)
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -147,8 +147,8 @@ extern struct cpuinfo_x86	boot_cpu_data;
 extern struct cpuinfo_x86	new_cpu_data;
 
 extern struct tss_struct	doublefault_tss;
-extern __u32			cpu_caps_cleared[NCAPINTS];
-extern __u32			cpu_caps_set[NCAPINTS];
+extern __u32			cpu_caps_cleared[NCAPINTS + NBUGINTS];
+extern __u32			cpu_caps_set[NCAPINTS + NBUGINTS];
 
 #ifdef CONFIG_SMP
 DECLARE_PER_CPU_SHARED_ALIGNED(struct cpuinfo_x86, cpu_info);
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -441,8 +441,8 @@ static const char *table_lookup_model(st
 	return NULL;		/* Not found */
 }
 
-__u32 cpu_caps_cleared[NCAPINTS];
-__u32 cpu_caps_set[NCAPINTS];
+__u32 cpu_caps_cleared[NCAPINTS + NBUGINTS];
+__u32 cpu_caps_set[NCAPINTS + NBUGINTS];
 
 void load_percpu_segment(int cpu)
 {
@@ -674,7 +674,7 @@ static void apply_forced_caps(struct cpu
 {
 	int i;
 
-	for (i = 0; i < NCAPINTS; i++) {
+	for (i = 0; i < NCAPINTS + NBUGINTS; i++) {
 		c->x86_capability[i] &= ~cpu_caps_cleared[i];
 		c->x86_capability[i] |= cpu_caps_set[i];
 	}
