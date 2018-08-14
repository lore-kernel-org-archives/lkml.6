Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9E5C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63DC2154F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C63DC2154F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390034AbeHNUaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:30:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59084 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730139AbeHNUaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:30:04 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 879E8D20;
        Tue, 14 Aug 2018 17:41:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 050/107] x86/speculation/l1tf: Extend 64bit swap file size limit
Date:   Tue, 14 Aug 2018 19:17:13 +0200
Message-Id: <20180814171524.266239103@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171520.883143803@linuxfoundation.org>
References: <20180814171520.883143803@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vlastimil Babka <vbabka@suse.cz>

commit 1a7ed1ba4bba6c075d5ad61bb75e3fbc870840d6 upstream

The previous patch has limited swap file size so that large offsets cannot
clear bits above MAX_PA/2 in the pte and interfere with L1TF mitigation.

It assumed that offsets are encoded starting with bit 12, same as pfn. But
on x86_64, offsets are encoded starting with bit 9.

Thus the limit can be raised by 3 bits. That means 16TB with 42bit MAX_PA
and 256TB with 46bit MAX_PA.

Fixes: 377eeaa8e11f ("x86/speculation/l1tf: Limit swap file size to MAX_PA/2")
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/mm/init.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -791,7 +791,15 @@ unsigned long max_swapfile_size(void)
 
 	if (boot_cpu_has_bug(X86_BUG_L1TF)) {
 		/* Limit the swap file size to MAX_PA/2 for L1TF workaround */
-		pages = min_t(unsigned long, l1tf_pfn_limit() + 1, pages);
+		unsigned long l1tf_limit = l1tf_pfn_limit() + 1;
+		/*
+		 * We encode swap offsets also with 3 bits below those for pfn
+		 * which makes the usable limit higher.
+		 */
+#ifdef CONFIG_X86_64
+		l1tf_limit <<= PAGE_SHIFT - SWP_OFFSET_FIRST_BIT;
+#endif
+		pages = min_t(unsigned long, l1tf_limit, pages);
 	}
 	return pages;
 }


