Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BE6C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2662064D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytheb-org.20150623.gappssmtp.com header.i=@bytheb-org.20150623.gappssmtp.com header.b="DsSQsA87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB2662064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bytheb.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeLJQtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:49:52 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39343 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbeLJQtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:49:52 -0500
Received: by mail-qt1-f193.google.com with SMTP id n21so13028467qtl.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 08:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytheb-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+lpt2um1viW9B9WmPsA1dq2HyIr1W6zNfawC08Q8olM=;
        b=DsSQsA87I0F9nUnmNTjIZKh4l58sMP93s9GKZnDmTZBgyQLZsglbcF4bFIX20U3IGA
         gxKCVBnsgz4wWooZuxzNGw7LdpOAZW6G1hczgDfQGK8wh6+fpZWCEJWXi5FZAEfNunq6
         hmIhG5zfIBD/VAOQxwcerdqTtSGnE/UF6xrh07e7NIzyvzxca/dHFwk5/rtASF13uiI0
         Er92r8Dj1ghpcASZEnhkZDCgP5DkNnP0ILRBmCPQL0eYidYfnXWcJa4edn8o5jBYM/xl
         TvZysHYfS6o8q6Yry7W62g3GeFvyKNoMouPAi2pFmrsN63WgfI9Q1Ni+CxVEvT6YwTsf
         luPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=+lpt2um1viW9B9WmPsA1dq2HyIr1W6zNfawC08Q8olM=;
        b=cVBMufItNT0D3SBVYuB0pqN82ISvl/dJylsfI1e6apm+pxpnNASURG6Y8i5xB2dX1z
         i6spqPUnO77sgdyRAbDJNGOViBLym7tyqrXBKrOCbpohJalED4WRmEjQJkcgY6/k7naV
         eFh9LshObChguYWhtqZTf+/tKy0dym6jsB77+tBxsp3S9lO/jteyYG8/9IqKpFMLj6mq
         nXTsGFaNwHqPLyZOcoHbxgSfsJyXoSKN3PLaDO7UzCGrmItvJSO6lRDbH9fqBO2opVk3
         CneU/6E0lJdzT/5prO0V/HivSpWNvqX7waPrvpy6H2dea6KV4inlH88ZFCUe5iuekHeM
         vGHg==
X-Gm-Message-State: AA+aEWb4s1UMpv3CCFwR/cCO7W/KE+vvV42cVFu13Xad536vw37crzOk
        WFPXa+5JyJbg646vZ02avLUKrg==
X-Google-Smtp-Source: AFSGD/VVu8eX/FGGoiFDLlzgVrYHlA8fyJhV32q33Sb6V++076Kti3cNb8ZRLJ9zdYiphcfyYBUcGw==
X-Received: by 2002:ac8:274a:: with SMTP id h10mr12651022qth.189.1544460590603;
        Mon, 10 Dec 2018 08:49:50 -0800 (PST)
Received: from dhcp-25.97.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id j89sm8061716qkh.34.2018.12.10.08.49.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 08:49:49 -0800 (PST)
From:   Aaron Conole <aconole@bytheb.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Brouer <brouer@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andy Gospodarek <andy@greyhouse.net>,
        Rony Efraim <ronye@mellanox.com>,
        Simon Horman <horms@verge.net.au>,
        Marcelo Leitner <marcelo.leitner@gmail.com>
Subject: Re: [RFC -next v0 1/3] bpf: modular maps
References: <20181125180919.13996-1-aconole@bytheb.org>
        <20181125180919.13996-2-aconole@bytheb.org>
        <20181127020608.4vucwmhrtu2cxrwu@ast-mbp.dhcp.thefacebook.com>
        <f7tftvmd2ey.fsf@dhcp-25.97.bos.redhat.com>
        <20181128051001.wcsgqx3d6c2aszp6@ast-mbp.dhcp.thefacebook.com>
        <f7to9a99gsh.fsf@dhcp-25.97.bos.redhat.com>
        <20181129041948.pepdcksplt6xppk3@ast-mbp>
        <f7twoou65gi.fsf@dhcp-25.97.bos.redhat.com>
        <20181205024928.57xcrgspllcr7umo@ast-mbp.dhcp.thefacebook.com>
