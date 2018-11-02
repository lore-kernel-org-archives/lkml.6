Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD198C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D80120840
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2LvLWIwm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D80120840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbeKCDqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:46:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbeKCDqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:46:24 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4A0C2081B;
        Fri,  2 Nov 2018 18:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541183893;
        bh=J74Ylb0oPOAjYd3nOtYu5ppgtIqpE8z4hnA9oeMHKjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2LvLWIwmZbCRxKYHZVf9mEeUgnuRtaZe0AQyOIsdnf98oQf2A5euACXQGNlaLaheI
         Y5xx0JIMuXhBFA2JFNizqZtFq+St8sAbAFy8rOymixiW1kpkRV503k4UZb8RzXGLnH
         F7nxRU6FjBZG4t05+8y6hux9FiuXz/ktJZ2YoHQY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nicolas Pitre <nico@linaro.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 012/150] ARM: 8799/1: mm: fix pci_ioremap_io() offset check
Date:   Fri,  2 Nov 2018 19:32:54 +0100
Message-Id: <20181102182903.524825010@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
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



