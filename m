Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4FBC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B96720866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="00Epuyyh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B96720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbeJPMIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:08:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729125AbeJPMEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:04:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20C602147E;
        Tue, 16 Oct 2018 04:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663373;
        bh=japtq3FLTG+Taxjz6AZTewet2E8Cef3InQASlB608QA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=00Epuyyh1zMEPjJEQkSAofSTnQhJRH5o1h98pEMNXGGYeqrKSu283LfIhPiggEoka
         QgGSWdvIbbeVZU5bh/IeZyb6H1FSB6M9U91vSmiG0p31Ve1Jns7vf2UWok0/QVEz+i
         4DeEvshaEWiGLHv1dftbrF7ErCs3hPjaz2Tzynp4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 06/25] ARM: 8799/1: mm: fix pci_ioremap_io() offset check
Date:   Tue, 16 Oct 2018 00:15:47 -0400
Message-Id: <20181016041606.135876-6-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041606.135876-1-sashal@kernel.org>
References: <20181016041606.135876-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

[ Upstream commit 3a58ac65e2d7969bcdf1b6acb70fa4d12a88e53e ]

IO_SPACE_LIMIT is the ending address of the PCI IO space, i.e
something like 0xfffff (and not 0x100000).

Therefore, when offset = 0xf0000 is passed as argument, this function
fails even though the offset + SZ_64K fits below the
IO_SPACE_LIMIT. This makes the last chunk of 64 KB of the I/O space
not usable as it cannot be mapped.

This patch fixes that by substracing 1 to offset + SZ_64K, so that we
compare the addrss of the last byte of the I/O space against
IO_SPACE_LIMIT instead of the address of the first byte of what is
after the I/O space.

Fixes: c2794437091a4 ("ARM: Add fixed PCI i/o mapping")
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Acked-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mm/ioremap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index 0c81056c1dd7..2a3feb73de0b 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -460,7 +460,7 @@ void pci_ioremap_set_mem_type(int mem_type)
 
 int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr)
 {
-	BUG_ON(offset + SZ_64K > IO_SPACE_LIMIT);
+	BUG_ON(offset + SZ_64K - 1 > IO_SPACE_LIMIT);
 
 	return ioremap_page_range(PCI_IO_VIRT_BASE + offset,
 				  PCI_IO_VIRT_BASE + offset + SZ_64K,
-- 
2.17.1

