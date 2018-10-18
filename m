Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEC4ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC88921477
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC88921477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbeJRQ4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 12:56:19 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:19527 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727360AbeJRQ4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 12:56:18 -0400
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id w9I8crZL003560
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 16:38:53 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w9I8cnt9003543;
        Thu, 18 Oct 2018 16:38:49 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 18 Oct 2018
 16:36:53 +0800
From:   Nickhu <nickhu@andestech.com>
To:     <greentime@andestech.com>, <linux-kernel@vger.kernel.org>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <deanbo422@gmail.com>,
        <adrian.hunter@intel.com>, <tglx@linutronix.de>,
        <gregkh@linuxfoundation.org>
CC:     Nickhu <nickhu@andestech.com>, <green.hu@gmail.com>
Subject: [PATCH 1/1] Perf: Compile failed when compile with libelf.
Date:   Thu, 18 Oct 2018 16:36:46 +0800
Message-ID: <36763ffb49ecc0342669ca4029a4592670f6249a.1539654517.git.nickhu@andestech.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1539654517.git.nickhu@andestech.com>
References: <cover.1539654517.git.nickhu@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w9I8cnt9003543
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error message:
=====================================================================
util/symbol-elf.c:46:12: error: static declaration of 'elf_getphdrnum'
follows non-static declaration
static int elf_getphdrnum(Elf *elf, size_t *dst)
            ^~~~~~~~~~~~~~
In file included from util/symbol.h:20,
                 from util/symbol-elf.c:9:
/local/nickhu/build-system-3/toolchain/nds32le-linux-glibc-v3-upstream/
nds32le-linux/sysroot/usr/include/libelf.h:266:12: note: previous declaration
of 'elf_getphdrnum' was here
extern int elf_getphdrnum (Elf *__elf, size_t *__dst);
            ^~~~~~~~~~~~~~
util/symbol-elf.c:62:12: error: static declaration of 'elf_getshdrstrndx'
follows non-static declaration
static int elf_getshdrstrndx(Elf *elf __maybe_unused, size_t *dst __maybe
_unused)
            ^~~~~~~~~~~~~~~~~
In file included from util/symbol.h:20,
                 from util/symbol-elf.c:9:
/local/nickhu/build-system-3/toolchain/nds32le-linux-glibc-v3-upstream/
nds32le-linux/sysroot/usr/include/libelf.h:316:12: note: previous declaration
of 'elf_getshdrstrndx' was here
extern int elf_getshdrstrndx (Elf *__elf, size_t *__dst);
=====================================================================

Fix it.

Signed-off-by: Nickhu <nickhu@andestech.com>
---
 tools/perf/util/symbol-elf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 29770ea61768..3ccdfe603d67 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -43,7 +43,7 @@ static inline char *bfd_demangle(void __maybe_unused *v,
 #endif
 
 #ifndef HAVE_ELF_GETPHDRNUM_SUPPORT
-static int elf_getphdrnum(Elf *elf, size_t *dst)
+int elf_getphdrnum(Elf *elf, size_t *dst)
 {
 	GElf_Ehdr gehdr;
 	GElf_Ehdr *ehdr;
@@ -59,7 +59,7 @@ static int elf_getphdrnum(Elf *elf, size_t *dst)
 #endif
 
 #ifndef HAVE_ELF_GETSHDRSTRNDX_SUPPORT
-static int elf_getshdrstrndx(Elf *elf __maybe_unused, size_t *dst __maybe_unused)
+int elf_getshdrstrndx(Elf *elf __maybe_unused, size_t *dst __maybe_unused)
 {
 	pr_err("%s: update your libelf to > 0.140, this one lacks elf_getshdrstrndx().\n", __func__);
 	return -1;
-- 
2.17.0

