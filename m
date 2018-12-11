Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6317FC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E6020672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544040;
	bh=ufXmbXQFReG4SVo9pv+qVihlTvYvdxYF71vXa3zcTvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BCmT17/jvCRf8KRXEB2x0M9JVS4uUuFEJXPUMT0go8+/TLUO3pY+vQkNGnhm0N0FK
	 DkkZTdBidleQBY/wvYR56OTXaCN7ljmii2y+g6uq3Is891rACFLd5c+eb6SiRAmwKS
	 QmeBMRifowXMy6/eJcl+H97N3Db4zgSqkRpuiT1s=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26E6020672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbeLKQAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:00:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:47352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730967AbeLKP6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:58:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 347272145D;
        Tue, 11 Dec 2018 15:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543889;
        bh=ufXmbXQFReG4SVo9pv+qVihlTvYvdxYF71vXa3zcTvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HWpQB4O2FzoaNJmwQbI/v2r0P4OpqK8lnoi1btRCOTGJGemoV2tqynmmTNfvnkMwd
         nG/ZTZO4xt/2afK2eYfkTi6WElyiiuGf0hjDNrDGIOcQpb8PEx4+DlzkGgyLF+bol1
         l0+XYpWtT46YEjwC8rX3QmhEyjEoZJINDVPAhDfU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Frank Scheiner <frank.scheiner@web.de>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 4.19 076/118] parisc: Enable -ffunction-sections for modules on 32-bit kernel
Date:   Tue, 11 Dec 2018 16:41:35 +0100
Message-Id: <20181211151647.324119111@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

commit 1e8249b8a4e960018e4baca6b523b8a4500af600 upstream.

Frank Schreiner reported, that since kernel 4.18 he faces sysfs-warnings
when loading modules on a 32-bit kernel. Here is one such example:

 sysfs: cannot create duplicate filename '/module/nfs/sections/.text'
 CPU: 0 PID: 98 Comm: modprobe Not tainted 4.18.0-2-parisc #1 Debian 4.18.10-2
 Backtrace:
  [<1017ce2c>] show_stack+0x3c/0x50
  [<107a7210>] dump_stack+0x28/0x38
  [<103f900c>] sysfs_warn_dup+0x88/0xac
  [<103f8b1c>] sysfs_add_file_mode_ns+0x164/0x1d0
  [<103f9e70>] internal_create_group+0x11c/0x304
  [<103fa0a0>] sysfs_create_group+0x48/0x60
  [<1022abe8>] load_module.constprop.35+0x1f9c/0x23b8
  [<1022b278>] sys_finit_module+0xd0/0x11c
  [<101831dc>] syscall_exit+0x0/0x14

This warning gets triggered by the fact, that due to commit 24b6c22504a2
("parisc: Build kernel without -ffunction-sections") we now get multiple .text
sections in the kernel modules for which sysfs_create_group() can't create
multiple virtual files.

This patch works around the problem by re-enabling the -ffunction-sections
compiler option for modules, while keeping it disabled for the non-module
kernel code.

Reported-by: Frank Scheiner <frank.scheiner@web.de>
Fixes: 24b6c22504a2 ("parisc: Build kernel without -ffunction-sections")
Cc: <stable@vger.kernel.org> # v4.18+
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/parisc/Makefile |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/arch/parisc/Makefile
+++ b/arch/parisc/Makefile
@@ -71,6 +71,13 @@ ifdef CONFIG_MLONGCALLS
 KBUILD_CFLAGS_KERNEL += -mlong-calls
 endif
 
+# Without this, "ld -r" results in .text sections that are too big (> 0x40000)
+# for branches to reach stubs. And multiple .text sections trigger a warning
+# when creating the sysfs module information section.
+ifndef CONFIG_64BIT
+KBUILD_CFLAGS_MODULE += -ffunction-sections
+endif
+
 # select which processor to optimise for
 cflags-$(CONFIG_PA7000)		+= -march=1.1 -mschedule=7100
 cflags-$(CONFIG_PA7200)		+= -march=1.1 -mschedule=7200


