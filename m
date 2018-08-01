Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8FBC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F2720862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F2720862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732915AbeHAUAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:00:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49806 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405669AbeHATIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:34 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B979C10A0;
        Wed,  1 Aug 2018 17:02:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 183/336] IB: Fix RDMA_RXE and INFINIBAND_RDMAVT dependencies for DMA_VIRT_OPS
Date:   Wed,  1 Aug 2018 18:48:38 +0200
Message-Id: <20180801165036.101717088@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben@decadent.org.uk>

[ Upstream commit e02637e97d68a54b1527bc654bf8377eda310226 ]

DMA_VIRT_OPS requires that dma_addr_t is at least as wide as a
pointer, which is expressed as a dependency on !64BIT ||
ARCH_DMA_ADDR_T_64BIT.

For parisc64 this is not true, and if these IB modules are enabled,
kconfig warns:

WARNING: unmet direct dependencies detected for DMA_VIRT_OPS
  Depends on [n]: HAS_DMA [=y] && (!64BIT [=y] || ARCH_DMA_ADDR_T_64BIT)
  Selected by [m]:
  - INFINIBAND_RDMAVT [=m] && INFINIBAND [=m] && 64BIT [=y] && PCI [=y]
  - RDMA_RXE [=m] && INET [=y] && PCI [=y] && INFINIBAND [=m]

Add dependencies to fix this.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/sw/rdmavt/Kconfig |    2 +-
 drivers/infiniband/sw/rxe/Kconfig    |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/sw/rdmavt/Kconfig
+++ b/drivers/infiniband/sw/rdmavt/Kconfig
@@ -1,6 +1,6 @@
 config INFINIBAND_RDMAVT
 	tristate "RDMA verbs transport library"
-	depends on 64BIT
+	depends on 64BIT && ARCH_DMA_ADDR_T_64BIT
 	depends on PCI
 	select DMA_VIRT_OPS
 	---help---
--- a/drivers/infiniband/sw/rxe/Kconfig
+++ b/drivers/infiniband/sw/rxe/Kconfig
@@ -1,6 +1,7 @@
 config RDMA_RXE
 	tristate "Software RDMA over Ethernet (RoCE) driver"
 	depends on INET && PCI && INFINIBAND
+	depends on !64BIT || ARCH_DMA_ADDR_T_64BIT
 	select NET_UDP_TUNNEL
 	select CRYPTO_CRC32
 	select DMA_VIRT_OPS


