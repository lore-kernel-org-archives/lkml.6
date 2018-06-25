Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC800C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A91255AB
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A91255AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752423AbeFYQSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:18:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:32958 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751513AbeFYQSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:18:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BA9D7A9;
        Mon, 25 Jun 2018 09:18:43 -0700 (PDT)
Received: from [10.1.206.75] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CDD23F5AD;
        Mon, 25 Jun 2018 09:18:42 -0700 (PDT)
Subject: Re: [PATCH] PCI: shpchp: Fix probing logic inversion
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180621164715.28160-1-marc.zyngier@arm.com>
 <20180625140122.GF108993@bhelgaas-glaptop.roam.corp.google.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <62eb1a4b-2ec9-b472-a277-33ddc5952348@arm.com>
Date:   Mon, 25 Jun 2018 17:18:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180625140122.GF108993@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn, Mika,

On 25/06/18 15:01, Bjorn Helgaas wrote:
> Hi Marc,
> 
> Sorry we broke this!

No worries, gave me a chance to stare at something else! ;-)

> 
> On Thu, Jun 21, 2018 at 05:47:15PM +0100, Marc Zyngier wrote:
>> Until recently, shpc_probe() would bail out pretty early in the
>> absence of the SHPC capability. A logic change in the way the
>> driver now checks that capability makes it go and probe the
>> firmware anyway, with ugly consequences if the system is not
>> ACPI based (my arm64 ThunderX is DT driven, and explodes in
>> a spectacular way after getting a NULL root bridge from the
>> non-existent ACPI tables...).
>>
>> Take this opportunity to move the call to shpchp_is_native()
>> back into shpc_probe(), making it clear that a non-ACPI system
>> is not expected to use this driver.
> 
> But a non-ACPI system *should* be able to use SHPC.

Yeah, I only realized that once Mika pointed it out.

> Here's my understanding of how it should work.  On an ACPI system,
> 
>   - If firmware has _OSC, the OS calls it to request permission to
>     manage the SHPC.  If _OSC grants permission, it should also
>     configure the hardware (interrupts, etc) to give the OS.
>     
>   - If there's no _OSC, shpchp assumes it's allowed to manage the
>     SHPC, and it calls OSHP to configure the hardware appropriately.
> 
> On a non-ACPI system, shpchp assumes there's no firmware involved at
> all, so it can manage the SHPC without doing anything special.
> 
> I see Mika has already posted a patch similar to the first one
> below; I think either of those should fix the problem you're seeing.

Absolutely. With this early exit when root is NULL, my test box is back
up and running.

> The second is an attempt to clean things up so they make a
> little more sense.

I haven't tried that second patch yet, but from reading it, it
definitely helps making sense of this driver.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
