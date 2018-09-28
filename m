Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09006C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C662173D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C662173D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbeI1ObB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 10:31:01 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44392 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbeI1ObA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 10:31:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0559E7A9;
        Fri, 28 Sep 2018 01:08:29 -0700 (PDT)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 717553F5D3;
        Fri, 28 Sep 2018 01:08:26 -0700 (PDT)
Subject: Re: [PATCH 0/3] ARM/PSCI: Fix THUMB2_KERNEL entry points
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        open list <linux-kernel@vger.kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>
References: <20180927192711.26455-1-f.fainelli@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <c68b01ab-9077-73cc-8356-25a4e3a909f0@arm.com>
Date:   Fri, 28 Sep 2018 09:08:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180927192711.26455-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-27 8:27 PM, Florian Fainelli wrote:
> Hi all,
> 
> While playing with THUMB2_KERNEL on ARCH_BRCMSTB, several issues came up
> which are addressed by these 3 patches.

Hmmm, PSCI looks to explicitly support Thumb entrypoints ("T32 support" 
in section 6.4.3 of DEN0022D), so these changes smell a little of 
papering over a more fundamental problem, which is presumably either 
that Thumb symbols are not being resolved correctly, or that the 
firmware you're using has a bug.

Robin.

> The THUMB() assembler macro is a no-op unless CONFIG_THUMB2_KERNEL so
> using it unconditionally for CONFIG_ARM should not cause a problem
> AFAICT.
> 
> Those patches can all be independently picked up by their respective
> maintainers and don't depent on one another.
> 
> Thank you!
> 
> Florian Fainelli (3):
>    firmware/psci: Fix cpu_resume entry points with THUMB2_KERNEL
>    ARM: psci: Fix secondary core boot with THUMB2_KERNEL
>    soc: bcm: brcmstb: Fix re-entry point with a THUMB2_KERNEL
> 
>   arch/arm/kernel/psci_smp.c          |  4 ++--
>   drivers/firmware/psci.c             | 18 +++++++++++++++---
>   drivers/soc/bcm/brcmstb/pm/pm-arm.c |  2 +-
>   3 files changed, 18 insertions(+), 6 deletions(-)
> 
