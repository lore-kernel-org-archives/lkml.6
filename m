Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21612C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7AE204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7AE204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731412AbeIMTGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:06:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34188 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730337AbeIMTGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:06:13 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5414ED19;
        Thu, 13 Sep 2018 13:56:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Palmer Dabbelt <palmer@sifive.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 090/197] RISC-V: Use KBUILD_CFLAGS instead of KCFLAGS when building the vDSO
Date:   Thu, 13 Sep 2018 15:30:39 +0200
Message-Id: <20180913131845.131802941@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
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

From: Palmer Dabbelt <palmer@sifive.com>

[ Upstream commit 4938c79bd0f5f3650c8c2cd4cdc972f0a6962ce4 ]

If you use a 64-bit compiler to build a 32-bit kernel then you'll get an
error when building the vDSO due to a library mismatch.  The happens
because the relevant "-march" argument isn't supplied to the GCC run
that generates one of the vDSO intermediate files.

I'm not actually sure what the right thing to do here is as I'm not
particularly familiar with the kernel build system.  I poked the
documentation and it appears that KCFLAGS is the correct thing to do
(it's suggested that should be used when building modules), but we set
KBUILD_CFLAGS in arch/riscv/Makefile.

This does at least fix the build error.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/kernel/vdso/Makefile |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -52,8 +52,8 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
 # Add -lgcc so rv32 gets static muldi3 and lshrdi3 definitions.
 # Make sure only to export the intended __vdso_xxx symbol offsets.
 quiet_cmd_vdsold = VDSOLD  $@
-      cmd_vdsold = $(CC) $(KCFLAGS) $(call cc-option, -no-pie) -nostdlib $(SYSCFLAGS_$(@F)) \
-                           -Wl,-T,$(filter-out FORCE,$^) -o $@.tmp -lgcc && \
+      cmd_vdsold = $(CC) $(KBUILD_CFLAGS) $(call cc-option, -no-pie) -nostdlib -nostartfiles $(SYSCFLAGS_$(@F)) \
+                           -Wl,-T,$(filter-out FORCE,$^) -o $@.tmp && \
                    $(CROSS_COMPILE)objcopy \
                            $(patsubst %, -G __vdso_%, $(vdso-syms)) $@.tmp $@
 


