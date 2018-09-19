Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82622C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D863020645
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D863020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731312AbeISPH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 11:07:56 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43242 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730897AbeISPHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 11:07:17 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5253E20795; Wed, 19 Sep 2018 11:30:13 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 236F8208EB;
        Wed, 19 Sep 2018 11:30:03 +0200 (CEST)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: [PATCH net-next 00/12] net: mvpp2: improve the interrupt usage
Date:   Wed, 19 Sep 2018 11:26:59 +0200
Message-Id: <20180919092711.22296-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series aims to improve the interrupts descriptions and usage in the
Marvell PPv2 driver.

- Before the series interrupts were named after their s/w usage,
  which in fact can be configured. The series rename all those
  interrupts and add a description of the ones left over.

- In PPv2 the interrupts are mapped to vectors. Those vectors were
  directly mapped to a given CPU, and per-cpu accesses were done. While
  this worked on our cases, the registers accesses mapped to the vectors
  are not actually linked to a given CPU. They instead are linked to
  what is called a "s/w thread". The series modify this so that the s/w
  threads are used instead of the CPU numbers, by adding an indirection.
  This means we now can have systems with more CPUs than s/w threads.

This is based on today's net-next, and was tested on various boards
using both versions of the PPv2 engine.

Two more patches will be coming, to update the device trees describing a
PPv2 engine. The patches are ready, but will go through a different
tree. I'll send them once this series will be accepted. This is not an
issue as the PPv2 driver keeps the dt bindings backward compatibility.

Thanks!
Antoine

Antoine Tenart (12):
  net: mvpp2: increase the number of s/w threads to 9
  net: mvpp2: rename the IRQs to match the hardware
  Documentation/bindings: net: marvell-pp2: update the IRQs description
  net: mvpp2: do not update the queue mode while probing
  net: mvpp2: fix the number of queues per cpu for PPv2.2
  net: mvpp2: cpu should always be unsigned
  net: mvpp2: make the per-cpu helpers static
  net: mvpp2: make mvpp2_read_relaxed static
  net: mvpp2: do not use the CPU number to access the per-thread
    registers
  net: mvpp2: map the CPUs to threads
  net: mvpp2: handle cases where more CPUs are available than s/w
    threads
  net: mvpp2: rename mvpp2_percpu function to mvpp2_thread

 .../devicetree/bindings/net/marvell-pp2.txt   |  45 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |  27 +-
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 431 +++++++++++-------
 3 files changed, 315 insertions(+), 188 deletions(-)

-- 
2.17.1

