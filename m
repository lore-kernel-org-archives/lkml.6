Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EAFECE567
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32FA620C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32FA620C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbeIRPpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 11:45:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36902 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbeIRPpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 11:45:14 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4D189300272B;
        Tue, 18 Sep 2018 10:13:21 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB8C6107304F;
        Tue, 18 Sep 2018 10:13:17 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Tejun Heo <tj@kernel.org>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>
Subject: [PATCH 0/3] blk-mq: allow to unfreeze queue when io isn't drained
Date:   Tue, 18 Sep 2018 18:13:07 +0800
Message-Id: <20180918101310.13154-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 18 Sep 2018 10:13:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The 1st patch introduces percpu_ref_resurge() for implementing
blk_mq_unfreeze_queue_no_drain_io().

The 2nd patch introdces blk_mq_unfreeze_queue_no_drain_io() for
cases in which queue can be unfreeze without draininig IO.

The 3rd patch applies blk_mq_unfreeze_queue_no_drain_io() to
NVMe PCI timeout, so that IO hang may be avoided inside
nvme_reset_work() when new IO timeout is triggered. 

Part of idea is from Jianchao's early work:

https://marc.info/?l=linux-kernel&m=153612052611020&w=2

Ming Lei (3):
  lib/percpu-refcount: introduce percpu_ref_resurge()
  blk-mq: introduce blk_mq_unfreeze_queue_no_drain_io
  nvme: don't drain IO in nvme_reset_work()

 block/blk-mq.c                  | 25 ++++++++++++++--
 drivers/nvme/host/core.c        | 12 +++++---
 drivers/nvme/host/nvme.h        |  2 +-
 drivers/nvme/host/pci.c         |  3 +-
 include/linux/blk-mq.h          |  1 +
 include/linux/percpu-refcount.h |  1 +
 lib/percpu-refcount.c           | 63 ++++++++++++++++++++++++++++++++++-------
 7 files changed, 87 insertions(+), 20 deletions(-)

Cc: Tejun Heo <tj@kernel.org>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
Cc: Keith Busch <keith.busch@intel.com>


-- 
2.9.5

