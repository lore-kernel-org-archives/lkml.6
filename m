Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEA2C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD8F2437D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD8F2437D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753447AbeGDNIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:08:16 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36902 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753003AbeGDNIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:08:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C6327A9;
        Wed,  4 Jul 2018 06:08:13 -0700 (PDT)
Received: from [192.168.67.35] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98C8A3F5BA;
        Wed,  4 Jul 2018 06:08:11 -0700 (PDT)
Subject: Re: [linux-sunxi] Re: [PATCH 0/2] Allwinner A64 timer workaround
To:     tglx@linutronix.de, Marc Zyngier <marc.zyngier@arm.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Mark Rutland <Mark.Rutland@arm.com>
References: <20180511022751.9096-1-samuel@sholland.org>
 <2c16d5ab-38f7-8f3e-875c-19e8032f440a@arm.com>
 <bdfb1a31-2c4a-d258-7bf6-aaab8cee4663@sholland.org>
 <5283f98e-6443-db7a-fe51-6379ed19002c@arm.com>
 <24b78819-5e3f-431f-3987-f7409742ef07@linaro.org>
 <1d75c538-9166-5eec-a08c-b168f9770bd1@arm.com>
 <alpine.DEB.2.21.1807041151530.1816@nanos.tec.linutronix.de>
From:   Andre Przywara <andre.przywara@arm.com>
Message-ID: <1a36f63c-0259-bdcd-bb96-d5230c2564ea@arm.com>
Date:   Wed, 4 Jul 2018 14:08:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1807041151530.1816@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04/07/18 11:00, Thomas Gleixner wrote:
> On Wed, 4 Jul 2018, Marc Zyngier wrote:
>> On 04/07/18 09:23, Daniel Lezcano wrote:
>>>
>>> If the patches fix a bug which already exist, it makes sense to
>>> propagated the fix back to the stable versions.
>>
>> That's your call, but I'm not supportive of that decision, specially as
>> we have information from the person developing the workaround that this
>> doesn't fully address the issue.
> 
> The patches should not be applied at all. Simply because they don't fix the
> issue completely.
> 
> From a quick glance at various links and information about this, this very
> much smells like the FSL_ERRATUM_A008585.
> Has that been tried? It looks way more robust than the magic 11 bit
> crystal ball logic.

The Freescale erratum is similar, but not identical [1].
It seems like the A64 is less variable, so we can use a cheaper
workaround, which gets away with normally just one sysreg read. But then
again the newer error reports may actually suggest otherwise ...

And as it currently stands, the Freescale erratum has the drawback of
relying on the CPU running much faster than the timer. The A64 can run
at 24 MHz (for power savings, or possibly during DVFS transitions),
which is the timer frequency. So subsequent counter reads will never
return the same value and the workaround times out.

Cheers,
Andre.

[1] https://lists.denx.de/pipermail/u-boot/2016-November/271836.html
