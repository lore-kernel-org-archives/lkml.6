Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4027C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A472082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A472082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbeKCAH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:07:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbeKCAH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:07:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 09E813083394;
        Fri,  2 Nov 2018 15:00:34 +0000 (UTC)
Received: from localhost (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 27F8D5D76A;
        Fri,  2 Nov 2018 15:00:32 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 0/4] irq: fix support for allocating sets of IRQs
Date:   Fri,  2 Nov 2018 22:59:47 +0800
Message-Id: <20181102145951.31979-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 02 Nov 2018 15:00:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

As I mentioned, there are at least two issues in the patch of '
irq: add support for allocating (and affinitizing) sets of IRQs':

1) it is wrong to pass 'mask + usedvec' to irq_build_affinity_masks()

2) we should spread all possible CPUs in 2-stage way on each set of IRQs

The fix isn't trivial, and I introduce two extra patches as preparation,
then the implementation can be more clean.

The patchset is against mq-maps branch of block tree, feel free to
integrate into the whole patchset of multiple queue maps.

Thanks,
Ming


Jens Axboe (1):
  irq: add support for allocating (and affinitizing) sets of IRQs

Ming Lei (3):
  Revert "irq: add support for allocating (and affinitizing) sets of
    IRQs"
  irq: move 2-stage irq spread into one helper
  irq: pass first vector to __irq_build_affinity_masks

 kernel/irq/affinity.c | 119 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 75 insertions(+), 44 deletions(-)

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Sagi Grimberg <sagi@grimberg.me>

-- 
2.9.5

