Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C254C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D998E241B2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WFVphuVI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WFVphuVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D998E241B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753341AbeGCNZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 09:25:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51882 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752423AbeGCNZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 09:25:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D4F5660B27; Tue,  3 Jul 2018 13:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530624318;
        bh=pAFHu8wUG8kOBiLRZ41P7G/M9DGhyOSQRRCshAbM01M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WFVphuVInRXZoLiDSafpWjD+oxOEjCtATEnHEoJ1B4FhT+J7e74ZeL0krseAoNwHd
         WavYFRKMfi59VQOI7UCFC3cmpyPw0i0VcQL3Tk1Hu9fexofHuhFKiB1zmausMioQ8I
         tRSsBvUgOdxyLNkqQPmquk4rszInZadECOw4SKH8=
Received: from [192.168.0.117] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4DD486063F;
        Tue,  3 Jul 2018 13:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530624318;
        bh=pAFHu8wUG8kOBiLRZ41P7G/M9DGhyOSQRRCshAbM01M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WFVphuVInRXZoLiDSafpWjD+oxOEjCtATEnHEoJ1B4FhT+J7e74ZeL0krseAoNwHd
         WavYFRKMfi59VQOI7UCFC3cmpyPw0i0VcQL3Tk1Hu9fexofHuhFKiB1zmausMioQ8I
         tRSsBvUgOdxyLNkqQPmquk4rszInZadECOw4SKH8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4DD486063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
To:     poza@codeaurora.org
Cc:     Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
 <1530571967-19099-4-git-send-email-okaya@codeaurora.org>
 <20180703083447.GA2689@wunner.de>
 <8b6ce0f415858463d1c0588c29e30415@codeaurora.org>
 <9e871cc3978fbdca12ccf8a91f34ad07@codeaurora.org>
From:   Sinan Kaya <okaya@codeaurora.org>
Message-ID: <2640af5e-f00f-d814-425d-78ac57714f6d@codeaurora.org>
Date:   Tue, 3 Jul 2018 09:25:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <9e871cc3978fbdca12ccf8a91f34ad07@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> what if we only have conditional enumeration ?  (leaving removing devices followed by SBR as is) ?
> 

If we leave it as is, hotplug driver observes a link down interrupt as soon
as secondary bus reset is issued. Hotplug driver will try device removal while
AER driver is working on the currently observe FATAL error causing a race
condition. Hotplug driver wait for rescan lock to be obtained.

> following code is doing little more extra work than our normal ERR_FATAL path.
> 

See this comment and the pseudo code below.

/*
 * pciehp has a 1:1 bus:slot relationship so we ultimately want a secondary
 * bus reset of the bridge, but at the same time we want to ensure that it is
 * not seen as a hot-unplug, followed by the hot-plug of the device. Thus,
 * disable link state notification and presence detection change notification
 * momentarily, if we see that they could interfere. Also, clear any spurious
 * events after.
 */
int pciehp_reset_slot(struct slot *slot, int probe)
{
	<mask hotplug interrupts>
	<issue secondary bus reset>
	<unmask hotplug interrupts>
}

This patch is trying to mask the interrupt before secondary bus reset in AER
path not after.

Otherwise, hotplug driver will remove the devices as soon as it obtains the
rescan lock following AER recovery since hotplug interrupts will be pending.

> pciehp_unconfigure_device doing little more than enumeration to quiescence the bus.
> 
> /*
>          * Ensure that no new Requests will be generated from
>          * the device.
>          */
>         if (presence) {
>             pci_read_config_word(dev, PCI_COMMAND, &command);
>             command &= ~(PCI_COMMAND_MASTER | PCI_COMMAND_SERR);
>             command |= PCI_COMMAND_INTX_DISABLE;
>             pci_write_config_word(dev, PCI_COMMAND, command);
>         }
> 
> 
> 
>>
>>>
>>> That would seem like a much simpler solution, given that it is known
>>> that the link will flap on reset, causing the hotplug driver to remove
>>> and re-enumerate devices.  That would also cover cases where hotplug is
>>> handled by a different driver than pciehp, or by the platform firmware.
>>>
>>> Thanks,
>>>
>>> Lukas
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
