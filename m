Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3A5C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8332320838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="4tvvh9lu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8332320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbeLFGGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 01:06:12 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60690 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729131AbeLFGGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 01:06:03 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB65xNmI025094;
        Thu, 6 Dec 2018 06:05:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=XBklHy8vSHYQYcjsPcyXmhV+Oh6uMBhDLfgsg3Z1Ag4=;
 b=4tvvh9lusuS8aFRGuH7zpUI5FQcXrN2HaC8BfDbUeHrtMTKYM6lARPCTMUpdrFRZSSV8
 EnuBKazOWcDSc7jTWW+4z6he6wuPGAB7Z6zCiyT/v0Itzpl3oVKqUbUeeNHQ1C7NZhvk
 ps5OQiX/4nM3EXoExT3WuIfn6fxPyoF58MO67vsmCcvGHlPyi4qQbniG/FtaiRPxUmE2
 e8/565bNTqvj19E587DFOTn2JmhRWLwiKyOuqrdPNONr1p0tk2bxn3F6LOTBd3S82Zf+
 xme/FIP9HdUZqW7V+4DZNrYiFhbWDq5KOWjm0XIly3UCxHHrseQzQUHXPZfkZ1f4rrO7 4A== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2p3hqu6c4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Dec 2018 06:05:38 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB665bQD016888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Dec 2018 06:05:38 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB665bb3030245;
        Thu, 6 Dec 2018 06:05:37 GMT
Received: from marawils-linux.us.oracle.com (/10.141.196.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Dec 2018 22:05:37 -0800
From:   Maran Wilson <maran.wilson@oracle.com>
To:     x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, jgross@suse.com
Cc:     boris.ostrovsky@oracle.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, roger.pau@citrix.com, rkrcmar@redhat.com,
        maran.wilson@oracle.com
Subject: [PATCH v8 3/7] xen/pvh: Create a new file for Xen specific PVH code
Date:   Wed,  5 Dec 2018 22:05:28 -0800
Message-Id: <1544076330-21992-1-git-send-email-maran.wilson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1544076152-21637-1-git-send-email-maran.wilson@oracle.com>
References: <1544076152-21637-1-git-send-email-maran.wilson@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9098 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812060055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to refactor PVH entry code so that support for other hypervisors
like Qemu/KVM can be added more easily.

The first step in that direction is to create a new file that will
eventually hold the Xen specific routines.

Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/platform/pvh/enlighten.c |  5 ++---
 arch/x86/xen/Makefile             |  2 ++
 arch/x86/xen/enlighten_pvh.c      | 10 ++++++++++
 3 files changed, 14 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/xen/enlighten_pvh.c

diff --git a/arch/x86/platform/pvh/enlighten.c b/arch/x86/platform/pvh/enlighten.c
index 02e3ab7ff242..491932991202 100644
--- a/arch/x86/platform/pvh/enlighten.c
+++ b/arch/x86/platform/pvh/enlighten.c
@@ -18,10 +18,9 @@
 /*
  * PVH variables.
  *
- * xen_pvh pvh_bootparams and pvh_start_info need to live in data segment
- * since they are used after startup_{32|64}, which clear .bss, are invoked.
+ * pvh_bootparams and pvh_start_info need to live in the data segment since
+ * they are used after startup_{32|64}, which clear .bss, are invoked.
  */
-bool xen_pvh __attribute__((section(".data"))) = 0;
 struct boot_params pvh_bootparams __attribute__((section(".data")));
 struct hvm_start_info pvh_start_info __attribute__((section(".data")));
 
diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
index b239922f6c6c..084de77a109e 100644
--- a/arch/x86/xen/Makefile
+++ b/arch/x86/xen/Makefile
@@ -36,6 +36,8 @@ obj-$(CONFIG_XEN_PV)		+= multicalls.o
 obj-$(CONFIG_XEN_PV)		+= xen-asm.o
 obj-$(CONFIG_XEN_PV)		+= xen-asm_$(BITS).o
 
+obj-$(CONFIG_XEN_PVH)		+= enlighten_pvh.o
+
 obj-$(CONFIG_EVENT_TRACING)	+= trace.o
 
 obj-$(CONFIG_SMP)		+= smp.o
diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
new file mode 100644
index 000000000000..6be7bc719b38
--- /dev/null
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/types.h>
+
+/*
+ * PVH variables.
+ *
+ * The variable xen_pvh needs to live in the data segment since it is used
+ * after startup_{32|64} is invoked, which will clear the .bss segment.
+ */
+bool xen_pvh __attribute__((section(".data"))) = 0;
-- 
2.16.1

