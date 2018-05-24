Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935843AbeEXIAj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 04:00:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60208 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935825AbeEXIAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 04:00:32 -0400
Message-ID: <1527148826.3058.16.camel@redhat.com>
Subject: Re: WARNING in ip_recv_error
From: Paolo Abeni <pabeni@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Miller <davem@davemloft.net>
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
        DaeLyong Jeong <threeearcat@gmail.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Byoungyoung Lee <byoungyoung@purdue.edu>,
        Kyungtae Kim <kt0755@gmail.com>, bammanag@purdue.edu,
        Willem de Bruijn <willemb@google.com>
Date: Thu, 24 May 2018 10:00:26 +0200
In-Reply-To: <CAF=yD-KTfUbXGvU7qQy4=eHbuUB88=g_tQ8sp8TEebhW=rzKVQ@mail.gmail.com>
References: <20180518120826.GA19515@dragonet.kaist.ac.kr>
         <293d029c-b14c-a625-3703-97a5754e99f1@gmail.com>
         <20180518.114433.390752642781753429.davem@davemloft.net>
         <CAF=yD-Kb4ZfJ3sMAnWEOB_s9Y=TTnLbRZxrDPiGZLO=trPjY5Q@mail.gmail.com>
         <CAF=yD-LvZk+gdyf_Kq1j+hoJBmFnTKgR=DResvMAC7tEJCgGJw@mail.gmail.com>
         <CAF=yD-+QLz63Z6h5OpC-ar+nHvpCpkVi79h9Vtn=7fzmHCK8Lg@mail.gmail.com>
         <CAF=yD-+Ai35L2=dGZzpjYYavBmBGNFXd-q9ju93WrPuewnhELg@mail.gmail.com>
         <CAF=yD-JObh3u+41V609=zph0XfcgOxpmqm3hL5WPKWFrSnnV3Q@mail.gmail.com>
         <CAF=yD-KTfUbXGvU7qQy4=eHbuUB88=g_tQ8sp8TEebhW=rzKVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-23 at 11:40 -0400, Willem de Bruijn wrote:
