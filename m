Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD0AC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1982026270
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1GrFcirK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1982026270
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932249AbeFYW7h (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:59:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752330AbeFYW7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:59:35 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6CAF2625C;
        Mon, 25 Jun 2018 22:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529967575;
        bh=c8804UNUQtihq+uBB8yzs1Q+R2/RdkCwnf+9zg3/jv8=;
        h=Subject:From:To:Cc:Date:From;
        b=1GrFcirKG18ICQQaAW5sEpDpyr+O9IV6sTUsemAH1v9IlSOBnaTNsOke+QohhcCON
         ybN2YPigkwWZtFb3nGNagYxx2gPdHM3ZuUBVlbyEpH2Ou91qQ9S0EgO2AKSXKxw1T4
         cWsmP1SJQ3ymn0dyUW7SspWRdt9CYjP6+xiVMfe8=
Subject: [PATCH v1 0/4] PCI: shpchp: NULL pointer fix and cleanups
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 25 Jun 2018 17:59:33 -0500
Message-ID: <152996746234.260522.11381067633352986554.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch fixes a NULL pointer dereference reported by Marc and would
be targeted for v4.18.

The others simplify the shpchp probe path and would be for v4.19.

---

Bjorn Helgaas (4):
      PCI: shpchp: Manage SHPC unconditionally on non-ACPI systems
      PCI: shpchp: Separate existence of SHPC and permission to use it
      PCI: shpchp: Inline shpchp_is_native()
      PCI: hotplug: Implement hotplug_is_native() only when CONFIG_ACPI=y


 drivers/pci/hotplug/acpi_pcihp.c  |   40 +++++++++++++++++++++++--------------
 drivers/pci/hotplug/shpchp_core.c |   21 +++++++++++++++++++
 drivers/pci/pci-acpi.c            |   29 ---------------------------
 include/linux/pci.h               |    1 +
 include/linux/pci_hotplug.h       |   20 ++++++++++---------
 5 files changed, 58 insertions(+), 53 deletions(-)
