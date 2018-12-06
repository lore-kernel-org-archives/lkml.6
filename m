Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7D4C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7E020989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="naPvf6EJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7E020989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbeLFGFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 01:05:50 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54986 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbeLFGFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 01:05:50 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB65xV4p182521;
        Thu, 6 Dec 2018 06:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=DciFCSrQQ2VxyKH8yaRNOZ40JJRsONHWShtjb3FMh80=;
 b=naPvf6EJJp+YQwPrkYVOFYxu4UCxKICwrMlrGBsOotNoXgZWSHQO/2zurWANFu9Aa97x
 GOwYiMGKfz44Q392AB4asR0XtC8wBu/SnkqmP4rGbfar9xbEdAcQPXbQubuUzaIlFBCp
 aCoDm9wOr2RvEqQnoO0OkCbTo1V6XB2/XUUPLFwBQOACyfzNjXlNqbdGX/F5uOzuQS8j
 QGnVNI2VSI0EMxtHJ7enyQA783cxIp2wjBajxUpxFBDMX0YaPozVoUoGxsOW8Hz84dxh
 BlwzGgrM2hVeGSLhb3upyFhLt6eAIGM9fhIBysyPh0R4AjVlSNjUE2L3ck9kZsAadYKQ Dg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2p3jxrp7um-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Dec 2018 06:05:02 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB664u83024981
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Dec 2018 06:04:56 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB664ttf006337;
        Thu, 6 Dec 2018 06:04:55 GMT
Received: from marawils-linux.us.oracle.com (/10.141.196.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Dec 2018 06:04:55 +0000
From:   Maran Wilson <maran.wilson@oracle.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, jgross@suse.com
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        boris.ostrovsky@oracle.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, mchehab@kernel.org,
        rdunlap@infradead.org, roger.pau@citrix.com, rkrcmar@redhat.com,
        maran.wilson@oracle.com
Subject: [PATCH v8 2/7] xen/pvh: Move PVH entry code out of Xen specific tree
Date:   Wed,  5 Dec 2018 22:04:49 -0800
Message-Id: <1544076289-21888-1-git-send-email-maran.wilson@oracle.com>
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
index 6682420421c1..349115c62e4f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16456,6 +16456,7 @@ L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
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

