Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id VNL0DSslGluHcQAAmS7hNA
	; Fri, 08 Jun 2018 06:41:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 253C66089E; Fri,  8 Jun 2018 06:41:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 96914607A4;
	Fri,  8 Jun 2018 06:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 96914607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752186AbeFHGlo (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 02:41:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:33006 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751079AbeFHGlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 02:41:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 35CEDAEC4;
        Fri,  8 Jun 2018 06:41:37 +0000 (UTC)
Subject: Re: Do Qualcomm drivers use DMA buffers for
 request_firmware_into_buf()?
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Will Deacon <will.deacon@arm.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Brown <david.brown@linaro.org>,
        Peter Jones <pjones@redhat.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Nicolas Broeking <nbroeking@me.com>,
        Jonathan Corbet <corbet@lwn.net>,
        the arch/x86 maintainers <x86@kernel.org>,
        Arve Hj?nnev?g <arve@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Todd Kjos <tkjos@android.com>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        linux-arm-msm@vger.kernel.org, Torsten Duwe <duwe@suse.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Chris Wright <chrisw@sous-sol.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        platform-driver-x86@vger.kernel.org,
        Martijn Coenen <maco@android.com>,
        Alan Cox <alan@linux.intel.com>,
        Martin Fuzzey <mfuzzey@parkeon.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Vikram Mulukutla <markivx@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Dave Olsthoorn <dave@bewaar.me>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@infradead.org>
References: <1524586021.3364.20.camel@linux.vnet.ibm.com>
 <20180424234219.GX14440@wotan.suse.de>
 <1524632409.3371.48.camel@linux.vnet.ibm.com>
 <20180425175557.GY14440@wotan.suse.de>
 <CAB0TPYGnCu+anWHBGvkaigxD--8uHQaQJ2c62kegJ7mTqvkmnA@mail.gmail.com>
 <20180508153805.GC27853@wotan.suse.de> <20180601192346.GQ4511@wotan.suse.de>
 <20180606203257.GH4511@wotan.suse.de> <20180607161847.GN510@tuxbook-pro>
 <CAKv+Gu8+Fq7BD4XD-YCyXzZh0mg6Z2k-0styj0cw6_uZfaqy4Q@mail.gmail.com>
 <20180607163308.GA18834@kroah.com>
From: Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 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
 cqmP8roqufIAj+Ohhzs=
Message-ID: <39e942b6-795c-b7c8-bf9d-16907ef40aea@suse.cz>
Date: Fri, 8 Jun 2018 08:41:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180607163308.GA18834@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2018 06:33 PM, Greg Kroah-Hartman wrote:
> On Thu, Jun 07, 2018 at 06:23:01PM +0200, Ard Biesheuvel wrote:
>> On 7 June 2018 at 18:18, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
>>> On Wed 06 Jun 13:32 PDT 2018, Luis R. Rodriguez wrote:
>>>
>>>> On Fri, Jun 01, 2018 at 09:23:46PM +0200, Luis R. Rodriguez wrote:
>>>>> On Tue, May 08, 2018 at 03:38:05PM +0000, Luis R. Rodriguez wrote:
>>>>>> On Fri, May 04, 2018 at 12:44:37PM -0700, Martijn Coenen wrote:
>>>>>>>
>>>>>>> I think the Qualcomm folks owning this (Andy, David, Bjorn, already
>>>>>>> cc'd here) are better suited to answer that question.
>>>>>>
>>>>>> Andy, David, Bjorn?
>>>>>
>>>>> Andy, David, Bjorn?
>>>>
>>>> A month now with no answer...
>>>>
>>>
>>> The patch at the top of this thread doesn't interest me and you didn't
>>> bother sending your question To me.
>>>
>>> As a matter of fact I'm confused to what the actual question is.
>>>
>>
>> The actual question is whether it is really required that the firmware
>> is loaded by the kernel into a buffer that is already mapped for DMA
>> at that point, and thus accessible by the device.
>>
>> To me, it is not entirely clear what the nature is of the firmware
>> that we are talking about, since it seems to be getting passed to the
>> secure world as well?
>>
>> In any case, the preferred model in terms of validation/sig checking is
>>
>> 1) allocate a CPU accessible buffer
>>
>> 2) request the firmware into it (which may include a sig check under the hood)
>>
>> 3) map the buffer for DMA to the device so it can load the firmware.
>>
>> 4) kick off the DMA transfer.
>>
>> The use of dma_alloc_coherent() for this purpose seems unnecessary,
>> given that the DMA transfer is not bidirectional. Would it be possible
>> to replace it with something like the above sequence?
> 
> Why not just use kmalloc, it will always return a DMAable buffer.

DMAble in what sense? For devices that can't handle physical addresses
above 16M you need to pass __GFP_DMA to get those, from ZONE_DMA.
Otherwise it can return anything from lowmem. That's for x86_64, some
other arches have different DMA zone.

> Is the problem that vmalloc() might not?

vmalloc() could only be used as an alternative if you used kvmalloc(),
otherwise kmalloc() won't give you anything from vmalloc

> We need to drop the whole DMA zone crud, it confuses everyone who sees
> it and was primarily for really really old systems.

Yeah that would be nice.

> greg k-h
> 
