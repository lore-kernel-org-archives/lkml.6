Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE43CC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07FE218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731809AbfAaJxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:53:46 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40754 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbfAaJxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:53:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 644B5A78;
        Thu, 31 Jan 2019 01:53:45 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 381223F71E;
        Thu, 31 Jan 2019 01:53:42 -0800 (PST)
Subject: Re: [PATCH v9 01/26] arm64: Fix HCR.TGE status for NMI contexts
To:     Julien Thierry <julien.thierry@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>
Cc:     James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        daniel.thompson@linaro.org, joel@joelfernandes.org,
        catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        stable@vger.kernel.org
References: <1548084825-8803-1-git-send-email-julien.thierry@arm.com>
 <1548084825-8803-2-git-send-email-julien.thierry@arm.com>
 <8e8c4f5b-5b83-7bbc-1b84-36d68e210968@arm.com>
 <847c54ef-ea41-eea5-8aff-72e0cea465f8@arm.com>
 <20190131081900.GM13482@e113682-lin.lund.arm.com>
 <32af4a5c-7aeb-0171-1b4a-2cbee5f78bca@arm.com>
 <20190131092706.GN13482@e113682-lin.lund.arm.com>
 <7a2c92ca-f0eb-1391-4dc4-005e1dbadc30@arm.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <3814b7ff-8d78-5f47-6eef-1b4e9bd7fd46@arm.com>
Date:   Thu, 31 Jan 2019 09:53:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <7a2c92ca-f0eb-1391-4dc4-005e1dbadc30@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2019 09:40, Julien Thierry wrote:
> 
> 
> On 31/01/2019 09:27, Christoffer Dall wrote:
>> On Thu, Jan 31, 2019 at 08:56:04AM +0000, Julien Thierry wrote:
>>>
>>>
>>> On 31/01/2019 08:19, Christoffer Dall wrote:
>>>> On Mon, Jan 28, 2019 at 03:42:42PM +0000, Julien Thierry wrote:
>>>>> Hi James,
>>>>>
>>>>> On 28/01/2019 11:48, James Morse wrote:
>>>>>> Hi Julien,
>>>>>>
>>>>>> On 21/01/2019 15:33, Julien Thierry wrote:
>>>>>>> When using VHE, the host needs to clear HCR_EL2.TGE bit in order
>>>>>>> to interract with guest TLBs, switching from EL2&0 translation regime
>>>>>>
>>>>>> (interact)
>>>>>>
>>>>>>
>>>>>>> to EL1&0.
>>>>>>>
>>>>>>> However, some non-maskable asynchronous event could happen while TGE is
>>>>>>> cleared like SDEI. Because of this address translation operations
>>>>>>> relying on EL2&0 translation regime could fail (tlb invalidation,
>>>>>>> userspace access, ...).
>>>>>>>
>>>>>>> Fix this by properly setting HCR_EL2.TGE when entering NMI context and
>>>>>>> clear it if necessary when returning to the interrupted context.
>>>>>>
>>>>>> Yes please. This would not have been fun to debug!
>>>>>>
>>>>>> Reviewed-by: James Morse <james.morse@arm.com>
>>>>>>
>>>>>>
>>>>>
>>>>> Thanks.
>>>>>
>>>>>>
>>>>>> I was looking for why we need core code to do this, instead of updating the
>>>>>> arch's call sites. Your 'irqdesc: Add domain handlers for NMIs' patch (pointed
>>>>>> to from the cover letter) is the reason: core-code calls nmi_enter()/nmi_exit()
>>>>>> itself.
>>>>>>
>>>>>
>>>>> Yes, that's the main reason.
>>>>>
>>>> I wondered the same thing, but I don't understand the explanation :(
>>>>
>>>> Why can't we do a local_daif_mask() around the (very small) calls that
>>>> clear TGE instead?
>>>>
>>>
>>> That would protect against the pseudo-NMIs, but you can still get an
>>> SDEI at that point even with all daif bits set. Or did I misunderstand
>>> how SDEI works?
>>>
>>
>> I don't know the details of SDEI.  From looking at this patch, the
>> logical conclusion would be that SDEIs can then only be delivered once
>> we've called nmi_enter, but since we don't call this directly from the
>> code that clears TGE for doing guest TLB invalidation (or do we?) then
>> masking interrupts at the PSTATE level should be sufficient.
>>
>> Surely I'm missing some part of the bigger picture here.
>>
> 
> I'm not sure I understand. SDEI uses the NMI context and AFAIU, it is an
> interrupt that the firmware sends to the OS, and it is sent regardless
> of the PSTATE at the OS EL.

I don't think we can describe SDEI as an interrupt. It is not even an
exception. It is just EL3 ERET-ing to a pre-defined location. And yes,
it will completely ignore any form of mask bit.

> 
> So, the worrying part is:
> - Hyp clears TGE
> - Exception/interrupt taken to EL3
> - Firmware decides it's a good time to send an SDEI to the OS
> - SDEI handler (at EL2 for VHE) does nmi_enter()
> - SDEI handler needs to do cache invalidation or something with the
> EL2&0 translation regime but TGE is cleared
> 
> We don't expect the code that clears TGE to call nmi_enter().

Indeed. Without this patch, SDEI is already broken. Pseudo-NMIs only
make the bug easier to trigger.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
