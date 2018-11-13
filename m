Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AE9C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BFB922360
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BFB922360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731401AbeKNIoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 03:44:21 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:38758 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeKNIoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 03:44:21 -0500
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23993030AbeKMWmRWRA0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:42:17 +0100
Date:   Tue, 13 Nov 2018 22:42:17 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
cc:     Christoph Hellwig <hch@lst.de>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] MIPS: SiByte: Handle PCI DMA with 64-bit memory
 addressing
Message-ID: <alpine.LFD.2.21.1811131653160.9637@eddie.linux-mips.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 This mini patch series enables correct support for DMA in the presence of 
memory outside the 32-bit address range with the Broadcom SiByte SOCs and 
the relevant development boards.

 There is a quirk in the BCM1250, BCM1125 and BCM1125H SOCs in that their 
onchip 32-bit PCI host bridge does not support DAC, however the HT link 
(where available) does support 40-bit addressing as per the HT spec.  
Therefore the first patch sets the bus mask accordingly, and then the 
second patch enables swiotlb.  See individual change descriptions for 
additional details; there's also a further discussion alongside.

 This has been verified with a Broadcom SWARM board equipped with 3200MiB 
of RAM (2176MiB of which the address decoder in the SOC maps above 4GiB), 
a pair of DEFPA FDDI adapters and an XHCI USB adapter.  There were also 
some other PCI and PCIe devices present in the system, though not actively 
used beyond being probed at boot, and none has shown any symptoms of 
breakage.

 I have come across commit 9d7a224b463e ("dma-direct: always allow dma 
mask <= physiscal memory size") and realised we do need ZONE_DMA32 for 
LittleSur.  Hence this v3, adding a third (second in the series) change 
for LittleSur.

 Also hopefully I'll have sorted out issues with threading in my MUA with 
this series update.

 Please apply.

  Maciej

