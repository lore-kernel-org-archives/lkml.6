Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B84AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D79B32177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499271;
	bh=DdqANRqW3XeU5JmWS0ahSa7x3u1KEG+cNmcH3CMyQ20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hVNGmk7HuMt6ybW8aCIvMlTSIKzjWsJwlRqKMtNj6r5EGYdvxubK42ID0g9AI0K3C
	 wZWoZiOa+LAZWdS8VDAzcwksIjgHWqJQJjQbBj6K5CCvmY2rRbq0xZTaVgo9IG9xSb
	 RymXtjPlSAtASU1h0UHaLqwgUdH+sb0PJv56MKYo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391966AbfBROO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:14:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:57834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392215AbfBRONL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:13:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9F80218AD;
        Mon, 18 Feb 2019 14:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550499191;
        bh=DdqANRqW3XeU5JmWS0ahSa7x3u1KEG+cNmcH3CMyQ20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SxWppTsWFFP78lKTXMW/4rJWwEYtLH15Vz4YwT48Auw+lxVAjVWJJ9aFibo+gp/dN
         sA8mrhguj2+W+U+ybI9VJm2ZSS9VHon3uPXOgKDw8mZIdUmnKrRiFGS9he0qSmaWin
         A1IFr4R3R/5ox6ZqZlzTTiua/E+1oOBslPzhTNM4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3.18 081/108] ARM: iop32x/n2100: fix PCI IRQ mapping
Date:   Mon, 18 Feb 2019 14:44:17 +0100
Message-Id: <20190218133523.281209053@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
References: <20190218133519.525507231@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Russell King <rmk+kernel@armlinux.org.uk>

commit db4090920ba2d61a5827a23e441447926a02ffee upstream.

Booting 4.20 on a TheCUS N2100 results in a kernel oops while probing
PCI, due to n2100_pci_map_irq() having been discarded during boot.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Cc: stable@vger.kernel.org # 2.6.18+
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/mach-iop32x/n2100.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/arm/mach-iop32x/n2100.c
+++ b/arch/arm/mach-iop32x/n2100.c
@@ -75,8 +75,7 @@ void __init n2100_map_io(void)
 /*
  * N2100 PCI.
  */
-static int __init
-n2100_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+static int n2100_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	int irq;
 


