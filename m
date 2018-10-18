Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65FEC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE4321476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5KKtMU+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE4321476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbeJSCA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:00:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729134AbeJSCA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:00:58 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92E9121476;
        Thu, 18 Oct 2018 17:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885533;
        bh=bjOqUdXs6gNZXH03iVCr2v9/mYX8u2aGHsJsOPSonUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W5KKtMU+luZOihAZvOIbOnB5vpWvfod/dcciQmaEjSJK4Z/BTQiUuXfcMz38aFnKX
         ezaNeWUrfJaWzc1dZKSLbElyMM1pfC8YQjzvUaOOmDcFI8X+Mamd4Ix/DXn1ocd+Zx
         Dw7ZCZ+EyXweC3zY0+FTYM84SJct+r0cMP2V0zVI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Brodkin <abrodkin@synopsys.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh@kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCH 4.18 53/53] ARC: build: Dont set CROSS_COMPILE in archs Makefile
Date:   Thu, 18 Oct 2018 19:54:46 +0200
Message-Id: <20181018175425.568632810@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175416.561567978@linuxfoundation.org>
References: <20181018175416.561567978@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Brodkin <abrodkin@synopsys.com>

commit 40660f1fcee8d524a60b5101538e42b1f39f106d upstream.

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

| gcc: error: unrecognized command line option -mmedium-calls
| gcc: error: unrecognized command line option -mno-sdata

[1] http://lists.infradead.org/pipermail/linux-snps-arc/2018-September/004308.html
[2] http://lists.infradead.org/pipermail/linux-snps-arc/2018-September/004320.html

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arc/Makefile |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

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
@@ -73,7 +65,7 @@ ldflags-$(CONFIG_CPU_BIG_ENDIAN)	+= -EB
 # --build-id w/o "-marclinux". Default arc-elf32-ld is OK
 ldflags-$(upto_gcc44)			+= -marclinux
 
-LIBGCC	:= $(shell $(CC) $(cflags-y) --print-libgcc-file-name)
+LIBGCC	= $(shell $(CC) $(cflags-y) --print-libgcc-file-name)
 
 # Modules with short calls might break for calls into builtin-kernel
 KBUILD_CFLAGS_MODULE	+= -mlong-calls -mno-millicode


