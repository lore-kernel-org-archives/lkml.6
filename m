Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3860BECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8B42124D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC8B42124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbeGMHec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:34:32 -0400
Received: from bmailout2.hostsharing.net ([83.223.90.240]:48713 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbeGMHeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:34:31 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id E66F128004EB5;
        Fri, 13 Jul 2018 09:21:09 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 9951A4A26; Fri, 13 Jul 2018 09:21:09 +0200 (CEST)
Date:   Fri, 13 Jul 2018 09:21:09 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/32] genirq: Synchronize only with single thread on
 free_irq()
Message-ID: <20180713072109.GA23955@wunner.de>
References: <cover.1529173804.git.lukas@wunner.de>
 <83cfe0c826f1d793e2ead9032ef2109b5efa403a.1529173804.git.lukas@wunner.de>
 <20180712222109.GE28466@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712222109.GE28466@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 05:21:09PM -0500, Bjorn Helgaas wrote:
> On Sat, Jun 16, 2018 at 09:25:00PM +0200, Lukas Wunner wrote:
> > When pciehp is converted to threaded IRQ handling, removal of unplugged
> > devices below a PCIe hotplug port happens synchronously in the IRQ
> > thread.  Removal of devices typically entails a call to free_irq() by
> > their drivers.
> > 
> > If those devices share their IRQ with the hotplug port, free_irq()
> > deadlocks because it calls synchronize_irq() to wait for all hard IRQ
> > handlers as well as all threads sharing the IRQ to finish.
> > 
> > Actually it's sufficient to wait only for the IRQ thread of the removed
> > device, so call synchronize_hardirq() to wait for all hard IRQ handlers
> > to finish, but no longer for any threads.  Compensate by rearranging the
> > control flow in irq_wait_for_interrupt() such that the device's thread
> > is allowed to run one last time after kthread_stop() has been called.
> 
> I assume this would need to be merged along with the rest of the
> series, which should probably go through the PCI tree, but I'm
> definitely not qualified to review this IRQ patch.  And it would need
> an ack from Thomas in any case.

A v2 of this patch has already been merged through the tip tree on June 24,
it's in linux-next as commit 519cc8652b3a, and ISTR that I marked this patch
either as "Obsoleted" or "Not Applicable" in pci-patchwork.  There was no
build-dependency of the succeeding patches in the series on this patch,
hence merging through a different tree was possible.

Thanks!

Lukas
