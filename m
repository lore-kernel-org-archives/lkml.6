Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4DCC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B4520880
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B4520880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbeIJRem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:34:42 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:52644 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727649AbeIJRel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:34:41 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="44733320"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 10 Sep 2018 20:40:41 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 5B41B4B6AE18;
        Mon, 10 Sep 2018 20:40:38 +0800 (CST)
Received: from localhost (10.167.225.56) by G08CNEXCHPEKD01.g08.fujitsu.local
 (10.167.33.89) with Microsoft SMTP Server id 14.3.408.0; Mon, 10 Sep 2018
 20:40:41 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <keescook@chromium.org>, <bhe@redhat.com>
CC:     <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>,
        <douly.fnst@cn.fujitsu.com>, Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: [PATCH v6 2/3] x86/boot/KASLR: Walk srat tables to filter immovable memory
Date:   Mon, 10 Sep 2018 20:40:14 +0800
Message-ID: <20180910124015.18073-3-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180910124015.18073-1-fanc.fnst@cn.fujitsu.com>
References: <20180910124015.18073-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-yoursite-MailScanner-ID: 5B41B4B6AE18.AAD3F
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_MEMORY_HOTREMOVE enabled, walk through the acpi srat memory
tables and store those immovable memory regions so that kaslr can get
where to choose for randomization.

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
---
 arch/x86/boot/compressed/kaslr.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index d1e19f358b6e..3d839040cc7f 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -101,6 +101,11 @@ static bool memmap_too_large;
 /* Store memory limit specified by "mem=nn[KMG]" or "memmap=nn[KMG]" */
 static unsigned long long mem_limit = ULLONG_MAX;
 
+#ifdef CONFIG_MEMORY_HOTREMOVE
+/* Store the immovable memory regions */
+extern struct mem_vector immovable_mem[MAX_NUMNODES*2];
+#endif
+
 
 enum mem_avoid_index {
 	MEM_AVOID_ZO_RANGE = 0,
@@ -418,6 +423,11 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 	/* Mark the memmap regions we need to avoid */
 	handle_mem_options();
 
+#ifdef CONFIG_MEMORY_HOTREMOVE
+	/* Mark the immovable regions we need to choose */
+	get_immovable_mem();
+#endif
+
 #ifdef CONFIG_X86_VERBOSE_BOOTUP
 	/* Make sure video RAM can be used. */
 	add_identity_map(0, PMD_SIZE);
-- 
2.17.1



