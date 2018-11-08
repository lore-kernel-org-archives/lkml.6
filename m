Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955A2C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58AF420840
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMRFDAPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58AF420840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbeKIHbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:31:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:45908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbeKIHbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:31:20 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ADEF2086C;
        Thu,  8 Nov 2018 21:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714034;
        bh=HwmeArcedaKxJAsaNLgj1IU69UNH6nueGWpvhegz/Fg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gMRFDAPsFDg9oWG/k1pPfe4BpZ9qkafqBVR2texaw7pgyf0to+jvaNao7G70F/6zo
         +7G5Eq7ypfTlbha+8fw7l8LYs7QKDffl26ucHmJNsoB2/JeJxuXfpQaj4N5YP+yHN8
         J29H0CJZga+PGijEqJHMK3gP0TrYAkm00CQ96060=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nicolas Pitre <nico@linaro.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 023/144] ARM: 8799/1: mm: fix pci_ioremap_io() offset check
Date:   Thu,  8 Nov 2018 13:49:54 -0800
Message-Id: <20181108215056.474368379@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index d1e5ad7ab3bc..1500d3befe02 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -447,7 +447,7 @@ void pci_ioremap_set_mem_type(int mem_type)
 
 int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr)
 {
-	BUG_ON(offset + SZ_64K > IO_SPACE_LIMIT);
+	BUG_ON(offset + SZ_64K - 1 > IO_SPACE_LIMIT);
 
 	return ioremap_page_range(PCI_IO_VIRT_BASE + offset,
 				  PCI_IO_VIRT_BASE + offset + SZ_64K,
-- 
2.17.1



