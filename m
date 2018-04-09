Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753072AbeDIOno (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 10:43:44 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:38504 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753046AbeDIOnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 10:43:41 -0400
X-Google-Smtp-Source: AIpwx48CY/pRkh8+VEaNkNg44ckzKiEiG5hBmEGDH2vZlqERbIcOwWcNcpjdN0O4+qwus7UVEVqnow/xvntirABomGQ=
MIME-Version: 1.0
In-Reply-To: <20180409143741.dzooqrzcgi2bnvd5@salvia>
References: <20180409105322.2247296-1-arnd@arndb.de> <20180409143741.dzooqrzcgi2bnvd5@salvia>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 9 Apr 2018 16:43:40 +0200
X-Google-Sender-Auth: Gek5hfsyr82KC6MAET9iw9YE3oU
Message-ID: <CAK8P3a1GH5OSu62TBh46S0OdiXTJODsvV3To5=Jp2nL+fz1Puw@mail.gmail.com>
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

On Mon, Apr 9, 2018 at 4:37 PM, Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> Hi Arnd,
>
> On Mon, Apr 09, 2018 at 12:53:12PM +0200, Arnd Bergmann wrote:
>> We get a new link error with CONFIG_NFT_REJECT_INET=y and CONFIG_NF_REJECT_IPV6=m
>
> I think we can update NFT_REJECT_INET so it depends on NFT_REJECT_IPV4
> and NFT_REJECT_IPV6. This doesn't allow here CONFIG_NFT_REJECT_INET=y
> and CONFIG_NF_REJECT_IPV6=m.
>
> I mean, just like we do with NFT_FIB_INET.

That can only work if NFT_REJECT_INET can be made a 'tristate' symbol
again, so that code gets built as a loadable module if
CONFIG_NF_REJECT_IPV6=m.

> BTW, I think this problem has been is not related to the recent patch,
> but something older that kbuild robot has triggered more easily for
> some reason?

02c7b25e5f54 is the one that turned NF_TABLES_INET into a 'bool'
symbol. NFT_REJECT depends on NF_TABLES_INET, so it used to
restricted to a loadable module with IPV6=m, but can now be
built-in, which causes that link error.

      Arnd
