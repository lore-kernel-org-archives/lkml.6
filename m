Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1465196-1518185061-2-7378924771755130578
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518185060; b=ezagPEBrJ6w2ab6DPLnHfXPKBqVupr09Q8dSHIsOD6azWvm
    2ZWN94dABkmwHny/R/LhCx8d6gXQvnLngMQldEHaml8E8jW8RRcHYT0f0sSRXDaI
    NShi6xGAh+YuQN/72dsHhbd+a0FsGl8USepCcwQ3wYWNFNiW9zDHY9fIg301xiWw
    nxXjMNNEThHk+VWHNMObv5JTGp9sbT43sOWrYbZMx9sG0775eKG0U7hjmuv7Dp3x
    lf0ENCmh6NPiXqfal1LA5ifeug5tkMJfpqIrlH0IIL7RzJ7GMnu6SRYYwYp+yJHf
    EvWPssQmluDfI/sbznkUzQj99aw865xCCFIhgjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518185060; bh=AcvpkX9zb6R7IjWfhgcXKYB3xp
    6khjULdIIQ1YwjzBE=; b=FrBlLtaRmIb0sUfVHqHS9WsE0Kl1+m4uZv4Q6R7dWI
    RWp9tn9jngNspd9pujGMOqjLAelHIErIdJNDsac1MGUUXerlC8DUyExivfClywuz
    54LgGep4T+2BPbvIo+R0nEC0EHgwnthOllzBFdVkrJJIbAzPO5qFdXg8r79J2K7T
    g7tsYQIpKd6A6od9n71yKs0xYoV8+d1RSuwdQ1xDZ6QOb5uNCpuU2Qccv9qYifqM
    BqxdkEMDZ+JUoHpmMo9Rvo2He5HGQePo+ISxCC7WbKF1qcbzphVOeCbh8deD8ceS
    eBeo2W4FD46Fm8yj1OnQpTVM95YxDhFpGD73+8uDiOZg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751189AbeBIODz (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 09:03:55 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50864 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753251AbeBINnh (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:43:37 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>, karahmed@amazon.de,
        peterz@infradead.org, bp@alien8.de
Subject: [PATCH 4.9 69/92] x86/cpuid: Fix up "virtual" IBRS/IBPB/STIBP feature bits on Intel
Date: Fri,  9 Feb 2018 14:39:38 +0100
Message-Id: <20180209133936.214516603@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>


(cherry picked from commit 7fcae1118f5fd44a862aa5c3525248e35ee67c3b)

Despite the fact that all the other code there seems to be doing it, just
using set_cpu_cap() in early_intel_init() doesn't actually work.

For CPUs with PKU support, setup_pku() calls get_cpu_cap() after
c->c_init() has set those feature bits. That resets those bits back to what
was queried from the hardware.

Turning the bits off for bad microcode is easy to fix. That can just use
setup_clear_cpu_cap() to force them off for all CPUs.

I was less keen on forcing the feature bits *on* that way, just in case
of inconsistencies. I appreciate that the kernel is going to get this
utterly wrong if CPU features are not consistent, because it has already
applied alternatives by the time secondary CPUs are brought up.

But at least if setup_force_cpu_cap() isn't being used, we might have a
chance of *detecting* the lack of the corresponding bit and either
panicking or refusing to bring the offending CPU online.

So ensure that the appropriate feature bits are set within get_cpu_cap()
regardless of how many extra times it's called.

Fixes: 2961298e ("x86/cpufeatures: Clean up Spectre v2 related CPUID flags")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: karahmed@amazon.de
Cc: peterz@infradead.org
Cc: bp@alien8.de
Link: https://lkml.kernel.org/r/1517322623-15261-1-git-send-email-dwmw@amazon.co.uk
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/common.c |   21 +++++++++++++++++++++
 arch/x86/kernel/cpu/intel.c  |   27 ++++++++-------------------
 2 files changed, 29 insertions(+), 19 deletions(-)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -718,6 +718,26 @@ static void apply_forced_caps(struct cpu
 	}
 }
 
+static void init_speculation_control(struct cpuinfo_x86 *c)
+{
+	/*
+	 * The Intel SPEC_CTRL CPUID bit implies IBRS and IBPB support,
+	 * and they also have a different bit for STIBP support. Also,
+	 * a hypervisor might have set the individual AMD bits even on
+	 * Intel CPUs, for finer-grained selection of what's available.
+	 *
+	 * We use the AMD bits in 0x8000_0008 EBX as the generic hardware
+	 * features, which are visible in /proc/cpuinfo and used by the
+	 * kernel. So set those accordingly from the Intel bits.
+	 */
+	if (cpu_has(c, X86_FEATURE_SPEC_CTRL)) {
+		set_cpu_cap(c, X86_FEATURE_IBRS);
+		set_cpu_cap(c, X86_FEATURE_IBPB);
+	}
+	if (cpu_has(c, X86_FEATURE_INTEL_STIBP))
+		set_cpu_cap(c, X86_FEATURE_STIBP);
+}
+
 void get_cpu_cap(struct cpuinfo_x86 *c)
 {
 	u32 eax, ebx, ecx, edx;
@@ -812,6 +832,7 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		c->x86_capability[CPUID_8000_000A_EDX] = cpuid_edx(0x8000000a);
 
 	init_scattered_cpuid_features(c);
+	init_speculation_control(c);
 }
 
 static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -140,28 +140,17 @@ static void early_init_intel(struct cpui
 		rdmsr(MSR_IA32_UCODE_REV, lower_word, c->microcode);
 	}
 
-	/*
-	 * The Intel SPEC_CTRL CPUID bit implies IBRS and IBPB support,
-	 * and they also have a different bit for STIBP support. Also,
-	 * a hypervisor might have set the individual AMD bits even on
-	 * Intel CPUs, for finer-grained selection of what's available.
-	 */
-	if (cpu_has(c, X86_FEATURE_SPEC_CTRL)) {
-		set_cpu_cap(c, X86_FEATURE_IBRS);
-		set_cpu_cap(c, X86_FEATURE_IBPB);
-	}
-	if (cpu_has(c, X86_FEATURE_INTEL_STIBP))
-		set_cpu_cap(c, X86_FEATURE_STIBP);
-
 	/* Now if any of them are set, check the blacklist and clear the lot */
-	if ((cpu_has(c, X86_FEATURE_IBRS) || cpu_has(c, X86_FEATURE_IBPB) ||
+	if ((cpu_has(c, X86_FEATURE_SPEC_CTRL) ||
+	     cpu_has(c, X86_FEATURE_INTEL_STIBP) ||
+	     cpu_has(c, X86_FEATURE_IBRS) || cpu_has(c, X86_FEATURE_IBPB) ||
 	     cpu_has(c, X86_FEATURE_STIBP)) && bad_spectre_microcode(c)) {
 		pr_warn("Intel Spectre v2 broken microcode detected; disabling Speculation Control\n");
-		clear_cpu_cap(c, X86_FEATURE_IBRS);
-		clear_cpu_cap(c, X86_FEATURE_IBPB);
-		clear_cpu_cap(c, X86_FEATURE_STIBP);
-		clear_cpu_cap(c, X86_FEATURE_SPEC_CTRL);
-		clear_cpu_cap(c, X86_FEATURE_INTEL_STIBP);
+		setup_clear_cpu_cap(X86_FEATURE_IBRS);
+		setup_clear_cpu_cap(X86_FEATURE_IBPB);
+		setup_clear_cpu_cap(X86_FEATURE_STIBP);
+		setup_clear_cpu_cap(X86_FEATURE_SPEC_CTRL);
+		setup_clear_cpu_cap(X86_FEATURE_INTEL_STIBP);
 	}
 
 	/*
