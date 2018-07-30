Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B2713F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A9220881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2A1VedCJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A9220881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbeG3P2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:28:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:32988 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbeG3P2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:28:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6UDnIID169057;
        Mon, 30 Jul 2018 13:52:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2018-07-02;
 bh=6RsyW697kFg33w+es2yISRlSoDTYey21pJbH2vl01uM=;
 b=2A1VedCJ3J+yNWAIVUUichEWAuTpJEZtyV1scKmViWHtLFiTBzYKpU9zpY6SS8DvG+w4
 pyv/U004FYD9zY0QgDtUe3M8CuhhkJQ3KiphoKJQGNODmhd5NFDDp2lYSYItyMI8aeeX
 ppiTSaDuw9juEstXmAcvwpUe1YsAEoUN0xK0b8j2gzoxkSTnZXgbmF7RvQh202Mo7arP
 C/39QV8D+m6Uyw980Lw6c8eZJFcelS56djLrVYU9J4OIVSVn4Wax6wkTHjcvcWhMF2KJ
 nNeXJw281O0QHS1ZPt23INW5WdTb8kvjTMfT8dRplW/UFkJWZaWW7sz+VG2mgtABMRFu 0g== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2kgfwsvks5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jul 2018 13:52:59 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6UDqxo1026470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jul 2018 13:52:59 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6UDqws6019923;
        Mon, 30 Jul 2018 13:52:58 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Jul 2018 06:52:58 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        pasha.tatashin@oracle.com, mingo@redhat.com, peterz@infradead.org,
        linux@roeck-us.net
Subject: [PATCH] sched/clock: disable irq for generic_sched_clock_init
Date:   Mon, 30 Jul 2018 09:52:52 -0400
Message-Id: <20180730135252.24599-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8969 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=914
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807300154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sched_clock_init() used be called early in boot  when IRQs are still
disabled. Now, it is called when IRQs are already enabled, and this
triggers some warning:

WARNING: CPU: 0 PID: 0 at kernel/time/sched_clock.c:180
sched_clock_register+0x44/0x278
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 4.18.0-rc6-next-20180724 #1
Hardware name: ARM Integrator/CP (Device Tree)
[<c0010cb4>] (unwind_backtrace) from [<c000dc24>] (show_stack+0x10/0x18)
[<c000dc24>] (show_stack) from [<c03ffb94>] (dump_stack+0x18/0x24)
[<c03ffb94>] (dump_stack) from [<c001a000>] (__warn+0xc8/0xf0)
[<c001a000>] (__warn) from [<c001a13c>] (warn_slowpath_null+0x3c/0x4c)
[<c001a13c>] (warn_slowpath_null) from [<c052367c>] (sched_clock_register+0x44/0x278)
[<c052367c>] (sched_clock_register) from [<c05238d8>] (generic_sched_clock_init+0x28/0x88)
[<c05238d8>] (generic_sched_clock_init) from [<c0521a00>] (sched_clock_init+0x54/0x74)
[<c0521a00>] (sched_clock_init) from [<c0519c18>] (start_kernel+0x310/0x3e4)
[<c0519c18>] (start_kernel) from [<00000000>] (  (null))
---[ end trace 08080eb81afa002c ]---

Disable IRQs for the duration of generic_sched_clock_init().

Fixes: 857baa87b642 ("sched/clock: Enable sched clock early")

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
---
 kernel/sched/clock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index 811a39aca1ce..e3e3b979f9bd 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -452,7 +452,9 @@ EXPORT_SYMBOL_GPL(sched_clock_idle_wakeup_event);
 void __init sched_clock_init(void)
 {
 	static_branch_inc(&sched_clock_running);
+	local_irq_disable();
 	generic_sched_clock_init();
+	local_irq_enable();
 }
 
 u64 sched_clock_cpu(int cpu)
-- 
2.18.0

