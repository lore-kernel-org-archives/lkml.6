Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33C8C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6883E21733
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6883E21733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732186AbeHNNEO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 09:04:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727858AbeHNNEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 09:04:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 999A6B5C6;
        Tue, 14 Aug 2018 10:17:42 +0000 (UTC)
Received: from localhost (ovpn-200-47.brq.redhat.com [10.40.200.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8A3E2156712;
        Tue, 14 Aug 2018 10:17:39 +0000 (UTC)
Date:   Tue, 14 Aug 2018 12:17:34 +0200
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, mst@redhat.com
Subject: Re: [RFC PATCH net-next V2 0/6] XDP rx handler
Message-ID: <20180814121734.105769fa@redhat.com>
In-Reply-To: <5de3d14f-f21a-c806-51f4-b5efd7d809b7@redhat.com>
References: <1534130250-5302-1-git-send-email-jasowang@redhat.com>
        <20180814003253.fkgl6lyklc7fclvq@ast-mbp>
        <5de3d14f-f21a-c806-51f4-b5efd7d809b7@redhat.com>
Organization: Red Hat Inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 14 Aug 2018 10:17:42 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 14 Aug 2018 10:17:42 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jbrouer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2018 15:59:01 +0800
Jason Wang <jasowang@redhat.com> wrote:

> On 2018年08月14日 08:32, Alexei Starovoitov wrote:
> > On Mon, Aug 13, 2018 at 11:17:24AM +0800, Jason Wang wrote:  
> >> Hi:
> >>
> >> This series tries to implement XDP support for rx hanlder. This would
> >> be useful for doing native XDP on stacked device like macvlan, bridge
> >> or even bond.
> >>
> >> The idea is simple, let stacked device register a XDP rx handler. And
> >> when driver return XDP_PASS, it will call a new helper xdp_do_pass()
> >> which will try to pass XDP buff to XDP rx handler directly. XDP rx
> >> handler may then decide how to proceed, it could consume the buff, ask
> >> driver to drop the packet or ask the driver to fallback to normal skb
> >> path.
> >>
> >> A sample XDP rx handler was implemented for macvlan. And virtio-net
> >> (mergeable buffer case) was converted to call xdp_do_pass() as an
> >> example. For ease comparision, generic XDP support for rx handler was
> >> also implemented.
> >>
> >> Compared to skb mode XDP on macvlan, native XDP on macvlan (XDP_DROP)
> >> shows about 83% improvement.  
> > I'm missing the motiviation for this.
> > It seems performance of such solution is ~1M packet per second.  
> 
> Notice it was measured by virtio-net which is kind of slow.
> 
> > What would be a real life use case for such feature ?  
> 
> I had another run on top of 10G mlx4 and macvlan:
> 
> XDP_DROP on mlx4: 14.0Mpps
> XDP_DROP on macvlan: 10.05Mpps
> 
> Perf shows macvlan_hash_lookup() and indirect call to 
> macvlan_handle_xdp() are the reasons for the number drop. I think the 
> numbers are acceptable. And we could try more optimizations on top.
> 
> So here's real life use case is trying to have an fast XDP path for rx 
> handler based device:
> 
> - For containers, we can run XDP for macvlan (~70% of wire speed). This 
> allows a container specific policy.
> - For VM, we can implement macvtap XDP rx handler on top. This allow us 
> to forward packet to VM without building skb in the setup of macvtap.
> - The idea could be used by other rx handler based device like bridge, 
> we may have a XDP fast forwarding path for bridge.
> 
> >
> > Another concern is that XDP users expect to get line rate performance
> > and native XDP delivers it. 'generic XDP' is a fallback only
> > mechanism to operate on NICs that don't have native XDP yet.  
> 
> So I can replace generic XDP TX routine with a native one for macvlan.

If you simply implement ndo_xdp_xmit() for macvlan, and instead use
XDP_REDIRECT, then we are basically done.


> > Toshiaki's veth XDP work fits XDP philosophy and allows
> > high speed networking to be done inside containers after veth.
> > It's trying to get to line rate inside container.  
> 
> This is one of the goal of this series as well. I agree veth XDP work 
> looks pretty fine, but it only work for a specific setup I believe since 
> it depends on XDP_REDIRECT which is supported by few drivers (and 
> there's no VF driver support). 

The XDP_REDIRECT (RX-side) is trivial to add to drivers.  It is a bad
argument that only a few drivers implement this.  Especially since all
drivers also need to be extended with your proposed xdp_do_pass() call.

(rant) The thing that is delaying XDP_REDIRECT adaption in drivers, is
that it is harder to implement the TX-side, as the ndo_xdp_xmit() call
have to allocate HW TX-queue resources.  If we disconnect RX and TX
side of redirect, then we can implement RX-side in an afternoon.


> And in order to make it work for a end 
> user, the XDP program still need logic like hash(map) lookup to 
> determine the destination veth.

That _is_ the general idea behind XDP and eBPF, that we need to add logic
that determine the destination.  The kernel provides the basic
mechanisms for moving/redirecting packets fast, and someone else
builds an orchestration tool like Cilium, that adds the needed logic.

Did you notice that we (Ahern) added bpf_fib_lookup a FIB route lookup
accessible from XDP.

For macvlan, I imagine that we could add a BPF helper that allows you
to lookup/call macvlan_hash_lookup().

 
> > This XDP rx handler stuff is destined to stay at 1Mpps speeds forever
> > and the users will get confused with forever slow modes of XDP.
> >
> > Please explain the problem you're trying to solve.
> > "look, here I can to XDP on top of macvlan" is not an explanation of the problem.
> >  


-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
