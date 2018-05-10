Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757389AbeEJN1G (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 09:27:06 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:38770 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756998AbeEJN1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 09:27:05 -0400
X-Google-Smtp-Source: AB8JxZregMX/oynpZKjstgKQJ74WpZNJEL6QGpfk4wk1G4ZUAQ7WOLPQ1vTezT9T/NX9+ihkFsXgAA==
Subject: Re: [PATCH net-next v2] tcp: Add mark for TIMEWAIT sockets
To: Jon Maxwell <jmaxwell37@gmail.com>, davem@davemloft.net
Cc: kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmaxwell@redhat.com
References: <20180510065351.22535-1-jmaxwell37@gmail.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <9889abda-a022-44ae-30b6-ce2484c3bd90@gmail.com>
Date: Thu, 10 May 2018 06:27:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180510065351.22535-1-jmaxwell37@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/09/2018 11:53 PM, Jon Maxwell wrote:
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

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks Jon.
