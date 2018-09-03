Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925C7C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495BA2077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495BA2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbeICViK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:38:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42702 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728282AbeICViJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:38:09 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 30A37D02;
        Mon,  3 Sep 2018 17:17:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 038/165] net: prevent ISA drivers from building on PPC32
Date:   Mon,  3 Sep 2018 18:55:24 +0200
Message-Id: <20180903165657.009878417@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit c9ce1fa1c24b08e13c2a3b5b1f94a19c9eaa982c ]

Prevent drivers from building on PPC32 if they use isa_bus_to_virt(),
isa_virt_to_bus(), or isa_page_to_bus(), which are not available and
thus cause build errors.

../drivers/net/ethernet/3com/3c515.c: In function 'corkscrew_open':
../drivers/net/ethernet/3com/3c515.c:824:9: error: implicit declaration of function 'isa_virt_to_bus'; did you mean 'virt_to_bus'? [-Werror=implicit-function-declaration]

../drivers/net/ethernet/amd/lance.c: In function 'lance_rx':
../drivers/net/ethernet/amd/lance.c:1203:23: error: implicit declaration of function 'isa_bus_to_virt'; did you mean 'bus_to_virt'? [-Werror=implicit-function-declaration]

../drivers/net/ethernet/amd/ni65.c: In function 'ni65_init_lance':
../drivers/net/ethernet/amd/ni65.c:585:20: error: implicit declaration of function 'isa_virt_to_bus'; did you mean 'virt_to_bus'? [-Werror=implicit-function-declaration]

../drivers/net/ethernet/cirrus/cs89x0.c: In function 'net_open':
../drivers/net/ethernet/cirrus/cs89x0.c:897:20: error: implicit declaration of function 'isa_virt_to_bus'; did you mean 'virt_to_bus'? [-Werror=implicit-function-declaration]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/3com/Kconfig   |    2 +-
 drivers/net/ethernet/amd/Kconfig    |    4 ++--
 drivers/net/ethernet/cirrus/Kconfig |    1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/3com/Kconfig
+++ b/drivers/net/ethernet/3com/Kconfig
@@ -32,7 +32,7 @@ config EL3
 
 config 3C515
 	tristate "3c515 ISA \"Fast EtherLink\""
-	depends on ISA && ISA_DMA_API
+	depends on ISA && ISA_DMA_API && !PPC32
 	---help---
 	  If you have a 3Com ISA EtherLink XL "Corkscrew" 3c515 Fast Ethernet
 	  network card, say Y here.
--- a/drivers/net/ethernet/amd/Kconfig
+++ b/drivers/net/ethernet/amd/Kconfig
@@ -44,7 +44,7 @@ config AMD8111_ETH
 
 config LANCE
 	tristate "AMD LANCE and PCnet (AT1500 and NE2100) support"
-	depends on ISA && ISA_DMA_API && !ARM
+	depends on ISA && ISA_DMA_API && !ARM && !PPC32
 	---help---
 	  If you have a network (Ethernet) card of this type, say Y here.
 	  Some LinkSys cards are of this type.
@@ -138,7 +138,7 @@ config PCMCIA_NMCLAN
 
 config NI65
 	tristate "NI6510 support"
-	depends on ISA && ISA_DMA_API && !ARM
+	depends on ISA && ISA_DMA_API && !ARM && !PPC32
 	---help---
 	  If you have a network (Ethernet) card of this type, say Y here.
 
--- a/drivers/net/ethernet/cirrus/Kconfig
+++ b/drivers/net/ethernet/cirrus/Kconfig
@@ -19,6 +19,7 @@ if NET_VENDOR_CIRRUS
 config CS89x0
 	tristate "CS89x0 support"
 	depends on ISA || EISA || ARM
+	depends on !PPC32
 	---help---
 	  Support for CS89x0 chipset based Ethernet cards. If you have a
 	  network (Ethernet) card of this type, say Y and read the file


