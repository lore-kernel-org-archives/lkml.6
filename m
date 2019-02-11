Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0509C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBFA214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895597;
	bh=dJ3lfC9OhfehczZFP5NjJLcAhCLUd4EWZixlyG2oAQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F5lY352aMt+cSQJLoLqW9+WXPnU7/cB3jMGO7lWzJOvzJsyu4bRkZnRVDpJNV/kZo
	 1WlaztybTzSd0KReflilan+/RRo4swbthIk7BKey9+CPU7X2+0QzamOJ3ejVndn3A+
	 kqAZ7I6gHOIEoxZQsQoN+FjQhRXhtmaf5etyE2m0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbfBKOdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:33:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:40802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730578AbfBKOdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:33:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8088C214DA;
        Mon, 11 Feb 2019 14:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895589;
        bh=dJ3lfC9OhfehczZFP5NjJLcAhCLUd4EWZixlyG2oAQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hebwc0BliNq2MPCKAzIm2sQm/5kSOS2IFE+9fOJ+H1in1xfRdCNFL0GllJhWITBny
         eukA36YVnYUGF94fBcRHLzQBtvrc5nEtSwA9qWNKHrLVg/3BGf12iXRx4tPeoZpleB
         RqsYkkM7ni0nIh9PCMXqkgWtRghj2LPk4DvlkEqs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Roese <sr@denx.de>,
        Paul Burton <paul.burton@mips.com>,
        John Crispin <blogic@openwrt.org>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 256/352] MIPS: ralink: Select CONFIG_CPU_MIPSR2_IRQ_VI on MT7620/8
Date:   Mon, 11 Feb 2019 15:18:03 +0100
Message-Id: <20190211141903.372203898@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 1f9cb0e3c79a..613d61763433 100644
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



