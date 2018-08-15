Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3A1C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 07:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0471216E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 07:04:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0471216E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbeHOJzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 05:55:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55210 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726135AbeHOJzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 05:55:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7080D7A7E8;
        Wed, 15 Aug 2018 07:04:46 +0000 (UTC)
Received: from [10.72.12.27] (ovpn-12-27.pek2.redhat.com [10.72.12.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C1C11012331;
        Wed, 15 Aug 2018 07:04:39 +0000 (UTC)
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
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <0809cbab-9c91-52f1-2abe-124a255d9304@redhat.com>
Date:   Wed, 15 Aug 2018 15:04:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180815053550.5g4f5qeb7r4wtgm5@ast-mbp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 15 Aug 2018 07:04:46 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 15 Aug 2018 07:04:46 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年08月15日 13:35, Alexei Starovoitov wrote:
> On Wed, Aug 15, 2018 at 08:29:45AM +0800, Jason Wang wrote:
>> Looks less flexible since the topology is hard coded in the XDP program
>> itself and this requires all logic to be implemented in the program on the
>> root netdev.
>>
>>> I have L3 forwarding working for vlan devices and bonds. I had not
>>> considered macvlans specifically yet, but it should be straightforward
>>> to add.
>>>
>> Yes, and all these could be done through XDP rx handler as well, and it can
>> do even more with rather simple logic:
>>
>> 1 macvlan has its own namespace, and want its own bpf logic.
>> 2 Ruse the exist topology information for dealing with more complex setup
>> like macvlan on top of bond and team. There's no need to bpf program to care
>> about topology. If you look at the code, there's even no need to attach XDP
>> on each stacked device. The calling of xdp_do_pass() can try to pass XDP
>> buff to upper device even if there's no XDP program attached to current
>> layer.
>> 3 Deliver XDP buff to userspace through macvtap.
> I think I'm getting what you're trying to achieve.
> You actually don't want any bpf programs in there at all.
> You want macvlan builtin logic to act on raw packet frames.

The built-in logic is just used to find the destination macvlan device. 
It could be done by through another bpf program. Instead of inventing 
lots of generic infrastructure on kernel with specific userspace API, 
built-in logic has its own advantages:

- support hundreds or even thousands of macvlans
- using exist tools to configure network
- immunity to topology changes

> It would have been less confusing if you said so from the beginning.

The name "XDP rx handler" is probably not good. Something like "stacked 
deivce XDP" might be better.

> I think there is little value in such work, since something still
> needs to process this raw frames eventually. If it's XDP with BPF progs
> than they can maintain the speed, but in such case there is no need
> for macvlan. The first layer can be normal xdp+bpf+xdp_redirect just fine.

I'm a little bit confused. We allow per veth XDP program, so I believe 
per macvlan XDP program makes sense as well? This allows great 
flexibility and there's no need to care about topology in bpf program. 
The configuration is also greatly simplified. The only difference is we 
can use xdp_redirect for veth since it was pair device, we can transmit 
XDP frames to one veth and do XDP on its peer. This does not work for 
the case of macvlan which is based on rx handler.

Actually, for the case of veth, if we implement XDP rx handler for 
bridge it can works seamlessly with veth like.

eth0(XDP_PASS) -> [bridge XDP rx handler and ndo_xdp_xmit()] -> veth --- 
veth (XDP).

Besides the usage for containers, we can implement macvtap RX handler 
which allows a fast packet forwarding to userspace.

> In case where there is no xdp+bpf in final processing, the frames are
> converted to skb and performance is lost, so in such cases there is no
> need for builtin macvlan acting on raw xdp frames either. Just keep
> existing macvlan acting on skbs.
>

Yes, this is how veth works as well.

Actually, the idea is not limited to macvlan but for all device that is 
based on rx handler. Consider the case of bonding, this allows to set a 
very simple XDP program on slaves and keep a single main logic XDP 
program on the bond instead of duplicating it in all slaves.

Thanks
