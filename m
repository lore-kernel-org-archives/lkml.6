Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F40C282C5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBEE8218EA
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbfAYC2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 21:28:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43054 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728371AbfAYC2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 21:28:39 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C33FB1326B0;
        Fri, 25 Jan 2019 02:28:39 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7CFF7850B;
        Fri, 25 Jan 2019 02:28:33 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@alien8.de, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, dyoung@redhat.com, x86@kernel.org,
        kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH RESEND 1/3] x86/boot: Add bit fields into xloadflags for 5-level kernel checking
Date:   Fri, 25 Jan 2019 10:28:15 +0800
Message-Id: <20190125022817.29506-2-bhe@redhat.com>
In-Reply-To: <20190125022817.29506-1-bhe@redhat.com>
References: <20190125022817.29506-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 25 Jan 2019 02:28:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two bit fields XLF_5LEVEL and XLF_5LEVEL_ENABLED for 5-level kernel.
Bit XLF_5LEVEL indicates if 5-level related code is contained
in this kernel.
Bit XLF_5LEVEL_ENABLED indicates if CONFIG_X86_5LEVEL=y is set.

They are being used in later patch to check if kexec/kdump kernel
is loaded in right place.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/boot/header.S                | 12 +++++++++++-
 arch/x86/include/uapi/asm/bootparam.h |  2 ++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 850b8762e889..be19f4199727 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -419,7 +419,17 @@ xloadflags:
 # define XLF4 0
 #endif
 
-			.word XLF0 | XLF1 | XLF23 | XLF4
+#ifdef CONFIG_X86_64
+#ifdef CONFIG_X86_5LEVEL
+#define XLF56 (XLF_5LEVEL|XLF_5LEVEL_ENABLED)
+#else
+#define XLF56 XLF_5LEVEL
+#endif
+#else
+#define XLF56 0
+#endif
+
+			.word XLF0 | XLF1 | XLF23 | XLF4 | XLF56
 
 cmdline_size:   .long   COMMAND_LINE_SIZE-1     #length of the command line,
                                                 #added with boot protocol
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index 60733f137e9a..c895df5482c5 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -29,6 +29,8 @@
 #define XLF_EFI_HANDOVER_32		(1<<2)
 #define XLF_EFI_HANDOVER_64		(1<<3)
 #define XLF_EFI_KEXEC			(1<<4)
+#define XLF_5LEVEL			(1<<5)
+#define XLF_5LEVEL_ENABLED		(1<<6)
 
 #ifndef __ASSEMBLY__
 
-- 
2.13.6

