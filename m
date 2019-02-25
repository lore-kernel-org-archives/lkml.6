Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89403C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F8E720663
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfBYOnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:43:17 -0500
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:51444 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726675AbfBYOnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:43:17 -0500
Received: from [IPv6:2001:983:e9a7:1:a04c:923e:654:ac91] ([IPv6:2001:983:e9a7:1:a04c:923e:654:ac91])
        by smtp-cloud7.xs4all.net with ESMTPA
        id yHTKgfG2qLMwIyHTLgKST1; Mon, 25 Feb 2019 15:43:15 +0100
Subject: Re: [Intel-gfx] BUG: KASAN: use-after-free in
 intel_hdmi_destroy+0x79/0x80
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
References: <dc22722f-a55c-6160-6485-a02f3bb91836@infradead.org>
 <87y364q924.fsf@intel.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <0df373d6-99e0-7509-1404-f3eadd9f23f7@xs4all.nl>
Date:   Mon, 25 Feb 2019 15:43:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <87y364q924.fsf@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNJfbF7BzJ+Bhm8NPj9iLOEiA6rOd2okRKnLvTNt0krWw7wBc6Plzx+0xDixbe0/Qm/h+Xqo9GaWgvqdjrDz/OHupXL4A3mkW8UmAIEqnRdTG/P1ftP3
 /5wtBkIHW5loHLY2MO1zHTs+Tx1keI1y5N+PlJC6sEb9J9F5BD1btUOcq7KL9tCH7+TKl47v8mcBaM6NdDkb5HYxrbGIsRx48Def31ArnpX9aLZPFA5FDBHJ
 AtcxJGECxKds0FhAXZPBcW+y9TEq1iuGXnVu9okkGsHFcL7A0S+eGmkDH/ycVa4Z8849eJUE8XUiQ1ntyeiRTuBkJJ08kt9kJIIs/nNFg9nDX5INuYzGGiyP
 VlIq8etWaHbOPxipTs4CZEuyCtKCnfhBbFdtw2tx6tBRadQV5EZboU5unmyY0VAgVLUfIiLfk6d02dmN5NCXj3O/YMqnQ5XtoxjDYFefpm+KpNJMISg2fL11
 VWj1sYRtnrjg8xYy
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jani,

On 2/25/19 2:40 PM, Jani Nikula wrote:
> On Fri, 22 Feb 2019, Randy Dunlap <rdunlap@infradead.org> wrote:
>> This is 5.0-rc7 on an old Toshiba Portege laptop.
>> No hdmi or other external video.
>>
>> Linux dragon.dunlab 5.0.0-rc7mod #3 SMP PREEMPT Wed Feb 20 00:05:17 PST 2019 x86_64 x86_64 x86_64 GNU/Linux
>>
>> on openSUSE LEAP 15.0 distro.
>>
>> Full boot log is attached.
> 
> On a hunch, caused by 9c229127aee2 ("drm/i915: hdmi: add CEC notifier to
> intel_hdmi") referencing the encoder in connector destroy hook. We
> should probably move the cec_notifier_put() call in the encoder destroy
> hook.

So the intel_encoder_destroy function is/can be called before the 
intel_hdmi_destroy function? Sounds odd. I would expect that the 
connectors are destroyed before the encoders.

In any case, I am happy to try it in another destroy hook, but I need
advice which hook I should use and how I get to the cec_notifier from
whatever structure pointer I have in that destroy hook.

I tried to figure it out, but I became very confused :-)

Regards,

	Hans
