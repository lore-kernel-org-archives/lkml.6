Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9165EECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64CC820825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64CC820825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeKIBqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:46:44 -0500
Received: from foss.arm.com ([217.140.101.70]:44484 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbeKIBqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:46:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA14180D;
        Thu,  8 Nov 2018 08:10:32 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD8CE3F5CF;
        Thu,  8 Nov 2018 08:10:29 -0800 (PST)
Subject: Re: [PATCH 13/36] dt-bindings: arm: Convert PMU binding to
 json-schema
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Kumar Gala <kumar.gala@linaro.org>,
        Grant Likely <glikely@secretlab.ca>,
        Arnd Bergmann <arnd@arndb.de>, Tom Rini <trini@konsulko.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-14-robh@kernel.org> <20181009115713.GE6248@arm.com>
 <CAL_JsqJh08wZCyGxg7HMbtKjOJTZKMoQcNOB_hPuSfJKQQK8JA@mail.gmail.com>
 <08738708-1c38-fab7-eb34-694e5f4d4b7e@arm.com>
 <20181108165940.64ad52f1@windsurf>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8eb3b6e5-6dc4-491f-5988-d9cb2031054d@arm.com>
Date:   Thu, 8 Nov 2018 16:10:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181108165940.64ad52f1@windsurf>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2018 15:59, Thomas Petazzoni wrote:
> Hello,
> 
> I'm jumping into the discussion, but I clearly don't have all the
> context of the discussion.
> 
> On Thu, 8 Nov 2018 15:54:31 +0000, Robin Murphy wrote:
> 
>>>> This seems like a semantic different between the two representations, or am
>>>> I missing something here? Specifically, both the introduction of
>>>> interrupts-extended and also dropping any mention of using a single per-cpu
>>>> interrupt (the single combined case is no longer support by Linux; not sure
>>>> if you want to keep it in the binding).
>>>
>>> In regards to no support for the single combined interrupt, it looks
>>> like Marvell Armada SoCs at least (armada-375 is what I'm looking at)
>>> have only a single interrupt. Though the interrupt gets routed to MPIC
>>> which then has a GIC PPI. So it isn't supported or happens to work
>>> still since it is a PPI?
>>
>> Well, the description of the MPIC in the Armada XP functional spec says:
>>
>> "Interrupt sources ID0–ID28 are private events per CPU. Thus, each
>> processor has a different set of events map interrupts ID0–ID28."
>>
>> Odd grammar aside, that would seem to imply that <&mpic 3> is a per-cpu
>> interrupt itself, thus AFAICS so long as it's cascaded to a GIC PPI and
>> not an SPI then there's no issue there.
> 
> The Armada XP does not have a GIC at all, but only a MPIC as the
> primary interrupt controller.
> 
> However the Armada 38x has both a GIC and a MPIC, and indeed the parent
> interrupts of the MPIC towards the GIC is:
> 
> 	interrupts = <GIC_PPI 15 IRQ_TYPE_LEVEL_HIGH>;

Yeah, perhaps I should have clarified that the XP manual was the only 
publicly-available one I could find, but I'm inferring from the binding 
and driver that the MPIC in 375/38x still behaves the same.

Robin.
