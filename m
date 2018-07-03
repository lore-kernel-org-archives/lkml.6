Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A08C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F056D24B1C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F056D24B1C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932520AbeGCOM7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:12:59 -0400
Received: from bmailout2.hostsharing.net ([83.223.90.240]:56127 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932409AbeGCOM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:12:58 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 019D628008B1A;
        Tue,  3 Jul 2018 16:12:56 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 9CC0D1BCE; Tue,  3 Jul 2018 16:12:55 +0200 (CEST)
Date:   Tue, 3 Jul 2018 16:12:55 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     okaya@codeaurora.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
Message-ID: <20180703141255.GB18639@wunner.de>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
 <1530571967-19099-4-git-send-email-okaya@codeaurora.org>
 <20180703083447.GA2689@wunner.de>
 <8b6ce0f415858463d1c0588c29e30415@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b6ce0f415858463d1c0588c29e30415@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 07:30:28AM -0400, okaya@codeaurora.org wrote:
> On 2018-07-03 04:34, Lukas Wunner wrote:
> >On Mon, Jul 02, 2018 at 06:52:47PM -0400, Sinan Kaya wrote:
> >>If a bridge supports hotplug and observes a PCIe fatal error, the
> >>following
> >>events happen:
> >>
> >>1. AER driver removes the devices from PCI tree on fatal error
> >>2. AER driver brings down the link by issuing a secondary bus reset
> >>waits
> >>for the link to come up.
> >>3. Hotplug driver observes a link down interrupt
> >>4. Hotplug driver tries to remove the devices waiting for the rescan
> >>lock
> >>but devices are already removed by the AER driver and AER driver is
> >>waiting
> >>for the link to come back up.
> >>5. AER driver tries to re-enumerate devices after polling for the link
> >>state to go up.
> >>6. Hotplug driver obtains the lock and tries to remove the devices
> >>again.
> >>
> >>If a bridge is a hotplug capable bridge, mask hotplug interrupts before
> >>the
> >>reset and unmask afterwards.
> >
> >Would it work for you if you just amended the AER driver to skip
> >removal and re-enumeration of devices if the port is a hotplug bridge?
> >Just check for is_hotplug_bridge in struct pci_dev.
> 
> The reason why we want to remove devices before secondary bus reset is to
> quiesce pcie bus traffic before issuing a reset.
> 
> Skipping this step might cause transactions to be lost in the middle of the
> reset as there will be active traffic flowing and drivers will suddenly
> start reading ffs.

Interesting, I think that merits a code comment.

FWIW, macOS has a "PCI pause" callback to quiesce a device:
https://opensource.apple.com/source/IOPCIFamily/IOPCIFamily-239.1.2/pause.rtf

They're using it to reconfigure a device's BAR and bus number
at runtime (sic!), e.g. if mmio windows need to be moved around
on Thunderbolt hotplug if there's insufficient space:

	"During pause reconfiguration, the following may be changed:
	 - device BAR registers
	 - the devices bus number
	 - registry properties reflecting these values ("ranges",
	   "assigned-addresses", "reg")
	 - device MSI block values for address and value, but not the
	   number of MSIs allocated"

Conceptually, "PCI pause" is similar to putting the device in a suspend
state.  I'm wondering if suspending the devices below the bridge would
make more sense than removing them in the AER driver.

Lukas