Date:   Mon, 10 Dec 2018 11:49:47 -0500
In-Reply-To: <20181205024928.57xcrgspllcr7umo@ast-mbp.dhcp.thefacebook.com>
        (Alexei Starovoitov's message of "Tue, 4 Dec 2018 18:49:30 -0800")
Message-ID: <f7tefap5ntg.fsf@dhcp-25.97.bos.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Fri, Nov 30, 2018 at 08:49:17AM -0500, Aaron Conole wrote:
>> 
>> While this is one reason to use hash map, I don't think we should use
>> this as a reason to exclude development of a data type that may work
>> better.  After all, if we can do better then we should.
>
> I'm all for improving existing hash map or implementing new data types.
> Like classifier map == same as wild-card match map == ACL map.
> The one that OVS folks could use and other folks wanted for long time.
>
> But I don't want bpf to become a collection of single purpose solutions.
> Like mega-flow style OVS map.
> That one does linear number of lookups applying mask at a time.
>
> It sounds to me that you're proposing "NAT-as-bpf-helper"
> or "NAT-as-bpf-map" type of solution.

Maybe that's what this particular iteration is.  But I'm open to a
different implementation.  My requirements aren't fixed to a specific
map type.

> That falls into single purpose solution category.
> I'd rather see generic connection tracking building block.
> The one that works out of skb and out of XDP layer.
> Existing stack-queue-map can already be used to allocate integers
> out of specified range. It can be used to implement port allocation for NAT.
> If generic stack-queue-map is not enough, let's improve it.

I don't understand this.  You say you want something out of skb and out
of xdp layer, but then advocate an ebpf approach (that would only be
useful from xdp).  Plus already some specialized mechanism exists for
FIB.  Not sure why this conntrack assist would be rejected as too
specialized?

I was thinking to re-use existing conntrack framework, and make the
metadata available from ebpf context.  That can be used even out of xdp
layer (for instance, maybe some tracing program, or other accounting /
auditing tool like a HIDS).

Anyway, as I wrote, there are other approaches.  But maybe instead of a
flowmap, an mkmap would make sense (this is a multi-key map, that allows
a single value to be reached via multiple keys).  I also wrote some
other approaches I was thinking in an earlier mail.  Maybe one of those
is better direction?

>> >> forward direction addresses could be different from reverse direction so
>> >> just swapping addresses / ports will not match).
>> >
>> > That makes no sense to me. What would be an example of such flow?
>> > Certainly not a tcp flow.
>> 
>> Maybe it's poorly worded on my part.  Think about this scenario (ipv4, tcp):
>> 
>> Interfaces A(internet), B(lan)
>> 
>> When XDP program receives a packet from B, it will have a tuple like:
>> 
>> source=B-subnet:B-port  dest=inet-addr:inet-port
>> 
>> When XDP program receives a packet from A, it will have a tuple like:
>> 
>> source=inet-addr:inet-port  dest=gw-addr:gw-port
>
> first of all there are two netdevs.
> one XDP program can attach to multiple netdevs, but in this
> case we're dealing with two indepedent tcp flows.
>
>> The only data in common there is inet-addr:inet-port, and that will
>> likely be shared among too many connections to be a valid key.
>
> two independent tcp flows don't make a 'connection'.
> That definition of connection is only meaningful in the context
> of the particular problem you're trying to solve and
> confuses me quite a bit.

I don't understand this.

They aren't independent.  We need to properly account the packets, and
need to apply policy decisions to either side.  Just because the tuples
are asymmetric, the connection *is* the same.  If you treat them
separately, then you lose the ability for accounting them properly.
Something needs to make the association.

>> I don't know how to figure out from A the same connetion that
>> corresponds to B.  A really simple static map works, *except*, when
>> something causes either side of the connection to become invalid, I
>> can't mark the other side.  For instance, even if I have some static
>> mapping, I might not be able to infer the correct B-side tuple from the
>> A-side tuple to do the teardown.
>
> I don't think I got enough information from the above description to
> understand why two tcp flows (same as two tcp connections) will
> form single 'connection' in your definition of connection.

They aren't two connections.  Maybe there's something I'm missing.

>> 1. Port / address reservation.  If I want to do NAT, I need to reserve
>>    ports and addresses correctly.  That requires knowing the interface
>>    addresses, and which addresses are currently allocated.  The stack
>>    knows this already, let it do these allocations then.  Then when
>>    packets arrive for the connection that the stack set up, just forward
>>    via XDP.
>
> I beg to disagree. For NAT use case the stack has nothing to do with
> port allocation for NATing. It's all within NAT framework
> (whichever way it's implemented).
> The stack cares about sockets and ports that are open on the host
> to be consumed by the host.
> NAT function is independent of that.

It's related.  If host has a particular port open, NAT can't reuse it if
NATing from a host IP.
So the NAT port allocation *must* take into account host ports.

>> 2. Helpers.  Parsing an in-flight stream is always going to be slow.
>>    Let the stack do that.  But when it sets up an expectation, then use
>>    that information to forward that via XDP.
>
> XDP parses packets way faster than the stack, since XDP deals with linear
> buffers whereas stack has to do pskb_may_pull at every step.

Sure.

> The stack can be optimized further, but assuming that packet parsing
> by the stack is faster than XDP and making techincal decisions based
> on that just doesn't seem like the right approach to take.

Agreed that packet parsing can be faster in XDP.  But my point is,
packet parsing is *slow* no matter what.  And the DPI required to
implement helpers is complex and slow.  The instant you need to parse
H.323 or some kind of SIP logic to implement conntrack helper you will
run out of instructions and tailcall iterations in eBPF.  Even simple FTP
parsing might not be 'good enough' from a throughput standpoint.  The
idea here is for control kinds of connections to traverse the stack
(since throughput isn't gating factor there), and the data connections
(which need maximum throughput) can just be switched via the xdp
mechanism.
