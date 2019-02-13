Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61162C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A78222D9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083179;
	bh=AHB0rZzOVgv4NhFV7LoZg458hjbd1VxmzJoUy9UJjqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sDynW64WhQddRcASQxt+KTyWS7rFn0DjCMHUMR4w0GBxxsUamYKr/+hkSnSQzvgy0
	 s4JEaZ+pY1OxzVLzQkHW1I9W9N/TfLdZNDsPovko2gdWiYNZJEjTGT9X8RY2coHx6V
	 bhxz0a0sPznse9LsAasQ7xFCk9lAuBOAeWuaUfd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405235AbfBMSjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:39:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:37536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387779AbfBMSjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:39:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB8EF222D5;
        Wed, 13 Feb 2019 18:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083173;
        bh=AHB0rZzOVgv4NhFV7LoZg458hjbd1VxmzJoUy9UJjqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uukBHbmgRcnWhlovOs5/xVWyRdLJlhiVpREciT9M9YPSkg9kntk+RHmrsUq+K7sC+
         ldLPxOHT9qR4nTo5OL093JIPuwwZEsuS7id7C73jLNGRN9XtJKEilxUhJT/w5Hmag0
         ZwInE9ONYNCu34u4PUU0VjNqIuU47EUCC5Mo1K+g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.9 11/24] ARM: iop32x/n2100: fix PCI IRQ mapping
Date:   Wed, 13 Feb 2019 19:38:08 +0100
Message-Id: <20190213183648.280307013@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183647.333441569@linuxfoundation.org>
References: <20190213183647.333441569@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 


