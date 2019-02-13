Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECC5C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1EB20811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083551;
	bh=D/hzYpz9F3QghcRIJw2S6RGemoJVp5XTOIyuJuaIoEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OuMclHDRk2b49U/CWm+krk11PyygiaGKkfrn1ub93Dz9FU2kTqNCYw9/y3k5USuc6
	 Va0Vrb8kreglD2nGKz0p80ip8Ju/vLHYcrOknTuQi3iFFHfDKIgisnJ55CNWRWnXsC
	 PxZrOa8Kvl5mO4JP27Gpk1QC8QO3wS92Px62zrMY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394110AbfBMSpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:45:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:44420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394072AbfBMSpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:45:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CD5520811;
        Wed, 13 Feb 2019 18:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083546;
        bh=D/hzYpz9F3QghcRIJw2S6RGemoJVp5XTOIyuJuaIoEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q/ppsfmlvsq1tNb/6/OQQ+G7ADbVR7153EbQQE+Wn7VCSQ3QI2qgZBE00m+BOrVjy
         7vfXcaP3bh5TXFj8GhtGuShdq4I5GGbIVLn/5p9hVVnRBqyu+DpXPGBqkzHRPeOB1t
         l+uuaWo4NPTCAmL37puDwhJow47uVzCBKePQmULA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.20 29/50] ARM: iop32x/n2100: fix PCI IRQ mapping
Date:   Wed, 13 Feb 2019 19:38:34 +0100
Message-Id: <20190213183658.076218117@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183655.747168774@linuxfoundation.org>
References: <20190213183655.747168774@linuxfoundation.org>
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
 


