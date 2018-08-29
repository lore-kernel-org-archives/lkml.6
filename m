Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4E9C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC8F2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC8F2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbeH2SNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:13:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40286 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727444AbeH2SNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:13:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 44193807A13D;
        Wed, 29 Aug 2018 14:16:45 +0000 (UTC)
Received: from 192.168.1.2 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 804A410B7C97;
        Wed, 29 Aug 2018 14:16:41 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        kirill.shutemov@linux.intel.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH 3/3] x86/kdump/64: Change the upper limit of crashkernel reservation
Date:   Wed, 29 Aug 2018 22:16:24 +0800
Message-Id: <20180829141624.13985-4-bhe@redhat.com>
In-Reply-To: <20180829141624.13985-1-bhe@redhat.com>
References: <20180829141624.13985-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 29 Aug 2018 14:16:45 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 29 Aug 2018 14:16:45 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Restrict kdump to only reserve crashkernel below 64TB. Since the kdump
jumping may be from 5-level to 4-level, and the kdump kernel is put
above 64TB in 5-level kernel, then the jumping will fail. And the
crashkernel reservation is done during the 1st kernel bootup, there's
no way to detect the paging mode of kdump kernel at that time.

Hence change the upper limmit of crashkernel reservation to 64TB
on x86_64.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/setup.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 8fe740e22030..1a6389096782 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -451,16 +451,26 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 #define CRASH_ALIGN		(16 << 20)
 
 /*
- * Keep the crash kernel below this limit.  On 32 bits earlier kernels
- * would limit the kernel to the low 512 MiB due to mapping restrictions.
- * On 64bit, old kexec-tools need to under 896MiB.
+ * Keep the crash kernel below this limit.
+ *
+ * On 32 bits earlier kernels would limit the kernel to the low
+ * 512 MiB due to mapping restrictions.
+ *
+ * On 64bit, old kexec-tools need to be under 896MiB. The later
+ * supports to put kernel above 4G, up to system RAM top. Here
+ * kdump kernel need be restricted to be under 64TB, which is
+ * the upper limit of system RAM in 4-level paing mode. Since
+ * the kdump jumping could be from 5-level to 4-level, the jumping
+ * will fail if kernel is put above 64TB, and there's no way to
+ * detect the paging mode of the kernel which will be loaded for
+ * dumping during the 1st kernel boots up.
  */
 #ifdef CONFIG_X86_32
 # define CRASH_ADDR_LOW_MAX	(512 << 20)
 # define CRASH_ADDR_HIGH_MAX	(512 << 20)
 #else
 # define CRASH_ADDR_LOW_MAX	(896UL << 20)
-# define CRASH_ADDR_HIGH_MAX	MAXMEM
+# define CRASH_ADDR_HIGH_MAX	(1ULL < 46)
 #endif
 
 static int __init reserve_crashkernel_low(void)
-- 
2.13.6

