Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D70F2C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9728F208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9728F208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756053AbeFOIQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 04:16:10 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39578 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756029AbeFOIQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 04:16:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CC3580D;
        Fri, 15 Jun 2018 01:16:05 -0700 (PDT)
Received: from [10.1.206.75] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D444A3F557;
        Fri, 15 Jun 2018 01:16:03 -0700 (PDT)
Subject: Re: [RFC PATCH] irqchip/gic-v3: Add quirk for msm8996 secured
 registers
To:     Stephen Boyd <sboyd@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        jason@lakedaemon.net, sudeep.holla@arm.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        nicolas.dechesne@linaro.org
References: <20180613114340.32550-1-srinivas.kandagatla@linaro.org>
 <2d866cd1-59a4-befb-b2de-b91f9e56804a@arm.com>
 <98209e4e-96b3-3baf-3f21-a57dc8447850@linaro.org>
 <152900843159.16708.3190914824253841690@swboyd.mtv.corp.google.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <61229c8f-7de0-a798-5af4-ba5e0ea78001@arm.com>
Date:   Fri, 15 Jun 2018 09:16:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <152900843159.16708.3190914824253841690@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/18 21:33, Stephen Boyd wrote:
> Quoting Srinivas Kandagatla (2018-06-14 10:54:43)
>>>
>>>> +{
>>>> +    struct gic_chip_data *d = data;
>>>> +
>>>> +    d->flags |= GICV3_FLAGS_WORKAROUND_IW_GICR_WAKER;
>>>> +
>>>> +    return true;
>>>> +}
>>>> +
>>>> +static const struct gic_quirk gicv3_quirks[] = {
>>>> +    {
>>>> +            .desc   = "GICV3: Qualcomm MSM8996 WAKER IW",
>>>
>>> Please the erratum number in the message. It should read something like:
>>>
>>>               "GICv3: Qualcomm erratum BIGNUMBERHERE"
>>>
>>>> +            .iidr   = 0x00001070,   /* MSM8996 */
>>>> +            .mask   = 0x0000ffff,
>>>
>>> Please match the full GICD_IIDR register, not just the implementer and
>>> the revision. Unless you expect all the QC systems to have the same
>>> behaviour?
>> There seems to be more than one SoC that has this issue,  I will dig up 
>> more info before sending next version.
>>
> 
> It depends on the firmware and if that firmware decides to block or
> allow access to this register space. I don't see how it can be quirked
> based on the IIDR at all because there could be different firmware on
> the board that doesn't block access to the register. Can a DT property
> work?

Are you saying that the IIDR doesn't isn't unique per implementation of
the firmware (which, as far as the kernel is concerned in this case,
implements the GIC)? That would be another erratum. If we did change the
behaviour of the vGIC in KVM, we'd certainly change the IIDR value! This
is the exact same case.

Whoever thought this was a good idea shouldn't be allowed near a
compiler. They clearly are clueless.

As for a DT property, I can't see how this allows us to move forward.
Firmware could get updated at any point, and the DT would be just as wrong.

	M.
-- 
Jazz is not dead. It just smells funny...
