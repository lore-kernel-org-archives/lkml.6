Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753656AbeBKSvE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 13:51:04 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36796 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753551AbeBKSvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 13:51:02 -0500
X-Google-Smtp-Source: AH8x227JF16kLaQTrXP3nDeceNYRpLtK0dI03t32k8X1Z1zGwPniho5cP8Rn0H1okojnb5A2NVclzQ==
Date: Sun, 11 Feb 2018 19:50:57 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Woodhouse <dwmw@amazon.co.uk>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        karahmed@amazon.de, sironi@amazon.de, kvm@vger.kernel.org,
        torvalds@linux-foundation.org, pbonzini@redhat.com, bp@alien8.de,
        peterz@infradead.org, jmattson@google.com, rkrcmar@redhat.com,
        arjan.van.de.ven@intel.com, dave.hansen@intel.com
Subject: [PATCH] x86/speculation: Clean up various Spectre related details
Message-ID: <20180211185057.rest4bf2ydx7slrk@gmail.com>
References: <1518305967-31356-1-git-send-email-dwmw@amazon.co.uk>
 <1518362359-1005-1-git-send-email-dwmw@amazon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518362359-1005-1-git-send-email-dwmw@amazon.co.uk>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* David Woodhouse <dwmw@amazon.co.uk> wrote:

> +	/*
> +	 * Retpoline means the kernel is safe because it has no indirect
> +	 * branches. But firmware isn't, so use IBRS to protect that.
> +	 */
> +	if (boot_cpu_has(X86_FEATURE_IBRS)) {
> +		setup_force_cpu_cap(X86_FEATURE_USE_IBRS_FW);
> +		pr_info("Enabling Restricted Speculation for firmware calls\n");
> +	}

I have changed this text to say:

		pr_info("Spectre mitigation: Restricting branch speculation (enabling IBRS) for firmware calls\n");

In fact while at it I found and improved a few other details as well, such as:

 	 * Retpoline means the kernel is safe because it has no indirect
-	 * branches. But firmware isn't, so use IBRS to protect that.
+	 * branches. But we don't know whether the firmware is safe, so
+	 * use IBRS to protect against that:

most Spectre related messages are now harmonized:

arch/x86/kernel/cpu/bugs.c:             pr_info("Spectre mitigation: Filling RSB on context switch\n");
arch/x86/kernel/cpu/bugs.c:             pr_info("Spectre mitigation: Enabling Indirect Branch Prediction Barrier (IBPB)\n");
arch/x86/kernel/cpu/bugs.c:             pr_info("Spectre mitigation: Restricting branch speculation (enabling IBRS) for firmware calls\n");

Find the full patch below.

Thanks,

	Ingo

=========================>
>From 82c2b2f29691143a05181333f387e786646aa28b Mon Sep 17 00:00:00 2001
From: Ingo Molnar <mingo@kernel.org>
Date: Sat, 10 Feb 2018 11:51:57 +0100
Subject: [PATCH] x86/speculation: Clean up various Spectre related details

Harmonize all the Spectre messages so that a:

    dmesg | grep -i spectre

... gives us most Spectre related kernel boot messages.

Also fix a few other details:

 - clarify a comment about firmware speculation control

 - s/KPTI/PTI

 - remove various line-breaks that made the code uglier

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6f6d763225c8..eff45477fcca 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -162,8 +162,7 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2"))
 		return SPECTRE_V2_CMD_NONE;
 	else {
-		ret = cmdline_find_option(boot_command_line, "spectre_v2", arg,
-					  sizeof(arg));
+		ret = cmdline_find_option(boot_command_line, "spectre_v2", arg, sizeof(arg));
 		if (ret < 0)
 			return SPECTRE_V2_CMD_AUTO;
 
@@ -175,8 +174,7 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 		}
 
 		if (i >= ARRAY_SIZE(mitigation_options)) {
-			pr_err("unknown option (%s). Switching to AUTO select\n",
-			       mitigation_options[i].option);
+			pr_err("unknown option (%s). Switching to AUTO select\n", mitigation_options[i].option);
 			return SPECTRE_V2_CMD_AUTO;
 		}
 	}
