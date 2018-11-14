Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6E3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B822254C
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bu78SLiC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B822254C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389435AbeKOIbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:31:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:39010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbeKOIbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:31:41 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8DAF2254C;
        Wed, 14 Nov 2018 22:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234397;
        bh=sQ4OF9s7b6FKWhCb3jJECnxDqylZSiBlReVdlDPYWmI=;
        h=From:To:Cc:Subject:Date:From;
        b=bu78SLiCRVI1CA9hap4MdViS6mV4zJh0FGNGY5QWAC8BQUTSn5r7FnAcKtImAk+NQ
         lf38M+nkDKi/U1LfcQzZluCZl2TEPJwFPfqz+B9ONowI0QKWj+dbIWkTxLkcM+ICwf
         5apvxiGkzMjb19Xazss4DKZBjQsT4mIv2FHVhqZw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 1/3] s390/vdso: add missing FORCE to build targets
Date:   Wed, 14 Nov 2018 17:26:30 -0500
Message-Id: <20181114222636.100512-1-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit b44b136a3773d8a9c7853f8df716bd1483613cbb ]

According to Documentation/kbuild/makefiles.txt all build targets using
if_changed should use FORCE as well. Add missing FORCE to make sure
vdso targets are rebuild properly when not just immediate prerequisites
have changed but also when build command differs.

Reviewed-by: Philipp Rudo <prudo@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/vdso32/Makefile | 6 +++---
 arch/s390/kernel/vdso64/Makefile | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kernel/vdso32/Makefile b/arch/s390/kernel/vdso32/Makefile
index 8ad2b34ad151..6661bfc2b3b4 100644
--- a/arch/s390/kernel/vdso32/Makefile
+++ b/arch/s390/kernel/vdso32/Makefile
@@ -29,7 +29,7 @@ GCOV_PROFILE := n
 $(obj)/vdso32_wrapper.o : $(obj)/vdso32.so
 
 # link rule for the .so file, .lds has to be first
-$(obj)/vdso32.so.dbg: $(src)/vdso32.lds $(obj-vdso32)
+$(obj)/vdso32.so.dbg: $(src)/vdso32.lds $(obj-vdso32) FORCE
 	$(call if_changed,vdso32ld)
 
 # strip rule for the .so file
@@ -38,12 +38,12 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
 	$(call if_changed,objcopy)
 
 # assembly rules for the .S files
-$(obj-vdso32): %.o: %.S
+$(obj-vdso32): %.o: %.S FORCE
 	$(call if_changed_dep,vdso32as)
 
 # actual build commands
 quiet_cmd_vdso32ld = VDSO32L $@
-      cmd_vdso32ld = $(CC) $(c_flags) -Wl,-T $^ -o $@
+      cmd_vdso32ld = $(CC) $(c_flags) -Wl,-T $(filter %.lds %.o,$^) -o $@
 quiet_cmd_vdso32as = VDSO32A $@
       cmd_vdso32as = $(CC) $(a_flags) -c -o $@ $<
 
diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/Makefile
index 2a8ddfd12a5b..5b7712f8eb4f 100644
--- a/arch/s390/kernel/vdso64/Makefile
+++ b/arch/s390/kernel/vdso64/Makefile
@@ -29,7 +29,7 @@ GCOV_PROFILE := n
 $(obj)/vdso64_wrapper.o : $(obj)/vdso64.so
 
 # link rule for the .so file, .lds has to be first
-$(obj)/vdso64.so.dbg: $(src)/vdso64.lds $(obj-vdso64)
+$(obj)/vdso64.so.dbg: $(src)/vdso64.lds $(obj-vdso64) FORCE
 	$(call if_changed,vdso64ld)
 
 # strip rule for the .so file
@@ -38,12 +38,12 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
 	$(call if_changed,objcopy)
 
 # assembly rules for the .S files
-$(obj-vdso64): %.o: %.S
+$(obj-vdso64): %.o: %.S FORCE
 	$(call if_changed_dep,vdso64as)
 
 # actual build commands
 quiet_cmd_vdso64ld = VDSO64L $@
-      cmd_vdso64ld = $(CC) $(c_flags) -Wl,-T $^ -o $@
+      cmd_vdso64ld = $(CC) $(c_flags) -Wl,-T $(filter %.lds %.o,$^) -o $@
 quiet_cmd_vdso64as = VDSO64A $@
       cmd_vdso64as = $(CC) $(a_flags) -c -o $@ $<
 
-- 
2.17.1

