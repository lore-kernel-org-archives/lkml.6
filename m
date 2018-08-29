Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA831C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917EF20880
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TW3w+B8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 917EF20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbeH2E2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 00:28:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41327 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbeH2E2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 00:28:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id h79-v6so1421520pfk.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 17:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=77CnGhDVfZ1V5/8Yy5v6KESYxPhz2WnPiEPmqkW81rc=;
        b=TW3w+B8AfD29Z07zFedJMYtgEE8fmRz9ewsmjDFn5/rGFHyVL2Rg2r4OK3s12mtwVT
         sd8vsoIkpV6XZm7ntpsDZWgB5477GPEFicITD02tTFPXDmoZ1ovP/ob01Szp4XAYtP1i
         nwkzLAXESgS+D48QX30WL4H75yNPyx1SUwmlMgR5kv5PrE5TXF8h6Qpt0aHOjLwyv9UU
         qr3/saCMDUURhyTdmAacfaK/ETt0fM+GllfUuwTlZmVdgtquXJGRbiyIYzqFUqjXbJgc
         QY7QIfXLM7WRhoLXhflOPlOuVJR9775JcSDznS0sRCTCVUD7/DMbyqouQFo9aA0dNjtg
         7MkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=77CnGhDVfZ1V5/8Yy5v6KESYxPhz2WnPiEPmqkW81rc=;
        b=VDrdX/h/ZUVmWRUgr3R26kg/IX4YFQAtjwlTj4ajItF7FlnSOq8JEQxPb5sDqTZUCp
         YBVZRBtIh2f/uLK2qMz+XvxrUvr5iV+QtoWTIdroyAglbCaK+sAmam2fRAKaUrYh+dx+
         PklC+LEi5+k4UQwvEKtziLqT9ceoO0k10Q6P3YR+x3RE1oRiZo/tWr325BWax2IeKv6T
         HKx0+mUglsZ+2W9hET0zTlHq3bzWEQK4hqmwVC3VO94XBXf8rnNp5Xu7trycR4HUbZNV
         80XogdQuz4VucuJZ0Br09xY0yU++Pu3Lm/+Q9QNBfdYdblJNtmf3xLrGT9/yd6FNQm8I
         /IJA==
X-Gm-Message-State: APzg51DG8x2oBsc2U33FjtL8mWZy9aYqMSR1FjI3atq6523DrAUJlGC1
        B48eW452m2In2FZHnGOIxNNdpn7G
X-Google-Smtp-Source: ANB0VdZHFhbiHN4dXwndXAa9bGK2YYD+on0GuiZgnuXwpH2+Hb9N6qOWUUd3kID9WHY77HtG0Y8N7w==
X-Received: by 2002:a63:d857:: with SMTP id k23-v6mr3621748pgj.106.1535502830057;
        Tue, 28 Aug 2018 17:33:50 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id b21-v6sm4803560pfe.148.2018.08.28.17.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 17:33:49 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, schwab@linux-m68k.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2] riscv: Do not overwrite initrd_start and initrd_end
Date:   Tue, 28 Aug 2018 17:33:46 -0700
Message-Id: <1535502826-23856-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

setup_initrd() overwrites initrd_start and initrd_end if __initramfs_size
is larger than 0, which is always true even if there is no embedded
initramfs. This prevents booting qemu with "-initrd" parameter.
Overwriting initrd_start and initrd_end is not necessary since
__initramfs_start and __initramfs_size are used directly in
populate_rootfs() to load the built-in initramfs, so just drop
that code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Instead of dropping setup_initrd() entirely, only stop
    overwriting initrd_start and initrd_end. Adjust explanation
    accordingly.

 arch/riscv/kernel/setup.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index db20dc630e7e..aee603123030 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -85,15 +85,8 @@ atomic_t hart_lottery;
 #ifdef CONFIG_BLK_DEV_INITRD
 static void __init setup_initrd(void)
 {
-	extern char __initramfs_start[];
-	extern unsigned long __initramfs_size;
 	unsigned long size;
 
-	if (__initramfs_size > 0) {
-		initrd_start = (unsigned long)(&__initramfs_start);
-		initrd_end = initrd_start + __initramfs_size;
-	}
-
 	if (initrd_start >= initrd_end) {
 		printk(KERN_INFO "initrd not found or empty");
 		goto disable;
-- 
2.7.4

