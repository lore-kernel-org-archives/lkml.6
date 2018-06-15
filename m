Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4022CC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8D6208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MyOksR3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE8D6208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966350AbeFORni (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 13:43:38 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:59014 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966080AbeFORnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 13:43:15 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5FHcWHE139317;
        Fri, 15 Jun 2018 17:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2017-10-26;
 bh=I4yGbMnHhIDblV6Yzh4pVP0FQYFl7ETeY1WLl0f6RTw=;
 b=MyOksR3jrU2Ny+6NHlVxOPYYEzAsdUNnZac3wDzlV9aC3I/JAEsc2J2SFpbh5jdZIzHk
 dpFmNOW3FmHHcJErekrO6LOKV4r9TWmLzKmofSADDyLDkNWX+Am9ZlcTCDVAfSXFp4GS
 zODVLKKuy9Y4sSRq0OchBU3jX3pSLaoj4wIjwmYm5T8oJ/hoSOZq5J58hzge8m1s+85P
 d5fhl8EPdFhcVtsj0hslwULTcGL8bPzaCFfQYrbMjnvDG19XY3KcOA34uUeHyKmjg9wv
 rAQDwHa0yhbti0v7dQfKY3e0QxJjFXb8jw+J5bsR4Z3V0tKbds4XUQH/f2NmOeU7izGc jg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2jk0xr1vys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 17:42:24 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5FHgNnS002516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 17:42:24 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5FHgMWR004421;
        Fri, 15 Jun 2018 17:42:22 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Jun 2018 10:42:22 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com,
        feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk
Subject: [PATCH v10 6/7] x86/paravirt: add active_sched_clock to pv_time_ops
Date:   Fri, 15 Jun 2018 13:42:03 -0400
Message-Id: <20180615174204.30581-7-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615174204.30581-1-pasha.tatashin@oracle.com>
References: <20180615174204.30581-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8925 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=915
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806150189
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Early boot clock might differ from the clock that is used later on,
therefore add a new field to pv_time_ops, that shows currently active
clock. If platform supports early boot clock, this field will be changed
to use that clock early in boot, and later will be replaced with the
permanent clock.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/include/asm/paravirt_types.h | 1 +
 arch/x86/kernel/paravirt.c            | 1 +
 arch/x86/xen/time.c                   | 7 ++++---
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 180bc0bff0fb..d555b66c5bbb 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -99,6 +99,7 @@ struct pv_lazy_ops {
 struct pv_time_ops {
 	unsigned long long (*sched_clock)(void);
 	unsigned long long (*steal_clock)(int cpu);
+	unsigned long long (*active_sched_clock)(void);
 } __no_randomize_layout;
 
 struct pv_cpu_ops {
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 99dc79e76bdc..5bfdb72f152f 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -320,6 +320,7 @@ struct pv_init_ops pv_init_ops = {
 struct pv_time_ops pv_time_ops = {
 	.sched_clock = native_sched_clock,
 	.steal_clock = native_steal_clock,
+	.active_sched_clock = native_sched_clock,
 };
 
 __visible struct pv_irq_ops pv_irq_ops = {
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index e0f1bcf01d63..29b07020c827 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -505,8 +505,8 @@ static void __init xen_time_init(void)
 
 void __ref xen_init_time_ops(void)
 {
-	pv_time_ops = xen_time_ops;
-
+	pv_time_ops.sched_clock = xen_time_ops.sched_clock;
+	pv_time_ops.steal_clock = xen_time_ops.steal_clock;
 	x86_init.timers.timer_init = xen_time_init;
 	x86_init.timers.setup_percpu_clockev = x86_init_noop;
 	x86_cpuinit.setup_percpu_clockev = x86_init_noop;
@@ -547,7 +547,8 @@ void __init xen_hvm_init_time_ops(void)
 		return;
 	}
 
-	pv_time_ops = xen_time_ops;
+	pv_time_ops.sched_clock = xen_time_ops.sched_clock;
+	pv_time_ops.steal_clock = xen_time_ops.steal_clock;
 	x86_init.timers.setup_percpu_clockev = xen_time_init;
 	x86_cpuinit.setup_percpu_clockev = xen_hvm_setup_cpu_clockevents;
 
-- 
2.17.1

