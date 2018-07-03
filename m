Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA42C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492D824A3A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NThk4YC3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NThk4YC3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 492D824A3A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753392AbeGCLab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:30:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52290 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752185AbeGCLa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:30:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C407E60B25; Tue,  3 Jul 2018 11:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530617428;
        bh=lBU20nT8HE20AX2q+fA38kKmR0Yok6O/G28Ty9ZVZhk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NThk4YC35zsI3zzpg4J9f7eKNYWsVZqNKYs+XsK5j8izIdLkfqqMi4Lp9rKIEax0K
         KiKn0wkx2OsvbViDmhc0bt0DSfSc10hCm6eGeDl1+ah3QktGQZ8uxan2HDHQlOZZeN
         cpUJ87FV6u0xtyoXuC4Kak8c5Ne5Nyxy/wYtGuo8=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 2FF4360274;
        Tue,  3 Jul 2018 11:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530617428;
        bh=lBU20nT8HE20AX2q+fA38kKmR0Yok6O/G28Ty9ZVZhk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NThk4YC35zsI3zzpg4J9f7eKNYWsVZqNKYs+XsK5j8izIdLkfqqMi4Lp9rKIEax0K
         KiKn0wkx2OsvbViDmhc0bt0DSfSc10hCm6eGeDl1+ah3QktGQZ8uxan2HDHQlOZZeN
         cpUJ87FV6u0xtyoXuC4Kak8c5Ne5Nyxy/wYtGuo8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 03 Jul 2018 07:30:28 -0400
From:   okaya@codeaurora.org
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
In-Reply-To: <20180703083447.GA2689@wunner.de>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
 <1530571967-19099-4-git-send-email-okaya@codeaurora.org>
 <20180703083447.GA2689@wunner.de>
Message-ID: <8b6ce0f415858463d1c0588c29e30415@codeaurora.org>
X-Sender: okaya@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-03 04:34, Lukas Wunner wrote:
> On Mon, Jul 02, 2018 at 06:52:47PM -0400, Sinan Kaya wrote:
>> If a bridge supports hotplug and observes a PCIe fatal error, the 
>> following
>> events happen:
>> 
>> 1. AER driver removes the devices from PCI tree on fatal error
>> 2. AER driver brings down the link by issuing a secondary bus reset 
>> waits
>> for the link to come up.
>> 3. Hotplug driver observes a link down interrupt
>> 4. Hotplug driver tries to remove the devices waiting for the rescan 
>> lock
>> but devices are already removed by the AER driver and AER driver is 
>> waiting
>> for the link to come back up.
>> 5. AER driver tries to re-enumerate devices after polling for the link
>> state to go up.
>> 6. Hotplug driver obtains the lock and tries to remove the devices 
>> again.
>> 
>> If a bridge is a hotplug capable bridge, mask hotplug interrupts 
>> before the
>> reset and unmask afterwards.
> 
> Would it work for you if you just amended the AER driver to skip
> removal and re-enumeration of devices if the port is a hotplug bridge?
> Just check for is_hotplug_bridge in struct pci_dev.

The reason why we want to remove devices before secondary bus reset is 
to quiesce pcie bus traffic before issuing a reset.

Skipping this step might cause transactions to be lost in the middle of 
the reset as there will be active traffic flowing and drivers will 
suddenly start reading ffs.

I don't think we can skip this step.


> 
> That would seem like a much simpler solution, given that it is known
> that the link will flap on reset, causing the hotplug driver to remove
> and re-enumerate devices.  That would also cover cases where hotplug is
> handled by a different driver than pciehp, or by the platform firmware.
> 
> Thanks,
> 
> Lukas
