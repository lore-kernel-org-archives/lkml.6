Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751216AbeDXQX6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 12:23:58 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41144 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeDXQX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 12:23:56 -0400
X-Google-Smtp-Source: AB8JxZq20XL7PoqaesH0U9hL8XipSHDDa70knyE0g1/KnpMLtYKBHGjOtH2ZbHaBTPb6sm9g1RhyFg==
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
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <a8d3c2d2-25ec-0dc1-c26c-20eb6fbb4e3e@gmail.com>
Date: Tue, 24 Apr 2018 19:23:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <s5h604gsl44.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/24/2018 06:02 PM, Takashi Iwai wrote:
> On Tue, 24 Apr 2018 16:58:43 +0200,
> Oleksandr Andrushchenko wrote:
>> On 04/24/2018 05:35 PM, Takashi Iwai wrote:
>>> On Tue, 24 Apr 2018 16:29:15 +0200,
>>> Oleksandr Andrushchenko wrote:
>>>> On 04/24/2018 05:20 PM, Takashi Iwai wrote:
>>>>> On Mon, 16 Apr 2018 08:24:51 +0200,
>>>>> Oleksandr Andrushchenko wrote:
>>>>>> +static irqreturn_t evtchnl_interrupt_req(int irq, void *dev_id)
>>>>>> +{
>>>>>> +	struct xen_snd_front_evtchnl *channel = dev_id;
>>>>>> +	struct xen_snd_front_info *front_info = channel->front_info;
>>>>>> +	struct xensnd_resp *resp;
>>>>>> +	RING_IDX i, rp;
>>>>>> +	unsigned long flags;
>>>>>> +
>>>>>> +	if (unlikely(channel->state != EVTCHNL_STATE_CONNECTED))
>>>>>> +		return IRQ_HANDLED;
>>>>>> +
>>>>>> +	spin_lock_irqsave(&front_info->io_lock, flags);
>>>>>> +
>>>>>> +again:
>>>>>> +	rp = channel->u.req.ring.sring->rsp_prod;
>>>>>> +	/* ensure we see queued responses up to rp */
>>>>>> +	rmb();
>>>>>> +
>>>>>> +	for (i = channel->u.req.ring.rsp_cons; i != rp; i++) {
>>>>> I'm not familiar with Xen stuff in general, but through a quick
>>>>> glance, this kind of code worries me a bit.
>>>>>
>>>>> If channel->u.req.ring.rsp_cons has a bogus number, this may lead to a
>>>>> very long loop, no?  Better to have a sanity check of the ring buffer
>>>>> size.
>>>> In this loop I have:
>>>> resp = RING_GET_RESPONSE(&channel->u.req.ring, i);
>>>> and the RING_GET_RESPONSE macro is designed in the way that
>>>> it wraps around when *i* in the question gets bigger than
>>>> the ring size:
>>>>
>>>> #define RING_GET_REQUEST(_r, _idx)                    \
>>>>       (&((_r)->sring->ring[((_idx) & (RING_SIZE(_r) - 1))].req))
>>>>
>>>> So, even if the counter has a bogus number it will not last long
>>> Hm, this prevents from accessing outside the ring buffer, but does it
>>> change the loop behavior?
>> no, it doesn't
>>> Suppose channel->u.req.ring_rsp_cons = 1, and rp = 0, the loop below
>>> would still consume the whole 32bit counts, no?
>>>
>>> 	for (i = channel->u.req.ring.rsp_cons; i != rp; i++) {
>>> 		resp = RING_GET_RESPONSE(&channel->u.req.ring, i);
>>> 		...
>>> 	}
>> You are right here and the comment is totally valid.
>> I'll put an additional check like here [1] and here [2]
>> Will this address your comment?
> Yep, this kind of sanity checks should work.
>
Great, will implement the checks this way then
> thanks,
>
> Takashi
Thank you,
Oleksandr
>>> Takashi
>> Thank you,
>> Oleksandr
>>
>> [1]
>> https://elixir.bootlin.com/linux/v4.17-rc2/source/drivers/block/xen-blkback/blkback.c#L1127
>> [2]
>> https://elixir.bootlin.com/linux/v4.17-rc2/source/drivers/block/xen-blkback/blkback.c#L1135
>>
