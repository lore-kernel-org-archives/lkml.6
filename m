Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C03C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF7C20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8D60Zl9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF7C20C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389916AbeKTDOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:14:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:51484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388976AbeKTDOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:14:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA737206BA;
        Mon, 19 Nov 2018 16:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646201;
        bh=dId2RdkQkRi84mF+6gx+2KSHVKDlHaN2O0CWXBKwHKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K8D60Zl9doOqX3QYTU0RYsQcQzRJwXcv1ycfiNio18kS2ibT1CU24YhnG1orY6nvG
         2RuBm0o+d1QEEFxXlAXzjMAVMQFRegD43PS43tLSVOCu284w4sqlBcEa2ypOK7OeRc
         rjdQOqlnyixU7TXPNsR8tG+kywBIyMY2k1shYNo0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 4.14 037/124] xtensa: add NOTES section to the linker script
Date:   Mon, 19 Nov 2018 17:28:11 +0100
Message-Id: <20181119162620.841784326@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.951907286@linuxfoundation.org>
References: <20181119162612.951907286@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Max Filippov <jcmvbkbc@gmail.com>

commit 4119ba211bc4f1bf638f41e50b7a0f329f58aa16 upstream.

This section collects all source .note.* sections together in the
vmlinux image. Without it .note.Linux section may be placed at address
0, while the rest of the kernel is at its normal address, resulting in a
huge vmlinux.bin image that may not be linked into the xtensa Image.elf.

Cc: stable@vger.kernel.org
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/xtensa/boot/Makefile        |    2 +-
 arch/xtensa/kernel/vmlinux.lds.S |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

--- a/arch/xtensa/boot/Makefile
+++ b/arch/xtensa/boot/Makefile
@@ -34,7 +34,7 @@ boot-elf boot-redboot: $(addprefix $(obj
 		       $(addprefix $(obj)/,$(host-progs))
 	$(Q)$(MAKE) $(build)=$(obj)/$@ $(MAKECMDGOALS)
 
-OBJCOPYFLAGS = --strip-all -R .comment -R .note.gnu.build-id -O binary
+OBJCOPYFLAGS = --strip-all -R .comment -R .notes -O binary
 
 vmlinux.bin: vmlinux FORCE
 	$(call if_changed,objcopy)
--- a/arch/xtensa/kernel/vmlinux.lds.S
+++ b/arch/xtensa/kernel/vmlinux.lds.S
@@ -146,6 +146,7 @@ SECTIONS
   .fixup   : { *(.fixup) }
 
   EXCEPTION_TABLE(16)
+  NOTES
   /* Data section */
 
   _sdata = .;


