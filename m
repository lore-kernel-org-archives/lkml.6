Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06D0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C9020831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C9020831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbeKSWWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:22:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:56570 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728554AbeKSWWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 17:22:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 36F2AAF63;
        Mon, 19 Nov 2018 11:59:15 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sh: Always enable CONFIG_GENERIC_PCI_IOMAP
Date:   Mon, 19 Nov 2018 12:59:10 +0100
Message-Id: <20181119115910.19390-1-tiwai@suse.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_GENERIC_PCI_IOMAP is supposed to be set no matter whether
CONFIG_PCI is present or not.  Otherwise the generic header
(asm-generic/pci_iomap.h) won't create dummy functions, and the code
using pci_iomap() and pci_iounmap() will fail due to the lack of the
function definitions / declarations.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 arch/sh/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index f82a4da7adf3..3d5220ad9e46 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -36,6 +36,8 @@ config SUPERH
 	select RTC_LIB
 	select GENERIC_ATOMIC64
 	select GENERIC_IRQ_SHOW
+	select GENERIC_PCI_IOMAP
+	select NO_GENERIC_PCI_IOPORT_MAP
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_CLOCKEVENTS
@@ -859,8 +861,6 @@ config PCI
 	bool "PCI support"
 	depends on SYS_SUPPORTS_PCI
 	select PCI_DOMAINS
-	select GENERIC_PCI_IOMAP
-	select NO_GENERIC_PCI_IOPORT_MAP
 	help
 	  Find out whether you have a PCI motherboard. PCI is the name of a
 	  bus system, i.e. the way the CPU talks to the other stuff inside
-- 
2.19.1

