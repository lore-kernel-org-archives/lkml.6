Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49aTKg4vqAWkv6CogCiLN22FoL38z18fYNezxU2Bag4luSS5zzQ95FYM1lw7om/N0ddG+AD
ARC-Seal: i=1; a=rsa-sha256; t=1523021984; cv=none;
        d=google.com; s=arc-20160816;
        b=RfmMAu1o71ARarrImdyMqMGhs5Sun5g6by1jMXFSfhxZvHkpkt+Sx/RtJoF4RfUiwl
         +ANO56B+Ejh1k3LfHHFMAXDK5k29sIRfnl8fjmhNJdmlqw3kWsUmDlkdK7d/p/IqDNNg
         qThXgAncdbF5bOVaWHTwcDIgfd9pI6XUcbYM0zCSbMfdxsThGaevsp4h7wcxpcNONHXI
         4xYYUPJ5ZV9I9LNOhx26MyD/8uS2k090/DzzWpXSiKQnWKesoiEO0PaQX0P+ERgvu8Uy
         jvmqUAmDn9LpnL99oX2yyk4HD/aIKQdk+7X2n8xwboAVlG/RCGh0XfEgM+T3HAsS9mlY
         XP0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GQy47CtRKlUc/hSTwuuqnJPqkP1YHNxc+GLqydBbVq0=;
        b=fnPSnYFtDBxNx0F/EVQ47Y31L5reYGzG4MGp4Vv6qEwISx64lqMMGFachuS+5D3Rq6
         58iup025FLYz8tI8uscWtXckA+QoUXkVcDINaMaxQp7rFHNiccXQxy7Jnln6f2447a8t
         jrjDzkAQqvKFN0EQEjM3Cwe16Rk2nMOBJ75y+vZWCpnDgkAuSJ1xdHgxnqcvNib1rwqx
         4BqfADrng51GYyTLPxjYi6CHpbHuRh3jxYh8sFPOYEExTGpP5ga+eLVC+V5dCQ202fKU
         hcZKBjZa8TfuLcs8Ts31UkeJRvln1bJhD0u8TVmxV+qGCfKv7VvRiXB1ClGw/i+o99BA
         4r4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Gaku Inami <gaku.inami.xh@renesas.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 4.14 56/67] Revert "base: arch_topology: fix section mismatch build warnings"
Date: Fri,  6 Apr 2018 15:24:26 +0200
Message-Id: <20180406084348.050302670@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004300585915542?=
X-GMAIL-MSGID: =?utf-8?q?1597004300585915542?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gaku Inami <gaku.inami.xh@renesas.com>

commit 9de9a449482677a75f1edd2049268a7efc40fc96 upstream.

This reverts commit 452562abb5b7 ("base: arch_topology: fix section
mismatch build warnings"). It causes the notifier call hangs in some
use-cases.

In some cases with using maxcpus, some of cpus are booted first and
then the remaining cpus are booted. As an example, some users who want
to realize fast boot up often use the following procedure.

  1) Define all CPUs on device tree (CA57x4 + CA53x4)
  2) Add "maxcpus=4" in bootargs
  3) Kernel boot up with CA57x4
  4) After kernel boot up, CA53x4 is booted from user

When kernel init was finished, CPUFREQ_POLICY_NOTIFIER was not still
unregisterd. This means that "__init init_cpu_capacity_callback()"
will be called after kernel init sequence. To avoid this problem,
it needs to remove __init{,data} annotations by reverting this commit.

Also, this commit was needed to fix kernel compile issue below.
However, this issue was also fixed by another patch: commit 82d8ba717ccb
("arch_topology: Fix section miss match warning due to
free_raw_capacity()") in v4.15 as well.
Whereas commit 452562abb5b7 added all the missing __init annotations,
commit 82d8ba717ccb removed it from free_raw_capacity().

WARNING: vmlinux.o(.text+0x548f24): Section mismatch in reference
from the function init_cpu_capacity_callback() to the variable
.init.text:$x
The function init_cpu_capacity_callback() references
the variable __init $x.
This is often because init_cpu_capacity_callback lacks a __init
annotation or the annotation of $x is wrong.

Fixes: 82d8ba717ccb ("arch_topology: Fix section miss match warning due to free_raw_capacity()")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Gaku Inami <gaku.inami.xh@renesas.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/arch_topology.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -166,11 +166,11 @@ bool __init topology_parse_cpu_capacity(
 }
 
 #ifdef CONFIG_CPU_FREQ
-static cpumask_var_t cpus_to_visit __initdata;
-static void __init parsing_done_workfn(struct work_struct *work);
-static __initdata DECLARE_WORK(parsing_done_work, parsing_done_workfn);
+static cpumask_var_t cpus_to_visit;
+static void parsing_done_workfn(struct work_struct *work);
+static DECLARE_WORK(parsing_done_work, parsing_done_workfn);
 
-static int __init
+static int
 init_cpu_capacity_callback(struct notifier_block *nb,
 			   unsigned long val,
 			   void *data)
@@ -206,7 +206,7 @@ init_cpu_capacity_callback(struct notifi
 	return 0;
 }
 
-static struct notifier_block init_cpu_capacity_notifier __initdata = {
+static struct notifier_block init_cpu_capacity_notifier = {
 	.notifier_call = init_cpu_capacity_callback,
 };
 
@@ -232,7 +232,7 @@ static int __init register_cpufreq_notif
 }
 core_initcall(register_cpufreq_notifier);
 
-static void __init parsing_done_workfn(struct work_struct *work)
+static void parsing_done_workfn(struct work_struct *work)
 {
 	cpufreq_unregister_notifier(&init_cpu_capacity_notifier,
 					 CPUFREQ_POLICY_NOTIFIER);
