Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 86B9AC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE88208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE88208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=helsinki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754985AbeFNKSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:18:51 -0400
Received: from smtp-rs2-vallila1.fe.helsinki.fi ([128.214.173.73]:34254 "EHLO
        smtp-rs2-vallila1.fe.helsinki.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754688AbeFNKSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:18:50 -0400
Received: from whs-18.cs.helsinki.fi (whs-18.cs.helsinki.fi [128.214.166.46])
        by smtp-rs2.it.helsinki.fi (8.14.7/8.14.7) with ESMTP id w5EAIjbx017083;
        Thu, 14 Jun 2018 13:18:45 +0300
Received: by whs-18.cs.helsinki.fi (Postfix, from userid 1070048)
        id 3AF433601A6; Thu, 14 Jun 2018 13:18:45 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by whs-18.cs.helsinki.fi (Postfix) with ESMTP id 3801C36007C;
        Thu, 14 Jun 2018 13:18:45 +0300 (EEST)
Date:   Thu, 14 Jun 2018 13:18:45 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@helsinki.fi>
X-X-Sender: ijjarvin@whs-18.cs.helsinki.fi
To:     Michal Kubecek <mkubecek@suse.cz>
cc:     Netdev <netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH RESEND] tcp: avoid F-RTO if SACK and timestamps are
 disabled
In-Reply-To: <20180613165716.4fy7ufk7jnk3r67r@unicorn.suse.cz>
Message-ID: <alpine.DEB.2.20.1806141252310.29120@whs-18.cs.helsinki.fi>
References: <20180613164802.99B89A09E2@unicorn.suse.cz> <20180613165543.0F92DA09E2@unicorn.suse.cz> <20180613165716.4fy7ufk7jnk3r67r@unicorn.suse.cz>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2018, Michal Kubecek wrote:

