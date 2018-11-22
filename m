Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A33C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1C120684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:11:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1C120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394528AbeKVVus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:50:48 -0500
Received: from mga03.intel.com ([134.134.136.65]:39305 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387933AbeKVVus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:50:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2018 03:11:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,265,1539673200"; 
   d="scan'208";a="91290765"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by orsmga007.jf.intel.com with ESMTP; 22 Nov 2018 03:11:51 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next v2 0/7] mei: Add DMA ring
Date:   Thu, 22 Nov 2018 13:11:35 +0200
Message-Id: <20181122111142.18653-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resend of the second part for the mei dma ring,
that was left out.

This series adds an alternative method for
transferring data between the mei driver and the device
via a DMA ring. The DMA ring allows transferring
data in bigger chunks, up to 128K, than the HW ring 512B.
The actual sizes depend on particular MEI generations.
The HW ring is faster for packets that fits
into the HW ring while a packet that would require
fragmentation is faster to send via the DMA ring.

V2: 1. Use single license for the new dma-ring.c file.
    2. Adjust kdoc to new requirements:
	https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html

Alexander Usyskin (2):
  mei: bump hbm version to 2.1
  mei: me: mark CNP devices as having dma support

Tomas Winkler (5):
  mei: dma ring buffers allocation
  mei: hbm: setup dma ring
  mei: hw: add dma ring control block
  mei: dma ring: implement rx circular buffer logic
  mei: dma ring: implement transmit flow

 drivers/misc/mei/Makefile    |   1 +
 drivers/misc/mei/client.c    |  66 +++++++--
 drivers/misc/mei/dma-ring.c  | 269 +++++++++++++++++++++++++++++++++++
 drivers/misc/mei/hbm.c       |  88 +++++++++++-
 drivers/misc/mei/hbm.h       |   2 +
 drivers/misc/mei/hw-me.c     |   6 +
 drivers/misc/mei/hw.h        |  29 +++-
 drivers/misc/mei/init.c      |   2 +-
 drivers/misc/mei/interrupt.c |  41 ++++--
 drivers/misc/mei/mei_dev.h   |  26 +++-
 drivers/misc/mei/pci-me.c    |   4 +-
 11 files changed, 500 insertions(+), 34 deletions(-)
 create mode 100644 drivers/misc/mei/dma-ring.c

-- 
2.17.2

