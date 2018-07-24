Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48632ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F307420852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="SrRJK4Cz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F307420852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388382AbeGXLQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 07:16:19 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:40123 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388251AbeGXLQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 07:16:19 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id F23F210C0721;
        Tue, 24 Jul 2018 03:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1532427036; bh=vzvuSMnHdTN2sQ60h+iWe+yw6d1UHKYEcrWy/R0i4xI=;
        h=From:To:Cc:Subject:Date:From;
        b=SrRJK4CzEK4nVrl7s6hu9KQfLMUoFW5gQJZ36vLSDebwTpe3AB/6eEQeXY0Sjt7vf
         CJNLfl0yyJMnR7edn5NR9aGY5M1PNu8xO0z9RYa2tuY+TKgy6iPnBstwZY1OSPp4YF
         WxujXfi2vDthcls8Jj96GrdWX+xpniWf7nzuRGn8QhC4kodOc5MuyE7YnOU5HuGaXw
         27iVktl0r86hpbsI41mLNc/hXlsBHuyxxhX9RGB6hDdzflL1DJVIj+l7Da3sPlpCVj
         1cJRUWQ/5NEp1cvJjJ8W8GnpyTXet63tk/R1yhINNFQ3Zao9A4TqOM4Yo4Ady3YTOF
         VyJuEKXeww+pQ==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.86])
        by mailhost.synopsys.com (Postfix) with ESMTP id D73773319;
        Tue, 24 Jul 2018 03:10:33 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>, hch@lst.de,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 0/4] ARC: allow to use IOC and non-IOC DMA devices simultaneously
Date:   Tue, 24 Jul 2018 13:09:57 +0300
Message-Id: <20180724101001.31965-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARC HS processor provides an IOC port (I/O coherency bus
interface) that allows external devices such as DMA devices
to access memory through the cache hierarchy, providing
coherency between I/O transactions and the complete memory
hierarchy.

Some recent SoC with ARC HS (like HSDK) allow to select bus
port (IOC or non-IOC port) for connecting DMA devices in runtime.

With this patch we can use both HW-coherent and regular DMA
peripherals simultaneously.

NOTE:
This patch series was stress tested on HSDK with iperf3 (ethernet)
and bonie++ (usb and sdio).

NOTE:
If you want to test some device without IOC it is not enough
to remove "dma-coherent" property from dts. You had to remap this
device to regular DDR AXI port intead of IOC AXI port.
You also need to take into account that all DMA devices on ARC will
not work without IOC after commit:
a8eb92d02dd7 - arc: fix arc_dma_{map,unmap}_page <Christoph Hellwig>
(I will create fix soon, see STAR 9001374807)

NOTE:
We don't touch any aperture configuration in this patch series. So we
don't switch any devices between IOC and non-IOC AXI ports on any board.
It can be done later if it is required.

Eugeniy Paltsev (4):
  ARC: DTS: mark DMA devices connected through IOC port as dma-coherent
  ARC: allow to use IOC and non-IOC DMA devices simultaneously
  ARC: refactor arch/arc/mm/dma.c
  ARC: IOC: panic if both IOC and ZONE_HIGHMEM enabled

 arch/arc/Kconfig                   |  1 +
 arch/arc/boot/dts/axc003.dtsi      | 26 +++++++++++++++++
 arch/arc/boot/dts/axc003_idu.dtsi  | 26 +++++++++++++++++
 arch/arc/boot/dts/hsdk.dts         |  4 +++
 arch/arc/include/asm/dma-mapping.h | 13 +++++++++
 arch/arc/mm/cache.c                | 30 ++++++++++----------
 arch/arc/mm/dma.c                  | 58 ++++++++++++++++++--------------------
 7 files changed, 112 insertions(+), 46 deletions(-)
 create mode 100644 arch/arc/include/asm/dma-mapping.h

-- 
2.14.4

