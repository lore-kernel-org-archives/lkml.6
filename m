Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7496BC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A97520866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlRokWwc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A97520866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbeJPMYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:24:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727620AbeJPMA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:00:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DEC521471;
        Tue, 16 Oct 2018 04:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663156;
        bh=lyiEMOCOti0rfoPYV/aFicjMmhpyucqiHSU+3pBw0ZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TlRokWwc6fV56mXGn0eBqtyjVc9SGU7bpvQezUjT29Al6ddUlkSomO5W5NNEaeLZ1
         MkiRUlGRDP4fx3yRR68yZWvKW8OAcclvLH8H7ecDSrd7kN5c7OTwrhQuOnGN7mRrMj
         2hoIsF/0PNQBsQN84v5iX6uueME0ixlJgvSCf/Cw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 012/100] ARM: 8799/1: mm: fix pci_ioremap_io() offset check
Date:   Tue, 16 Oct 2018 00:10:53 -0400
Message-Id: <20181016041221.135528-12-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
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
index fc91205ff46c..5bf9443cfbaa 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -473,7 +473,7 @@ void pci_ioremap_set_mem_type(int mem_type)
 
 int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr)
 {
-	BUG_ON(offset + SZ_64K > IO_SPACE_LIMIT);
+	BUG_ON(offset + SZ_64K - 1 > IO_SPACE_LIMIT);
 
 	return ioremap_page_range(PCI_IO_VIRT_BASE + offset,
 				  PCI_IO_VIRT_BASE + offset + SZ_64K,
-- 
2.17.1

