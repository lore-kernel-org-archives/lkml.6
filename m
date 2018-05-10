Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbeEJVpX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 17:45:23 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:37756 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752298AbeEJVpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 17:45:21 -0400
Date: Thu, 10 May 2018 17:45:20 -0400 (EDT)
Message-Id: <20180510.174520.128087783939744310.davem@davemloft.net>
To: jmaxwell37@gmail.com
Cc: kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmaxwell@redhat.com
Subject: Re: [PATCH net-next v2] tcp: Add mark for TIMEWAIT sockets
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180510065351.22535-1-jmaxwell37@gmail.com>
References: <20180510065351.22535-1-jmaxwell37@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Maxwell <jmaxwell37@gmail.com>
Date: Thu, 10 May 2018 16:53:51 +1000

> This version has some suggestions by Eric Dumazet:
> 
> - Use a local variable for the mark in IPv6 instead of ctl_sk to avoid SMP 
> races. 
> - Use the more elegant "IP4_REPLY_MARK(net, skb->mark) ?: sk->sk_mark"
> statement. 
> - Factorize code as sk_fullsock() check is not necessary.
> 
> Aidan McGurn from Openwave Mobility systems reported the following bug:
> 
> "Marked routing is broken on customer deployment. Its effects are large 
> increase in Uplink retransmissions caused by the client never receiving 
> the final ACK to their FINACK - this ACK misses the mark and routes out 
> of the incorrect route."
> 
> Currently marks are added to sk_buffs for replies when the "fwmark_reflect" 
> sysctl is enabled. But not for TW sockets that had sk->sk_mark set via 
> setsockopt(SO_MARK..).  
> 
> Fix this in IPv4/v6 by adding tw->tw_mark for TIME_WAIT sockets. Copy the the 
> original sk->sk_mark in __inet_twsk_hashdance() to the new tw->tw_mark location. 
> Then progate this so that the skb gets sent with the correct mark. Do the same 
> for resets. Give the "fwmark_reflect" sysctl precedence over sk->sk_mark so that
> netfilter rules are still honored.
> 
> Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>

I'm surprised the lack of a mark in timewait sockets wasn't noticed earlier.

Applied, thank you.
