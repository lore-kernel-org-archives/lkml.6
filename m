Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80885C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 294D924CAD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HZj5YUDD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oHaTWQ6v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 294D924CAD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753015AbeGCMEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 08:04:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41054 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752686AbeGCMEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 08:04:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5D53660B67; Tue,  3 Jul 2018 12:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530619462;
        bh=XY5YhIUna8GtPIvVvfcgPCbqCm4BkKymU8l22JUACFs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HZj5YUDDjxOLBRVgJlY4SyyBLlmLFnZ46h3qrN4M7Uz6Upb/7+dTlfP4AU5cncW2l
         /c5sVOyBLt6k5qln3u8xGd7RK8S8VpLTHHxoMPXb1LoWHA+v6L7yYjLPNlch6ywu+e
         mjSksrLpEbL+NuBu1Wzgk0Gy013zjxitW50Cw7Hw=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 9090D6037C;
        Tue,  3 Jul 2018 12:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530619460;
        bh=XY5YhIUna8GtPIvVvfcgPCbqCm4BkKymU8l22JUACFs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oHaTWQ6vlTA6MsBRaTCMe0TrYhOi4tcWmeIn0+HidPFMd8qVhnejGBLkve/yy1JrM
         NP8n1kipDbWhZj76U2X6n1GoxA1x2aXONraNzh7attG8U4dOU/sUYFuRYXg1EC0ucG
         s9ikKolU9F9FdTz9Mcxx6vInccmb/0jwmdB6uSAQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 03 Jul 2018 08:04:20 -0400
From:   okaya@codeaurora.org
To:     poza@codeaurora.org
Cc:     Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
In-Reply-To: <324f8cf2fe6f7bdc43ca8a646eea908d@codeaurora.org>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
 <1530571967-19099-4-git-send-email-okaya@codeaurora.org>
 <20180703083447.GA2689@wunner.de>
 <324f8cf2fe6f7bdc43ca8a646eea908d@codeaurora.org>
Message-ID: <c129b813df87a2a471e8b9101447f535@codeaurora.org>
X-Sender: okaya@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-03 06:52, poza@codeaurora.org wrote:
> On 2018-07-03 14:04, Lukas Wunner wrote:
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
>> 
> 
> I tend to agree with you Lukas.
> 
> on this line I already have follow up patches
> although I am waiting for Bjorn to review some patch-series before 
> that.
> [PATCH v2 0/6] Fix issues and cleanup for ERR_FATAL and ERR_NONFATAL
> 
> It doesn't look to me a an entirely a race condition since its guarded
> by pci_lock_rescan_remove())
> I observed that both hotplug and aer/dpc comes out of it in a quiet 
> sane state.
> 

To add more detail on when this issue happens.

This problem is more visible on root ports with MSI-x capability or with 
multiple MSI interrupt numbers.

AFAIK, QDT root ports are single shared MSI interrupt only. Therefore, 
you won't see this issue.

As you can see in the code, rescan lock is held for the entire fatal 
error handling path.

> My thinking is: Disabling hotplug interrupts during ERR_FATAL,
> is something little away from natural course of link_down event
> handling, which is handled by pciehp more maturely.
> so it would be just easy not to take any action e.g. removal and
> re-enumeration of devices from ERR_FATAL handling point of view.
> 

I think it is more unnatural to fragment code flow and allow two drivers 
to do the same thing in parallel or create inter-driver dependency.

I got the idea from pci_reset_slot() function which is already masking 
hotplug interrupts when called by external entries during secondary bus 
reset. We just didn't handle the same for fatal error cases.
