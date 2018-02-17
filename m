Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AH8x225jx40ET7eEFPCqqULYtXv08q9/Dt7dOvVyX2DyzieZHaEwUHoOfU/6lqFUS7RKmCMizFrW
ARC-Seal: i=1; a=rsa-sha256; t=1518863611; cv=none;
        d=google.com; s=arc-20160816;
        b=zDfP3e8rZmNFymmFz6GIKhL1dlG0xJEHpFXTLlwecAHrPuRtIKiGf6ckHXdxgstxKR
         dpq6Io8uVfpvcqk3NxylVaUKVvQCzxTMGBfLXb1IYBLZT6OsGQXTjVfgvqtaBRuxqoex
         lx/PDpb7xzrE2FQsUTtkEIuS1S5xPF6yWf/ml1MCTyrUrwYpwEjKkzubmcFYUe/CUqk4
         qjxr4m9fPI+8xddWEsxo30cPATWfjKT8d1zO2DvObljO55Ks6Ls5GpzozqjFAGDp9uah
         C+Zg867SmoP+sfI0ZivD3vjKj9Q30eKc+m0QIfUj6LJ1vx7yjGaeL23SO5USSgNotRRf
         YZGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=s9vw/77ZDNBPmbhdPlE+osdyrbReFOVKiGCLqdmTcFM=;
        b=Zr4duuZ5OB05MjUfUy6cqAE/X43M0DPf6va9qs5x/CAVDrWDzKKV/awNJ/ZooWPr5p
         q0ibhKyMsL392qhtTPgRi6LlxgK93xgIGSeZ5YZiEKxPJ3CiKGufAwWgIH2LwqidMK7a
         t2JgJ3UJyTwqejxicJu+ga0EKnftJMRLHIQvRBXf35ZMcgmTUlz+eqKrEb7v0eBfTThD
         BSCQsFD83HveyOAuSz/pjxgJvzpHa/k8OMQrERS2xv8DcTzVru6QeVGX6ov2qiEHsnux
         k6OKLY0vwIWJzyQE6EawDNzeQPtvHdrdegoDLXD81pJqpWeGJR633n8hmkfBgEj+z7HU
         HwuA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Sat, 17 Feb 2018 02:12:33 -0800
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-1008c52c09dcb23d93f8e0ea83a6246265d2cce0@git.kernel.org>
Cc: bp@alien8.de, ashok.raj@intel.com, luto@kernel.org, bp@suse.de,
        arjan@linux.intel.com, gregkh@linuxfoundation.org, hpa@zytor.com,
        dwmw2@infradead.org, dan.j.williams@intel.com,
        torvalds@linux-foundation.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@kernel.org, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com
Reply-To: torvalds@linux-foundation.org, dan.j.williams@intel.com,
        dwmw2@infradead.org, tglx@linutronix.de, peterz@infradead.org,
        mingo@kernel.org, dave.hansen@linux.intel.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com, bp@alien8.de,
        bp@suse.de, luto@kernel.org, hpa@zytor.com, gregkh@linuxfoundation.org,
        arjan@linux.intel.com
In-Reply-To: <20180216112640.11554-3-bp@alien8.de>
References: <20180216112640.11554-3-bp@alien8.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/CPU: Add a microcode loader callback
Git-Commit-ID: 1008c52c09dcb23d93f8e0ea83a6246265d2cce0
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592643930953089456?=
X-GMAIL-MSGID: =?utf-8?q?1592643930953089456?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  1008c52c09dcb23d93f8e0ea83a6246265d2cce0
Gitweb:     https://git.kernel.org/tip/1008c52c09dcb23d93f8e0ea83a6246265d2cce0
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Fri, 16 Feb 2018 12:26:39 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 17 Feb 2018 08:43:55 +0100

x86/CPU: Add a microcode loader callback

Add a callback function which the microcode loader calls when microcode
has been updated to a newer revision. Do the callback only when no error
was encountered during loading.

Tested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180216112640.11554-3-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/processor.h     |  1 +
 arch/x86/kernel/cpu/common.c         | 10 ++++++++++
 arch/x86/kernel/cpu/microcode/core.c |  8 ++++++--
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 1bd9ed8..b0ccd48 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -977,4 +977,5 @@ bool xen_set_default_idle(void);
 
 void stop_this_cpu(void *dummy);
 void df_debug(struct pt_regs *regs, long error_code);
+void microcode_check(void);
 #endif /* _ASM_X86_PROCESSOR_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 824aee0..84f1cd8 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1749,3 +1749,13 @@ static int __init init_cpu_syscore(void)
 	return 0;
 }
 core_initcall(init_cpu_syscore);
+
+/*
+ * The microcode loader calls this upon late microcode load to recheck features,
+ * only when microcode has been updated. Caller holds microcode_mutex and CPU
+ * hotplug lock.
+ */
+void microcode_check(void)
+{
+	perf_check_microcode();
+}
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 6fdaf7c..aa1b9a4 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -509,6 +509,7 @@ static ssize_t reload_store(struct device *dev,
 			    const char *buf, size_t size)
 {
 	enum ucode_state tmp_ret = UCODE_OK;
+	bool do_callback = false;
 	unsigned long val;
 	ssize_t ret = 0;
 	int cpu;
@@ -531,10 +532,13 @@ static ssize_t reload_store(struct device *dev,
 			if (!ret)
 				ret = -EINVAL;
 		}
+
+		if (tmp_ret == UCODE_UPDATED)
+			do_callback = true;
 	}
 
-	if (!ret && tmp_ret == UCODE_UPDATED)
-		perf_check_microcode();
+	if (!ret && do_callback)
+		microcode_check();
 
 	mutex_unlock(&microcode_mutex);
 	put_online_cpus();
