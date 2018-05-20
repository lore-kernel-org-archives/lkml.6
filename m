Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752662AbeETXFl (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 19:05:41 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:39728 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751990AbeETXFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 19:05:37 -0400
X-Google-Smtp-Source: AB8JxZpUni7MepqJEdqsymV9hUSn2+Cv5DtipKSbeiNC7SBK/lfhrNV+CFwlJQs7XLOuQxZeXwdD6bxcurwE7eHv+zY=
MIME-Version: 1.0
In-Reply-To: <CAF=yD-JbiE0W6pv77DUO0pYrJCYfgszm6zwCEfkv8HedvRfujQ@mail.gmail.com>
References: <20180518080308.GA28587@dragonet.kaist.ac.kr> <CAF=yD-JbiE0W6pv77DUO0pYrJCYfgszm6zwCEfkv8HedvRfujQ@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Sun, 20 May 2018 19:04:55 -0400
Message-ID: <CAF=yD-+jS5BJKHEDp+K4fB41YnY1mR8ksVg98oWPJV=mG01pfg@mail.gmail.com>
Subject: Re: WARNING in __static_key_slow_dec
To: DaeRyong Jeong <threeearcat@gmail.com>
Cc: David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Byoungyoung Lee <byoungyoung@purdue.edu>,
        Kyungtae Kim <kt0755@gmail.com>, bammanag@purdue.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 4:30 PM, Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
> On Fri, May 18, 2018 at 4:03 AM, DaeRyong Jeong <threeearcat@gmail.com> wrote:
>> We report the crash: WARNING in __static_key_slow_dec
>>
>> This crash has been found in v4.8 using RaceFuzzer (a modified
>> version of Syzkaller), which we describe more at the end of this
>> report.
>> Even though v4.8 is the relatively old version, we did manual verification
>> and we think the bug still exists.
>> Our analysis shows that the race occurs when invoking two syscalls
>> concurrently, setsockopt() with optname SO_TIMESTAMPING and ioctl() with
>> cmd SIOCGSTAMPNS.
>>
>>
>> Diagnosis:
>> We think if timestamp was previously enabled with
>> SOCK_TIMESTAMPING_RX_SOFTWARE flag, the concurrent execution of
>> sock_disable_timestamp() and sock_enable_timestamp() causes the crash.
>>
>>
>> Thread interleaving:
>> (Assume sk->flag has the SOCK_TIMESTAMPING_RX_SOFTWARE flag by the
>> previous setsockopt() call with SO_TIMESTAMPING)
>>
>> CPU0 (sock_disable_timestamp())                 CPU1 (sock_enable_timestamp())
>> =====                                           =====
>> (flag == 1UL << SOCK_TIMESTAMPING_RX_SOFTWARE)  (flag == SOCK_TIMESTAMP)
>>
>>                                                 if (!sock_flag(sk, flag)) {
>>                                                         unsigned long previous_flags = sk->sk_flags;
>>
>> if (sk->sk_flags & flags) {
>>         sk->sk_flags &= ~flags;
>>         if (sock_needs_netstamp(sk) &&
>>             !(sk->sk_flags & SK_FLAGS_TIMESTAMP))
>>                 net_disable_timestamp();
>>                                                         sock_set_flag(sk, flag);
>>
>>                                                         if (sock_needs_netstamp(sk) &&
>>                                                             !(previous_flags & SK_FLAGS_TIMESTAMP))
>>                                                                 net_enable_timestamp();
>>                                                         /* Here, net_enable_timestamp() is not called because
>>                                                          * previous_flags has the SOCK_TIMESTAMPING_RX_SOFTWARE
>>                                                          * flag
>>                                                          */
>> /* After the race, sk->sk has the flag SOCK_TIMESTAMP, but
>>  * net_enable_timestamp() is not called one more time.
>>  * Consequently, when the socket is closed, __sk_destruct()
>>  * calls net_disable_timestamp() that leads WARNING.
>>  */
>
> Thanks for the detailed analysis.
>
> Indeed the updates to sk->sk_flags and calls to net_(dis|en)able_timestamp
> should happen atomically, but this is not the case. The setsockopt
> path holds the socket lock, but not all ioctl paths.
>
> Perhaps we can take lock_sock_fast in sock_get_timestamp and
> variants.

Some callers of sock_get_timestamp already hold the socket lock,
e.g., ax25_ioctl, so that is out.

There is some known non-determinism in this path. Callers of
sock_get_timestamp do not necessarily expect a valid sk_stamp
when they enable the timestamp, so that function can continue
to test sk_flags lockless.

net_enable_timestamp enables timestamping using a static_branch
and possibly a workqueue, so already does not complete synchronously
in the sock_enable_timestamp call.

The only requirement is that updates to sk_flags do not race. This
should be solvable with cmpxchg. The situation is slightly complicated
because sk_flags has two bits that may toggle timestamping. Only the
first bit set must trigger a call to net_enable_timestamp and only the
last bit cleared must call net_disable_timestamp.

Something like

-static bool sock_needs_netstamp(const struct sock *sk)
+static bool sock_needs_netstamp(const struct sock *sk, unsigned long flags)
 {
        switch (sk->sk_family) {
        case AF_UNSPEC:
        case AF_UNIX:
                return false;
        default:
-               return true;
+               return (flags & SK_FLAGS_TIMESTAMP);
        }
 }

-static void sock_disable_timestamp(struct sock *sk, unsigned long flags)
+static void sock_disable_timestamp(struct sock *sk, unsigned long flag)
 {
-       if (sk->sk_flags & flags) {
-               sk->sk_flags &= ~flags;
-               if (sock_needs_netstamp(sk) &&
-                   !(sk->sk_flags & SK_FLAGS_TIMESTAMP))
-                       net_disable_timestamp();
-       }
+       unsigned long prev;
+
+       do {
+               prev = READ_ONCE(sk->sk_flags);
+
+               if (!(prev & flag))
+                       return;
+
+               if (cmpxchg(&sk->sk_flags, prev, prev & ~flag) == prev)
+                       break;
+       } while (1);
+
+       /* disable only if this operation removed the last tstamp flag */
+       if (!sock_needs_netstamp(sk, prev & ~flag))
+               net_disable_timestamp();
 }

and analogous for enable.