> On Sun, May 20, 2018 at 7:13 PM, Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> > On Fri, May 18, 2018 at 2:59 PM, Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > > On Fri, May 18, 2018 at 2:46 PM, Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > On Fri, May 18, 2018 at 2:44 PM, Willem de Bruijn
> > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > On Fri, May 18, 2018 at 1:09 PM, Willem de Bruijn
> > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > > On Fri, May 18, 2018 at 11:44 AM, David Miller <davem@davemloft.net> wrote:
> > > > > > > From: Eric Dumazet <eric.dumazet@gmail.com>
> > > > > > > Date: Fri, 18 May 2018 08:30:43 -0700
> > > > > > > 
> > > > > > > > We probably need to revert Willem patch (7ce875e5ecb8562fd44040f69bda96c999e38bbc)
> > > > > > > 
> > > > > > > Is it really valid to reach ip_recv_err with an ipv6 socket?
> > > > > > 
> > > > > > I guess the issue is that setsockopt IPV6_ADDRFORM is not an
> > > > > > atomic operation, so that the socket is neither fully ipv4 nor fully
> > > > > > ipv6 by the time it reaches ip_recv_error.
> > > > > > 
> > > > > >   sk->sk_socket->ops = &inet_dgram_ops;
> > > > > >   < HERE >
> > > > > >   sk->sk_family = PF_INET;
> > > > > > 
> > > > > > Even calling inet_recv_error to demux would not necessarily help.
> > > > > > 
> > > > > > Safest would be to look up by skb->protocol, similar to what
> > > > > > ipv6_recv_error does to handle v4-mapped-v6.
> > > > > > 
> > > > > > Or to make that function safe with PF_INET and swap the order
> > > > > > of the above two operations.
> > > > > > 
> > > > > > All sound needlessly complicated for this rare socket option, but
> > > > > > I don't have a better idea yet. Dropping on the floor is not nice,
> > > > > > either.
> > > > > 
> > > > > Ensuring that ip_recv_error correctly handles packets from either
> > > > > socket and removing the warning should indeed be good.
> > > > > 
> > > > > It is robust against v4-mapped packets from an AF_INET6 socket,
> > > > > but see caveat on reconnect below.
> > > > > 
> > > > > The code between ipv6_recv_error for v4-mapped addresses and
> > > > > ip_recv_error is essentially the same, the main difference being
> > > > > whether to return network headers as sockaddr_in with SOL_IP
> > > > > or sockaddr_in6 with SOL_IPV6.
> > > > > 
> > > > > There are very few other locations in the stack that explicitly test
> > > > > sk_family in this way and thus would be vulnerable to races with
> > > > > IPV6_ADDRFORM.
> > > > > 
> > > > > I'm not sure whether it is possible for a udpv6 socket to queue a
> > > > > real ipv6 packet on the error queue, disconnect, connect to an
> > > > > ipv4 address, call IPV6_ADDRFORM and then call ip_recv_error
> > > > > on a true ipv6 packet. That would return buggy data, e.g., in
> > > > > msg_name.
> > > > 
> > > > In do_ipv6_setsockopt IPV6_ADDRFORM we can test that the
> > > > error queue is empty, and then take its lock for the duration of the
> > > > operation.
> > > 
> > > Actually, no reason to hold the lock. This setsockopt holds the socket
> > > lock, which connect would need, too. So testing that the queue
> > > is empty after testing that it is connected to a v4 address is
> > > sufficient to ensure that no ipv6 packets are queued for reception.
> > > 
> > > diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
> > > index 4d780c7f0130..a975d6311341 100644
> > > --- a/net/ipv6/ipv6_sockglue.c
> > > +++ b/net/ipv6/ipv6_sockglue.c
> > > @@ -199,6 +199,11 @@ static int do_ipv6_setsockopt(struct sock *sk,
> > > int level, int optname,
> > > 
> > >                         if (ipv6_only_sock(sk) ||
> > >                             !ipv6_addr_v4mapped(&sk->sk_v6_daddr)) {
> > >                                 retv = -EADDRNOTAVAIL;
> > >                                 break;
> > >                         }
> > > 
> > > +                       if (!skb_queue_empty(&sk->sk_error_queue)) {
> > > +                               retv = -EBUSY;
> > > +                               break;
> > > +                       }
> > > +
> > >                         fl6_free_socklist(sk);
> > >                         __ipv6_sock_mc_close(sk);
> > > 
> > > After this it should be safe to remove the warning in ip_recv_error.
> > 
> > Hmm.. nope.
> > 
> > This ensures that the socket cannot produce any new true v6 packets.
> > But it does not guarantee that they are not already in the system, e.g.
> > queued in tc, and will find their way to the error queue later.
> > 
> > We'll have to just be able to handle ipv6 packets in ip_recv_error.
> > Since IPV6_ADDRFORM is used to pass to legacy v4-only
> > processes and those likely are only confused by SOL_IPV6
> > error messages, it is probably best to just drop them and perhaps
> > WARN_ONCE.
> 
> Even more fun, this is not limited to the error queue.
> 
> I can queue a v6 packet for reception on a socket, connect to a v4
> address, call IPV6_ADDRFORM and then a regular recvfrom will
> return a partial v6 address as AF_INET.
> 
> We definitely do not want to have to add a check
> 
>   if (skb->protocol == htons(ETH_P_IPV6)) {
>     kfree_skb(skb);
>     goto try_again;
>   }
> 
> to the normal recvmsg path.
> 
> An alternative may be to tighten the check on when to allow
> IPV6_ADDRFORM. Not only return EBUSY if a packet is pending,
> but also if any sk_{rmem, omem, wmem}_alloc is non-zero. Only,
> these tightened constraints could break a legacy application.

I fear that condition will be very restrictive: for UDP sockets sk_rmem
can be zero only occasionally, after the first packet has been
received, due to the peculiar memory accounting - commit 6b229cf77d68
("This computer thing still completely fool me").

Cheers,

Paolo
