Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E42EC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17F3424B1C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mY3w7DV2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ioUVpVav"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17F3424B1C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753549AbeGCOKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:10:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54646 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752684AbeGCOKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:10:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 65FAD602AE; Tue,  3 Jul 2018 14:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530627047;
        bh=fNZLCPAYA8s5iygCpewpLbXZcYzaVF3LaaYASyg/BEs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mY3w7DV2JHOQ/6s+h/kjT8Gc7BH8FOKGbmQDcFGm3pSeLEv+3BLyyEp7znDrFovPA
         Qe/HdPnrrAW/u0ZSMX3KNR5xY750BCOeFgS+XM6Gr3AyIu2QyzBZbFhBIMwhA4X4+2
         uDKKWiTyPJjpuWZkNuh3LxCvoKXQEalZGXrPnJ1o=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id DD4016031A;
        Tue,  3 Jul 2018 14:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530627046;
        bh=fNZLCPAYA8s5iygCpewpLbXZcYzaVF3LaaYASyg/BEs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ioUVpVav2US+79jMKXOJiXZvv/PmIfqYxAP02xn44+nE/IQzMp0BWsCAzQzaPbRGn
         glCCJWhZ5/cYbEwiEF2Db0r/buHLfr9ujr0w5jW8tm1aRv0vW7zi0A+/mu40K/b7it
         P6NWLicA/YMaWhIPeK53qLVjkJ8u6ioSsKFHrQSY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 03 Jul 2018 19:40:46 +0530
From:   poza@codeaurora.org
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
In-Reply-To: <20180703135956.GA18639@wunner.de>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
 <1530571967-19099-4-git-send-email-okaya@codeaurora.org>
 <20180703083447.GA2689@wunner.de>
 <8b6ce0f415858463d1c0588c29e30415@codeaurora.org>
 <9e871cc3978fbdca12ccf8a91f34ad07@codeaurora.org>
 <2640af5e-f00f-d814-425d-78ac57714f6d@codeaurora.org>
 <bd04c9d1-6dfe-3071-69f9-beb0d649b6c0@codeaurora.org>
 <20180703135956.GA18639@wunner.de>
Message-ID: <1658f1759864e22fed4273a22d501a8e@codeaurora.org>
X-Sender: poza@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-03 19:29, Lukas Wunner wrote:
> On Tue, Jul 03, 2018 at 09:31:24AM -0400, Sinan Kaya wrote:
>> Issue is observing hotplug link down event in the middle of AER 
>> recovery
>> as in my previous reply.
>> 
>> If we mask hotplug interrupts before secondary bus reset via my patch,
>> then hotplug driver will not observe both link up and link down 
>> interrupts.
>> 
>> If we don't mask hotplug interrupts, we have a race condition.
> 
> I assume that a bus reset not only causes a link and presence event but
> also clears the Presence Detect State bit in the Slot Status register
> and the Data Link Layer Link Active bit in the Link Status register
> momentarily.
> 
> pciehp may access those two bits concurrently to the AER driver
> performing a slot reset.  So it may not be sufficient to mask
> the interrupt.

Was just wondering that you are protecting Presence Detect State bit 
with reset_lock, mainly in pciehp_ist
but with hotplug interrupt disabled, is there another way that it 
hotplug code gets activated ?

> 
> I've posted this patch to address the issue:
> https://patchwork.ozlabs.org/patch/930391/
> 
> Thanks,
> 
> Lukas
