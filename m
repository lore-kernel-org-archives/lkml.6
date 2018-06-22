Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81298C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E92723FC9
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E92723FC9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754204AbeFVJxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:53:04 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60778 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751307AbeFVJxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:53:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 566A51596;
        Fri, 22 Jun 2018 02:53:02 -0700 (PDT)
Received: from approximate.cambridge.arm.com (approximate.cambridge.arm.com [10.1.206.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 230AE3F819;
        Fri, 22 Jun 2018 02:53:00 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 0/7]  irqchip: v4.18-rc1 fixes
Date:   Fri, 22 Jun 2018 10:52:47 +0100
Message-Id: <20180622095254.5906-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's a handful of patches I've accumulated over the merge
window. The only interesting thing is the issue that Yang found on a
bizarrely configured NUMA system, which prompted me to add more code
to detect similar situations (just in case). The rest is pretty dull.

Thanks,

	M.

* From v1:
  - Much better fix for the ls-scfg driver (thanks to Thomas)
  - New patch fixing a CPU hotplug regression on GICv3

Marc Zyngier (6):
  genirq/debugfs: Add missing IRQCHIP_SUPPORTS_LEVEL_MSI debug
  irqchip/ls-scfg-msi: Fix MSI affinity handling
  irqchip/gic-v2m: Fix SPI release on error path
  irqchip/gic-v3-its: Only emit SYNC if targetting a valid collection
  irqchip/gic-v3-its: Only emit VSYNC if targetting a valid collection
  irqchip/gic-v3-its: Fix reprogramming of redistributors on CPU hotplug

Yang Yingliang (1):
  irqchip/gic-v3-its: Don't bind LPI to unavailable NUMA node

 drivers/irqchip/irq-gic-v2m.c     |  2 +-
 drivers/irqchip/irq-gic-v3-its.c  | 62 +++++++++++++++++++++++++------
 drivers/irqchip/irq-ls-scfg-msi.c | 10 +++--
 include/linux/irq.h               |  1 +
 kernel/irq/debugfs.c              |  1 +
 5 files changed, 60 insertions(+), 16 deletions(-)

-- 
2.17.1

