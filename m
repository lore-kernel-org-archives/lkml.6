Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932407AbeCOPNo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:13:44 -0400
Received: from www62.your-server.de ([213.133.104.62]:48965 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752761AbeCOPNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:13:43 -0400
Subject: Re: [PATCH] net: dev_forward_skb(): Scrub packet's per-netns info
 only when crossing netns
To: Shmulik Ladkani <shmulik.ladkani@gmail.com>
Cc: Liran Alon <liran.alon@oracle.com>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        idan.brown@oracle.com, Yuval Shaia <yuval.shaia@oracle.com>
References: <1520953642-8145-1-git-send-email-liran.alon@oracle.com>
 <20180315112150.58586758@halley>
 <a673c689-ec30-61f6-9238-6b1773788201@iogearbox.net>
 <20180315145038.16df4fea@halley>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <cd0b73e3-2cde-1442-4312-566c69571e8a@iogearbox.net>
Date: Thu, 15 Mar 2018 16:13:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180315145038.16df4fea@halley>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/15/2018 01:50 PM, Shmulik Ladkani wrote:
> On Thu, 15 Mar 2018 12:56:13 +0100 Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 03/15/2018 10:21 AM, Shmulik Ladkani wrote:
>>>
>>> Regarding veth xmit, it does makes sense to preserve the fields if not
>>> crossing netns. This is also the case when one uses tc mirred.
>>>
>>> Regarding bpf redirect, well, it depends on the expectations of each bpf
>>> program.
>>> I'd argue that preserving the fields (at least the mark field) in the
>>> *non* xnet makes sense and provides more information and therefore more
>>> capabilities; Alas this might change behavior already being relied on.
>>>
>>> Maybe Daniel can comment on the matter.  
>>
>> Overall I think it might be nice to not need scrubbing skb in such cases,
>> although my concern would be that this has potential to break existing
>> setups when they would expect mark being zero on other veth peer in any
>> case since it's the behavior for a long time already. The safer option
>> would be to have some sort of explicit opt-in e.g. on link creation to let
>> the skb->mark pass through unscrubbed. This would definitely be a useful
>> option e.g. when mark is set in the netns facing veth via clsact/egress
>> on xmit and when the container is unprivileged anyway.
> 
> For the veth xmit case, an opt-in flag which disables mark scrubbing in
> the *non* xnet veth-pair seems reasonable.
> 
> But what about bpf_redirect BPF_F_INGRESS, in setups not invovling
> containers?
> Currently bpf_redirect is implemented using dev_forward_skb which
> *fully* scrubs the skb, even if the target device is on same netns as
> skb->dev is.
> 
> One might use ebpf programs that perform BPF_F_INGRESS bpf_redirect, for
> example for demuxing skbs arriving on some "master" device into various
> "slave" devices using specialized critiria.
> 
> It would be beneficial to have the mark preserved when skb is injected
> to the slave device's rx path (especially when it's on the same netns).

Right, I think also here the easiest would be to have a BPF_F_PRESERVE_MARK
flag to opt-in in general case (xnet/non-xnet) and where helper bails out
on unknown flag, but also for the redirect in the same netns I think it would
be useful to have a similar redirect mode as in ipvlan master where instead
of dev_forward_skb() you would set the skb->dev = dev and have a similar
notion of RX_HANDLER_ANOTHER. Was thinking about the latter more recently
but haven't gotten to implement it yet.

> Liran's patch fixes this - but at the cost of changing existing behavior
> for BPF_F_INGRESS users (formerly: fully scrubbed; post patch: scrubbed
> only if xnet).
> 
> I wonder, do you know of implementations that actually RELY on the fact
> that BPF_F_INGRESS actually clears the mark, in the *non* xnet case?

Not that I'm aware of right now, but hard to tell what other people run
in the wild.

But lets presume for a sec you would _not_ scrub it, then how are users
supposed to make use of this? The feature/bug may not be critical enough
(well, otherwise it wouldn't have been like this for long time) for stable,
so to write an app relying on it the behavior will change from kernel A to
kernel B, where you need to end up having a full blown veth run-time test
in order to figure it out before you can use it, not really useful either.

Thanks,
Daniel
