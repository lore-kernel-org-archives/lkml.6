Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4800C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F654214C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxziC4a+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F654214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732073AbeJICD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:03:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbeJICD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:03:28 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60C04204FD;
        Mon,  8 Oct 2018 18:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024621;
        bh=KyU6vCy5gjHMRy5pRuB8LygJtqgyNS7JsbNP+hi9dvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sxziC4a+2okqijgfQw/rs1HG53TtX+oiutoI/Bns4XYv83du4Bm3XGABaWQI09Jcq
         GGjHsWtZOsNtHv7DpqcUIsNQXp2SHzalPKH294yY9tUpxBwtBrQ4UnYGNNLukOiKup
         0qLfz/UtKj6aZnEnpZSzootCnxiR1an0YjkhKjTI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Palmer Dabbelt <palmer@sifive.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 099/168] riscv: Do not overwrite initrd_start and initrd_end
Date:   Mon,  8 Oct 2018 20:31:19 +0200
Message-Id: <20181008175623.826535321@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
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

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit e866d3e84eb7c9588afb77604d417e8cc49fe216 ]

setup_initrd() overwrites initrd_start and initrd_end if __initramfs_size
is larger than 0, which is always true even if there is no embedded
initramfs. This prevents booting qemu with "-initrd" parameter.
Overwriting initrd_start and initrd_end is not necessary since
__initramfs_start and __initramfs_size are used directly in
populate_rootfs() to load the built-in initramfs, so just drop
that code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/kernel/setup.c |    7 -------
 1 file changed, 7 deletions(-)

--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -64,15 +64,8 @@ atomic_t hart_lottery;
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


