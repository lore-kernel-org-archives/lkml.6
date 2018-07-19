Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07ED5ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1D120684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB1D120684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbeGSOOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:14:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:54206 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731829AbeGSON4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:13:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 35816AF48;
        Thu, 19 Jul 2018 13:30:44 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>
Cc:     James Smart <james.smart@broadcom.com>,
        Hannes Reinecke <hare@suse.de>, Ewan Milne <emilne@redhat.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 0/4] Rework NVMe abort handling
Date:   Thu, 19 Jul 2018 15:28:34 +0200
Message-Id: <20180719132838.15556-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCI currently is the only transport we have which is doing more than
queueing a transport reset but trying to abort the command first.

This series brings the other transports we currently have up to the
same level.

On FC we can prepend a third escalation level by first to abort the FC
operation before trying to abort the NVMe command.

Johannes Thumshirn (4):
  nvme: factor out pci abort handling into core
  nvme: rdma: abort commands before resetting controller
  nvmet: loop: abort commands before resetting controller
  nvme: fc: abort commands before resetting controller

 drivers/nvme/host/core.c   | 47 +++++++++++++++++++++++++++++++++++
 drivers/nvme/host/fc.c     |  9 +++++++
 drivers/nvme/host/nvme.h   |  1 +
 drivers/nvme/host/pci.c    | 61 +++++++++-------------------------------------
 drivers/nvme/host/rdma.c   | 22 ++++++++++++++---
 drivers/nvme/target/loop.c | 17 ++++++++++++-
 6 files changed, 104 insertions(+), 53 deletions(-)

-- 
2.16.4

