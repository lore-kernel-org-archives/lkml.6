Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A985ECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4A92075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C41jF4a4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D4A92075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731545AbeGRC6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 22:58:46 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44416 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730652AbeGRC6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 22:58:46 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6I2JURv196546;
        Wed, 18 Jul 2018 02:22:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=ZntRaDbUuxhxmDg3r+qcxXUnWZPIR2GeFaDystUaG8s=;
 b=C41jF4a4hJZ6MCUhPDlG851pbrnw+Y9SqmSB87qL008sKqBnDjZV1qPji6JVRq7qL90c
 x+IOgDQ44Jk1GYNxJDF6VE+NhD2nzF0AZmUIY48AvKq41rTWmIQDi+IwYP4DRNrPwgMn
 I6JsMv4lvPJjTBJXjPYbCn4tbd0bKnt75hTOGVKnUJJey6g9+W0euyjBHpi2PjbtpdBQ
 2+gw1+bx1R51hrCGyz1WECgAdZ1q5NHEB77+8B1DJejZjGnw/9SMl0sH0UHUPiQefVyX
 USDImbIIAEH/e41o7Z/zdH/47H4GeIG8LVjnaHdap5xXLLsNyzT0WvPZyasn6RiUmVzO 9g== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2k7a3t34cr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 02:22:29 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6I2MS2A027420
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 02:22:28 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6I2MQCf017360;
        Wed, 18 Jul 2018 02:22:26 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Jul 2018 19:22:26 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com,
        feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org, pasha.tatashin@oracle.com,
        boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
Subject: [PATCH v14 03/25] x86/kvmclock: Decrapify kvm_register_clock()
Date:   Tue, 17 Jul 2018 22:21:49 -0400
Message-Id: <20180718022211.6259-4-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180718022211.6259-1-pasha.tatashin@oracle.com>
References: <20180718022211.6259-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8957 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=846
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807180026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The return value is pointless because the wrmsr cannot fail if
KVM_FEATURE_CLOCKSOURCE or KVM_FEATURE_CLOCKSOURCE2 are set.

kvm_register_clock() is only called locally so wants to be static.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_para.h |  1 -
 arch/x86/kernel/kvmclock.c      | 34 +++++++++++----------------------
 2 files changed, 11 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
index 3aea2658323a..4c723632c036 100644
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -7,7 +7,6 @@
 #include <uapi/asm/kvm_para.h>
 
 extern void kvmclock_init(void);
-extern int kvm_register_clock(char *txt);
 
 #ifdef CONFIG_KVM_GUEST
 bool kvm_check_and_clear_guest_paused(void);
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index e9863639312c..cbf0a6b9217b 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -186,23 +186,19 @@ struct clocksource kvm_clock = {
 };
 EXPORT_SYMBOL_GPL(kvm_clock);
 
-int kvm_register_clock(char *txt)
+static void kvm_register_clock(char *txt)
 {
-	int cpu = smp_processor_id();
-	int low, high, ret;
 	struct pvclock_vcpu_time_info *src;
+	int cpu = smp_processor_id();
+	u64 pa;
 
 	if (!hv_clock)
-		return 0;
+		return;
 
 	src = &hv_clock[cpu].pvti;
-	low = (int)slow_virt_to_phys(src) | 1;
-	high = ((u64)slow_virt_to_phys(src) >> 32);
-	ret = native_write_msr_safe(msr_kvm_system_time, low, high);
-	printk(KERN_INFO "kvm-clock: cpu %d, msr %x:%x, %s\n",
-	       cpu, high, low, txt);
-
-	return ret;
+	pa = slow_virt_to_phys(src) | 0x01ULL;
+	wrmsrl(msr_kvm_system_time, pa);
+	pr_info("kvm-clock: cpu %d, msr %llx, %s\n", cpu, pa, txt);
 }
 
 static void kvm_save_sched_clock_state(void)
@@ -217,11 +213,7 @@ static void kvm_restore_sched_clock_state(void)
 #ifdef CONFIG_X86_LOCAL_APIC
 static void kvm_setup_secondary_clock(void)
 {
-	/*
-	 * Now that the first cpu already had this clocksource initialized,
-	 * we shouldn't fail.
-	 */
-	WARN_ON(kvm_register_clock("secondary cpu clock"));
+	kvm_register_clock("secondary cpu clock");
 }
 #endif
 
@@ -264,16 +256,12 @@ void __init kvmclock_init(void)
 	} else if (!(kvmclock && kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE)))
 		return;
 
-	hv_clock = (struct pvclock_vsyscall_time_info *)hv_clock_mem;
-
-	if (kvm_register_clock("primary cpu clock")) {
-		hv_clock = NULL;
-		return;
-	}
-
 	printk(KERN_INFO "kvm-clock: Using msrs %x and %x",
 		msr_kvm_system_time, msr_kvm_wall_clock);
 
+	hv_clock = (struct pvclock_vsyscall_time_info *)hv_clock_mem;
+	kvm_register_clock("primary cpu clock");
+
 	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE_STABLE_BIT))
 		pvclock_set_flags(PVCLOCK_TSC_STABLE_BIT);
 
-- 
2.18.0

