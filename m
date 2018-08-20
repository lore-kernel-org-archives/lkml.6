Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A72C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 668C720C0C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 668C720C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbeHTU2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 16:28:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59238 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726201AbeHTU2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 16:28:36 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7KHBwmY026559
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 13:12:08 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m010vhy5a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 13:12:01 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Mon, 20 Aug 2018 18:10:02 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 20 Aug 2018 18:10:00 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7KH9x3E29294700
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Aug 2018 17:09:59 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCAD44203F;
        Mon, 20 Aug 2018 20:10:01 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B4F242042;
        Mon, 20 Aug 2018 20:10:00 +0100 (BST)
Received: from srikart450.in.ibm.com (unknown [9.124.212.101])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 20 Aug 2018 20:10:00 +0100 (BST)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH] kobject: Access kobject name with caution if state is not initialized
Date:   Mon, 20 Aug 2018 22:39:47 +0530
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18082017-0008-0000-0000-000002644E01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082017-0009-0000-0000-000021CC88F7
Message-Id: <1534784987-16107-1-git-send-email-srikar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-20_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808200179
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If kobject state is not initialized, then its not even certain that
kobject'name is initialized. Hence when accessing the kobject's name
tread carefully.

A stupid module test like
https://github.com/srikard/tests/blob/master/modules/kobject_test.c
can panic the system.

With patch: We will see the correct warning.

[ 2058.129913] ------------[ cut here ]------------
[ 2058.129919] kobject: ' ' (00000000ad405b63): is not initialized, yet kobject_get() is being called.
[ 2058.129938] WARNING: CPU: 58 PID: 18529 at /home/srikar/work/linux.git/lib/kobject.c:620 kobject_get+0x90/0xb0
[ 2058.129946] Modules linked in: kobject_test(OE+) uio_pdrv_genirq(E) uio(E) leds_powernv(E) powernv_op_panel(E) ipmi_powernv(E) ipmi_devintf(E) powernv_rng(E) ibmpowernv(E) ipmi_msghandler(E) vmx_crypto(E) crct10dif_vpmsum(E) sch_fq_codel(E) ip_tables(E) x_tables(E) autofs4(E) ses enclosure scsi_transport_sas mlx4_ib mlx4_en ib_core lpfc crc32c_vpmsum mlx4_core nvmet_fc nvmet nvme_fc ipr nvme_fabrics devlink scsi_transport_fc tg3 [last unloaded: module_test]
[ 2058.130014] CPU: 58 PID: 18529 Comm: insmod Tainted: G        W  OEL    4.18.0-master+ #3
[ 2058.130022] NIP:  c000000000d5f530 LR: c000000000d5f52c CTR: 0000000000000000
[ 2058.130029] REGS: c000002fd32f3640 TRAP: 0700   Tainted: G        W  OEL     (4.18.0-master+)
[ 2058.130036] MSR:  9000000002029033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE>  CR: 48002282  XER: 20000000
[ 2058.130054] CFAR: c000000000114e10 IRQMASK: 0
               GPR00: c000000000d5f52c c000002fd32f38c0 c0000000017bc200 0000000000000057
               GPR04: 0000000000000001 000000000000107e 9000000002009033 00000000000000f2
               GPR08: 0000000000000007 0000000000000007 0000000000000001 9000000002001003
               GPR12: 0000000000002200 c000002ffffe0d00 0000000000000000 0000000000000000
               GPR16: 0000000000000000 c0000000001e92e0 0000000000000000 0000000000000100
               GPR20: 0000000000000001 c000000001662e60 c000000001662ed8 c000002feb4114a0
               GPR24: 0000000000000001 c000000000dbd438 c000000001662ea0 c000000001662ec0
               GPR28: c000002fe5f0cea0 d00000001ded03d0 c000002fd32f39a0 c000002fd32f39a0
[ 2058.130133] NIP [c000000000d5f530] kobject_get+0x90/0xb0
[ 2058.130140] LR [c000000000d5f52c] kobject_get+0x8c/0xb0
[ 2058.130146] Call Trace:
[ 2058.130150] [c000002fd32f38c0] [c000000000d5f52c] kobject_get+0x8c/0xb0 (unreliable)
[ 2058.130159] [c000002fd32f3940] [d00000001ded0088] kobject_test_init+0x80/0xb0 [kobject_test]
[ 2058.130168] [c000002fd32f39f0] [c0000000000101f8] do_one_initcall+0x58/0x240
[ 2058.130178] [c000002fd32f3ab0] [c0000000001ef2b0] do_init_module+0x90/0x260
[ 2058.130186] [c000002fd32f3b40] [c0000000001edec8] load_module+0x2d88/0x3320
[ 2058.130193] [c000002fd32f3d20] [c0000000001ee764] sys_finit_module+0xc4/0x130
[ 2058.130204] [c000002fd32f3e30] [c00000000000b288] system_call+0x5c/0x70
[ 2058.130210] Instruction dump:
[ 2058.130215] e89f0000 4b5b4c15 60000000 2f830000 419e0030 3c82ff8c 388491e0 3c62ff90
[ 2058.130228] 7fe5fb78 3863e9b0 4b3b5881 60000000 <0fe00000> e8010090 7c0803a6 4bffff88
[ 2058.130240] ---[ end trace 0f471c192555a013 ]---
[ 2070.084234] kobject_test module unloaded

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 lib/kobject.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index 389829d3a1d1..2d65be37fd7b 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -16,6 +16,7 @@
 #include <linux/stat.h>
 #include <linux/slab.h>
 #include <linux/random.h>
+#include <linux/uaccess.h>
 
 /**
  * kobject_namespace - return @kobj's namespace tag
@@ -417,8 +418,11 @@ int kobject_add(struct kobject *kobj, struct kobject *parent,
 		return -EINVAL;
 
 	if (!kobj->state_initialized) {
+		char tmp;
+		int ret = probe_kernel_address(kobject_name(kobj), tmp);
+
 		pr_err("kobject '%s' (%p): tried to add an uninitialized object, something is seriously wrong.\n",
-		       kobject_name(kobj), kobj);
+			ret ? " " : kobject_name(kobj), kobj);
 		dump_stack();
 		return -EINVAL;
 	}
@@ -606,10 +610,14 @@ EXPORT_SYMBOL(kobject_del);
 struct kobject *kobject_get(struct kobject *kobj)
 {
 	if (kobj) {
-		if (!kobj->state_initialized)
+		if (!kobj->state_initialized) {
+			char tmp;
+			int ret = probe_kernel_address(kobject_name(kobj), tmp);
+
 			WARN(1, KERN_WARNING
 				"kobject: '%s' (%p): is not initialized, yet kobject_get() is being called.\n",
-			     kobject_name(kobj), kobj);
+			     ret ? " " : kobject_name(kobj), kobj);
+		}
 		kref_get(&kobj->kref);
 	}
 	return kobj;
@@ -701,10 +709,14 @@ static void kobject_release(struct kref *kref)
 void kobject_put(struct kobject *kobj)
 {
 	if (kobj) {
-		if (!kobj->state_initialized)
+		if (!kobj->state_initialized) {
+			char tmp;
+			int ret = probe_kernel_address(kobject_name(kobj), tmp);
+
 			WARN(1, KERN_WARNING
 				"kobject: '%s' (%p): is not initialized, yet kobject_put() is being called.\n",
-			     kobject_name(kobj), kobj);
+			     ret ? " " : kobject_name(kobj), kobj);
+		}
 		kref_put(&kobj->kref, kobject_release);
 	}
 }
-- 
2.17.1

