Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319E4C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0128D2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548693810;
	bh=ol+GQcxW3dEXmVczFWa3yJEsROoP/lF6JCLsaiBgMeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=139TzaIaJwYuLy89am5AdPBKhSeOdE9+FWmVlBbR8GEHGxRBztIqxCA/OFpTDorEZ
	 YSqoAO221mrP5rJU43AiuQ8bF7qDfxz35kVyVWZYZRIC/M0n2lCSzRrS5Ykb/Q1D6e
	 n7sBIysbk75+tJW0C8XCGgkx3Pe7i8olLF54nopg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389438AbfA1QX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:23:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:59654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389019AbfA1QXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:23:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E48DF2147A;
        Mon, 28 Jan 2019 16:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692604;
        bh=ol+GQcxW3dEXmVczFWa3yJEsROoP/lF6JCLsaiBgMeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=soZC/ys9txCPGzbv+XVVHqfNWESpy0EE1SCtQ+tTeOhLnvYWAVXptVusBk8QbQQef
         NoXR0T5J4wqimwflhpIGD0UYCBwJsEQR3DbkGaMYi2zSo6ORoWVDzAEoAYnzmaDAqm
         dt6OXnDnQKqEuvSeSfkqiK/8D0Ns2P9qqq+EyM+k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stefan Roese <sr@denx.de>, Paul Burton <paul.burton@mips.com>,
        John Crispin <blogic@openwrt.org>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Sasha Levin <sashal@kernel.org>, linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 089/107] MIPS: ralink: Select CONFIG_CPU_MIPSR2_IRQ_VI on MT7620/8
Date:   Mon, 28 Jan 2019 11:19:29 -0500
Message-Id: <20190128161947.57405-89-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161947.57405-1-sashal@kernel.org>
References: <20190128161947.57405-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Roese <sr@denx.de>

[ Upstream commit 0b15394475e3bcaf35ca4bf22fc55d56df67224e ]

Testing has shown, that when using mainline U-Boot on MT7688 based
boards, the system may hang or crash while mounting the root-fs. The
main issue here is that mainline U-Boot configures EBase to a value
near the end of system memory. And with CONFIG_CPU_MIPSR2_IRQ_VI
disabled, trap_init() will not allocate a new area to place the
exception handler. The original value will be used and the handler
will be copied to this location, which might already be used by some
userspace application.

The MT7688 supports VI - its config3 register is 0x00002420, so VInt
(Bit 5) is set. But without setting CONFIG_CPU_MIPSR2_IRQ_VI this
bit will not be evaluated to result in "cpu_has_vi" being set. This
patch now selects CONFIG_CPU_MIPSR2_IRQ_VI on MT7620/8 which results
trap_init() to allocate some memory for the exception handler.

Please note that this issue was not seen with the Mediatek U-Boot
version, as it does not touch EBase (stays at default of 0x8000.0000).
This is strictly also not correct as the kernel (_text) resides
here.

Signed-off-by: Stefan Roese <sr@denx.de>
[paul.burton@mips.com: s/beeing/being/]
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: John Crispin <blogic@openwrt.org>
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/ralink/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
index 813826a456ca..55a5fee781e8 100644
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -38,6 +38,7 @@ choice
 
 	config SOC_MT7620
 		bool "MT7620/8"
+		select CPU_MIPSR2_IRQ_VI
 		select HW_HAS_PCI
 
 	config SOC_MT7621
-- 
2.19.1

