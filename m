Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39085C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E77A32082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fnwHIlgE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E77A32082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbeLJTIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:08:15 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40866 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbeLJTIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:08:14 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBAIwvoG112599;
        Mon, 10 Dec 2018 19:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=umL3QlzI1scxxJBtvRJMPSB2eyKHEmgVLZanod1IdxM=;
 b=fnwHIlgEGJAmoSY7ndSrjiSPJT+Zw3klGNQbgFO+oNA68Gb58Gc39bkjhycqUlgOsH+y
 pdl78dPXVSYkaxHxw+ASeQs8DnI/cy7djnjaT8sqPiVAAeMXwUN/pkxXi3VxxxFa4+gm
 tpPH4Zp6A1hfaruevyvHml2aOjwomoeDYaNZug44r8vDVHncQ1OeXWvui8xIc/KpwNOT
 ku+mg6yvC7c/BxxWdMCezzAf6kcAwCtjClZO+i09E6HLA1OOf8HK036PJCcYSuyPRmR3
 5qwSbo5c2BQcmQxref+pa47eUn8NCkf59pUeahjfWwKJJUZgIkBGzyjdRIks/kVovKwH RQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2p86kqqt7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Dec 2018 19:07:39 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBAJ7Xln032687
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Dec 2018 19:07:33 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBAJ7X5E023918;
        Mon, 10 Dec 2018 19:07:33 GMT
Received: from marawils-linux.us.oracle.com (/10.141.196.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Dec 2018 11:07:33 -0800
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
Subject: [PATCH v9 1/7] xen/pvh: Split CONFIG_XEN_PVH into CONFIG_PVH and CONFIG_XEN_PVH
Date:   Mon, 10 Dec 2018 11:07:28 -0800
Message-Id: <1544468848-496-1-git-send-email-maran.wilson@oracle.com>
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

