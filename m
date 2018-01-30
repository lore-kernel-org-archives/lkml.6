Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753572AbeA3U5l (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:57:41 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:42498 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752711AbeA3U5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:57:40 -0500
X-Google-Smtp-Source: AH8x224ygjpVzwI4vKWItF12Fr/ukFkQbE1ogYLHzeqqActmw1IwWB4EqxZASaPta0z40igux+np5g==
Subject: Re: net: hang in unregister_netdevice: waiting for lo to become free
To: Daniel Borkmann <daniel@iogearbox.net>,
        Cong Wang <xiyou.wangcong@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, David Miller <davem@davemloft.net>,
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
References: <CACT4Y+ZyUxeUqEB7q1EHcs4j93mtk9UOBuYhJtcnnc8AfApoLw@mail.gmail.com>
 <CAM_iQpVo0iSXKSR=Qc+7syn77BnhE2R72M2u5YfJF=fBkJHjsw@mail.gmail.com>
 <7fd7e3b3-77b1-0936-b169-d08b946bedc7@iogearbox.net>
From: David Ahern <dsahern@gmail.com>
Message-ID: <991243e2-e7c2-f2b2-72b9-d37b0d569b3b@gmail.com>
Date: Tue, 30 Jan 2018 13:57:35 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <7fd7e3b3-77b1-0936-b169-d08b946bedc7@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/18 1:08 PM, Daniel Borkmann wrote:
> On 01/30/2018 07:32 PM, Cong Wang wrote:
>> On Tue, Jan 30, 2018 at 4:09 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
>>> Hello,
>>>
>>> The following program creates a hang in unregister_netdevice.
>>> cleanup_net work hangs there forever periodically printing
>>> "unregister_netdevice: waiting for lo to become free. Usage count = 3"
>>> and creation of any new network namespaces hangs forever.
>>
>> Interestingly, this is not reproducible on net-next.
> 
> The most recent change on netns refcnt was 4ee806d51176 ("net: tcp: close
> sock if net namespace is exiting") in net/net-next from 5 days ago, maybe
> fixed due to that?
> 

This appears to be the commit introducing the refcnt leak:

$ git bisect bad
dbc2b5e9a09e9a6664679a667ff81cff6e5f2641 is the first bad commit
commit dbc2b5e9a09e9a6664679a667ff81cff6e5f2641
Author: Xin Long <lucien.xin@gmail.com>
Date:   Fri May 12 14:39:52 2017 +0800

    sctp: fix src address selection if using secondary addresses for ipv6


v4.14 is bad. Running bisect in the background while doing other things....
