Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B22FC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FB220989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Oic6+YcY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61FB220989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbeLFGFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 01:05:17 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60124 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728996AbeLFGFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 01:05:16 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB65xIJY025070;
        Thu, 6 Dec 2018 06:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=umL3QlzI1scxxJBtvRJMPSB2eyKHEmgVLZanod1IdxM=;
 b=Oic6+YcYsKhv+Pneqw6grCw1SAjVQ9UUJFcDfmgZphVgf5BEEuFk8aOZDlRQzsJ2C2gJ
 sUCXujiJa7QqvqNQ1XZN/OFlD4IPkGKALzFiSc/VP8xdNiZcRtID0+WAu2gKKYkwB5Xe
 7BuLdmylOCKkMw4QXg3+c3rSQLhP/Kv7fVrY1amDeCR++4md0SJtsMDVYUU1hjLO1vgC
 4WHlz87TZauMwH2OTlyQwoNcpQ3RqzJgFGj7O+pWIrmWpZkWDXWCzLiourewg27HufP8
 iXkLRjecM5j19y70TPP0E7jQZjOfkZZN0LrDqlmUuia8QfHH9mo3bh3JyO5+XkSoGLjC 2g== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2p3hqu6bxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Dec 2018 06:04:25 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB664P0K017104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Dec 2018 06:04:25 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB664Od4006576;
        Thu, 6 Dec 2018 06:04:24 GMT
Received: from marawils-linux.us.oracle.com (/10.141.196.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Dec 2018 22:04:23 -0800
From:   Maran Wilson <maran.wilson@oracle.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, jgross@suse.com
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        boris.ostrovsky@oracle.com, jpoimboe@redhat.com,
        kirill.shutemov@linux.intel.com, bp@suse.de,
        thomas.lendacky@amd.com, luto@kernel.org,
        dave.hansen@linux.intel.com, roger.pau@citrix.com,
        rkrcmar@redhat.com, maran.wilson@oracle.com, rdunlap@infradead.org
Subject: [PATCH v8 1/7] xen/pvh: Split CONFIG_XEN_PVH into CONFIG_PVH and CONFIG_XEN_PVH
Date:   Wed,  5 Dec 2018 22:04:17 -0800
Message-Id: <1544076257-21792-1-git-send-email-maran.wilson@oracle.com>
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

In order to pave the way for hypervisors other than Xen to use the PVH
entry point for VMs, we need to factor the PVH entry code into Xen specific
and hypervisor agnostic components. The first step in doing that, is to
create a new config option for PVH entry that can be enabled
independently from CONFIG_XEN.

Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/Kconfig          | 6 ++++++
 arch/x86/kernel/head_64.S | 2 +-
 arch/x86/xen/Kconfig      | 3 ++-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8689e794a43c..c2a22a74abee 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -796,6 +796,12 @@ config KVM_GUEST
 	  underlying device model, the host provides the guest with
 	  timing infrastructure such as time of day, and system time
 
+config PVH
+	bool "Support for running PVH guests"
+	---help---
+	  This option enables the PVH entry point for guest virtual machines
+	  as specified in the x86/HVM direct boot ABI.
+
 config KVM_DEBUG_FS
 	bool "Enable debug information for KVM Guests in debugfs"
 	depends on KVM_GUEST && DEBUG_FS
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 747c758f67b7..d1dbe8e4eb82 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -386,7 +386,7 @@ NEXT_PAGE(early_dynamic_pgts)
 
 	.data
 
-#if defined(CONFIG_XEN_PV) || defined(CONFIG_XEN_PVH)
+#if defined(CONFIG_XEN_PV) || defined(CONFIG_PVH)
 NEXT_PGD_PAGE(init_top_pgt)
 	.quad   level3_ident_pgt - __START_KERNEL_map + _KERNPG_TABLE_NOENC
 	.org    init_top_pgt + L4_PAGE_OFFSET*8, 0
diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index 1ef391aa184d..e07abefd3d26 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -74,6 +74,7 @@ config XEN_DEBUG_FS
 	  Enabling this option may incur a significant performance overhead.
 
 config XEN_PVH
-	bool "Support for running as a PVH guest"
+	bool "Support for running as a Xen PVH guest"
 	depends on XEN && XEN_PVHVM && ACPI
+	select PVH
 	def_bool n
-- 
2.16.1

