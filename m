Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC40C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD99920823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zqSqv6En"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfARLKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 06:10:24 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:44098 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfARLKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 06:10:23 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0IB3nd2097799;
        Fri, 18 Jan 2019 11:09:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=vJ0vJrzTwis8w2+AQlcWaXGQ6PMulOuhthc3OKzqbnM=;
 b=zqSqv6En949O1MnRipyzH3VB4x8nRv7kbP2WvnPrGWXPrf6CuFit4KyxvD2SXkumhECO
 pcb9mEJLlZihvbXpSvNNXVby1kysnf1uf7p3lPW47wsP/ez7rWq2a42B1zcLclo3wQo7
 iE0ofE0dKeaufNMHmr5aPEfj1xTKSvTBwjjH6/Y+v6hxtriigBYVNjkAbw/yEFB7PA1F
 JMzrQG7TTVn0d6J8iBzg8AnIPRZ57nPbnuW6L6Z85n6EjjXeLmDlqLvXlDa4u1e6LVYi
 N4MdHbx0GkJ4HwTMWfR7sSB4wK0TRknoYqknVf1Q5RoGsaAeOFQr0RC75aZScsZHg2dQ 2A== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2pybjsn2k5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jan 2019 11:09:57 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0IB9tut019376
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jan 2019 11:09:55 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0IB9sXN031280;
        Fri, 18 Jan 2019 11:09:54 GMT
MIME-Version: 1.0
Message-ID: <48a105d3-fa32-40e4-9775-37d49f42eac0@default>
Date:   Fri, 18 Jan 2019 03:09:54 -0800 (PST)
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     <linux-kernel@vger.kernel.org>
Cc:     <mingo@redhat.com>, <konrad.wilk@oracle.com>, <x86@kernel.org>,
        <tglx@linutronix.de>, <srinivas.eeda@oracle.com>, <bp@suse.de>,
        <tim.c.chen@linux.intel.com>, <peterz@infradead.org>,
        <hpa@zytor.com>
Subject: [PATCH] x86/speculation: Update TIF_SPEC_IB before ibpb barrier
X-Mailer: Zimbra on Oracle Beehive
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9139 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=536
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901180083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a task is set for updating TIF_SPEC_IB throuth SECCOMP by others
and it's scheduled in the first time, a stale TIF_SPEC_IB value is
picked in cond_ibpb(). This is due to TIF_SPEC_IB is updated later at
__switch_to_xtra().

Add an extra call to speculation_ctrl_update_tif() to update it before
IBPB barrier.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
---
 arch/x86/include/asm/spec-ctrl.h | 1 +
 arch/x86/kernel/process.c        | 2 +-
 arch/x86/mm/tlb.c                | 4 +++-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/spec-ctrl.h b/arch/x86/include/asm/spec-c=
trl.h
index 5393bab..8b2814a 100644
--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -82,6 +82,7 @@ static inline u64 ssbd_tif_to_amd_ls_cfg(u64 tifn)
 static inline void speculative_store_bypass_ht_init(void) { }
 #endif
=20
+extern unsigned long speculation_ctrl_update_tif(struct task_struct *tsk);
 extern void speculation_ctrl_update(unsigned long tif);
 extern void speculation_ctrl_update_current(void);
=20
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 90ae0ca..454e71d 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -446,7 +446,7 @@ static __always_inline void __speculation_ctrl_update(u=
nsigned long tifp,
 =09=09wrmsrl(MSR_IA32_SPEC_CTRL, msr);
 }
=20
-static unsigned long speculation_ctrl_update_tif(struct task_struct *tsk)
+unsigned long speculation_ctrl_update_tif(struct task_struct *tsk)
 {
 =09if (test_and_clear_tsk_thread_flag(tsk, TIF_SPEC_FORCE_UPDATE)) {
 =09=09if (task_spec_ssb_disable(tsk))
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 999d6d8..c0f3fcf 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -8,6 +8,7 @@
 #include <linux/cpu.h>
 #include <linux/debugfs.h>
=20
+#include <asm/spec-ctrl.h>
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
 #include <asm/nospec-branch.h>
@@ -190,7 +191,8 @@ static void sync_current_stack_to_mm(struct mm_struct *=
mm)
=20
 static inline unsigned long mm_mangle_tif_spec_ib(struct task_struct *next=
)
 {
-=09unsigned long next_tif =3D task_thread_info(next)->flags;
+=09/* Update the flag bits to newest value actively */
+=09unsigned long next_tif =3D speculation_ctrl_update_tif(next);
 =09unsigned long ibpb =3D (next_tif >> TIF_SPEC_IB) & LAST_USER_MM_IBPB;
=20
 =09return (unsigned long)next->mm | ibpb;
--=20
1.8.3.1
