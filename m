Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D868C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E082084D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfBKHlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 02:41:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58222 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbfBKHlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 02:41:04 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8D70EC04BE02;
        Mon, 11 Feb 2019 07:41:03 +0000 (UTC)
Received: from localhost (ovpn-12-138.pek2.redhat.com [10.72.12.138])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 920E75B682;
        Mon, 11 Feb 2019 07:40:59 +0000 (UTC)
Date:   Mon, 11 Feb 2019 15:40:56 +0800
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, kexec@lists.infradead.org, bp@alien8.de,
        hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com,
        mingo@kernel.org, kirill.shutemov@linux.intel.com
Subject: [PATCH v2 1/3] x86/boot: Add xloadflags bits for 5-level kernel
 checking
Message-ID: <20190211074056.GB2332@localhost>
References: <20190125022817.29506-1-bhe@redhat.com>
 <20190125022817.29506-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125022817.29506-2-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 11 Feb 2019 07:41:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two bits XLF_5LEVEL and XLF_5LEVEL_ENABLED for 5-level kernel.
Bit XLF_5LEVEL indicates if 5-level related code is contained
in this kernel.
Bit XLF_5LEVEL_ENABLED indicates if CONFIG_X86_5LEVEL=y is set.

They are being used in later patch to check if kexec/kdump kernel
is loaded in right place.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
v1->v2:
  Change the wrong term in subject pointed out by tglx.

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
2.17.2