@@ -185,8 +183,7 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 	     cmd == SPECTRE_V2_CMD_RETPOLINE_AMD ||
 	     cmd == SPECTRE_V2_CMD_RETPOLINE_GENERIC) &&
 	    !IS_ENABLED(CONFIG_RETPOLINE)) {
-		pr_err("%s selected but not compiled in. Switching to AUTO select\n",
-		       mitigation_options[i].option);
+		pr_err("%s selected but not compiled in. Switching to AUTO select\n", mitigation_options[i].option);
 		return SPECTRE_V2_CMD_AUTO;
 	}
 
@@ -256,14 +253,14 @@ static void __init spectre_v2_select_mitigation(void)
 			goto retpoline_auto;
 		break;
 	}
-	pr_err("kernel not compiled with retpoline; no mitigation available!");
+	pr_err("Spectre mitigation: kernel not compiled with retpoline; no mitigation available!");
 	return;
 
 retpoline_auto:
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
 	retpoline_amd:
 		if (!boot_cpu_has(X86_FEATURE_LFENCE_RDTSC)) {
-			pr_err("LFENCE not serializing. Switching to generic retpoline\n");
+			pr_err("Spectre mitigation: LFENCE not serializing, switching to generic retpoline\n");
 			goto retpoline_generic;
 		}
 		mode = retp_compiler() ? SPECTRE_V2_RETPOLINE_AMD :
@@ -281,7 +278,7 @@ static void __init spectre_v2_select_mitigation(void)
 	pr_info("%s\n", spectre_v2_strings[mode]);
 
 	/*
-	 * If neither SMEP or KPTI are available, there is a risk of
+	 * If neither SMEP or PTI are available, there is a risk of
 	 * hitting userspace addresses in the RSB after a context switch
 	 * from a shallow call stack to a deeper one. To prevent this fill
 	 * the entire RSB, even when using IBRS.
@@ -295,30 +292,30 @@ static void __init spectre_v2_select_mitigation(void)
 	if ((!boot_cpu_has(X86_FEATURE_PTI) &&
 	     !boot_cpu_has(X86_FEATURE_SMEP)) || is_skylake_era()) {
 		setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
-		pr_info("Filling RSB on context switch\n");
+		pr_info("Spectre mitigation: Filling RSB on context switch\n");
 	}
 
 	/* Initialize Indirect Branch Prediction Barrier if supported */
 	if (boot_cpu_has(X86_FEATURE_IBPB)) {
 		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
-		pr_info("Enabling Indirect Branch Prediction Barrier\n");
+		pr_info("Spectre mitigation: Enabling Indirect Branch Prediction Barrier (IBPB)\n");
 	}
 
 	/*
 	 * Retpoline means the kernel is safe because it has no indirect
-	 * branches. But firmware isn't, so use IBRS to protect that.
+	 * branches. But we don't know whether the firmware is safe, so
+	 * use IBRS to protect against that:
 	 */
 	if (boot_cpu_has(X86_FEATURE_IBRS)) {
 		setup_force_cpu_cap(X86_FEATURE_USE_IBRS_FW);
-		pr_info("Enabling Restricted Speculation for firmware calls\n");
+		pr_info("Spectre mitigation: Restricting branch speculation (enabling IBRS) for firmware calls\n");
 	}
 }
 
 #undef pr_fmt
 
 #ifdef CONFIG_SYSFS
-ssize_t cpu_show_meltdown(struct device *dev,
-			  struct device_attribute *attr, char *buf)
+ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	if (!boot_cpu_has_bug(X86_BUG_CPU_MELTDOWN))
 		return sprintf(buf, "Not affected\n");
@@ -327,16 +324,14 @@ ssize_t cpu_show_meltdown(struct device *dev,
 	return sprintf(buf, "Vulnerable\n");
 }
 
-ssize_t cpu_show_spectre_v1(struct device *dev,
-			    struct device_attribute *attr, char *buf)
+ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1))
 		return sprintf(buf, "Not affected\n");
 	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
 }
 
-ssize_t cpu_show_spectre_v2(struct device *dev,
-			    struct device_attribute *attr, char *buf)
+ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
 		return sprintf(buf, "Not affected\n");
