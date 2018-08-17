Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AB7C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918CD21A2E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 918CD21A2E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbeHQVT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 17:19:26 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:46673 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbeHQVTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 17:19:25 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 051F730000F3C;
        Fri, 17 Aug 2018 20:15:01 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id AB65D15647C; Fri, 17 Aug 2018 20:15:01 +0200 (CEST)
Date:   Fri, 17 Aug 2018 20:15:01 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-pci@vger.kernel.org, Hari Vyas <hari.vyas@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jens Axboe <axboe@kernel.dk>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Marta Rybczynska <mrybczyn@kalray.eu>,
        Pierre-Yves Kerbrat <pkerbrat@kalray.eu>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/6] pci: Set pci_dev->is_added before calling
 device_add
Message-ID: <20180817181501.m4j7jibzsrgljmlj@wunner.de>
References: <20180817044902.31420-1-benh@kernel.crashing.org>
 <20180817044902.31420-3-benh@kernel.crashing.org>
 <20180817162534.GD128050@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180817162534.GD128050@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 11:25:34AM -0500, Bjorn Helgaas wrote:
> The "bind driver, then set dev->added = 1" order seems to have been
> there since the beginning of dev->is_added:
> 
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=8a1bc9013a03
> 
> This patch seems reasonable, but I'm a little dubious about the
> existence of "is_added" in the first place.  As far as I can tell, the
> only other buses with something similar are the MEN Chameleon bus and
> the Intel Management Engine Interface.
> 
> The PCI uses of "is_added" don't seem *that* critical or unique to
> PCI, so I'm not 100% convinced we need it at all.  But I haven't
> looked into it enough to be able to propose an alternative.

Addition of new PCI devices, e.g. on boot or on hotplug, consists of two
stages:  First, new devices are created by pci_scan_slot(), afterwards
they're bound to a driver by pci_bus_add_devices().  The idea is that
the bus is scanned in full before drivers are attached to devices.

In the second step, i.e. in pci_bus_add_devices(), the is_added flag is
set on devices.  The flag is significant because pci_scan_slot() returns
the number of newly discovered PCI functions in the given slot, and it
calculates that number based on the is_added flag.

More specifically, it invokes pci_scan_single_device() which either
returns an existing device or a newly created device.  The is_added flag
is basically a way for pci_scan_single_device() to communicate back to
pci_scan_slot() which of the two code paths it took.

The two steps (enumeration and driver attachment) are protected by
pci_lock_rescan_remove().  Initially, when a pci_dev is newly allocated
with kzalloc(), is_added is 0.  The transition from 0 to 1 happens while
under pci_lock_rescan_remove().  When that lock is released, is_added is
always 1, barring a device_attach() error, in which case it will remain
at 0.

AFAICS, there is no second mutex needed to ensure synchronization of
is_added, the existing mutex should be sufficient and the only problem
are RMW races when accessing adjacent flags. Those were correctly addressed
by Hari's patch.  Benjamin seems to be alleging that concurrency issues
exist beyond the RMW races, I fail to see them, sorry.

Thanks,

Lukas
