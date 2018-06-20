Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B10C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C68B20693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C68B20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753933AbeFTEd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 00:33:26 -0400
Received: from smtprelay0119.hostedemail.com ([216.40.44.119]:40938 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750821AbeFTEdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 00:33:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 9DBBE18096A28;
        Wed, 20 Jun 2018 04:33:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fight64_1d37dbbd70615
X-Filterd-Recvd-Size: 3739
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Wed, 20 Jun 2018 04:33:20 +0000 (UTC)
Message-ID: <9bd45007ddfe2c32b6ee5097e427aabdc267ce53.camel@perches.com>
Subject: pci: pci_printk use
From:   Joe Perches <joe@perches.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederick Lawler <fred@fredlawl.com>
Date:   Tue, 19 Jun 2018 21:33:18 -0700
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the pci_printk uses are at KERN_DEBUG which is always
emitted into the kernel logging whenever the console log
level is high enough.

Are any of these appropriate for conversion to pci_dbg
to allow these only to be emitted via dynamic_debug or
if necessary via a #define DEBUG during compilation?

$ git grep -w -n pci_printk drivers
drivers/pci/bus.c:291:          pci_printk(KERN_DEBUG, dev, "%pR clipped to %pR\n",
drivers/pci/hotplug/shpchp.h:51:                        pci_printk(KERN_DEBUG, ctrl->pci_dev,           \
drivers/pci/pci.c:2484:                 pci_printk(KERN_DEBUG, dev, "supports%s%s\n",
drivers/pci/pci.c:2491:         pci_printk(KERN_DEBUG, dev, "PME# supported from%s%s%s%s%s\n",
drivers/pci/pci.c:2655:         pci_printk(KERN_DEBUG, dev, "BAR %d: %pR (from Enhanced Allocation, properties %#02x)\n",
drivers/pci/pci.c:2658:         pci_printk(KERN_DEBUG, dev, "ROM: %pR (from Enhanced Allocation, properties %#02x)\n",
drivers/pci/pci.c:2661:         pci_printk(KERN_DEBUG, dev, "VF BAR %d: %pR (from Enhanced Allocation, properties %#02x)\n",
drivers/pci/pci.c:2664:         pci_printk(KERN_DEBUG, dev, "BEI %d res: %pR (from Enhanced Allocation, properties %#02x)\n",
drivers/pci/pci.c:3775: pci_printk(KERN_DEBUG, dev, "cache line size of %d is not supported\n",
drivers/pci/pcie/aer.c:775:             pci_printk(KERN_DEBUG, parent, "can't find device of ID%04x\n",
drivers/pci/pcie/aer.c:1317:    pci_printk(KERN_DEBUG, dev, "Root Port link has been reset\n");
drivers/pci/pcie/err.c:75:                      pci_printk(KERN_DEBUG, dev, "device has %s\n",
drivers/pci/pcie/err.c:179:     pci_printk(KERN_DEBUG, dev, "downstream link has been reset\n");
drivers/pci/pcie/err.c:205:             pci_printk(KERN_DEBUG, dev, "no link-reset support at upstream device %s\n",
drivers/pci/pcie/err.c:211:             pci_printk(KERN_DEBUG, dev, "link reset at upstream device %s failed\n",
drivers/pci/pcie/err.c:237:     pci_printk(KERN_DEBUG, dev, "broadcast %s message\n", error_mesg);
drivers/pci/probe.c:321:                pci_printk(KERN_DEBUG, dev, "reg 0x%x: %pR\n", pos, res);
drivers/pci/probe.c:388:                pci_printk(KERN_DEBUG, dev, "  bridge window %pR\n", res);
drivers/pci/probe.c:410:                pci_printk(KERN_DEBUG, dev, "  bridge window %pR\n", res);
drivers/pci/probe.c:463:                pci_printk(KERN_DEBUG, dev, "  bridge window %pR\n", res);
drivers/pci/probe.c:493:                                pci_printk(KERN_DEBUG, dev,
drivers/pci/probe.c:1598:       pci_printk(KERN_DEBUG, dev, "[%04x:%04x] type %02x class %#08x\n",
drivers/pci/setup-bus.c:258:                            pci_printk(KERN_DEBUG, add_res->dev,
drivers/pci/setup-bus.c:954:            pci_printk(KERN_DEBUG, bus->self, "bridge window %pR to %pR add_size %llx\n",
drivers/pci/setup-bus.c:1101:           pci_printk(KERN_DEBUG, bus->self, "bridge window %pR to %pR add_size %llx add_align %llx\n",
drivers/pci/setup-bus.c:1569:           pci_printk(KERN_DEBUG, dev, "resource %d %pR released\n",

