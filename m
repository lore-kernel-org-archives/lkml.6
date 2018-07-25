Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03219C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB71720843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HVDo6XPo";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HVDo6XPo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB71720843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbeGYJjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 05:39:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46658 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728222AbeGYJjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 05:39:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E12C760B73; Wed, 25 Jul 2018 08:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532507356;
        bh=nvdbsYkc5fMIMw//dqUzmWMoBMax6XztzkUA4pXVuFs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HVDo6XPoatOZZJgJQXblZR4/B4OC/A4cZ4W2aLHRFebcR+94OhJWXjypM2vLTBKku
         zBidV3yKX/vbjnHU3r718VLZPH90+XKlTTyYTX3zebWzU5lduhuyHu68NvmLLytcKD
         27yVE5odhnuGCxSHeEnF0UDnu5c0DaGZB35r99/w=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 6275960B19;
        Wed, 25 Jul 2018 08:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532507356;
        bh=nvdbsYkc5fMIMw//dqUzmWMoBMax6XztzkUA4pXVuFs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HVDo6XPoatOZZJgJQXblZR4/B4OC/A4cZ4W2aLHRFebcR+94OhJWXjypM2vLTBKku
         zBidV3yKX/vbjnHU3r718VLZPH90+XKlTTyYTX3zebWzU5lduhuyHu68NvmLLytcKD
         27yVE5odhnuGCxSHeEnF0UDnu5c0DaGZB35r99/w=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 25 Jul 2018 13:59:16 +0530
From:   poza@codeaurora.org
To:     Sinan Kaya <okaya@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        linux-pci@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
In-Reply-To: <d34eb5da-0ae1-d455-93e2-2432ec7931ea@kernel.org>
References: <CAK9iUCM=zWexWow9TwkRfO186Hwr5WyGy0NHZF1vtXn3wbbZGQ@mail.gmail.com>
 <12fc8de5-ff03-cb00-52cb-25a43c71d03a@codeaurora.org>
 <20180708171418.GA11476@wunner.de>
 <CAK9iUCMcic5mzGiT20KNxgwPo6AuajHFsoj7GOjSht5SwrQevg@mail.gmail.com>
 <20180709160008.GA1490@wunner.de>
 <CAK9iUCMMVR114msKiMHu7ik0VK8T5j=LAYAKsEkdnocTqkdMjQ@mail.gmail.com>
 <20180720200123.GS128988@bhelgaas-glaptop.roam.corp.google.com>
 <2febe688-f973-5ff5-f61d-0451ad7d36ae@kernel.org>
 <d34eb5da-0ae1-d455-93e2-2432ec7931ea@kernel.org>
Message-ID: <5cdaf58f3c848b2a5097484cd703acae@codeaurora.org>
X-Sender: poza@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-21 11:37, Sinan Kaya wrote:
> On 7/20/2018 7:58 PM, Sinan Kaya wrote:
>> We need to figure out how to gracefully return inside hotplug driver
>> if link down happened and there is an error pending.
> 
> How about adding the following into the hotplug ISR?
> 
> 1. check if firmware first is disabled
> 2. check if there is a fatal error pending in the device_status 
> register
> of the PCI Express capability on the root port.
> 3. bail out from hotplug routine if this is the case.
> 4. otherwise, existing behavior.

This makes sense.

from Lukas's text

"
The user may turn the slot on/off via sysfs.  If an Attention Button
is present, the user may also press that button to turn the slot on/off
after 5 seconds.  Either way, it may cause pciehp's IRQ thread to run
concurrently to a reset initiated by the AER driver, independently of
any events signalled by the slot.
"

so if device gets removed and re-enumerated other than hotplug ISR,
or any other similar path has to take care of checking ERR_FATAL status.

Regards,
Oza.
