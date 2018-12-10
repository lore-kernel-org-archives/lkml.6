Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE1DC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE202084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="u+QSnPbG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE202084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbeLJTJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:09:12 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:58026 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbeLJTJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:09:10 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBAJ8mQ4115781;
        Mon, 10 Dec 2018 19:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=XBklHy8vSHYQYcjsPcyXmhV+Oh6uMBhDLfgsg3Z1Ag4=;
 b=u+QSnPbGy6deX1wrTEW4l9lnD9Zzczd3E/mftArdy2BA62qC2e3DIOPh6O89DzMGYPzf
 SiA4LMl5EtfKWRVM8HH5VgxnwjnKoeiWk+ODvCYeZcKZGMFySXf5UeHKglkzQScCOdyJ
 5KE52nvkoqO7JPdJb6lQz8srm/fNyPhjiiGHTUFMHDwxLYUGFpPa8uJMaUEbpX6/y/cE
 /N1TLd0nvmrKQ7tHxyeVRtqTpBzL1RoqXTeiXYGYX8FrjKeRNHJf10/Jc6ZpImbRceWc
 VyI73YhtVgS3QXheLT0IU+vw55MdZDiowG4TSJH9plCmdzcFsgvig/3wWMwfWGEZAxxA tQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2p83fe01d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Dec 2018 19:08:54 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBAJ8rV2006370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Dec 2018 19:08:53 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBAJ8qTX018717;
        Mon, 10 Dec 2018 19:08:52 GMT
Received: from marawils-linux.us.oracle.com (/10.141.196.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Dec 2018 11:08:52 -0800
From:   Maran Wilson <maran.wilson@oracle.com>
To:     x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, jgross@suse.com
Cc:     boris.ostrovsky@oracle.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, roger.pau@citrix.com, rkrcmar@redhat.com,
        maran.wilson@oracle.com
Subject: [PATCH v9 3/7] xen/pvh: Create a new file for Xen specific PVH code
Date:   Mon, 10 Dec 2018 11:08:44 -0800
Message-Id: <1544468926-737-1-git-send-email-maran.wilson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1544468734-32763-1-git-send-email-maran.wilson@oracle.com>
References: <1544468734-32763-1-git-send-email-maran.wilson@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9103 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812100170
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

