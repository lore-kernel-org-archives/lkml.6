Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7BEC46464
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 00:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8848C216F8
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 00:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8848C216F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbeHODTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 23:19:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53202 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726837AbeHODTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 23:19:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4056C40251BD;
        Wed, 15 Aug 2018 00:29:52 +0000 (UTC)
Received: from [10.72.12.27] (ovpn-12-27.pek2.redhat.com [10.72.12.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 919532156712;
        Wed, 15 Aug 2018 00:29:48 +0000 (UTC)
Subject: Re: [RFC PATCH net-next V2 0/6] XDP rx handler
To:     David Ahern <dsahern@gmail.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, mst@redhat.com
References: <1534130250-5302-1-git-send-email-jasowang@redhat.com>
 <20180814003253.fkgl6lyklc7fclvq@ast-mbp>
 <5de3d14f-f21a-c806-51f4-b5efd7d809b7@redhat.com>
 <20180814121734.105769fa@redhat.com>
 <03ab3b18-9b13-8169-7e68-ada307694bc1@redhat.com>
 <08bf7aec-078a-612d-833f-5b3d09a289d0@gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <aa9cf883-7822-70a7-5ab5-c873b69c2098@redhat.com>
Date:   Wed, 15 Aug 2018 08:29:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <08bf7aec-078a-612d-833f-5b3d09a289d0@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 15 Aug 2018 00:29:52 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 15 Aug 2018 00:29:52 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年08月14日 22:03, David Ahern wrote:
> On 8/14/18 7:20 AM, Jason Wang wrote:
>>
>> On 2018年08月14日 18:17, Jesper Dangaard Brouer wrote:
>>> On Tue, 14 Aug 2018 15:59:01 +0800
>>> Jason Wang <jasowang@redhat.com> wrote:
>>>
>>>> On 2018年08月14日 08:32, Alexei Starovoitov wrote:
>>>>> On Mon, Aug 13, 2018 at 11:17:24AM +0800, Jason Wang wrote:
>>>>>> Hi:
>>>>>>
>>>>>> This series tries to implement XDP support for rx hanlder. This would
>>>>>> be useful for doing native XDP on stacked device like macvlan, bridge
>>>>>> or even bond.
>>>>>>
>>>>>> The idea is simple, let stacked device register a XDP rx handler. And
>>>>>> when driver return XDP_PASS, it will call a new helper xdp_do_pass()
>>>>>> which will try to pass XDP buff to XDP rx handler directly. XDP rx
>>>>>> handler may then decide how to proceed, it could consume the buff, ask
>>>>>> driver to drop the packet or ask the driver to fallback to normal skb
>>>>>> path.
>>>>>>
>>>>>> A sample XDP rx handler was implemented for macvlan. And virtio-net
>>>>>> (mergeable buffer case) was converted to call xdp_do_pass() as an
>>>>>> example. For ease comparision, generic XDP support for rx handler was
>>>>>> also implemented.
>>>>>>
>>>>>> Compared to skb mode XDP on macvlan, native XDP on macvlan (XDP_DROP)
>>>>>> shows about 83% improvement.
>>>>> I'm missing the motiviation for this.
>>>>> It seems performance of such solution is ~1M packet per second.
>>>> Notice it was measured by virtio-net which is kind of slow.
>>>>
>>>>> What would be a real life use case for such feature ?
>>>> I had another run on top of 10G mlx4 and macvlan:
>>>>
>>>> XDP_DROP on mlx4: 14.0Mpps
>>>> XDP_DROP on macvlan: 10.05Mpps
>>>>
>>>> Perf shows macvlan_hash_lookup() and indirect call to
>>>> macvlan_handle_xdp() are the reasons for the number drop. I think the
>>>> numbers are acceptable. And we could try more optimizations on top.
>>>>
>>>> So here's real life use case is trying to have an fast XDP path for rx
>>>> handler based device:
>>>>
>>>> - For containers, we can run XDP for macvlan (~70% of wire speed). This
>>>> allows a container specific policy.
>>>> - For VM, we can implement macvtap XDP rx handler on top. This allow us
>>>> to forward packet to VM without building skb in the setup of macvtap.
>>>> - The idea could be used by other rx handler based device like bridge,
>>>> we may have a XDP fast forwarding path for bridge.
>>>>
>>>>> Another concern is that XDP users expect to get line rate performance
>>>>> and native XDP delivers it. 'generic XDP' is a fallback only
>>>>> mechanism to operate on NICs that don't have native XDP yet.
>>>> So I can replace generic XDP TX routine with a native one for macvlan.
>>> If you simply implement ndo_xdp_xmit() for macvlan, and instead use
>>> XDP_REDIRECT, then we are basically done.
>> As I replied in another thread this probably not true. Its
>> ndo_xdp_xmit() just need to call under layer device's ndo_xdp_xmit()
>> except for the case of bridge mode.
>>
>>>
>>>>> Toshiaki's veth XDP work fits XDP philosophy and allows
>>>>> high speed networking to be done inside containers after veth.
>>>>> It's trying to get to line rate inside container.
>>>> This is one of the goal of this series as well. I agree veth XDP work
>>>> looks pretty fine, but it only work for a specific setup I believe since
>>>> it depends on XDP_REDIRECT which is supported by few drivers (and
>>>> there's no VF driver support).
>>> The XDP_REDIRECT (RX-side) is trivial to add to drivers.  It is a bad
>>> argument that only a few drivers implement this.  Especially since all
>>> drivers also need to be extended with your proposed xdp_do_pass() call.
>>>
>>> (rant) The thing that is delaying XDP_REDIRECT adaption in drivers, is
>>> that it is harder to implement the TX-side, as the ndo_xdp_xmit() call
>>> have to allocate HW TX-queue resources.  If we disconnect RX and TX
>>> side of redirect, then we can implement RX-side in an afternoon.
>> That's exactly the point, ndo_xdp_xmit() may requires per CPU TX queues
>> which breaks assumptions of some drivers. And since we don't disconnect
>> RX and TX, it looks to me the partial implementation is even worse?
>> Consider a user can redirect from mlx4 to ixgbe but not ixgbe to mlx4.
>>
>>>
>>>> And in order to make it work for a end
>>>> user, the XDP program still need logic like hash(map) lookup to
>>>> determine the destination veth.
>>> That _is_ the general idea behind XDP and eBPF, that we need to add logic
>>> that determine the destination.  The kernel provides the basic
>>> mechanisms for moving/redirecting packets fast, and someone else
>>> builds an orchestration tool like Cilium, that adds the needed logic.
>> Yes, so my reply is for the concern about performance. I meant anyway
>> the hash lookup will make it not hit the wire speed.
>>
>>> Did you notice that we (Ahern) added bpf_fib_lookup a FIB route lookup
>>> accessible from XDP.
>> Yes.
>>
>>> For macvlan, I imagine that we could add a BPF helper that allows you
>>> to lookup/call macvlan_hash_lookup().
>> That's true but we still need a method to feed macvlan with XDP buff.
>> I'm not sure if this could be treated as another kind of redirection,
>> but ndo_xdp_xmit() could not be used for this case for sure. Compared to
>> redirection, XDP rx handler has its own advantages:
>>
>> 1) Use the exist API and userspace to setup the network topology instead
>> of inventing new tools and its own specific API. This means user can
>> just setup macvlan (macvtap, bridge or other) as usual and simply attach
>> XDP programs to both macvlan and its under layer device.
>> 2) Ease the processing of complex logic, XDP can not do cloning or
>> reference counting. We can differ those cases and let normal networking
>> stack to deal with such packets seamlessly. I believe this is one of the
>> advantage of XDP. This makes us to focus on the fast path and greatly
>> simplify the codes.
>>
>> Like ndo_xdp_xmit(), XDP rx handler is used to feed RX handler with XDP
>> buff. It's just another basic mechanism. Policy is still done by XDP
>> program itself.
>>
> I have been looking into handling stacked devices via lookup helper
> functions. The idea is that a program only needs to be installed on the
> root netdev (ie., the one representing the physical port), and it can
> use helpers to create an efficient pipeline to decide what to do with
> the packet in the presence of stacked devices.
>
> For example, anyone doing pure L3 could do:
>
> {port, vlan} --> [ find l2dev ] --> [ find l3dev ] ...
>
>    --> [ l3 forward lookup ] --> [ header rewrite ] --> XDP_REDIRECT
>
> port is the netdev associated with the ingress_ifindex in the xdp_md
> context, vlan is the vlan in the packet or the assigned PVID if
> relevant. From there l2dev could be a bond or bridge device for example,
> and l3dev is the one with a network address (vlan netdev, bond netdev, etc).

Looks less flexible since the topology is hard coded in the XDP program 
itself and this requires all logic to be implemented in the program on 
the root netdev.

>
> I have L3 forwarding working for vlan devices and bonds. I had not
> considered macvlans specifically yet, but it should be straightforward
> to add.
>

Yes, and all these could be done through XDP rx handler as well, and it 
can do even more with rather simple logic:

1 macvlan has its own namespace, and want its own bpf logic.
2 Ruse the exist topology information for dealing with more complex 
setup like macvlan on top of bond and team. There's no need to bpf 
program to care about topology. If you look at the code, there's even no 
need to attach XDP on each stacked device. The calling of xdp_do_pass() 
can try to pass XDP buff to upper device even if there's no XDP program 
attached to current layer.
3 Deliver XDP buff to userspace through macvtap.

Thanks
