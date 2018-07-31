Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C14EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1813D208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1813D208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbeGaIQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:16:05 -0400
Received: from mga09.intel.com ([134.134.136.24]:59929 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbeGaIQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:16:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 23:37:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,426,1526367600"; 
   d="scan'208";a="61154154"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by orsmga008.jf.intel.com with ESMTP; 30 Jul 2018 23:37:19 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 00/12] mei: Add DMA ring
Date:   Tue, 31 Jul 2018 09:35:32 +0300
Message-Id: <20180731063544.25540-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds an alternative method for
transferring data between the mei driver and the device
via a DMA ring. The DMA ring allows transferring
data in bigger chunks, up to 128K, than the HW ring 512B.
The actual sizes depend on particular MEI generations.
The HW ring is faster for packets that fits
into the HW ring while a packet that would require
fragmentation is faster to send via the DMA ring.

Alexander Usyskin (3):
  mei: define dma ring buffer sizes for PCH12 HW and newer
  mei: bump hbm version to 2.1
  mei: me: mark CNP devices as having dma support

Tomas Winkler (9):
  mei: add support for variable length mei headers.
  mei: hbm: define dma ring setup protocol
  mei: hbm: introduce dma bit in the message header
  mei: restrict dma ring support to hbm version 2.1
  mei: dma ring buffers allocation
  mei: hbm: setup dma ring
  mei: hw: add dma ring control block
  mei: dma ring: implement rx circular buffer logic
  mei: dma ring: implement transmit flow

 drivers/misc/mei/Makefile    |   1 +
 drivers/misc/mei/client.c    |  84 +++++++++----
 drivers/misc/mei/debugfs.c   |   2 +
 drivers/misc/mei/dma-ring.c  | 278 +++++++++++++++++++++++++++++++++++++++++++
 drivers/misc/mei/hbm.c       | 126 ++++++++++++++++++--
 drivers/misc/mei/hbm.h       |   2 +
 drivers/misc/mei/hw-me.c     |  53 ++++++---
 drivers/misc/mei/hw-me.h     |   4 +
 drivers/misc/mei/hw-txe.c    |  42 +++----
 drivers/misc/mei/hw.h        |  98 ++++++++++++++-
 drivers/misc/mei/init.c      |   2 +-
 drivers/misc/mei/interrupt.c |  45 ++++---
 drivers/misc/mei/mei_dev.h   |  57 +++++++--
 drivers/misc/mei/pci-me.c    |   4 +-
 14 files changed, 700 insertions(+), 98 deletions(-)
 create mode 100644 drivers/misc/mei/dma-ring.c

-- 
2.14.4

