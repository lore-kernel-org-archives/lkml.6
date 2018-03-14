Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbeCNOkX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 10:40:23 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35046 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbeCNOkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 10:40:21 -0400
X-Google-Smtp-Source: AG47ELum8hyMz9QfC+rPjoBACnrfk7vOZH3tu6lRKvoXQZiBUNdQvoLmtqeczz5ZDY2zeM+l7loFXBICgV9TYnBbE4I=
MIME-Version: 1.0
In-Reply-To: <CAG_fn=VMj0KDqr24Mx71QBZjHzJDdQi0OthA-E1YcB0q=Sk0BA@mail.gmail.com>
References: <20180314140322.233047-1-glider@google.com> <CANn89iL8gWYReSPRfhHdyYT1+TC+GwxTD45SG+zjCMBEYjY3KQ@mail.gmail.com>
 <CAG_fn=VMj0KDqr24Mx71QBZjHzJDdQi0OthA-E1YcB0q=Sk0BA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 14 Mar 2018 07:40:19 -0700
Message-ID: <CANn89iL3wh6DJBOGGjvH+dPX7Q+otNPH4N+CDrBDGAyFqaM5jQ@mail.gmail.com>
Subject: Re: [PATCH] netlink: make sure nladdr has correct size in netlink_connect()
To: Alexander Potapenko <glider@google.com>
Cc: Dmitriy Vyukov <dvyukov@google.com>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 7:16 AM, Alexander Potapenko <glider@google.com> wrote:
>
>
>
> On Wed, Mar 14, 2018 at 3:11 PM Eric Dumazet <edumazet@google.com> wrote:
>>
>> On Wed, Mar 14, 2018 at 7:03 AM, Alexander Potapenko <glider@google.com>
>> wrote:
>> > KMSAN reports use of uninitialized memory in the case when |alen| is
>> > smaller than sizeof(struct netlink_sock), and therefore |nladdr| isn't
>> > fully copied from the userspace.
>> >
>> > Signed-off-by: Alexander Potapenko <glider@google.com>
>> > Fixes: 1da177e4c3f41524 ("Linux-2.6.12-rc2")
>> > ---
>> >  net/netlink/af_netlink.c | 3 +++
>> >  1 file changed, 3 insertions(+)
>> >
>> > diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
>> > index 07e8478068f0..5d49b39e81c3 100644
>> > --- a/net/netlink/af_netlink.c
>> > +++ b/net/netlink/af_netlink.c
>> > @@ -1085,6 +1085,9 @@ static int netlink_connect(struct socket *sock,
>> > struct sockaddr *addr,
>> >         if (addr->sa_family != AF_NETLINK)
>> >                 return -EINVAL;
>> >
>> > +       if (alen < sizeof(struct netlink_sock))
>> > +               return -EINVAL;
>> > +
>> >
>>
>> Hmmm. How was this patch tested exactly ?
>
> You're absolutely right, I should have been using sizeof(sockaddr_nl).
> The reproducer that I used to trigger the bug was passing alen=2, so the
> patch still worked despite being incorrect.
> Is there any generic set of networking tests that I can use for such bugs?

There are upstream tests in tools/testing/selftests/

In your case, making sure tools like iproute2 ss are still working
would have done the job.
