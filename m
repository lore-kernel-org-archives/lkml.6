Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB7DC64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 08:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7042147D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 08:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7042147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbeJFPqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 11:46:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49758 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbeJFPqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 11:46:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BBB2C30014C6;
        Sat,  6 Oct 2018 08:43:37 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C2334608F2;
        Sat,  6 Oct 2018 08:43:33 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, tglx@linutronix.de, thgarnie@google.com,
        corbet@lwn.net, Baoquan He <bhe@redhat.com>
Subject: [PATCH 1/3] x86/KASLR: Update KERNEL_IMAGE_SIZE description
Date:   Sat,  6 Oct 2018 16:43:25 +0800
Message-Id: <20181006084327.27467-2-bhe@redhat.com>
In-Reply-To: <20181006084327.27467-1-bhe@redhat.com>
References: <20181006084327.27467-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Sat, 06 Oct 2018 08:43:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently CONFIG_RANDOMIZE_BASE=y is set by default, which makes some of the
old comments above the KERNEL_IMAGE_SIZE definition out of date. Update them
to the current state of affairs.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/include/asm/page_64_types.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index 6afac386a434..cd0cf1c568b4 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -59,13 +59,16 @@
 #endif
 
 /*
- * Kernel image size is limited to 1GiB due to the fixmap living in the
- * next 1GiB (see level2_kernel_pgt in arch/x86/kernel/head_64.S). Use
- * 512MiB by default, leaving 1.5GiB for modules once the page tables
- * are fully set up. If kernel ASLR is configured, it can extend the
- * kernel page table mapping, reducing the size of the modules area.
+ * Maximum kernel image size is limited to 1 GiB, due to the fixmap living
+ * in the next 1 GiB (see level2_kernel_pgt in arch/x86/kernel/head_64.S).
+ *
+ * On KASLR use 1 GiB by default, leaving 1 GiB for modules once the
+ * page tables are fully set up.
+ *
+ * If KASLR is disabled we can shrink it to 0.5 GiB and increase the size
+ * of the modules area to 1.5 GiB.
  */
-#if defined(CONFIG_RANDOMIZE_BASE)
+#ifdef CONFIG_RANDOMIZE_BASE
 #define KERNEL_IMAGE_SIZE	(1024 * 1024 * 1024)
 #else
 #define KERNEL_IMAGE_SIZE	(512 * 1024 * 1024)
-- 
2.13.6

