Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C77C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC6A2086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC6A2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731097AbeKGJhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 04:37:54 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:56626 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731021AbeKGJhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 04:37:54 -0500
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23991112AbeKGAIQRanZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 01:08:16 +0100
Date:   Wed, 7 Nov 2018 00:08:16 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
cc:     Christoph Hellwig <hch@lst.de>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] MIPS: SiByte: Handle PCI DMA with 64-bit memory
 addressing
Message-ID: <alpine.LFD.2.21.1811050350070.20378@eddie.linux-mips.org>
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

 Thanks to Christoph for making this change so easy with his recent work!

 Please apply.

  Maciej
