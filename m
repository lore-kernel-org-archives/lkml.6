Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADD7C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA9221AA8
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA9221AA8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730080AbeHIK64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 06:58:56 -0400
Received: from mail.windriver.com ([147.11.1.11]:52451 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbeHIK64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 06:58:56 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w798YmsV012134
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 9 Aug 2018 01:34:48 -0700 (PDT)
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.399.0; Thu, 9 Aug 2018 01:34:47 -0700
From:   <zhe.he@windriver.com>
To:     <tglx@linutronix.de>, <kstewart@linuxfoundation.org>,
        <pombredanne@nexb.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <zhe.he@windriver.com>
Subject: [PATCH] scripts/gcc-goto.sh: Show stdout and stderr for potential errors
Date:   Thu, 9 Aug 2018 16:34:45 +0800
Message-ID: <1533803685-42422-1-git-send-email-zhe.he@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

The check may fail not only because ${CC} does not support the asm
feature, but also due to potential defects of ${CC} itself like what
we experienced below or even it's missing.

Assembler messages:
Fatal error: The input and output files must be distinct
(introduced by binutils-2.31 "Stop the assembler from overwriting its
output file.")

This patch enables stdout and stderr to give user direct error
information for those cases, while not polluting the output for normal
cases.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 scripts/gcc-goto.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gcc-goto.sh b/scripts/gcc-goto.sh
index 083c526..bd7fc8eb 100755
--- a/scripts/gcc-goto.sh
+++ b/scripts/gcc-goto.sh
@@ -3,7 +3,7 @@
 # Test for gcc 'asm goto' support
 # Copyright (C) 2010, Jason Baron <jbaron@redhat.com>
 
-cat << "END" | $@ -x c - -c -o /dev/null >/dev/null 2>&1 && echo "y"
+cat << "END" | $@ -x c - -c -o /dev/null && echo "y"
 int main(void)
 {
 #if defined(__arm__) || defined(__aarch64__)
-- 
2.7.4

