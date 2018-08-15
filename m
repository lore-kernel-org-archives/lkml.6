Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30447C46470
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 09:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39782168D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 09:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39782168D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbeHOM13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 08:27:29 -0400
Received: from exmail.andestech.com ([59.124.169.137]:58071 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbeHOM13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 08:27:29 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w7F9YGOl011273;
        Wed, 15 Aug 2018 17:34:16 +0800 (GMT-8)
        (envelope-from zong@andestech.com)
Received: from atcsqa06.andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Wed, 15 Aug 2018
 17:35:40 +0800
From:   Zong Li <zong@andestech.com>
To:     <green.hu@gmail.com>, <deanbo422@gmail.com>, <rostedt@goodmis.org>,
        <mingo@redhat.com>, <arnd@arndb.de>, <linux-kernel@vger.kernel.org>
CC:     <zongbox@gmail.com>, <greentime@andestech.com>,
        Zong Li <zong@andestech.com>
Subject: [PATCH 3/6] nds32/ftrace: Add RECORD_MCOUNT support
Date:   Wed, 15 Aug 2018 17:35:20 +0800
Message-ID: <41567424a0ae2e4e268fa105cae2e5cc58333dcb.1534323834.git.zong@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1534323834.git.zong@andestech.com>
References: <cover.1534323834.git.zong@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w7F9YGOl011273
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recognize NDS32 object files in recordmcount.pl.

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/nds32/Kconfig      | 1 +
 scripts/recordmcount.pl | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index ae1a94ca..66d507d 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -42,6 +42,7 @@ config NDS32
 	select THREAD_INFO_IN_TASK
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
+	select HAVE_FTRACE_MCOUNT_RECORD
 	help
 	  Andes(nds32) Linux support.
 
diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index fe06e77..f599031 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -389,6 +389,9 @@ if ($arch eq "x86_64") {
     $mcount_regex = "^\\s*([0-9a-fA-F]+):\\sR_RISCV_CALL\\s_mcount\$";
     $type = ".quad";
     $alignment = 2;
+} elsif ($arch eq "nds32") {
+    $mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*R_NDS32_HI20_RELA\\s+_mcount\$";
+    $alignment = 2;
 } else {
     die "Arch $arch is not supported with CONFIG_FTRACE_MCOUNT_RECORD";
 }
-- 
2.7.4