> On Wed, Jun 13, 2018 at 06:55:43PM +0200, Michal Kubecek wrote:
> > When F-RTO algorithm (RFC 5682) is used on connection without both SACK and
> > timestamps (either because of (mis)configuration or because the other
> > endpoint does not advertise them), specific pattern loss can make RTO grow
> > exponentially until the sender is only able to send one packet per two
> > minutes (TCP_RTO_MAX).
> > 
> > One way to reproduce is to
> > 
> >   - make sure the connection uses neither SACK nor timestamps
> >   - let tp->reorder grow enough so that lost packets are retransmitted
> >     after RTO (rather than when high_seq - snd_una > reorder * MSS)
> >   - let the data flow stabilize
> >   - drop multiple sender packets in "every second" pattern
> >   - either there is no new data to send or acks received in response to new
> >     data are also window updates (i.e. not dupacks by definition)
> > 
> > In this scenario, the sender keeps cycling between retransmitting first
> > lost packet (step 1 of RFC 5682), sending new data by (2b) and timing out
> > again. In this loop, the sender only gets
> > 
> >   (a) acks for retransmitted segments (possibly together with old ones)
> >   (b) window updates
> > 
> > Without timestamps, neither can be used for RTT estimator and without SACK,
> > we have no newly sacked segments to estimate RTT either. Therefore each
> > timeout doubles RTO and without usable RTT samples so that there is nothing
> > to counter the exponential growth.
> > 
> > While disabling both SACK and timestamps doesn't make any sense, the
> > resulting behaviour is so pathological that it deserves an improvement.
> > (Also, both can be disabled on the other side.) Avoid F-RTO algorithm in
> > case both SACK and timestamps are disabled so that the sender falls back to
> > traditional slow start retransmission.
> > 
> > Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
> 
> I was able to illustrate the issue using a packetdrill script. It cheats
> a bit by setting net.ipv4.tcp_reordering to 30 so that it we can get to
> the issue more quickly. In this case, we don't have more data to send
> but it's not essential; the issue can be reproduced even with sending of
> new data in F-RTO, it would only make everything more complicated.
> 
> I was able to run the same script on kernels 4.17-rc6, 4.12 (SLE15) and
> 4.4 (SLE12-SP2). Kernel 3.12 required minor modifications but not in the
> important part (the slow start is a bit slower there).
> 
> ---------------------------------------------------------------------------
> --tolerance_usecs=10000
> 
> // flush cached TCP metrics
> 0.000  `ip tcp_metrics flush all`
> +0.000 `sysctl -q net.ipv4.tcp_reordering=20`
> 
> 
> // establish a connection
> +0.000 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
> +0.000 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
> +0.000 setsockopt(3, SOL_SOCKET, SO_SNDBUF, [131072], 4) = 0
> +0.000 bind(3, ..., ...) = 0
> +0.000 listen(3, 1) = 0
> 
> +0.100 < S 0:0(0) win 40000 <mss 1000>
> +0.000 > S. 0:0(0) ack 1 <mss 1460>
> +0.100 < . 1:1(0) ack 1 win 40000
> +0.000 accept(3, ..., ...) = 4
> 
> // Send 10 data segments.
> +0.100 write(4, ..., 30000) = 30000
> // For some reason (unknown yet), GSO packets are only 2000 bytes long
> +0.000 > . 1:2001(2000) ack 1
> +0.000 > . 2001:4001(2000) ack 1
> +0.000 > . 4001:6001(2000) ack 1
> +0.000 > . 6001:8001(2000) ack 1
> +0.000 > . 8001:10001(2000) ack 1
> +0.100 < . 1:1(0) ack 2001 win 38000
> +0.000 > . 10001:12001(2000) ack 1
> +0.000 > . 12001:14001(2000) ack 1
> +0.001 < . 1:1(0) ack 4001 win 36000
> +0.000 > . 14001:16001(2000) ack 1
> +0.000 > . 16001:18001(2000) ack 1
> +0.001 < . 1:1(0) ack 6001 win 34000
> +0.000 > . 18001:20001(2000) ack 1
> +0.000 > . 20001:22001(2000) ack 1
> +0.001 < . 1:1(0) ack 8001 win 32000
> +0.000 > . 22001:24001(2000) ack 1
> +0.000 > . 24001:26001(2000) ack 1
> +0.001 < . 1:1(0) ack 10001 win 30000
> +0.000 > . 26001:28001(2000) ack 1
> +0.000 > P. 28001:30001(2000) ack 1
> 
> // loss of 12001:13001, 14001:15001, ..., 28001:29001
> +0.100 < . 1:1(0) ack 12001 win 30000	// original ack
> +0.000 < . 1:1(0) ack 12001 win 30000	// 13001:14001
> +0.000 < . 1:1(0) ack 12001 win 30000	// 15001:16001
> +0.000 < . 1:1(0) ack 12001 win 30000	// 17001:18001
> +0.000 < . 1:1(0) ack 12001 win 30000	// 19001:20001
> +0.000 < . 1:1(0) ack 12001 win 30000	// 21001:22001
> +0.000 < . 1:1(0) ack 12001 win 30000	// 13001:24001
> +0.000 < . 1:1(0) ack 12001 win 30000	// 25001:26001
> +0.000 < . 1:1(0) ack 12001 win 30000	// 27001:28001
> +0.000 < . 1:1(0) ack 12001 win 30000	// 29001:30001
> 
> // RTO 300ms
> +0.270~+0.330 > . 12001:13001(1000) ack 1

Lets analyze this case:
ca_state = CA_Loss

> +0.100 < . 1:1(0) ack 14001 win 38000

snd_una advances => icsk_retransmits = 0

...The lack of new data segments here seems very relevant to me and it 
hides from you what is really happening under the hood...

> // RTO 600ms
> +0.540~+0.660 > . 14001:15001(1000) ack 1

The above should already result false for FRTO in this case:
                   (new_recovery || icsk->icsk_retransmits) &&

...But it doesn't. If there would be the new data segment they would show 
to you that we're running a FRTO bogus undo here (with a burst of new 
data segments before the second RTO). The bogus undo on that ACK causes 
ca_state to switch away from CA_Loss and FRTO can then reoccur even though 
it was not intended. Please, try with this patch:
  https://patchwork.ozlabs.org/patch/883654/


...Since you're dealing with non-SACK flows here, you might want to 
consider the other fixes in that same series too as they all fix bad 
brokeness. I should do an updated version for that series but I've been 
waiting for the TCP testsuite to be published...


-- 
 i.
