Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA565C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B3921738
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbfAITXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:23:22 -0500
Received: from ale.deltatee.com ([207.54.116.67]:59702 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728450AbfAITWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:22:48 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ghJR2-00053o-GE; Wed, 09 Jan 2019 12:22:47 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ghJR1-0001Vc-11; Wed, 09 Jan 2019 12:22:39 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        Jon Mason <jdmason@kudzu.us>
Cc:     Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed,  9 Jan 2019 12:22:25 -0700
Message-Id: <20190109192233.5752-1-logang@deltatee.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, fancer.lancer@gmail.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v3 0/8]  Fix breakage caused by the NTB multi-port patchset
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

I'm resending this because I've recently found out that the change we
made to use the NTB struct device in DMA allocations is wrong and
needs to be reverted. Turns out that, when running with an IOMMU,
dma_alloc_coherent() will always fail if you pass it the NTB struct
device. This is because the device has not been assigned an IOMMU
group and the Intel IOMMU at least expect the devices to be on the PCI
bus and be able to find a proper bus-dev-fn number through a struct
pci device. Therefore, we must revert the change and I've changed
patch 2 to do this and remove the no longer necessary DMA mask
adjustments.

I'm not sure if we can get past the impass in getting this series merged:
I still maintain every patch in this series is necessary to fix a
regression and there's no way to add port numbers to switchtec in the
crosslink configuration so it can't be fixed in the other way that was
suggested.

Logan

--

Changes since v2:
- Rebased on v5.0-rc1
- Modify Patch 2 to revert back to using the PCI struct device
  instead of the NTB struct device in DMA calls
- Collected Allen's Acks
- Collected Alexander's Tested-By

Changes since v1:
- Rebased onto ntb-next (there was a minor conflict in a recent change
  to the intel driver)
- Collected Dave's Ack

--

Logan Gunthorpe (8):
  NTB: ntb_tool: reading the link file should not end in a NULL byte
  NTB: Revert the change to use the NTB device dev for DMA allocations
  NTB: Fix the default port and peer numbers for legacy drivers
  NTB: ntb_pingpong: Choose doorbells based on port number
  NTB: perf: Don't require one more memory window than number of peers
  NTB: perf: Fix support for hardware that doesn't have port numbers
  NTB: perf: Fix race condition when run with ntb_test
  NTB: ntb_test: Fix bug when counting remote files

 drivers/ntb/hw/amd/ntb_hw_amd.c         |  4 ----
 drivers/ntb/hw/idt/ntb_hw_idt.c         |  6 -----
 drivers/ntb/hw/intel/ntb_hw_gen1.c      |  4 ----
 drivers/ntb/ntb.c                       |  9 ++------
 drivers/ntb/test/ntb_perf.c             | 29 +++++++++++++++++++------
 drivers/ntb/test/ntb_pingpong.c         | 14 +++++-------
 drivers/ntb/test/ntb_tool.c             |  9 ++++----
 tools/testing/selftests/ntb/ntb_test.sh |  2 +-
 8 files changed, 35 insertions(+), 42 deletions(-)

--
2.19.0
