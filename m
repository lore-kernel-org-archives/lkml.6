Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751779AbeDYJEm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 05:04:42 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:42799 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbeDYJEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 05:04:39 -0400
X-Google-Smtp-Source: AB8JxZrp8hnQyVXcfEv0kIAuIHb/lAH5VrsASBxB7vZx+Lpj802YJn2ejhCMHr4RDFWxF0mgpLuqFQ==
Subject: Re: [PATCH v2 3/5] ALSA: xen-front: Implement Xen event channel
 handling
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, perex@perex.cz,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180416062453.24743-1-andr2000@gmail.com>
 <20180416062453.24743-4-andr2000@gmail.com> <s5ho9i8sn25.wl-tiwai@suse.de>
 <af277f77-5b22-58e3-4ea6-cde34e3181d3@gmail.com>
 <s5hlgdcsmdm.wl-tiwai@suse.de>
 <f37a8eb9-8733-eae9-4c3e-312d864592fc@gmail.com>
 <s5h604gsl44.wl-tiwai@suse.de>
 <a8d3c2d2-25ec-0dc1-c26c-20eb6fbb4e3e@gmail.com>
 <04e313e5-4fdb-9f7b-43e3-f1551f582db2@gmail.com>
 <s5hpo2nveu8.wl-tiwai@suse.de>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <72af8fdb-586f-6c5c-72af-071682ceab7d@gmail.com>
Date: Wed, 25 Apr 2018 12:04:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <s5hpo2nveu8.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/25/2018 12:02 PM, Takashi Iwai wrote:
> On Wed, 25 Apr 2018 10:26:34 +0200,
> Oleksandr Andrushchenko wrote:
>> On 04/24/2018 07:23 PM, Oleksandr Andrushchenko wrote:
>>> On 04/24/2018 06:02 PM, Takashi Iwai wrote:
>>>> On Tue, 24 Apr 2018 16:58:43 +0200,
>>>> Oleksandr Andrushchenko wrote:
>>>>> On 04/24/2018 05:35 PM, Takashi Iwai wrote:
>>>>>> On Tue, 24 Apr 2018 16:29:15 +0200,
>>>>>> Oleksandr Andrushchenko wrote:
>>>>>>> On 04/24/2018 05:20 PM, Takashi Iwai wrote:
>>>>>>>> On Mon, 16 Apr 2018 08:24:51 +0200,
>>>>>>>> Oleksandr Andrushchenko wrote:
>>>>>>>>> +static irqreturn_t evtchnl_interrupt_req(int irq, void *dev_id)
>>>>>>>>> +{
>>>>>>>>> +    struct xen_snd_front_evtchnl *channel = dev_id;
>>>>>>>>> +    struct xen_snd_front_info *front_info = channel->front_info;
>>>>>>>>> +    struct xensnd_resp *resp;
>>>>>>>>> +    RING_IDX i, rp;
>>>>>>>>> +    unsigned long flags;
>>>>>>>>> +
>>>>>>>>> +    if (unlikely(channel->state != EVTCHNL_STATE_CONNECTED))
>>>>>>>>> +        return IRQ_HANDLED;
>>>>>>>>> +
>>>>>>>>> +    spin_lock_irqsave(&front_info->io_lock, flags);
>>>>>>>>> +
>>>>>>>>> +again:
>>>>>>>>> +    rp = channel->u.req.ring.sring->rsp_prod;
>>>>>>>>> +    /* ensure we see queued responses up to rp */
>>>>>>>>> +    rmb();
>>>>>>>>> +
>>>>>>>>> +    for (i = channel->u.req.ring.rsp_cons; i != rp; i++) {
>>>>>>>> I'm not familiar with Xen stuff in general, but through a quick
>>>>>>>> glance, this kind of code worries me a bit.
>>>>>>>>
>>>>>>>> If channel->u.req.ring.rsp_cons has a bogus number, this may
>>>>>>>> lead to a
>>>>>>>> very long loop, no?  Better to have a sanity check of the ring
>>>>>>>> buffer
>>>>>>>> size.
>>>>>>> In this loop I have:
>>>>>>> resp = RING_GET_RESPONSE(&channel->u.req.ring, i);
>>>>>>> and the RING_GET_RESPONSE macro is designed in the way that
>>>>>>> it wraps around when *i* in the question gets bigger than
>>>>>>> the ring size:
>>>>>>>
>>>>>>> #define RING_GET_REQUEST(_r, _idx)                    \
>>>>>>>        (&((_r)->sring->ring[((_idx) & (RING_SIZE(_r) - 1))].req))
>>>>>>>
>>>>>>> So, even if the counter has a bogus number it will not last long
>>>>>> Hm, this prevents from accessing outside the ring buffer, but does it
>>>>>> change the loop behavior?
>>>>> no, it doesn't
>>>>>> Suppose channel->u.req.ring_rsp_cons = 1, and rp = 0, the loop below
>>>>>> would still consume the whole 32bit counts, no?
>>>>>>
>>>>>>      for (i = channel->u.req.ring.rsp_cons; i != rp; i++) {
>>>>>>          resp = RING_GET_RESPONSE(&channel->u.req.ring, i);
>>>>>>          ...
>>>>>>      }
>>>>> You are right here and the comment is totally valid.
>>>>> I'll put an additional check like here [1] and here [2]
>>>>> Will this address your comment?
>>>> Yep, this kind of sanity checks should work.
>>>>
>>> Great, will implement the checks this way then
>> Well, after thinking a bit more on that and chatting on #xendevel IRC
>> with Juergen (he is on CC list), it seems that the way the code is now
>> it is all fine without the checks: the assumption here is that
>> the backend is trusted to always write sane values to the ring counters,
>> thus no overflow checks on frontend side are required.
>> Even if I implement the checks then I have no means to recover, but
>> just print
>> an error message and bail out not handling any responses.
>> This is probably why the checks [1] and [2] are only implemented for the
>> backend side and there are no such macros for the frontend side.
>>
>> Takashi, please let me know if the above sounds reasonable and
>> addresses your comments.
> If it's guaranteed to work, that's OK.
> But maybe it's worth to comment for readers.
ok, will put a comment on that
>
> thanks,
>
> Takashi
Thank you,
Oleksandr
