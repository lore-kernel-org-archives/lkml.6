Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932157AbeBAAtQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 19:49:16 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:39730 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754068AbeBAAtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 19:49:13 -0500
X-Google-Smtp-Source: AH8x226+lp7CBHqBXyVqVcuabIv19vILChpXXBZOhnIFcqNHrfwuYGIC1HetKeJQAgfY+hwHHlEFHJmVrPd63Wa4IIk=
MIME-Version: 1.0
In-Reply-To: <efa5811c-0a01-a4af-ade2-71ef5dbc4eaf@gmail.com>
References: <CACT4Y+ZyUxeUqEB7q1EHcs4j93mtk9UOBuYhJtcnnc8AfApoLw@mail.gmail.com>
 <CAM_iQpVo0iSXKSR=Qc+7syn77BnhE2R72M2u5YfJF=fBkJHjsw@mail.gmail.com>
 <7fd7e3b3-77b1-0936-b169-d08b946bedc7@iogearbox.net> <991243e2-e7c2-f2b2-72b9-d37b0d569b3b@gmail.com>
 <efa5811c-0a01-a4af-ade2-71ef5dbc4eaf@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 1 Feb 2018 01:49:12 +0100
Message-ID: <CADvbK_dgEa5g0ynY4F8pX6LuuBwW4e42rK_TFuRhY1=2G5zinw@mail.gmail.com>
Subject: Re: net: hang in unregister_netdevice: waiting for lo to become free
To: David Ahern <dsahern@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Dan Streetman <ddstreet@canonical.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 11:59 PM, David Ahern <dsahern@gmail.com> wrote:
> On 1/30/18 1:57 PM, David Ahern wrote:
>> On 1/30/18 1:08 PM, Daniel Borkmann wrote:
>>> On 01/30/2018 07:32 PM, Cong Wang wrote:
>>>> On Tue, Jan 30, 2018 at 4:09 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
>>>>> Hello,
>>>>>
>>>>> The following program creates a hang in unregister_netdevice.
>>>>> cleanup_net work hangs there forever periodically printing
>>>>> "unregister_netdevice: waiting for lo to become free. Usage count = 3"
>>>>> and creation of any new network namespaces hangs forever.
>>>>
>>>> Interestingly, this is not reproducible on net-next.
>>>
>>> The most recent change on netns refcnt was 4ee806d51176 ("net: tcp: close
>>> sock if net namespace is exiting") in net/net-next from 5 days ago, maybe
>>> fixed due to that?
>>>
>>
>> This appears to be the commit introducing the refcnt leak:
>>
>> $ git bisect bad
>> dbc2b5e9a09e9a6664679a667ff81cff6e5f2641 is the first bad commit
>> commit dbc2b5e9a09e9a6664679a667ff81cff6e5f2641
>> Author: Xin Long <lucien.xin@gmail.com>
>> Date:   Fri May 12 14:39:52 2017 +0800
>>
>>     sctp: fix src address selection if using secondary addresses for ipv6
>>
>>
>> v4.14 is bad. Running bisect in the background while doing other things....
>>
>
> Interesting. The commit that avoids the refcnt leak is
>
> commit 955ec4cb3b54c7c389a9f830be7d3ae2056b9212
> Author: David Ahern <dsahern@gmail.com>
> Date:   Wed Jan 24 19:45:29 2018 -0800
>
>     net/ipv6: Do not allow route add with a device that is down
>
> That commit does not intentionally address the problem so it is just
> masking the problematic code introduced by the commit above.
Thanks, David A.

I'm still on a trip. will look into this asap.
