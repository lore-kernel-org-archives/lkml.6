Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57684C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25EF720857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfBAFva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 00:51:30 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:15511 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725854AbfBAFva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 00:51:30 -0500
X-IronPort-AV: E=Sophos;i="5.56,547,1539619200"; 
   d="scan'208";a="53383465"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 01 Feb 2019 13:51:25 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 90ACE4C4BB95;
        Fri,  1 Feb 2019 13:51:24 +0800 (CST)
Received: from TSAO.g08.fujitsu.local (10.167.226.60) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 1 Feb 2019 13:51:24 +0800
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <bhe@redhat.com>, <keescook@chromium.org>,
        <fanc.fnst@cn.fujitsu.com>
Subject: [PATCH] x86/boot: minor improvement in kaslr
Date:   Fri, 1 Feb 2019 13:48:53 +0800
Message-ID: <20190201054853.28541-1-caoj.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: 90ACE4C4BB95.AB9CD
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

comments fix: input_size is ZO image size which just don't count .bss
in, but has .text, .data, etc;
drop unecessary alignment: minimum is either 512M or output, both are
CONFIG_PHYSICAL_ALIGN aligned(output is aligned in head_32/64.S). But
mention it in earlier comments.

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 arch/x86/boot/compressed/kaslr.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 9ed9709d9947..a947c5aba34e 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -360,7 +360,7 @@ static void handle_mem_options(void)
  * (i.e. it does not include its run size). This range must be avoided
  * because it contains the data used for decompression.
  *
- * [input+input_size, output+init_size) is [_text, _end) for ZO. This
+ * [input+input_size, output+init_size) is [_bss, _end) for ZO. This
  * range includes ZO's heap and stack, and must be avoided since it
  * performs the decompression.
  *
@@ -763,9 +763,6 @@ static unsigned long find_random_phys_addr(unsigned long minimum,
 		return 0;
 	}
 
-	/* Make sure minimum is aligned. */
-	minimum = ALIGN(minimum, CONFIG_PHYSICAL_ALIGN);
-
 	if (process_efi_entries(minimum, image_size))
 		return slots_fetch_random();
 
@@ -831,8 +828,8 @@ void choose_random_location(unsigned long input,
 
 	/*
 	 * Low end of the randomization range should be the
-	 * smaller of 512M or the initial kernel image
-	 * location:
+	 * smaller of 512M or the initial kernel image location.
+	 * Should be aligned to CONFIG_PHYSICAL_ALIGN.
 	 */
 	min_addr = min(*output, 512UL << 20);
 
-- 
2.17.0



