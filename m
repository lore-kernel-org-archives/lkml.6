Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C790ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505D52084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O+/d26sN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 505D52084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbeGSVmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 17:42:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50816 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730821AbeGSVmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 17:42:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6JKs6VO156730;
        Thu, 19 Jul 2018 20:56:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=XrRbhf3twvdaYzhNW+EV+4STib3pW8j21uVam7a6pDE=;
 b=O+/d26sNHpJqM1Rc6OCwX1qfoyyAwi/RnNkoTTumGA8AceUikETC3OJet8hxaTCZZ1Ck
 9Y9ZU/ZoIW94IhNPC6PiZFFeh/quiGsMvYzHFjtr7LoFq+AORsIXTPrwQ7Ud5vPdRDow
 nGf8PdwhS0FZx9mU+AczrBqunrNhSH7TzvyAVkB57WPi+DG5Q3QpGk4SfQzeHYmh/prO
 lzMGDeCEbKJLtX0GhOZWjoPp2T7s59aGxLUx+VQe0FnvOISPa/TVgVAfaLZO8soeDIn8
 gxMg56uJFNdVMv0b5iax9iWlCMe5rgjkOBGAxsoBvxOH4DZ7qCDYaxyBtVzRnVRvNDmY 5g== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2k9yjx8uu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 20:56:21 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6JKuKrR000540
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 20:56:20 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6JKuKwU002242;
        Thu, 19 Jul 2018 20:56:20 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Jul 2018 20:56:20 +0000
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
Subject: [PATCH v15 05/26] x86/kvmclock: Mark variables __initdata and __ro_after_init
Date:   Thu, 19 Jul 2018 16:55:24 -0400
Message-Id: <20180719205545.16512-6-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180719205545.16512-1-pasha.tatashin@oracle.com>
References: <20180719205545.16512-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8959 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807190218
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The kvmclock parameter is init data and the other variables are not
modified after init.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kernel/kvmclock.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 4afb03e49a4f..78aec160f5e0 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -32,10 +32,10 @@
 #include <asm/reboot.h>
 #include <asm/kvmclock.h>
 
-static int kvmclock __ro_after_init = 1;
-static int msr_kvm_system_time = MSR_KVM_SYSTEM_TIME;
-static int msr_kvm_wall_clock = MSR_KVM_WALL_CLOCK;
-static u64 kvm_sched_clock_offset;
+static int kvmclock __initdata = 1;
+static int msr_kvm_system_time __ro_after_init = MSR_KVM_SYSTEM_TIME;
+static int msr_kvm_wall_clock __ro_after_init = MSR_KVM_WALL_CLOCK;
+static u64 kvm_sched_clock_offset __ro_after_init;
 
 static int __init parse_no_kvmclock(char *arg)
 {
@@ -50,7 +50,7 @@ early_param("no-kvmclock", parse_no_kvmclock);
 static u8 hv_clock_mem[PAGE_ALIGN(HV_CLOCK_SIZE)] __aligned(PAGE_SIZE);
 
 /* The hypervisor will put information about time periodically here */
-static struct pvclock_vsyscall_time_info *hv_clock;
+static struct pvclock_vsyscall_time_info *hv_clock __ro_after_init;
 static struct pvclock_wall_clock wall_clock;
 
 /*
-- 
2.18.0

