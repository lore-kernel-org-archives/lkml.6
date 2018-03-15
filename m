Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752662AbeCOOxO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 10:53:14 -0400
Received: from www62.your-server.de ([213.133.104.62]:46131 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752293AbeCOOxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 10:53:12 -0400
Subject: Re: [PATCH] net: dev_forward_skb(): Scrub packet's per-netns info
 only when crossing netns
To: Roman Mashak <mrv@mojatatu.com>, Liran Alon <liran.alon@oracle.com>
Cc: netdev@vger.kernel.org, shmulik.ladkani@gmail.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, yuval.shaia@oracle.com,
        idan.brown@oracle.com
References: <be0d17cf-12d5-440c-adee-e943ccb199c9@default>
 <85woydh0e9.fsf@mojatatu.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <b351511b-664a-cd99-6777-fdec3d12685a@iogearbox.net>
Date: Thu, 15 Mar 2018 15:53:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <85woydh0e9.fsf@mojatatu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/15/2018 03:35 PM, Roman Mashak wrote:
> Liran Alon <liran.alon@oracle.com> writes:
> [...]
>>> Overall I think it might be nice to not need scrubbing skb in such
>>> cases,
>>> although my concern would be that this has potential to break
>>> existing
>>> setups when they would expect mark being zero on other veth peer in
>>> any
>>> case since it's the behavior for a long time already. The safer
>>> option
>>> would be to have some sort of explicit opt-in e.g. on link creation to
>>> let
>>> the skb->mark pass through unscrubbed. This would definitely be a
>>> useful
>>> option e.g. when mark is set in the netns facing veth via
>>> clsact/egress
>>> on xmit and when the container is unprivileged anyway.
>>>
>>> Thanks,
>>> Daniel
>>
>> I see your point in regards to backwards comparability.
>> However, not scrubbing skb when it cross netns via some kernel functions compared to
>> others is basically a bug which could easily break with a little bit of more refactoring.
>> Therefore, it seems a bit weird to me to from now on, we will force
>> every user on link creation to consider that once there was a bug leading
>> to this weird behavior on specific netdevs.

Why bug specifically? It could well be that for some unpriv containers
it would be fine to do e.g. in cases where orchestrator sets up clsact/
egress on veth/ipvlan/etc in the container to set the mark and where app
cannot mess with this while for others you need to act out of host facing
veth; thus, explicit opt-in per dev could provide such more fine grained
control.

> One valid use case could be preserving a source namespace nsid in
> skb->mark when a packet crosses netns.

Right, was thinking about something similar.
