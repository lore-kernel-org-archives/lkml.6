Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC84ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10C5208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A10C5208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731408AbeGQMdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:33:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:45762 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731300AbeGQMdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:33:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5E85CAF6A;
        Tue, 17 Jul 2018 12:01:21 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, Juergen Gross <jgross@suse.com>
Subject: [PATCH 3/4] xen: link platform-pci-unplug.o only if CONFIG_XEN_PVHVM
Date:   Tue, 17 Jul 2018 14:01:12 +0200
Message-Id: <20180717120113.12756-4-jgross@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20180717120113.12756-1-jgross@suse.com>
References: <20180717120113.12756-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using one large #ifdef CONFIG_XEN_PVHVM in
arch/x86/xen/platform-pci-unplug.c add the object file depending on
CONFIG_XEN_PVHVM being set.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/Makefile              | 2 +-
 arch/x86/xen/platform-pci-unplug.c | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
index a964f307a266..dd2550d33b38 100644
--- a/arch/x86/xen/Makefile
+++ b/arch/x86/xen/Makefile
@@ -19,11 +19,11 @@ obj-y				+= mmu.o
 obj-y				+= time.o
 obj-y				+= grant-table.o
 obj-y				+= suspend.o
-obj-y				+= platform-pci-unplug.o
 
 obj-$(CONFIG_XEN_PVHVM)		+= enlighten_hvm.o
 obj-$(CONFIG_XEN_PVHVM)		+= mmu_hvm.o
 obj-$(CONFIG_XEN_PVHVM)		+= suspend_hvm.o
+obj-$(CONFIG_XEN_PVHVM)		+= platform-pci-unplug.o
 
 obj-$(CONFIG_XEN_PV)		+= setup.o
 obj-$(CONFIG_XEN_PV)		+= apic.o
diff --git a/arch/x86/xen/platform-pci-unplug.c b/arch/x86/xen/platform-pci-unplug.c
index 33a783c77d96..3957946a6cfe 100644
--- a/arch/x86/xen/platform-pci-unplug.c
+++ b/arch/x86/xen/platform-pci-unplug.c
@@ -30,7 +30,6 @@
 #define XEN_PLATFORM_ERR_PROTOCOL -2
 #define XEN_PLATFORM_ERR_BLACKLIST -3
 
-#ifdef CONFIG_XEN_PVHVM
 /* store the value of xen_emul_unplug after the unplug is done */
 static int xen_platform_pci_unplug;
 static int xen_emul_unplug;
@@ -214,4 +213,3 @@ static int __init parse_xen_emul_unplug(char *arg)
 	return 0;
 }
 early_param("xen_emul_unplug", parse_xen_emul_unplug);
-#endif
-- 
2.13.7

