Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A002FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18F020870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="AZvceG92"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F18F020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731797AbeG3SC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:02:26 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:43636 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeG3SC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:02:26 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id C320A24E071D;
        Mon, 30 Jul 2018 09:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1532968002; bh=/+xzHONe1WwpXfZ4Cc8MXPVK+iiK/GUO+4yIHyB1Cw4=;
        h=From:To:Cc:Subject:Date:From;
        b=AZvceG92pphJI9GeyGyuLKHNd/14FG9ys/KeH1Us0K/E6M8TaRYKgHxc0DOm6U6DZ
         nQTwCtIRpHEspFmj/Cq/sEA2XFZuDAIa/2S7zMAOMcgPsAqpuLKwRa85bq29yHUyKz
         BzWOg3ajFp3zHVUm/LEVqNrdbZAaH8eq8nXx9v5CVi0tUHT4Gm7YpwoMClE8V4sFUO
         MCnaPn3rAW8QAoBADMUNClH+5oJP67wroN+cS1s7gzbA5F6ptwtXkqJFed6mqS0Tpl
         G2RKrL4uksm0bkmjyXW0zOeIl6FL8vgeBlFq+K47wEuy/f/aRXDzFy0alrc1uY9XRB
         f6K6frILKKQxA==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.86])
        by mailhost.synopsys.com (Postfix) with ESMTP id 059E33F3C;
        Mon, 30 Jul 2018 09:26:39 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>, hch@lst.de,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v2 0/4] ARC: allow to use IOC and non-IOC DMA devices simultaneously
Date:   Mon, 30 Jul 2018 19:26:32 +0300
Message-Id: <20180730162636.3556-1-Eugeniy.Paltsev@synopsys.com>
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
and bonie++ (usb and sdio) in three configurations:
 * IOC enabled globaly
 * IOC disabled globaly
 * IOC enabled partially (USB & SDIO are connected via IOC AXI port,
   ethernet is connected to DDR AXI port (non-IOC port) 

NOTE:
If you want to test some device without IOC it is not enough
to remove "dma-coherent" property from dts. You had to remap this
device to regular DDR AXI port intead of IOC AXI port.
You also need to apply 3 following patches firstly:
https://www.mail-archive.com/linux-snps-arc@lists.infradead.org/msg03865.html
https://www.mail-archive.com/linux-snps-arc@lists.infradead.org/msg03889.html
https://www.mail-archive.com/linux-snps-arc@lists.infradead.org/msg03887.html

NOTE:
We don't touch any aperture configuration in this patch series. So we
don't switch any devices between IOC and non-IOC AXI ports on any board.
It can be done later if it is required.

Changes v1->v2 (Thanks to Christoph):
 * Don't select DMA_DIRECT_OPS explicitly as it is already selected by
   DMA_NONCOHERENT_OPS
 * Remove check for HIGHMEM pages from arch_dma_{alloc, free}

Eugeniy Paltsev (4):
  ARC: DTS: mark DMA devices connected through IOC port as dma-coherent
  ARC: allow to use IOC and non-IOC DMA devices simultaneously
  ARC: IOC: panic if both IOC and ZONE_HIGHMEM enabled
  ARC: don't check for HIGHMEM pages in arch_dma_alloc

 arch/arc/boot/dts/axc003.dtsi      | 26 ++++++++++++++++
 arch/arc/boot/dts/axc003_idu.dtsi  | 26 ++++++++++++++++
 arch/arc/boot/dts/hsdk.dts         |  4 +++
 arch/arc/include/asm/dma-mapping.h | 13 ++++++++
 arch/arc/mm/cache.c                | 30 +++++++++---------
 arch/arc/mm/dma.c                  | 62 +++++++++++++++++++-------------------
 6 files changed, 115 insertions(+), 46 deletions(-)
 create mode 100644 arch/arc/include/asm/dma-mapping.h

-- 
2.14.4

