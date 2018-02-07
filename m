Return-Path: <prarit@redhat.com>
X-Google-Smtp-Source: AH8x226Y3Q9qrp1hs5Nh6LgOBTUz9eaKxQSICMlibUfwkzUjVeQvp6o55UF8g9VOR1lzTirrf9Ts
ARC-Seal: i=1; a=rsa-sha256; t=1518047368; cv=none;
        d=google.com; s=arc-20160816;
        b=LxnNkjg1vVAH0O9I2q5n4v5J0xRCWReBmmJG4xTObIp7bA8572NOPyaZpZYCSuOdln
         HvWFYis+nvUVwsYr52AjzjTbmLvehrGLJHy0BZIFCOAdzZaZBl0peIZDGKDfYOEmIZWz
         L/UgZaq9iFdKdNPk4hNbcZXpNaqgMBUNHqsA1T+m0axqDHs9KTZw7xQq5J3hnPWcAEvc
         qB4nR3jvCbtPSmTfPMFNlwBJrmipP0g6wHFZcvrRpgQBejP2CfNyyNWtT/f357hVZmGo
         3pOS9LoKQSwZb3ges6Av0Nqw1KG/mQlPoYnqP6Uygfugke6zIrJjniYAu/k0SA0N/DH0
         ZkBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=6XYV+u3XBsQC5Hbr2v1siuE6XY6pnpF1DayvYE0OIQ8=;
        b=xCbh1MmIffdMimSc0VQ4vwI5ghCQ2wvMZl9g1DJjk2sGc22ekUb3R7zd0Uemk3dXre
         xhFwd95Od3ZHgmnb7r+Ns3XZSeP83f1swM/DTZTSkTLMm+TkL5ON8pLyiT56bVZT7ECN
         onphhDezUQmjvUhl9/CQ0g0YHsbcP0SxmNyPd3MfwhlA1rAIesFFees14oB/GtSCvwDi
         NAeRluqfW2sS4geuo7LZbt9pOU262/HpOJZ4MJHgqY1gFaZVrzN6bIRsnVH6NfgAtqlW
         9qcRVBCOLNHN2/0wupVfHNrKceRjwbRxYwDvrCQI2azmmK+256ykLitBoif84IbXN6VH
         WZZw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of prarit@redhat.com designates 209.132.183.28 as permitted sender) smtp.mailfrom=prarit@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of prarit@redhat.com designates 209.132.183.28 as permitted sender) smtp.mailfrom=prarit@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
From: Prarit Bhargava <prarit@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Juergen Gross <jgross@suse.com>,
	Dou Liyang <douly.fnst@cn.fujitsu.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Andi Kleen <ak@linux.intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	xen-devel@lists.xenproject.org
Subject: [PATCH] x86/xen: Calculate __max_logical_packages on PV domains
Date: Wed,  7 Feb 2018 18:49:23 -0500
Message-Id: <20180207234923.13544-1-prarit@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591788037595473599?=
X-GMAIL-MSGID: =?utf-8?q?1591788037595473599?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The kernel panics on PV domains because native_smp_cpus_done() is
only called for HVM domains.

Calculate __max_logical_packages for PV domains.

Fixes: b4c0a7326f5d ("x86/smpboot: Fix __max_logical_packages estimate")
Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Tested-and-reported-by: Simon Gaiser <simon@invisiblethingslab.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: xen-devel@lists.xenproject.org
---
 arch/x86/include/asm/smp.h |  1 +
 arch/x86/kernel/smpboot.c  | 10 ++++++++--
 arch/x86/xen/smp.c         |  2 ++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 461f53d27708..a4189762b266 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -129,6 +129,7 @@ static inline void arch_send_call_function_ipi_mask(const struct cpumask *mask)
 void cpu_disable_common(void);
 void native_smp_prepare_boot_cpu(void);
 void native_smp_prepare_cpus(unsigned int max_cpus);
+void calculate_max_logical_packages(void);
 void native_smp_cpus_done(unsigned int max_cpus);
 void common_cpu_up(unsigned int cpunum, struct task_struct *tidle);
 int native_cpu_up(unsigned int cpunum, struct task_struct *tidle);
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 6f27facbaa9b..767573b7f2db 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1281,11 +1281,10 @@ void __init native_smp_prepare_boot_cpu(void)
 	cpu_set_state_online(me);
 }
 
-void __init native_smp_cpus_done(unsigned int max_cpus)
+void __init calculate_max_logical_packages(void)
 {
 	int ncpus;
 
-	pr_debug("Boot done\n");
 	/*
 	 * Today neither Intel nor AMD support heterogenous systems so
 	 * extrapolate the boot cpu's data to all packages.
@@ -1293,6 +1292,13 @@ void __init native_smp_cpus_done(unsigned int max_cpus)
 	ncpus = cpu_data(0).booted_cores * topology_max_smt_threads();
 	__max_logical_packages = DIV_ROUND_UP(nr_cpu_ids, ncpus);
 	pr_info("Max logical packages: %u\n", __max_logical_packages);
+}
+
+void __init native_smp_cpus_done(unsigned int max_cpus)
+{
+	pr_debug("Boot done\n");
+
+	calculate_max_logical_packages();
 
 	if (x86_has_numa_in_package)
 		set_sched_topology(x86_numa_in_package_topology);
diff --git a/arch/x86/xen/smp.c b/arch/x86/xen/smp.c
index 77c959cf81e7..7a43b2ae19f1 100644
--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -122,6 +122,8 @@ void __init xen_smp_cpus_done(unsigned int max_cpus)
 
 	if (xen_hvm_domain())
 		native_smp_cpus_done(max_cpus);
+	else
+		calculate_max_logical_packages();
 
 	if (xen_have_vcpu_info_placement)
 		return;
-- 
2.15.0.rc0.39.g2f0e14e64
