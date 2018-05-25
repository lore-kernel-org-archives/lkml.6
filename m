Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934295AbeEYNAO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 09:00:14 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:35437 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933152AbeEYNAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 09:00:11 -0400
X-Google-Smtp-Source: ADUXVKIfMZU+fvKsNSrH90XXXmu+0Nh8IKWE7BMxgf7ET5lSY27rWWNdqRcacN4m26l61gGX/PwtIQ==
Date: Fri, 25 May 2018 09:00:04 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Jonathan Cameron <jic23@kernel.org>, benjamin.gaignard@st.com,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 3/9] docs: Add Generic Counter interface documentation
Message-ID: <20180525130004.GA3751@sophia>
References: <cover.1526487615.git.vilhelm.gray@gmail.com>
 <aa4d62315bb11ddc66d0e1a685c81b1721ffe624.1526487615.git.vilhelm.gray@gmail.com>
 <20180520163109.22b11af8@archlinux>
 <20180521134729.GB5723@sophia>
 <20180522180805.2b61f0ed@archlinux>
 <cd045792-8ed2-8d83-231a-661975ffc7c5@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cd045792-8ed2-8d83-231a-661975ffc7c5@st.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 11:26:11AM +0200, Fabrice Gasnier wrote:
>On 05/22/2018 07:08 PM, Jonathan Cameron wrote:
>>>>> +* Quadrature x2 Rising:
>>>>> +  Rising edges on either quadrature pair signals updates the respective
>>>>> +  count. Quadrature encoding determines the direction.  
>>>> This one I've never met.  Really? There are devices who do this form
>>>> of crazy? It gives really uneven counting and I'm failing to see when
>>>> it would ever make sense...  References for these odd corner cases
>>>> would be good.
>>>>
>>>>
>>>> __|---|____|-----|____
>>>> ____|----|____|-----|____
>>>>
>>>> 001122222223334444444  
>>> That's the same reaction I had when I discovered this -- in fact the
>>> STM32 LP Timer is the first time I've come across such a quadrature
>>> mode. I'm not sure of the use case for this mode, because positioning
>>> wouldn't be precise as you've pointed out. Perhaps Fabrice or Benjamin
>>> can probe the ST guys responsible for this design choice to figure out
>>> the rationale.
>> Hmm.  My inclination would be to not support it unless someone can up
>> with a meaningful use.  We are adding ABI (be it not much) for a case
>> that to us makes no sense.
>
>Hi Jonathan, William,
>
>Sorry for the late reply. To follow your advise, we can probably drop
>this for now. I think simple counter, or quadrature x4 will be mostly
>used for now. As you pointed out, there's not much ABI for x2
>rising/falling cases. It will not be a big deal to add it later if needed.
>
>I can help to update (remove & test) this in LP-Timer counter driver if
>you wish.
>
>Please let me know,
>
>Thanks,
>Fabrice

All right, let's postpone the COUNT_FUNCTION_QUADRATURE_X2_RISING and
COUNT_FUNCTION_QUADRATURE_X2_FALLING modes for now. Fabrice, send me
over an update patch removing these modes from the LP-Timer counter
driver and I'll squash it in with the next patchset revision.

I'll keep the rest of the quadrature modes the same as they are used in
the other counter drivers as well (with the remaining "Quadrature x1 B"
staying to complete the pattern) and I've seen real world use cases for
each:

    * COUNT_FUNCTION_QUADRATURE_X1_A
    * COUNT_FUNCTION_QUADRATURE_X1_B
    * COUNT_FUNCTION_QUADRATURE_X2_A
    * COUNT_FUNCTION_QUADRATURE_X2_B

Adding support in the future for "Quadrature x2 Rising" and "Quadrature
x2 Falling" will be trivial, so really the main requirement in order to
bring these modes back is to provide reasonable use cases for them. My
suspicion is that there was some rationale for these Quadrature x2 modes
in the STM32 LP-Timer -- afterall, why else would the engineers go
through the trouble of designing and implementing it -- but until that
use case is clear, it's best to wait on changing the Generic Counter ABI
lest we end up with an interface that is never used in the real world.

William Breathitt Gray

>
>> 
>> Looks rather like the sort of thing that is a side effect of the
>> implementation rather than deliberate.
>> 
>>> I'm leaving in these modes for now, as they do exist in the STM32 LP
>>> Timer, but it does make me curious what the intentions for them were
>>> (perhaps use cases outside of traditional quadrature encoder
>>> positioning).
>>>
>> Sure if there is a usecase then fair enough.
>> 
>> Jonathan
>> 
>> 
