Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A9BC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317DC2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfAGHlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 02:41:05 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:26748 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726468AbfAGHlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 02:41:04 -0500
X-IronPort-AV: E=Sophos;i="5.56,450,1539619200"; 
   d="scan'208";a="51456255"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 07 Jan 2019 15:41:03 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id B91F44B7EC5B;
        Mon,  7 Jan 2019 15:40:57 +0800 (CST)
Received: from TSAO.g08.fujitsu.local (10.167.226.60) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 7 Jan 2019 15:41:01 +0800
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
To:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>
Subject: [PATCH] x86/boot: drop memset from copy.S
Date:   Mon, 7 Jan 2019 15:40:56 +0800
Message-ID: <20190107074056.12532-1-caoj.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: B91F44B7EC5B.AE839
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to objdump output of setup, function memset is not used in
setup code. Currently, all usage of memset in setup come from macro
definition of string.h.

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
Compiled and booted under x86_64; compiled under i386.

Questions: now there is 2 definition of memcpy, one lies in copy.S,
another lies in string.h which is mapped to gcc builtin function. Do we
still need 2 definition? Could we move the content of copy.S to
boot/string.c?

At first glance, the usage of string.{c.h} of setup is kind of confusing,
they are also used in compressed/ and purgatory/

 arch/x86/boot/copy.S | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/x86/boot/copy.S b/arch/x86/boot/copy.S
index 15d9f74b0008..5157d08b0ff2 100644
--- a/arch/x86/boot/copy.S
+++ b/arch/x86/boot/copy.S
@@ -33,21 +33,6 @@ GLOBAL(memcpy)
 	retl
 ENDPROC(memcpy)
 
-GLOBAL(memset)
-	pushw	%di
-	movw	%ax, %di
-	movzbl	%dl, %eax
-	imull	$0x01010101,%eax
-	pushw	%cx
-	shrw	$2, %cx
-	rep; stosl
-	popw	%cx
-	andw	$3, %cx
-	rep; stosb
-	popw	%di
-	retl
-ENDPROC(memset)
-
 GLOBAL(copy_from_fs)
 	pushw	%ds
 	pushw	%fs
-- 
2.17.0



