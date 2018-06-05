Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753248AbeFERFW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:05:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752033AbeFERFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:05:18 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "dwmw@amazon.co.uk, boris.ostrovsky@oracle.com, Juergen Gross"
        <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>
Subject: [PATCH 4.9 17/61] x86/amd: dont set X86_BUG_SYSRET_SS_ATTRS when running under Xen
Date: Tue,  5 Jun 2018 19:01:38 +0200
Message-Id: <20180605170118.702375842@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605170117.643936916@linuxfoundation.org>
References: <20180605170117.643936916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juergen Gross <jgross@suse.com>

Upstream commit: def9331a12977770cc6132d79f8e6565871e8e38 ("x86/amd:
don't set X86_BUG_SYSRET_SS_ATTRS when running under Xen")

When running as Xen pv guest X86_BUG_SYSRET_SS_ATTRS must not be set
on AMD cpus.

This bug/feature bit is kind of special as it will be used very early
when switching threads. Setting the bit and clearing it a little bit
later leaves a critical window where things can go wrong. This time
window has enlarged a little bit by using setup_clear_cpu_cap() instead
of the hypervisor's set_cpu_features callback. It seems this larger
window now makes it rather easy to hit the problem.

The proper solution is to never set the bit in case of Xen.

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/amd.c |    5 +++--
 arch/x86/xen/enlighten.c  |    4 +---
 2 files changed, 4 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -857,8 +857,9 @@ static void init_amd(struct cpuinfo_x86
 		if (cpu_has(c, X86_FEATURE_3DNOW) || cpu_has(c, X86_FEATURE_LM))
 			set_cpu_cap(c, X86_FEATURE_3DNOWPREFETCH);
 
-	/* AMD CPUs don't reset SS attributes on SYSRET */
-	set_cpu_bug(c, X86_BUG_SYSRET_SS_ATTRS);
+	/* AMD CPUs don't reset SS attributes on SYSRET, Xen does. */
+	if (!cpu_has(c, X86_FEATURE_XENPV))
+		set_cpu_bug(c, X86_BUG_SYSRET_SS_ATTRS);
 }
 
 #ifdef CONFIG_X86_32
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -474,10 +474,8 @@ static void __init xen_init_cpuid_mask(v
 
 static void __init xen_init_capabilities(void)
 {
-	if (xen_pv_domain()) {
-		setup_clear_cpu_cap(X86_BUG_SYSRET_SS_ATTRS);
+	if (xen_pv_domain())
 		setup_force_cpu_cap(X86_FEATURE_XENPV);
-	}
 }
 
 static void xen_set_debugreg(int reg, unsigned long val)
