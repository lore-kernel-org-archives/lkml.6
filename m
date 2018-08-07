Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4802C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 01:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59AFD21A6D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 01:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59AFD21A6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbeHGELf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 00:11:35 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:7770 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725815AbeHGELf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 00:11:35 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="43144656"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 07 Aug 2018 09:59:34 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 81CD54B66A09;
        Tue,  7 Aug 2018 09:59:30 +0800 (CST)
Received: from localhost (10.167.225.56) by G08CNEXCHPEKD02.g08.fujitsu.local
 (10.167.33.89) with Microsoft SMTP Server id 14.3.399.0; Tue, 7 Aug 2018
 09:59:39 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <x86@kernel.org>, <kirill.shutemov@linux.intel.com>,
        <bhe@redhat.com>, <linux-kernel@vger.kernel.org>
CC:     <douly.fnst@cn.fujitsu.com>, Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: [PATCH] x86/boot/KASLR: Change the function type to void
Date:   Tue, 7 Aug 2018 09:57:05 +0800
Message-ID: <20180807015705.21697-1-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-yoursite-MailScanner-ID: 81CD54B66A09.A9ACA
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since function "handle_mem_options" is used only once:
arch/x86/boot/compressed/kaslr.c:421
	handle_mem_options();
The return value is useless, so change it to void.

And also clean a useless variable.

Suggested-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
---
 arch/x86/boot/compressed/kaslr.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 302517929932..78724caadcfb 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -244,7 +244,7 @@ static void parse_gb_huge_pages(char *param, char *val)
 }
 
 
-static int handle_mem_options(void)
+static void handle_mem_options(void)
 {
 	char *args = (char *)get_cmd_line_ptr();
 	size_t len = strlen((char *)args);
@@ -254,7 +254,7 @@ static int handle_mem_options(void)
 
 	if (!strstr(args, "memmap=") && !strstr(args, "mem=") &&
 		!strstr(args, "hugepages"))
-		return 0;
+		return;
 
 	tmp_cmdline = malloc(len + 1);
 	if (!tmp_cmdline)
@@ -272,8 +272,7 @@ static int handle_mem_options(void)
 		/* Stop at -- */
 		if (!val && strcmp(param, "--") == 0) {
 			warn("Only '--' specified in cmdline");
-			free(tmp_cmdline);
-			return -1;
+			goto out;
 		}
 
 		if (!strcmp(param, "memmap")) {
@@ -286,16 +285,16 @@ static int handle_mem_options(void)
 			if (!strcmp(p, "nopentium"))
 				continue;
 			mem_size = memparse(p, &p);
-			if (mem_size == 0) {
-				free(tmp_cmdline);
-				return -EINVAL;
-			}
+			if (mem_size == 0)
+				goto out;
+
 			mem_limit = mem_size;
 		}
 	}
 
+out:
 	free(tmp_cmdline);
-	return 0;
+	return;
 }
 
 /*
@@ -581,7 +580,6 @@ static void process_mem_region(struct mem_vector *entry,
 			       unsigned long image_size)
 {
 	struct mem_vector region, overlap;
-	struct slot_area slot_area;
 	unsigned long start_orig, end;
 	struct mem_vector cur_entry;
 
-- 
2.17.1



