Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935381AbeCHJVH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 04:21:07 -0500
Received: from mail-pl0-f54.google.com ([209.85.160.54]:33179 "EHLO
        mail-pl0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751374AbeCHJVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 04:21:05 -0500
X-Google-Smtp-Source: AG47ELurogrMJjoOEq1sNM0q/rwp1PXptZzyr6w4tJEt7+WNVzc+VtvAcQ83NGbwf7imqs6tqZ1f6bMpee9PxS1Wl2U=
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Z6SS2AzYnMjbx_cmrataCLUhdjAx8XyYAnTMdVzndH5w@mail.gmail.com>
References: <CACT4Y+Z6SS2AzYnMjbx_cmrataCLUhdjAx8XyYAnTMdVzndH5w@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 8 Mar 2018 10:20:44 +0100
Message-ID: <CACT4Y+aLOqSqdfRYEyQB33MSXXb-3=APs5B1ZHsXJ2XYXF_Ppw@mail.gmail.com>
Subject: Re: KASAN poisoning for skb linear data
To: David Miller <davem@davemloft.net>,
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

On Mon, Jan 15, 2018 at 3:15 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> Hi,
>
> As far as I understand pskb_may_pull() plays important role in packet
> parsing for all protocols. And we did custom fragmentation of packets
> emitted via tun (IFF_NAPI_FRAGS). However, it seems that it does not
> give any results (bugs found), and I think the reason for this is that
> linear data is rounded up and is usually quite large. So if a parsing
> function does pskb_may_pull(1), or does not do it at all, it can
> usually access more and it will go unnoticed. KASAN has an ability to
> do custom poisoning: it can poison/unpoison any memory range, and then
> detect any reads/writes to that range. What do you think about adding
> custom KASAN poisoning to pskb_may_pull() and switching it to
> non-eager mode (pull only what was requested) under KASAN? Do you
> think it has potential for finding important bugs? What amount of work
> is this?

Filed https://bugzilla.kernel.org/show_bug.cgi?id=199055 for this so
it's not get lost.
