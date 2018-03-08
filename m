Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935839AbeCHQAD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:00:03 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:41544 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935254AbeCHQAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:00:01 -0500
X-Google-Smtp-Source: AG47ELtYEEA7OfpO5TbyiEWQE9mXfGpNEwoFsZyv5sblEWHfyej638yU6mLbI2mMIePN+kANPjI31Cfd1b7T+Tuf+R8=
MIME-Version: 1.0
In-Reply-To: <20180308074543.250898af@xeon-e3>
References: <CACT4Y+Z6SS2AzYnMjbx_cmrataCLUhdjAx8XyYAnTMdVzndH5w@mail.gmail.com>
 <20180308074543.250898af@xeon-e3>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 8 Mar 2018 16:59:39 +0100
Message-ID: <CACT4Y+aDK5y0EoundSdKmWLT3uzG=kLj4cbdQsgsCAzsw-EzTw@mail.gmail.com>
Subject: Re: KASAN poisoning for skb linear data
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Miller <davem@davemloft.net>,
        Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        andreyknvl <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 8, 2018 at 4:45 PM, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> On Mon, 15 Jan 2018 15:15:04 +0100
> Dmitry Vyukov <dvyukov@google.com> wrote:
>
>> Hi,
>>
>> As far as I understand pskb_may_pull() plays important role in packet
>> parsing for all protocols. And we did custom fragmentation of packets
>> emitted via tun (IFF_NAPI_FRAGS). However, it seems that it does not
>> give any results (bugs found), and I think the reason for this is that
>> linear data is rounded up and is usually quite large. So if a parsing
>> function does pskb_may_pull(1), or does not do it at all, it can
>> usually access more and it will go unnoticed. KASAN has an ability to
>> do custom poisoning: it can poison/unpoison any memory range, and then
>> detect any reads/writes to that range. What do you think about adding
>> custom KASAN poisoning to pskb_may_pull() and switching it to
>> non-eager mode (pull only what was requested) under KASAN? Do you
>> think it has potential for finding important bugs? What amount of work
>> is this?
>>
>> Thanks
>
> Also, kernel networking only deals with in-tree upstream code.
> Any problems with infrastructure for custom code are your problem
> to deal with, not our problem.


This is 100% about upstream code. The issue for me, it is not in
networking component.
I've filed an issue because kernel mailing lists are used mostly for
patches, everything else is immediately lost (e.g. like this one).
