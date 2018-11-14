Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13ED5C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA1532145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbeQ/UbR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA1532145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbeKOIvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:51:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:34392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbeKOI1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:27:12 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A16C22512;
        Wed, 14 Nov 2018 22:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234129;
        bh=JZkYnhfo6oPyXug1i56TwOPEM0BSj9n+2edVn8ZBuLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jbeQ/UbRAawG/P9MKPJ7mz+227j7chjGQPRKgqeKvo4EIvdQdokUBLpd7eUZ1tzU+
         s5xy3B/7IAFfkbTK37De/YTtpD7fnq07kWNqCEod8YUGSaxvLCMpupkxKl07Ir2qas
         BgyP2j7hsIkgdekopt7noPeiIVqHWQbxyJ671Ud0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 04/73] s390/decompressor: add missing FORCE to build targets
Date:   Wed, 14 Nov 2018 17:20:58 -0500
Message-Id: <20181114222207.98701-4-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222207.98701-1-sashal@kernel.org>
References: <20181114222207.98701-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit ef5febae1543f35a45f01614123e829d77326d0f ]

According to Documentation/kbuild/makefiles.txt all build targets
using if_changed should use FORCE as well. Add missing FORCE to make
sure vmlinux decompressor targets are rebuild properly when not just
immediate prerequisites have changed but also when build command differs.

Reviewed-by: Philipp Rudo <prudo@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/boot/compressed/Makefile | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/s390/boot/compressed/Makefile b/arch/s390/boot/compressed/Makefile
index 04609478d18b..b375c6c5ae7b 100644
--- a/arch/s390/boot/compressed/Makefile
+++ b/arch/s390/boot/compressed/Makefile
@@ -20,7 +20,7 @@ KBUILD_CFLAGS := $(KBUILD_CFLAGS_DECOMPRESSOR)
 OBJECTS := $(addprefix $(obj)/,$(obj-y))
 
 LDFLAGS_vmlinux := --oformat $(LD_BFD) -e startup -T
-$(obj)/vmlinux: $(obj)/vmlinux.lds $(objtree)/arch/s390/boot/startup.a $(OBJECTS)
+$(obj)/vmlinux: $(obj)/vmlinux.lds $(objtree)/arch/s390/boot/startup.a $(OBJECTS) FORCE
 	$(call if_changed,ld)
 
 # extract required uncompressed vmlinux symbols and adjust them to reflect offsets inside vmlinux.bin
@@ -51,17 +51,17 @@ suffix-$(CONFIG_KERNEL_LZMA)  := .lzma
 suffix-$(CONFIG_KERNEL_LZO)  := .lzo
 suffix-$(CONFIG_KERNEL_XZ)  := .xz
 
-$(obj)/vmlinux.bin.gz: $(vmlinux.bin.all-y)
+$(obj)/vmlinux.bin.gz: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,gzip)
-$(obj)/vmlinux.bin.bz2: $(vmlinux.bin.all-y)
+$(obj)/vmlinux.bin.bz2: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,bzip2)
-$(obj)/vmlinux.bin.lz4: $(vmlinux.bin.all-y)
+$(obj)/vmlinux.bin.lz4: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,lz4)
-$(obj)/vmlinux.bin.lzma: $(vmlinux.bin.all-y)
+$(obj)/vmlinux.bin.lzma: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,lzma)
-$(obj)/vmlinux.bin.lzo: $(vmlinux.bin.all-y)
+$(obj)/vmlinux.bin.lzo: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,lzo)
-$(obj)/vmlinux.bin.xz: $(vmlinux.bin.all-y)
+$(obj)/vmlinux.bin.xz: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,xzkern)
 
 LDFLAGS_piggy.o := -r --format binary --oformat $(LD_BFD) -T
-- 
2.17.1

