Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC6DC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B41213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:08:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B41213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeJDQAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:00:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57606 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbeJDQAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:00:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 580843081256;
        Thu,  4 Oct 2018 09:08:14 +0000 (UTC)
Received: from ovpn-117-12.ams2.redhat.com (ovpn-117-12.ams2.redhat.com [10.36.117.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 040BF5D6A6;
        Thu,  4 Oct 2018 09:08:12 +0000 (UTC)
Message-ID: <e7e3e30374b1b95f7f9a945c765ff523dfda3016.camel@redhat.com>
Subject: Re: [PATCH net] udp: Allow kernel service to avoid udp socket rx
 queue
From:   Paolo Abeni <pabeni@redhat.com>
To:     David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 04 Oct 2018 11:08:11 +0200
In-Reply-To: <153859250219.15389.11970533498295122206.stgit@warthog.procyon.org.uk>
References: <153859250219.15389.11970533498295122206.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 04 Oct 2018 09:08:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2018-10-03 at 19:48 +0100, David Howells wrote:
> There's a problem somewhere skb_recv_udp() that doesn't decrease the
> sk_rmem_alloc counter when a packet is extracted from the receive queue by
> a kernel service.  

If this is the case, it's really bad and need an explicit fix. However
it looks like sk_rmem_alloc is reclaimed by skb_recv_udp(), as it ends-
up calling udp_rmem_release() on succesfull dequeue.

udp_rmem_release() can delay sk_rmem_alloc reclaiming is the rx queue
is almost empty, due to commit
6b229cf77d683f634f0edd876c6d1015402303ad. Anyhow I don't see either as
that may affect this scenario: if only 1/4 of the maxium receive buffer
size is used, the next packet should always be able to land into the rx
queue, with the default sk_rcvbuf and every reasonable truesize.

> Further, there doesn't seem any point in having the socket buffer being
> added to the UDP socket's rx queue since the rxrpc's data_ready handler
> takes it straight back out again (more or less, there seem to be occasional
> hold ups there).

I really would really try to avoid adding another indirect call in the
data-path, unless strictly needed (to avoid more RETPOLINE overhead for
all other use-case). If skipping altogether the enqueuing makes sense
(I guess so, mostily for performance reasons), I *think* you can use
the already existing encap_rcv hook, initializing it to the rxrpc input
function, and updating such function to pull the udp header and ev.
initializing the pktinfo, if needed. Please see e.g. l2tp usage.
 
> Putting in some tracepoints show a significant delay occurring between packets
> coming in and thence being delivered to rxrpc:
> 
> <idle>-0  [001] ..s2    67.631844: net_rtl8169_napi_rx: enp3s0 skb=07db0a32
> ...
> <idle>-0  [001] ..s4    68.292778: rxrpc_rx_packet: d5ce8d37:bdb93c60:00000002:09c7 00000006 00000000 02 20 ACK 660967981 skb=07db0a32
> 
> The "660967981" is the time difference in nanoseconds between the sk_buff
> timestamp and the current time.  It seems to match the time elapsed between
> the two trace lines reasonably well.  I've seen anything up to about 4s.

Can you please provide more data? specifically can you please add:
* a perf probe in rxrpc_data_ready() just after skb_recv_udp()
reporting the sk->sk_rmem_alloc and skb->truesize
* a perf probe in __udp_enqueue_schedule_skb() just before the 'if
(rmem > sk->sk_rcvbuf)' test reporting again sk->sk_rmem_alloc, skb-
>truesize and sk->sk_rcvbuf

And then provide the perf record -g -e ... /perf script output?

Thanks,

Paolo

