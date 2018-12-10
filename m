Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2C5C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B958C2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f3HEXVvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B958C2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbeLJTIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:08:35 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41192 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbeLJTIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:08:34 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBAIxHji113029;
        Mon, 10 Dec 2018 19:08:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=MtjmuHbEi0+8Ut3CJie6v5qOMYxdhXgYhRxSYrecVyQ=;
 b=f3HEXVvsqlZ4wtH/XF5GCmomov6zScr6reaspushgJtAWtO0uCU2kn3xRyqwxB+QEOvx
 853/flXFjquhVaZyl0M4YlySs7cklZIXXFtxuSPrAPKdmvH70i3+HT/B7M6+OkASHNJQ
 SUTdPCKY6alA5w2xenILm6cr7UVurFBTn9BaPHiC91Ld7lFfWZtafZaAGhqcJwxh/qHE
 ocrcPD8bwssBw4+6nc7hgrYmWtSvUFpWTiPjMMnZqJsvjhND72QRZrPndVjfJIi8cO8V
 XqpwtK0QmMoEt9PK6lr3I7vqgxQADHxQ6htU9h0ZBxmytbq09HmM5pXgJa96n9DKWx4v Hg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2p86kqqt9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Dec 2018 19:08:03 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBAJ82De002433
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Dec 2018 19:08:02 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBAJ81hr005774;
        Mon, 10 Dec 2018 19:08:01 GMT
Received: from marawils-linux.us.oracle.com (/10.141.196.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Dec 2018 11:08:00 -0800
From:   Maran Wilson <maran.wilson@oracle.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, jgross@suse.com
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        boris.ostrovsky@oracle.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, mchehab@kernel.org,
        rdunlap@infradead.org, roger.pau@citrix.com, rkrcmar@redhat.com,
        maran.wilson@oracle.com
Subject: [PATCH v9 2/7] xen/pvh: Move PVH entry code out of Xen specific tree
Date:   Mon, 10 Dec 2018 11:07:55 -0800
Message-Id: <1544468875-597-1-git-send-email-maran.wilson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1544468734-32763-1-git-send-email-maran.wilson@oracle.com>
References: <1544468734-32763-1-git-send-email-maran.wilson@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9103 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812100169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once hypervisors other than Xen start using the PVH entry point for
starting VMs, we would like the option of being able to compile PVH entry
capable kernels without enabling CONFIG_XEN and all the code that comes
along with that. To allow that, we are moving the PVH code out of Xen and
into files sitting at a higher level in the tree.

This patch is not introducing any code or functional changes, just moving
files from one location to another.

Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
---
 MAINTAINERS                                                | 1 +
 arch/x86/Kbuild                                            | 2 ++
 arch/x86/platform/pvh/Makefile                             | 5 +++++
 arch/x86/{xen/enlighten_pvh.c => platform/pvh/enlighten.c} | 0
 arch/x86/{xen/xen-pvh.S => platform/pvh/head.S}            | 0
 arch/x86/xen/Makefile                                      | 4 ----
 6 files changed, 8 insertions(+), 4 deletions(-)
 create mode 100644 arch/x86/platform/pvh/Makefile
 rename arch/x86/{xen/enlighten_pvh.c => platform/pvh/enlighten.c} (100%)
 rename arch/x86/{xen/xen-pvh.S => platform/pvh/head.S} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index d27401df091f..477ab97c2062 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16461,6 +16461,7 @@ L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
 S:	Supported
 F:	arch/x86/xen/
+F:	arch/x86/platform/pvh/
 F:	drivers/*/xen-*front.c
 F:	drivers/xen/
 F:	arch/x86/include/asm/xen/
diff --git a/arch/x86/Kbuild b/arch/x86/Kbuild
index 0038a2d10a7a..2089e4414300 100644
--- a/arch/x86/Kbuild
+++ b/arch/x86/Kbuild
@@ -7,6 +7,8 @@ obj-$(CONFIG_KVM) += kvm/
 # Xen paravirtualization support
 obj-$(CONFIG_XEN) += xen/
 
+obj-$(CONFIG_XEN_PVH) += platform/pvh/
+
 # Hyper-V paravirtualization support
 obj-$(subst m,y,$(CONFIG_HYPERV)) += hyperv/
 
diff --git a/arch/x86/platform/pvh/Makefile b/arch/x86/platform/pvh/Makefile
new file mode 100644
index 000000000000..9fd25efcd2a3
--- /dev/null
+++ b/arch/x86/platform/pvh/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+OBJECT_FILES_NON_STANDARD_head.o := y
+
+obj-$(CONFIG_XEN_PVH) += enlighten.o
+obj-$(CONFIG_XEN_PVH) += head.o
diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/platform/pvh/enlighten.c
similarity index 100%
rename from arch/x86/xen/enlighten_pvh.c
rename to arch/x86/platform/pvh/enlighten.c
diff --git a/arch/x86/xen/xen-pvh.S b/arch/x86/platform/pvh/head.S
similarity index 100%
rename from arch/x86/xen/xen-pvh.S
rename to arch/x86/platform/pvh/head.S
diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
index dd2550d33b38..b239922f6c6c 100644
--- a/arch/x86/xen/Makefile
+++ b/arch/x86/xen/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 OBJECT_FILES_NON_STANDARD_xen-asm_$(BITS).o := y
-OBJECT_FILES_NON_STANDARD_xen-pvh.o := y
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not profile debug and lowlevel utilities
@@ -37,9 +36,6 @@ obj-$(CONFIG_XEN_PV)		+= multicalls.o
 obj-$(CONFIG_XEN_PV)		+= xen-asm.o
 obj-$(CONFIG_XEN_PV)		+= xen-asm_$(BITS).o
 
-obj-$(CONFIG_XEN_PVH)		+= enlighten_pvh.o
-obj-$(CONFIG_XEN_PVH)	 	+= xen-pvh.o
-
 obj-$(CONFIG_EVENT_TRACING)	+= trace.o
 
 obj-$(CONFIG_SMP)		+= smp.o
-- 
2.16.1

