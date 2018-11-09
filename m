Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1109EC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADC9206BA
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BADC9206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbeKIWC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 17:02:57 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:51648 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727560AbeKIWC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 17:02:57 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="47736632"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 09 Nov 2018 20:22:27 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 8A1904B71EA6;
        Fri,  9 Nov 2018 20:22:27 +0800 (CST)
Received: from TSAO.g08.fujitsu.local (10.167.226.60) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 9 Nov 2018 20:22:26 +0800
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
To:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>
Subject: [PATCH] x86/mkpiggy: Drop endianness transforming
Date:   Fri, 9 Nov 2018 20:19:29 +0800
Message-ID: <20181109121929.11448-1-caoj.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: 8A1904B71EA6.ABB5E
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gzip file has 4-byte little-endian file size encoded at the end of file,
while all the other compressed kernel file has size_append operation in
the Makefile which also append the 4-byte little-endian file size. There
is no need to do endianness transforming by mkpiggy.

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---

A simple printf debug line before transformation also shows they are the
same among 6 compression.

 arch/x86/boot/compressed/Makefile  | 1 -
 arch/x86/boot/compressed/mkpiggy.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 466f66c8a7f8..8b2bcfd65920 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -58,7 +58,6 @@ endif
 LDFLAGS_vmlinux := -T
 
 hostprogs-y	:= mkpiggy
-HOST_EXTRACFLAGS += -I$(srctree)/tools/include
 
 sed-voffset := -e 's/^\([0-9a-fA-F]*\) [ABCDGRSTVW] \(_text\|__bss_start\|_end\)$$/\#define VO_\2 _AC(0x\1,UL)/p'
 
diff --git a/arch/x86/boot/compressed/mkpiggy.c b/arch/x86/boot/compressed/mkpiggy.c
index 72bad2c8debe..d5402fcd844a 100644
--- a/arch/x86/boot/compressed/mkpiggy.c
+++ b/arch/x86/boot/compressed/mkpiggy.c
@@ -28,7 +28,6 @@
 #include <stdio.h>
 #include <string.h>
 #include <inttypes.h>
-#include <tools/le_byteshift.h>
 
 int main(int argc, char *argv[])
 {
@@ -61,7 +60,6 @@ int main(int argc, char *argv[])
 	}
 
 	ilen = ftell(f);
-	olen = get_unaligned_le32(&olen);
 
 	printf(".section \".rodata..compressed\",\"a\",@progbits\n");
 	printf(".globl z_input_len\n");
-- 
2.17.0



