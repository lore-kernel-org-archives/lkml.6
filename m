Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00B3C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 04:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1744214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 04:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1744214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388112AbeHPHRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 03:17:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46976 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726072AbeHPHRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 03:17:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9188B410BC3F;
        Thu, 16 Aug 2018 04:21:27 +0000 (UTC)
Received: from [10.72.12.48] (ovpn-12-48.pek2.redhat.com [10.72.12.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A96E7C54;
        Thu, 16 Aug 2018 04:21:21 +0000 (UTC)
Subject: Re: [RFC PATCH net-next V2 0/6] XDP rx handler
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     David Ahern <dsahern@gmail.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, mst@redhat.com,
        Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
References: <1534130250-5302-1-git-send-email-jasowang@redhat.com>
 <20180814003253.fkgl6lyklc7fclvq@ast-mbp>
 <5de3d14f-f21a-c806-51f4-b5efd7d809b7@redhat.com>
 <20180814121734.105769fa@redhat.com>
 <03ab3b18-9b13-8169-7e68-ada307694bc1@redhat.com>
 <08bf7aec-078a-612d-833f-5b3d09a289d0@gmail.com>
 <aa9cf883-7822-70a7-5ab5-c873b69c2098@redhat.com>
 <20180815053550.5g4f5qeb7r4wtgm5@ast-mbp>
 <0809cbab-9c91-52f1-2abe-124a255d9304@redhat.com>
 <20180816024913.57ykirt7eqrjntfy@ast-mbp.dhcp.thefacebook.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <e459ee4a-7689-7b20-e2e3-c31944306396@redhat.com>
Date:   Thu, 16 Aug 2018 12:21:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180816024913.57ykirt7eqrjntfy@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 16 Aug 2018 04:21:27 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 16 Aug 2018 04:21:27 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年08月16日 10:49, Alexei Starovoitov wrote:
> On Wed, Aug 15, 2018 at 03:04:35PM +0800, Jason Wang wrote:
>>>> 3 Deliver XDP buff to userspace through macvtap.
>>> I think I'm getting what you're trying to achieve.
>>> You actually don't want any bpf programs in there at all.
>>> You want macvlan builtin logic to act on raw packet frames.
>> The built-in logic is just used to find the destination macvlan device. It
>> could be done by through another bpf program. Instead of inventing lots of
>> generic infrastructure on kernel with specific userspace API, built-in logic
>> has its own advantages:
>>
>> - support hundreds or even thousands of macvlans
> are you saying xdp bpf program cannot handle thousands macvlans?

Correct me if I was wrong. It works well when the macvlan requires 
similar logic. But let's consider the case when each macvlan wants its 
own specific logic. Is this possible to have thousands of different 
policies and actions in a single BPF program? With XDP rx hanlder, 
there's no need to root device to care about them. Each macvlan can only 
care about itself. This is similar to the case that qdisc could be 
attached to each stacked device.

>
>> - using exist tools to configure network
>> - immunity to topology changes
> what do you mean specifically?

Still the above example, if some macvlans is deleted or created. We need 
notify and update the policies in the root device, this requires 
userspace control program to monitor those changes and notify BPF 
program through maps. Unless the BPF program is designed for some 
specific configurations and setups, it would not be an easy task.

>
>> Besides the usage for containers, we can implement macvtap RX handler which
>> allows a fast packet forwarding to userspace.
> and try to reinvent af_xdp? the motivation for the patchset still escapes me.

Nope, macvtap was used for forwarding packets to VM. This is just try to 
deliver the XDP buff to VM instead of skb. Similar idea was used by 
TUN/TAP which shows amazing improvements.

>
>> Actually, the idea is not limited to macvlan but for all device that is
>> based on rx handler. Consider the case of bonding, this allows to set a very
>> simple XDP program on slaves and keep a single main logic XDP program on the
>> bond instead of duplicating it in all slaves.
> I think such mixed environment of hardcoded in-kernel things like bond
> mixed together with xdp programs will be difficult to manage and debug.
> How admin suppose to debug it?

Well, we've already had in-kernel XDP_TX routine. It should be not 
harder than that.

>   Say something in the chain of
> nic -> native xdp -> bond with your xdp rx -> veth -> xdp prog -> consumer
> is dropping a packet. If all forwarding decisions are done by bpf progs
> the progs will have packet tracing facility (like cilium does) to
> show packet flow end-to-end. It works briliantly like traceroute within a host.

Does this work well for veth pair as well? If yes, it should work for rx 
handler or maybe it has some hard code logic like "ok, the packet goes 
to veth, I'm sure it will be delivered to its peer"? The idea of this 
series is not forbidding the forwarding decisions done by bpf progs, if 
the code did this by accident, we can introduce flag to disable/enable 
XDP rx handler.

And I believe redirection is part of XDP usage, we may still want things 
like XDP_TX.

> But when you have things like macvlan, bond, bridge in the middle
> that can also act on packet, the admin will have a hard time.

I admit it may require admin help, but it gives us more flexibility.

>
> Essentially what you're proposing is to make all kernel builtin packet
> steering/forwarding facilities to understand raw xdp frames.

Probably not, at least for this series it just focus on rx handler. We 
only have less than 10 devices use that.

> That's a lot of code
> and at the end of the chain you'd need fast xdp frame consumer otherwise
> perf benefits are lost.

The performance are lost but still the same as skb. And except for 
redirection, we do have other consumer like XDP_TX.

>   If that consumer is xdp bpf program
> why bother with xdp-fied macvlan or bond?

For macvlan, we may want to have different polices for different 
devices. For bond, we don't want to duplicate XDP logic in each slaves, 
and only bond know which slave could be used for XDP_TX.

>   If that consumer is tcp stack
> than forwarding via xdp-fied bond is no faster than via skb-based bond.
>

Yes.

Thanks
