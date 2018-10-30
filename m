Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36560C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF892081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="t620DQK7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF892081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbeJaD1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 23:27:32 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54657 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbeJaD1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 23:27:32 -0400
Received: by mail-it1-f194.google.com with SMTP id d6so9362350itl.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 11:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=68IQswqg/GKbVxYhTOX8sXE5FH1dVSvGl2490piw0is=;
        b=t620DQK7Jv+BudP12h+6EVJaZb0nmC/ClKHO/CSh94z17jC0GaeSpIxwtReacqzE0+
         FUDNUUhty9NDu/qh0KWzGAhFecc/fAZpOzU7HNZsP4kW+j4fFKYWHI+zaRiTBCicxqxm
         EAXUW4iOqCq0WmJ+sjRV+F45b+PAooCSNlrQVEU3mTQq80FrLp4VeYzwTFcKsKXTAxuk
         yMDN8OUJdSxYHtog55eC/kZ+LKgs7N6yPPARs3MCOxSXgfvM+6AnsJ9meYbJJtFfxfOP
         HZS1XQW7JDvbhwonAjnAsHMEzEMqglGM9C5Uj81y6fZYJAE5e4czb74/V0vJn4P7VoBY
         jHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=68IQswqg/GKbVxYhTOX8sXE5FH1dVSvGl2490piw0is=;
        b=laC7rcv1xiQ47Hfgju7ZZd/8EoMc1OSn1huofJCiXc0VncjaoZxG+hyYeUDajk3BfL
         TB76xN/7SyyHHNkvaWYGuPKmfe3gCqLrG4X7l987dy2UfBVtbQLhX1GAr7hLRDpte7en
         KBuaWVwNKykzVWV9+cI7RSN9giq+ct6IN9rbBhCe1T62tqQ5KxnMbegBlhmHIl9A0tsR
         gTMuUvkb4z6/Q6MYTK4N/vaLoKd89NXwWrL9pS2h4U5G/SG67PfaWlHyHoVO58c4MX+x
         eCElIuGMsx9pJFwv1G9xJviEtKSn3LvIWrP4qzMcgrKZq9NFqWI1iKfARj2nfE10LjBx
         NQQQ==
X-Gm-Message-State: AGRZ1gLN+AG7TzFHHufqFqNzBEBkJh9yDR/9v7zTvYez5QosD1ktJRHD
        g/pv64UnHxwwHqK62LtWQa2zTg==
X-Google-Smtp-Source: AJdET5eEv83OfXrfUzdhM3jdXfJIXwkNmmEB+ZJ696/+qibuFzUcE0I87+R8PONuWTdhxDemOV/pCg==
X-Received: by 2002:a02:a98e:: with SMTP id q14-v6mr13599010jam.109.1540924375945;
        Tue, 30 Oct 2018 11:32:55 -0700 (PDT)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o20-v6sm4895739itc.34.2018.10.30.11.32.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 11:32:54 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCHSET v3 0/16] blk-mq: Add support for multiple queue maps
Date:   Tue, 30 Oct 2018 12:32:36 -0600
Message-Id: <20181030183252.17857-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for multiple queue maps for blk-mq.
Since blk-mq was introduced, it's only support a single queue
map. This means you can have 1 set of queues, and the mapping
purely depends on what CPU an IO originated from. With this
patch set, drivers can implement mappings that depend on both
CPU and request type - and they can have multiple sets of mappings.

NVMe is used as a proof of concept. It adds support for a separate
write queue set. One way to use this would be to limit the number
of write queues to favor reads, since NVMe does round-robin service
of queues. An easy extension of this would be to add multiple
sets of queues, for prioritized IO.

NVMe also uses this feature to finally make the polling work
efficiently, without triggering interrupts. This both increases
performance (and decreases latency), at a lower system load. At
the same time it's more flexible, as you don't have to worry about
IRQ coalescing and redirection to avoid interrupts disturbing the
workload. This is how polling should have worked from day 1.

This is on top of my mq-conversions branch. It can also be bound
in my mq-maps branch.

Changes since v2:

- Address review comments (mostly code comments)
- Add rq->mq_hctx cache
- Cleanup/improve blk_mq_sched_insert_requests()
- Harden the IRQ affinity sets feature
- Fix assignment of hardware queue type if already mapped
- Improve plug sorting for multiple maps

Changes since v1:

- Ensure irq_calc_affinity_vectors() doesn't return more than 'maxvec'
- Rebase on top of current mq-conversions series


 block/blk-flush.c                     |  11 +-
 block/blk-mq-cpumap.c                 |  19 +--
 block/blk-mq-debugfs.c                |   2 +-
 block/blk-mq-pci.c                    |  10 +-
 block/blk-mq-rdma.c                   |   4 +-
 block/blk-mq-sched.c                  |  12 +-
 block/blk-mq-sched.h                  |   2 +-
 block/blk-mq-sysfs.c                  |  10 ++
 block/blk-mq-tag.c                    |  12 +-
 block/blk-mq-virtio.c                 |   8 +-
 block/blk-mq.c                        | 237 +++++++++++++++++++-----------
 block/blk-mq.h                        |  45 ++++--
 block/blk.h                           |   6 +-
 block/kyber-iosched.c                 |   6 +-
 drivers/block/virtio_blk.c            |   2 +-
 drivers/nvme/host/pci.c               | 263 ++++++++++++++++++++++++++++++----
 drivers/pci/msi.c                     |  14 ++
 drivers/scsi/qla2xxx/qla_os.c         |   5 +-
 drivers/scsi/scsi_lib.c               |   2 +-
 drivers/scsi/smartpqi/smartpqi_init.c |   3 +-
 drivers/scsi/virtio_scsi.c            |   3 +-
 fs/block_dev.c                        |   2 +
 fs/direct-io.c                        |   2 +
 fs/iomap.c                            |   9 +-
 include/linux/blk-mq-pci.h            |   4 +-
 include/linux/blk-mq-virtio.h         |   4 +-
 include/linux/blk-mq.h                |  33 ++++-
 include/linux/blk_types.h             |   4 +-
 include/linux/blkdev.h                |   3 +-
 include/linux/interrupt.h             |   4 +
 kernel/irq/affinity.c                 |  40 ++++--
 31 files changed, 582 insertions(+), 199 deletions(-)

-- 
Jens Axboe


