Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36DDECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC122075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LqG0AL4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC122075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731633AbeGRC6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 22:58:47 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44418 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731225AbeGRC6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 22:58:46 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6I2JWFw196557;
        Wed, 18 Jul 2018 02:22:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=2/2mUIP1useLQ8rBekcLf5mLbx3AV7Bin4FelnnmozY=;
 b=LqG0AL4Sn0zVHCPcal5joYCXBtidq7LHextpEYnhuUrW1xhqYLn0HWS/l5pdSpCO5kzy
 +CMGUuqCa7hMuRBD/IbQ2vMlbuBqJs/q91MUEqXNTjAqJM2OGGrz6EdljjuzPP0d0ERv
 iUrQOekfvLsnO2olNw0a2neeUmzXXNYpraPsTEPQwxrwvfxg10MdOGv91W8H6sZEo4rs
 SsG8xCi4TIxRZ1yOpVpUlDYWmpIs3MjZWMKeDm9gz4STBseo3YuBAYmEAhekvsLN8Hu2
 riTXJHIky79aohvUeCMzmG77WvjlAVkjuB8ooraxpjZp5uD/u4W8yI6bgIQYKl0kz5vc tg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2k7a3t34cq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 02:22:25 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6I2MPbt023118
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 02:22:25 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6I2MOP0020545;
        Wed, 18 Jul 2018 02:22:24 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Jul 2018 19:22:23 -0700
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
Subject: [PATCH v14 02/25] x86/kvmclock: Remove page size requirement from wall_clock
Date:   Tue, 17 Jul 2018 22:21:48 -0400
Message-Id: <20180718022211.6259-3-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180718022211.6259-1-pasha.tatashin@oracle.com>
References: <20180718022211.6259-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8957 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807180026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

There is no requirement for wall_clock data to be page aligned or page
sized.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kernel/kvmclock.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 890e9e58e4bf..e9863639312c 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -46,14 +46,12 @@ early_param("no-kvmclock", parse_no_kvmclock);
 
 /* Aligned to page sizes to match whats mapped via vsyscalls to userspace */
 #define HV_CLOCK_SIZE	(sizeof(struct pvclock_vsyscall_time_info) * NR_CPUS)
-#define WALL_CLOCK_SIZE	(sizeof(struct pvclock_wall_clock))
 
 static u8 hv_clock_mem[PAGE_ALIGN(HV_CLOCK_SIZE)] __aligned(PAGE_SIZE);
-static u8 wall_clock_mem[PAGE_ALIGN(WALL_CLOCK_SIZE)] __aligned(PAGE_SIZE);
 
 /* The hypervisor will put information about time periodically here */
 static struct pvclock_vsyscall_time_info *hv_clock;
-static struct pvclock_wall_clock *wall_clock;
+static struct pvclock_wall_clock wall_clock;
 
 /*
  * The wallclock is the time of day when we booted. Since then, some time may
@@ -66,15 +64,15 @@ static void kvm_get_wallclock(struct timespec64 *now)
 	int low, high;
 	int cpu;
 
-	low = (int)slow_virt_to_phys(wall_clock);
-	high = ((u64)slow_virt_to_phys(wall_clock) >> 32);
+	low = (int)slow_virt_to_phys(&wall_clock);
+	high = ((u64)slow_virt_to_phys(&wall_clock) >> 32);
 
 	native_write_msr(msr_kvm_wall_clock, low, high);
 
 	cpu = get_cpu();
 
 	vcpu_time = &hv_clock[cpu].pvti;
-	pvclock_read_wallclock(wall_clock, vcpu_time, now);
+	pvclock_read_wallclock(&wall_clock, vcpu_time, now);
 
 	put_cpu();
 }
@@ -266,12 +264,10 @@ void __init kvmclock_init(void)
 	} else if (!(kvmclock && kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE)))
 		return;
 
-	wall_clock = (struct pvclock_wall_clock *)wall_clock_mem;
 	hv_clock = (struct pvclock_vsyscall_time_info *)hv_clock_mem;
 
 	if (kvm_register_clock("primary cpu clock")) {
 		hv_clock = NULL;
-		wall_clock = NULL;
 		return;
 	}
 
-- 
2.18.0

