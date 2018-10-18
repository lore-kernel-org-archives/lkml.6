Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D08C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5048C21473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:56:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5048C21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbeJRQ4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 12:56:34 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:57265 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727613AbeJRQ4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 12:56:33 -0400
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id w9I8e7NV003843
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 16:40:07 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w9I8e0Gw003677;
        Thu, 18 Oct 2018 16:40:00 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 18 Oct 2018
 16:38:03 +0800
From:   Nickhu <nickhu@andestech.com>
To:     <greentime@andestech.com>, <linux-kernel@vger.kernel.org>,
        <arnd@arndb.de>, <zong@andestech.com>, <deanbo422@gmail.com>
CC:     Nickhu <nickhu@andestech.com>, <green.hu@gmail.com>
Subject: [PATCH 1/1] nds32: Fix gcc 8.0 compiler option incompatible.
Date:   Thu, 18 Oct 2018 16:37:55 +0800
Message-ID: <6f54200ae5c132634ede74df536a547e134554c2.1539654583.git.nickhu@andestech.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1539654583.git.nickhu@andestech.com>
References: <cover.1539654583.git.nickhu@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w9I8e0Gw003677
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	When the kernel configs of ftrace and frame pointer options are
choosed, the compiler option of kernel will incompatible.
	Error message:
		nds32le-linux-gcc: error: -pg and -fomit-frame-pointer are incompatible

Signed-off-by: Nickhu <nickhu@andestech.com>
Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/nds32/mm/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/nds32/mm/Makefile b/arch/nds32/mm/Makefile
index 6b6855852223..7c5c15ad854a 100644
--- a/arch/nds32/mm/Makefile
+++ b/arch/nds32/mm/Makefile
@@ -4,4 +4,8 @@ obj-y				:= extable.o tlb.o \
 
 obj-$(CONFIG_ALIGNMENT_TRAP)	+= alignment.o
 obj-$(CONFIG_HIGHMEM)           += highmem.o
-CFLAGS_proc-n13.o		+= -fomit-frame-pointer
+
+ifdef CONFIG_FUNCTION_TRACER
+CFLAGS_REMOVE_proc.o     = $(CC_FLAGS_FTRACE)
+endif
+CFLAGS_proc.o              += -fomit-frame-pointer
-- 
2.17.0

