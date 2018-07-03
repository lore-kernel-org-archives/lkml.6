Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76767C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3D3208B0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="b67FDcAt";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="J0/PdUJ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F3D3208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753322AbeGCNLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 09:11:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60766 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752961AbeGCNLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 09:11:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 546AE60B81; Tue,  3 Jul 2018 13:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530623494;
        bh=LQ2wOhMEPvGYVtmOVUtPjt8yEizY/Ewfio1Gn5/+uX0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b67FDcAtOAP+D82spPMVj8z+5/jR54ynLfk9Ag3xPepx+S2kXRK9Cr2VUdP8S35Q2
         Ud7MaV+dVbzJPQDnjxtj3tTnMPXLSEyoF+W8rstTyUshFxib4MBhaaPwzm14nZq+DT
         I+XdPB1vhlX/5OOMrFssCF0q+v79aWTLXYrP00sA=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 0CDA460B71;
        Tue,  3 Jul 2018 13:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530623493;
        bh=LQ2wOhMEPvGYVtmOVUtPjt8yEizY/Ewfio1Gn5/+uX0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J0/PdUJ9xo5TweLQv2B1KqIA1JpHDSHzFgMXQ42zFnYurSRGjz421Oe2mY+Go6bEF
         EN9IfHp9+9DP/PGBZh/2aXP/dtO3stG7hCPTZOpG0m86qxr2DLKPtwmf2I0I5/EGrL
         hiM1PidFU/tdWFvE/6l7tC7xi9UKwcD3qetLXJ7o=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 03 Jul 2018 18:41:33 +0530
From:   poza@codeaurora.org
To:     okaya@codeaurora.org
Cc:     Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
In-Reply-To: <8b6ce0f415858463d1c0588c29e30415@codeaurora.org>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
 <1530571967-19099-4-git-send-email-okaya@codeaurora.org>
 <20180703083447.GA2689@wunner.de>
 <8b6ce0f415858463d1c0588c29e30415@codeaurora.org>
Message-ID: <9e871cc3978fbdca12ccf8a91f34ad07@codeaurora.org>
X-Sender: poza@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-03 17:00, okaya@codeaurora.org wrote:
> On 2018-07-03 04:34, Lukas Wunner wrote:
>> On Mon, Jul 02, 2018 at 06:52:47PM -0400, Sinan Kaya wrote:
>>> If a bridge supports hotplug and observes a PCIe fatal error, the 
>>> following
>>> events happen:
>>> 
>>> 1. AER driver removes the devices from PCI tree on fatal error
>>> 2. AER driver brings down the link by issuing a secondary bus reset 
>>> waits
>>> for the link to come up.
>>> 3. Hotplug driver observes a link down interrupt
>>> 4. Hotplug driver tries to remove the devices waiting for the rescan 
>>> lock
>>> but devices are already removed by the AER driver and AER driver is 
>>> waiting
>>> for the link to come back up.
>>> 5. AER driver tries to re-enumerate devices after polling for the 
>>> link
>>> state to go up.
>>> 6. Hotplug driver obtains the lock and tries to remove the devices 
>>> again.
>>> 
>>> If a bridge is a hotplug capable bridge, mask hotplug interrupts 
>>> before the
>>> reset and unmask afterwards.
>> 
>> Would it work for you if you just amended the AER driver to skip
>> removal and re-enumeration of devices if the port is a hotplug bridge?
>> Just check for is_hotplug_bridge in struct pci_dev.
> 
> The reason why we want to remove devices before secondary bus reset is
> to quiesce pcie bus traffic before issuing a reset.
> 
> Skipping this step might cause transactions to be lost in the middle
> of the reset as there will be active traffic flowing and drivers will
> suddenly start reading ffs.
> 
> I don't think we can skip this step.
> 

what if we only have conditional enumeration ?  (leaving removing 
devices followed by SBR as is) ?

following code is doing little more extra work than our normal ERR_FATAL 
path.

pciehp_unconfigure_device doing little more than enumeration to 
quiescence the bus.

/*
		 * Ensure that no new Requests will be generated from
		 * the device.
		 */
		if (presence) {
			pci_read_config_word(dev, PCI_COMMAND, &command);
			command &= ~(PCI_COMMAND_MASTER | PCI_COMMAND_SERR);
			command |= PCI_COMMAND_INTX_DISABLE;
			pci_write_config_word(dev, PCI_COMMAND, command);
		}



> 
>> 
>> That would seem like a much simpler solution, given that it is known
>> that the link will flap on reset, causing the hotplug driver to remove
>> and re-enumerate devices.  That would also cover cases where hotplug 
>> is
>> handled by a different driver than pciehp, or by the platform 
>> firmware.
>> 
>> Thanks,
>> 
>> Lukas
