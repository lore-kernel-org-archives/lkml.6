Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F3AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B4F24AB4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fjNQfKu5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RhtytI7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B4F24AB4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932541AbeGCO3Y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:29:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40186 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753165AbeGCO3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:29:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 829B5607DC; Tue,  3 Jul 2018 14:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530628162;
        bh=bPPfswuzyx8c0dEMJOPzyY6leKSwnnI9hK+6lbiP65I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fjNQfKu5b/i2oXRpovWlUyO+PTHqoAfEZfHsDxtedCMqauygfbdwc+SOLqKSFHGZL
         /iYoe10W14fylISVKoC0s/TNV2hEveuWPgk7WX1xVjuPZnXbMzfiYPNUQ9XO/zYeyg
         kIgUSezAtcnH9Nmkg9w6ewmPKWnDYiNFc8NyMaRQ=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id A5B6860452;
        Tue,  3 Jul 2018 14:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530628161;
        bh=bPPfswuzyx8c0dEMJOPzyY6leKSwnnI9hK+6lbiP65I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RhtytI7ATjCtznRTeDoc0gPzm3FraVIhkDr/FZ/fyegYqrSavIK5EBJ9PqYxzfedk
         gI1u6NDZmZm+yjjnlMQyVMI2QFNITlofFURugNRQv0JMTIFkpo/v3NQLgSq4ax+9jP
         4IQi//BsHPQFiVFro7RAyqt7mElm7n8wBM6CRRaA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 03 Jul 2018 19:59:21 +0530
From:   poza@codeaurora.org
To:     Lukas Wunner <lukas@wunner.de>
Cc:     okaya@codeaurora.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
In-Reply-To: <20180703141255.GB18639@wunner.de>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
 <1530571967-19099-4-git-send-email-okaya@codeaurora.org>
 <20180703083447.GA2689@wunner.de>
 <8b6ce0f415858463d1c0588c29e30415@codeaurora.org>
 <20180703141255.GB18639@wunner.de>
Message-ID: <237b7dd4036d8a6156b9e1cb605c84c9@codeaurora.org>
X-Sender: poza@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-03 19:42, Lukas Wunner wrote:
> On Tue, Jul 03, 2018 at 07:30:28AM -0400, okaya@codeaurora.org wrote:
>> On 2018-07-03 04:34, Lukas Wunner wrote:
>> >On Mon, Jul 02, 2018 at 06:52:47PM -0400, Sinan Kaya wrote:
>> >>If a bridge supports hotplug and observes a PCIe fatal error, the
>> >>following
>> >>events happen:
>> >>
>> >>1. AER driver removes the devices from PCI tree on fatal error
>> >>2. AER driver brings down the link by issuing a secondary bus reset
>> >>waits
>> >>for the link to come up.
>> >>3. Hotplug driver observes a link down interrupt
>> >>4. Hotplug driver tries to remove the devices waiting for the rescan
>> >>lock
>> >>but devices are already removed by the AER driver and AER driver is
>> >>waiting
>> >>for the link to come back up.
>> >>5. AER driver tries to re-enumerate devices after polling for the link
>> >>state to go up.
>> >>6. Hotplug driver obtains the lock and tries to remove the devices
>> >>again.
>> >>
>> >>If a bridge is a hotplug capable bridge, mask hotplug interrupts before
>> >>the
>> >>reset and unmask afterwards.
>> >
>> >Would it work for you if you just amended the AER driver to skip
>> >removal and re-enumeration of devices if the port is a hotplug bridge?
>> >Just check for is_hotplug_bridge in struct pci_dev.
>> 
>> The reason why we want to remove devices before secondary bus reset is 
>> to
>> quiesce pcie bus traffic before issuing a reset.
>> 
>> Skipping this step might cause transactions to be lost in the middle 
>> of the
>> reset as there will be active traffic flowing and drivers will 
>> suddenly
>> start reading ffs.
> 
> Interesting, I think that merits a code comment.
> 
> FWIW, macOS has a "PCI pause" callback to quiesce a device:
> https://opensource.apple.com/source/IOPCIFamily/IOPCIFamily-239.1.2/pause.rtf
> 
> They're using it to reconfigure a device's BAR and bus number
> at runtime (sic!), e.g. if mmio windows need to be moved around
> on Thunderbolt hotplug if there's insufficient space:
> 
> 	"During pause reconfiguration, the following may be changed:
> 	 - device BAR registers
> 	 - the devices bus number
> 	 - registry properties reflecting these values ("ranges",
> 	   "assigned-addresses", "reg")
> 	 - device MSI block values for address and value, but not the
> 	   number of MSIs allocated"
> 
> Conceptually, "PCI pause" is similar to putting the device in a suspend
> state.  I'm wondering if suspending the devices below the bridge would
> make more sense than removing them in the AER driver.
> 

the code is shared by not only AER but also DPC, where if DPC event 
happens the devices are removed.
also if the bridge is hotplug capable, then the devices beneath might 
have changed and resume might break.

> Lukas
