Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1748C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC3F2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC3F2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbeIGWXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:23:25 -0400
Received: from foss.arm.com ([217.140.101.70]:35184 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727708AbeIGWXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:23:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBB5818A;
        Fri,  7 Sep 2018 10:41:25 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BBE673F5BC;
        Fri,  7 Sep 2018 10:41:25 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id ECEBA1AE37BD; Fri,  7 Sep 2018 18:41:40 +0100 (BST)
Date:   Fri, 7 Sep 2018 18:41:40 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     yuanzhichang@hisilicon.com, dann.frazier@canonical.com,
        gabriele.paoloni@huawei.com, arnd@arndb.de, bhelgaas@google.com,
        andy.shevchenko@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
        jean-philippe.brucker@arm.com
Subject: [REGRESSION] Commit 5745392e0c2b ("PCI: Apply the new generic I/O
 management on PCI IO hosts") breaks PCI for legacy virtio devices with
 kvmtool on arm64
Message-ID: <20180907174140.GI12788@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm seeing a regression in Linux guests since 4.17 under kvmtool, where
legacy virtio devices using the PCI transport fail to probe. Legacy virtio
PCI devices must be accessed via "I/O space" (e.g. BAR0, which is
IORESOURCE_IO) and kvmtool assigns this to the guest physical range
0x0 - 0x10000.

On arm64, when the virtio legacy PCI driver calls pci_iomap() for this BAR,
it expands to ioport_map():

  static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
  {
  	return PCI_IOBASE + (port & MMIO_UPPER_LIMIT);
  }

Since the indirect PIO changes, MMIO_UPPER_LIMIT is defined as:

  /*
   * We reserve 0x4000 bytes for Indirect IO as so far this library is only
   * used by the HiSilicon LPC Host. If needed, we can reserve a wider IO
   * area by redefining the macro below.
   */
  #define PIO_INDIRECT_SIZE 0x4000
  #define MMIO_UPPER_LIMIT (IO_SPACE_LIMIT - PIO_INDIRECT_SIZE)

which corrupts the BAR address. For example, kvmtool has the BAR pointing
at 0x6200 on my system, but pci_iomap() actually maps offset 0x2200.
Changing PIO_INDIRECT_SIZE to 0 gets things working again.

Since this stuff doesn't revert nicely, I'm not sure how to proceed. Any
thoughts? Generally, having a per-platform magic constant hardcoded in
the PCI mapping code makes me feel slightly ill...

Cheers,

Will
