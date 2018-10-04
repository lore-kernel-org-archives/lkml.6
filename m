Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB40AC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 23:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF1A2082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 23:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF1A2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbeJEGUb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 02:20:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60742 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbeJEGUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 02:20:31 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BB810308A941;
        Thu,  4 Oct 2018 23:24:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6544E1057046;
        Thu,  4 Oct 2018 23:24:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20181004171925.6neebizw4xmpjhv6@ast-mbp.dhcp.thefacebook.com>
References: <20181004171925.6neebizw4xmpjhv6@ast-mbp.dhcp.thefacebook.com> <f4d5ec71-b09a-84fa-599e-d0482cdb77b7@gmail.com> <153864184110.20296.16498481420320274305.stgit@warthog.procyon.org.uk> <25668.1538672073@warthog.procyon.org.uk>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     dhowells@redhat.com, David Ahern <dsahern@gmail.com>,
        netdev@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] udp: Add tracepoints to monitor skbs going in and out of a UDP socket
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5212.1538695482.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Fri, 05 Oct 2018 00:24:42 +0100
Message-ID: <5213.1538695482@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 04 Oct 2018 23:24:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> I don't quite see what value this tracepoint adds.  Just use kprobe in the
> same spot?  Or tcpdump?

The point was to measure the elapsed time between a packet being received in
the r8169 driver (see the patch I posted for that), getting into udp driver,
being queued by the udp driver and and thence being passed to the af_rxrpc
driver's data_ready function.  You cannot measure this with tcpdump.

Further, packets were crossing each other, so the skb pointer had to be
included so that non-consecutive trace lines could be correlated.  Note that I
have seen up to 4s of delay between a packet being received in r8169 and
arriving in af_rxrpc, so the correlation is necessary.

As for kprobes: spots, plural.  Using kprobes involves installing breakpoint
instructions and taking traps and would seem to require using printk for the
output, which would affect the timings and potentially affect the situation,
especially given the sheer amount of traces produced.  Note that one of these
was in an interrupt handler, which is possibly not the best place to be taking
an illegal instruction trap.

Using kprobes gets worse too.  In my case, the source code and the build tree
aren't on the test machine, which I understand would be a requirement - and
they change regularly (every few minutes).  I boot a monolithic kernel by PXE
directly out of the build tree rather than messing about with building kernel
packages.

Further, I already have tracepoints in rxrpc that produce what I needed that I
could just turn on.

> How was it useful for you?

I could get traces like the following:

<idle>-0     [001] d.h2    95.751176: net_rtl8169_interrupt: enp3s0 st=1
<idle>-0     [001] ..s2    95.751181: net_rtl8169_poll: enp3s0 st=1
<idle>-0     [001] ..s2    95.751185: net_rtl8169_rx: enp3s0 skb=00000000efddbee8
<idle>-0     [001] ..s4    95.751204: udp_rcv: skb=00000000efddbee8
<idle>-0     [001] ..s4    95.751207: rxrpc_skb: s=00000000efddbee8 Rx RCV u=1 m=1 p=rxrpc_rcv_enqueue_skb+0xae/0x18f8
<idle>-0     [001] ..s4    95.751208: rxrpc_rx_packet: 911beb59:b241ccb4:00000006:0001 0000000e 00000001 01 04 DATA
<idle>-0     [001] ..s5    95.751214: rxrpc_skb: s=00000000efddbee8 Rx GOT u=1 m=2 p=rxrpc_input_data+0x557/0x96f
<idle>-0     [001] .Ns4    95.751234: rxrpc_skb: s=00000000efddbee8 Rx FRE u=2 m=1 p=rxrpc_rcv_enqueue_skb+0x15b0/0x18f8
    ls-3183  [001] ...1    95.751252: rxrpc_skb: s=00000000efddbee8 Rx SEE u=1 m=1 p=rxrpc_recvmsg_data.isra.0+0x1bf/0xdc1
    ls-3183  [001] ...1    95.751255: rxrpc_skb: s=00000000efddbee8 Rx ROT u=1 m=1 p=rxrpc_recvmsg_data.isra.0+0x7eb/0xdc1
    ls-3183  [001] ...1    95.751255: rxrpc_skb: s=00000000efddbee8 Rx FRE u=1 m=0 p=rxrpc_recvmsg_data.isra.0+0x840/0xdc1

I can see the interrupt where the NIC pokes the machine to say that there's a
packet, and then I can see the path that the received skbuff passes through
the r8169, udp and af_rxrpc drivers.

For its warts, tracepoints are pretty nice for this sort of thing - but they
have to already exist for you to make use of them, and changing them does
require a recompile.  The main problem I have with tracepoints is during boot,
module load or module removal where the buffer never becomes accessible or
gets wiped.

So, in and of themselves, the udp tracepoints in my patch aren't that useful -
but in combination with tracepoints in the nic driver and in the kernel
service that's using udp, they're actually quite useful.

> and why it couldn't have been achieved by other means?

It probably could, but why should I?

I'm changing my test kernel at very regular intervals.  Stacking on extra
patches to add more tracepoints is much less of an inconvenience than trying
to use kprobes.

David
