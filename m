Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E48ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061F62077B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 061F62077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731171AbeGQWRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 18:17:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:41011 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730249AbeGQWRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 18:17:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2018 14:42:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,367,1526367600"; 
   d="scan'208";a="58456013"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.117.43])
  by orsmga006.jf.intel.com with ESMTP; 17 Jul 2018 14:42:28 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <keith.busch@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Logan Gunthorpe <logang@deltatree.com>,
        Stephen Bates <sbates@raithlin.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [RFC 0/3] PCI: Granular hotplug memory/io reservation
Date:   Tue, 17 Jul 2018 15:39:44 -0600
Message-Id: <1531863587-3723-1-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series granularizes hotplug memory/io reservations to allow different
reservations by-id/by-path. It does this by expanding the kernel boot
parameters pci=hpmemsize= and pci=hpiosize=.

Patch 1/3:
	Changes the hpmemsize behavior between occupied and non-occupied slots,
	where occupied slots were being reserved their current allocation size
	in addition to the hpmemsize parameter. Following this patch, both
	occupied and non-occupied slots receive the same reservation and the
	current allocation size of the occupied slots is considered as part of
	the hotplug reservation.

	I have an additional patch which does this for hpiosize, however I
	don't have any compatible hotplug hardware requiring IO. I could
	synthesize it to test, but I am also not aware of requirements other
	users may have for additional IO.

Patch 2/3:
	Adds the format parsing for hpmemsize and hpiosize. Please see the log
	and 3/3 for documentation.

	Additionally I've noticed there's some overlap in Logan's ACS set with
	respect to format and device matching. Maybe this is something that can
	be refactored into common code once one is accepted.

Patch 3/3:
	Documents the new expanded formats


Jon Derrick (3):
  PCI: Equalize hotplug memory for non/occupied slots
  PCI: Granularize hpmemsize and hpiosize per-id/path
  docs: Document the expanded hp{io,mem}size interface

 Documentation/admin-guide/kernel-parameters.txt |  21 +-
 drivers/pci/pci.c                               | 253 +++++++++++++++++++++++-
 drivers/pci/setup-bus.c                         |  44 +++--
 include/linux/pci.h                             |  21 +-
 4 files changed, 309 insertions(+), 30 deletions(-)

-- 
1.8.3.1

