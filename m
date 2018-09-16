Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FA7ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 20:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334622087E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 20:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="QxuPzYuF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 334622087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbeIQCMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 22:12:15 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:59582 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbeIQCMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 22:12:15 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id E4CBA10C122B;
        Sun, 16 Sep 2018 13:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1537130883; bh=XjmeVeyG9wV6D3nGOQldhWLe9nny5Pcrq273tbDxsyk=;
        h=From:To:Cc:Subject:Date:From;
        b=QxuPzYuF4NFIpeuRJcErJuqG/t6l09vroZ6jgaEort2nhUQLhGVNrGQNzeMW6+8xn
         snIsXTw0RUQmTVYuu7uFZJu1fiPfICp8PLCt3enXp8Y8ERWDFqKDRw12Uo7/k/i70C
         1lm+q0wqDWjwBXqtDC9iPA73D6IpTrCkiKe8ZPFsS1/wULRbuRdRhcZTTlGwqdZU8V
         dugIPto92WDA5qhkq6FC+6HXsUdTLrkmXSX4jHv3yD02iT4/dnhFLjLR8zxZeItSg/
         Xigfe1irDZ/lgN12hLFTCDkYZ/QgpxN7IGMsploRio9jFjt5Hh+CuP/XVDWmh576tT
         5Ezmo8Kgv24nw==
Received: from abrodkin-7480l.internal.synopsys.com (unknown [10.225.15.87])
        by mailhost.synopsys.com (Postfix) with ESMTP id B80EB5ACD;
        Sun, 16 Sep 2018 13:48:00 -0700 (PDT)
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH] ARC: Don't set CROSS_COMPILE in arch's Makefile
Date:   Sun, 16 Sep 2018 23:47:57 +0300
Message-Id: <20180916204757.31131-1-abrodkin@synopsys.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's not much sense in doing that because if user or
his build-system didn't set CROSS_COMPILE we still may
very well make incorrect guess.

But as it turned out setting CROSS_COMPILE is not as harmless
as one may think: with recent changes that implemented automatic
discovery of __host__ gcc features unconditional setup of
CROSS_COMPILE leads to failures on execution of "make xxx_defconfig"
with absent cross-compiler, for more info see [1].

Set CROSS_COMPILE as well gets in the way if we want only to build
.dtb's (again with absent cross-compiler which is not really needed
for building .dtb's), see [2].

Note, we had to change LIBGCC assignment type from ":=" to "="
so that is is resolved on its usage, otherwise if it is resolved
at declaration time with missing CROSS_COMPILE we're getting this
error message from host GCC:
------------------------->8-------------------------
gcc: error: unrecognized command line option ‘-mmedium-calls’
gcc: error: unrecognized command line option ‘-mno-sdata’; did you mean ‘-fno-stats’?
------------------------->8-------------------------

[1] http://lists.infradead.org/pipermail/linux-snps-arc/2018-September/004308.html
[2] http://lists.infradead.org/pipermail/linux-snps-arc/2018-September/004320.html

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Rob Herring <robh@kernel.org>
---
 arch/arc/Makefile | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index 99cce77ab98f..5f6b67917dc2 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -6,14 +6,6 @@
 # published by the Free Software Foundation.
 #
 
-ifeq ($(CROSS_COMPILE),)
-ifndef CONFIG_CPU_BIG_ENDIAN
-CROSS_COMPILE := arc-linux-
-else
-CROSS_COMPILE := arceb-linux-
-endif
-endif
-
 KBUILD_DEFCONFIG := nsim_700_defconfig
 
 cflags-y	+= -fno-common -pipe -fno-builtin -mmedium-calls -D__linux__
@@ -79,7 +71,7 @@ cflags-$(disable_small_data)		+= -mno-sdata -fcall-used-gp
 cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= -mbig-endian
 ldflags-$(CONFIG_CPU_BIG_ENDIAN)	+= -EB
 
-LIBGCC	:= $(shell $(CC) $(cflags-y) --print-libgcc-file-name)
+LIBGCC	= $(shell $(CC) $(cflags-y) --print-libgcc-file-name)
 
 # Modules with short calls might break for calls into builtin-kernel
 KBUILD_CFLAGS_MODULE	+= -mlong-calls -mno-millicode
-- 
2.17.1

