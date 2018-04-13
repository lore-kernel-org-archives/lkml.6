Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752403AbeDMOwm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 10:52:42 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34018 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbeDMOwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 10:52:40 -0400
X-Google-Smtp-Source: AIpwx4+0hL1N9u0kOkvAMFAXi67Cw/flHnJdduId6KrNeKHUfMrE1Shah39fih/jH0VdjzTgdBQWX3ykZUqMXUEVA+0=
MIME-Version: 1.0
In-Reply-To: <20180413131558.3jw5dhub5gcyotyt@salvia>
References: <20180409105322.2247296-1-arnd@arndb.de> <20180409143741.dzooqrzcgi2bnvd5@salvia>
 <CAK8P3a1GH5OSu62TBh46S0OdiXTJODsvV3To5=Jp2nL+fz1Puw@mail.gmail.com> <20180413131558.3jw5dhub5gcyotyt@salvia>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 13 Apr 2018 16:52:38 +0200
X-Google-Sender-Auth: rpcFOCyFHbR4kdxBw--zOT3WXOA
Message-ID: <CAK8P3a0u-7xVDuhU90GL50S63sd2WTCisKnorG+FDTLp4WDCVg@mail.gmail.com>
Subject: Re: [PATCH] netfilter: fix CONFIG_NF_REJECT_IPV6=m link error
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2018 at 3:15 PM, Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> On Mon, Apr 09, 2018 at 04:43:40PM +0200, Arnd Bergmann wrote:
>> On Mon, Apr 9, 2018 at 4:37 PM, Pablo Neira Ayuso <pablo@netfilter.org> wrote:
>> > Hi Arnd,
>> >
>> > On Mon, Apr 09, 2018 at 12:53:12PM +0200, Arnd Bergmann wrote:
>> >> We get a new link error with CONFIG_NFT_REJECT_INET=y and CONFIG_NF_REJECT_IPV6=m
>> >
>> > I think we can update NFT_REJECT_INET so it depends on NFT_REJECT_IPV4
>> > and NFT_REJECT_IPV6. This doesn't allow here CONFIG_NFT_REJECT_INET=y
>> > and CONFIG_NF_REJECT_IPV6=m.
>> >
>> > I mean, just like we do with NFT_FIB_INET.
>>
>> That can only work if NFT_REJECT_INET can be made a 'tristate' symbol
>> again, so that code gets built as a loadable module if
>> CONFIG_NF_REJECT_IPV6=m.
>>
>> > BTW, I think this problem has been is not related to the recent patch,
>> > but something older that kbuild robot has triggered more easily for
>> > some reason?
>>
>> 02c7b25e5f54 is the one that turned NF_TABLES_INET into a 'bool'
>> symbol. NFT_REJECT depends on NF_TABLES_INET, so it used to
>> restricted to a loadable module with IPV6=m, but can now be
>> built-in, which causes that link error.
>
> Still one more spin on this, I would like to see if we have a way to
> fix this by simplifing things a bit.
>
> Would this one I'm attaching would work?

One disadvantage is that it makes the vmlinux bigger since
NF_REJECT_IPV{4,6} can no longer be a module at all now.

I suspect you also stil get a link error with IPV6=m, this time because
the nf_reject_ipv6.o file fails to link against the ipv6 code, e.g.
ipv6_skip_exthdr() and icmpv6_send() appear to be unreachable here.
I haven't tried that though, so I might be missing something.

        Arnd
