Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039F2C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B699221A04
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B699221A04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731408AbeHFPsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:48:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731138AbeHFPsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:48:12 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w76DO36a095944
        for <linux-kernel@vger.kernel.org>; Mon, 6 Aug 2018 09:39:02 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kpq550pf5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 09:39:01 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Mon, 6 Aug 2018 14:39:00 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 Aug 2018 14:38:59 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w76DcwTw33423586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Aug 2018 13:38:58 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5178242047;
        Mon,  6 Aug 2018 16:39:07 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FA2C42042;
        Mon,  6 Aug 2018 16:39:07 +0100 (BST)
Received: from localhost (unknown [9.152.212.144])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  6 Aug 2018 16:39:07 +0100 (BST)
Date:   Mon, 6 Aug 2018 15:38:56 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: [PATCH] kbuild: add Map option to save vmlinux linker map file(s)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
x-cbid: 18080613-0028-0000-0000-000002E6360B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080613-0029-0000-0000-0000239E586E
Message-Id: <patch.git-39444503b4d3.your-ad-here.call-01533562662-ext-6094@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "Map" kbuild option, so that "make Map=1" would save vmlinux linker
map into vmlinux.map, which is quite useful during making kernel changes
related to how the kernel is composed.

KBUILD_SAVE_LINK_MAP flag is exported and architectures
supporting compressed kernel images might respect it and produce
arch/*/boot/compressed/vmlinux.map for the decompressor code as well.

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 .gitignore |  1 +
 Makefile   | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/.gitignore b/.gitignore
index 97ba6b79834c..1d2308e597ad 100644
--- a/.gitignore
+++ b/.gitignore
@@ -44,6 +44,7 @@
 *.xz
 Module.symvers
 modules.builtin
+vmlinux.map
 
 #
 # Top-level generic files
diff --git a/Makefile b/Makefile
index 7a3c4548162b..f1790deae03b 100644
--- a/Makefile
+++ b/Makefile
@@ -176,6 +176,14 @@ ifndef KBUILD_CHECKSRC
   KBUILD_CHECKSRC = 0
 endif
 
+# Use 'make Map=1' to enable saving linker map file(s):
+# vmlinux.map for vmlinux,
+# (arch/*/boot/compressed/vmlinux.map for arch/*/boot/compressed/vmlinux)
+
+ifeq ("$(origin Map)", "command line")
+	export KBUILD_SAVE_LINK_MAP := $(Map)
+endif
+
 # Use make M=dir to specify directory of external module to build
 # Old syntax make ... SUBDIRS=$PWD is still supported
 # Setting the environment variable KBUILD_EXTMOD take precedence
@@ -838,6 +846,11 @@ ifeq ($(CONFIG_STRIP_ASM_SYMS),y)
 LDFLAGS_vmlinux	+= $(call ld-option, -X,)
 endif
 
+ifdef KBUILD_SAVE_LINK_MAP
+LDFLAGS_vmlinux	+= -Map=vmlinux.map
+CLEAN_FILES	+= vmlinux.map
+endif
+
 # insure the checker run with the right endianness
 CHECKFLAGS += $(if $(CONFIG_CPU_BIG_ENDIAN),-mbig-endian,-mlittle-endian)
 
@@ -1434,6 +1447,7 @@ help:
 	@echo  '		2: warnings which occur quite often but may still be relevant'
 	@echo  '		3: more obscure warnings, can most likely be ignored'
 	@echo  '		Multiple levels can be combined with W=12 or W=123'
+	@echo  '  make Map=1 [targets] Save vmlinux linker map file(s)'
 	@echo  ''
 	@echo  'Execute "make" or "make all" to build all targets marked with [*] '
 	@echo  'For further info see the ./README file'
-- 
2.18.0.13.gd42ae10

