Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3E0C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F06C20869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="SRukdNfL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F06C20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389707AbeKGDSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:18:14 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55864 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730671AbeKGDSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:18:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CHuw1KmGmf+uPnv6AM4nW3dc0Xygli7B1SC42kWCxrI=; b=SRukdNfLCxm9Iwd0hLlVRogiF
        Yv6g61774GGIPKM5F1lwT1T79Fki2wwenvCO/IOW3WfmrAnikQ90izDu5r8NVsKJvmO/f6t6rYQl5
        vFRUWszUMszdcfNSf6zZvny5Pmy4caHvQh3nnOp7io9gRYfKhyE+zA6VNvDlXh/mcUnzs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gK5W0-0002qJ-JJ; Tue, 06 Nov 2018 17:51:48 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 347CF112266B; Tue,  6 Nov 2018 17:51:48 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     arnd@arndb.de, akpm@linux-foundation.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] sh: Provide prototypes for PCI I/O mapping in asm/io.h
Date:   Tue,  6 Nov 2018 17:51:42 +0000
Message-Id: <20181106175142.27988-1-broonie@kernel.org>
X-Mailer: git-send-email 2.19.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most architectures provide prototypes for the PCI I/O mapping operations
when asm/io.h is included but SH doesn't currently do that, leading to
for example warnings in sound/pci/hda/patch_ca0132.c when pci_iomap() is
used on current -next.  Make SH more consistent with other architectures
by including asm-generic/pci_iomap.h in asm/io.h.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/sh/include/asm/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 98cb8c802b1a..4f7f235f15f8 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -24,6 +24,7 @@
 #define __IO_PREFIX     generic
 #include <asm/io_generic.h>
 #include <asm/io_trapped.h>
+#include <asm-generic/pci_iomap.h>
 #include <mach/mangle-port.h>
 
 #define __raw_writeb(v,a)	(__chk_io_ptr(a), *(volatile u8  __force *)(a) = (v))
-- 
2.19.0.rc2

