Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6588BC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E792087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277171;
	bh=ke1kRp1SSPdauB3qpKdqMAIGTnIjZ6ueuK11H8xrDVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yRhZXVqNwSdN8CuvTlfKQGprkYxB55Pz8FDUyRhJJSYU91VEA2yY3/6VwSJbxexg6
	 zM5d8PlQrODknHQbsS0r68yDjLc3L4FryphzYvXw0vtwWp6zanTZl/uR/KaqrPb9Fz
	 h5uGBFPKNBpxaDiRhbm0X/A85j+amsH26KIiFu6c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbfBDKqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:46:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:44290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730865AbfBDKqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:46:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B03E2087C;
        Mon,  4 Feb 2019 10:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277166;
        bh=ke1kRp1SSPdauB3qpKdqMAIGTnIjZ6ueuK11H8xrDVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pFFE89Rj71itli7CDXIqHyTn/Zo+xoLMHW807Lm47gAcmoltd1/KsJ2xu65xdJ6Yd
         kXh5XmYdsMyecUb0u74CHfxZBNQt1v9cd0HEaYB5AE6avORdErRlCWHkuapO2y01DO
         q36EEt6O6+UnbSzjjESaG4cDPpwIH7cO3lfqxiLw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Tim Harvey <tharvey@gateworks.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Olof Johansson <olof@lixom.net>,
        Robin Leblon <robin.leblon@ncentric.com>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH 4.14 25/46] ARM: cns3xxx: Fix writing to wrong PCI config registers after alignment
Date:   Mon,  4 Feb 2019 11:36:56 +0100
Message-Id: <20190204103612.960320861@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103608.651205056@linuxfoundation.org>
References: <20190204103608.651205056@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Koen Vandeputte <koen.vandeputte@ncentric.com>

commit 65dbb423cf28232fed1732b779249d6164c5999b upstream.

Originally, cns3xxx used its own functions for mapping, reading and
writing config registers.

Commit 802b7c06adc7 ("ARM: cns3xxx: Convert PCI to use generic config
accessors") removed the internal PCI config write function in favor of
the generic one:

  cns3xxx_pci_write_config() --> pci_generic_config_write()

cns3xxx_pci_write_config() expected aligned addresses, being produced by
cns3xxx_pci_map_bus() while the generic one pci_generic_config_write()
actually expects the real address as both the function and hardware are
capable of byte-aligned writes.

This currently leads to pci_generic_config_write() writing to the wrong
registers.

For instance, upon ath9k module loading:

- driver ath9k gets loaded
- The driver wants to write value 0xA8 to register PCI_LATENCY_TIMER,
  located at 0x0D
- cns3xxx_pci_map_bus() aligns the address to 0x0C
- pci_generic_config_write() effectively writes 0xA8 into register 0x0C
  (CACHE_LINE_SIZE)

Fix the bug by removing the alignment in the cns3xxx mapping function.

Fixes: 802b7c06adc7 ("ARM: cns3xxx: Convert PCI to use generic config accessors")
Signed-off-by: Koen Vandeputte <koen.vandeputte@ncentric.com>
[lorenzo.pieralisi@arm.com: updated commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Krzysztof Halasa <khalasa@piap.pl>
Acked-by: Tim Harvey <tharvey@gateworks.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
CC: stable@vger.kernel.org	# v4.0+
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: Olof Johansson <olof@lixom.net>
CC: Robin Leblon <robin.leblon@ncentric.com>
CC: Rob Herring <robh@kernel.org>
CC: Russell King <linux@armlinux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/mach-cns3xxx/pcie.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/mach-cns3xxx/pcie.c
+++ b/arch/arm/mach-cns3xxx/pcie.c
@@ -83,7 +83,7 @@ static void __iomem *cns3xxx_pci_map_bus
 	} else /* remote PCI bus */
 		base = cnspci->cfg1_regs + ((busno & 0xf) << 20);
 
-	return base + (where & 0xffc) + (devfn << 12);
+	return base + where + (devfn << 12);
 }
 
 static int cns3xxx_pci_read_config(struct pci_bus *bus, unsigned int devfn,


