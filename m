Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45376C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D76C8223DF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76C8223DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933193AbeGFPCb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:02:31 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:53250 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932925AbeGFPAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:00:48 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1fbSDt-0007n8-9t; Fri, 06 Jul 2018 17:00:37 +0200
Date:   Fri, 6 Jul 2018 17:00:37 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        "David S. Miller" <davem@davemloft.net>,
        =?iso-8859-15?Q?M=E1t=E9?= Eckl <ecklm94@gmail.com>,
        Fernando Fernandez Mancera <ffmancera@riseup.net>,
        "Pablo M. Bermudo Garay" <pablombg@gmail.com>,
        Felix Fietkau <nbd@nbd.name>, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netfilter: conntrack: add weak IPV6 dependency
Message-ID: <20180706150037.knqt736uq6uyh3bs@breakpoint.cc>
References: <20180706130005.3640993-1-arnd@arndb.de>
 <20180706135516.viz6pjtkdmcoqq2l@breakpoint.cc>
 <CAK8P3a1o6+dcZuW_iMGzwBBw_dcW41QAQ2Mu4A5Ru9ScnwaYDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1o6+dcZuW_iMGzwBBw_dcW41QAQ2Mu4A5Ru9ScnwaYDA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> wrote:
> and that resulted in a new build failure:
> 
> net/netfilter/nf_conntrack_proto.o:(.rodata+0x788): undefined
> reference to `nf_conntrack_l4proto_icmpv6'
> net/ipv6/netfilter/nf_conntrack_reasm.o: In function `nf_ct_frag6_expire':
> nf_conntrack_reasm.c:(.text+0x2320): undefined reference to
> `ip6_expire_frag_queue'
> net/ipv6/netfilter/nf_conntrack_reasm.o: In function `nf_ct_frag6_init':
> nf_conntrack_reasm.c:(.text+0x2384): undefined reference to `ip6_frag_init'
> nf_conntrack_reasm.c:(.text+0x2394): undefined reference to `ip6_frag_init'
> nf_conntrack_reasm.c:(.text+0x2398): undefined reference to `ip6_rhash_params'
> net/ipv6/netfilter/nf_conntrack_reasm.o: In function `nf_ct_frag6_expire':
> nf_conntrack_reasm.c:(.text+0x10bc): undefined reference to
> `ip6_expire_frag_queue'
> 
> I don't think we can get CONFIG_NF_DEFRAG_IPV6=y to work with IPV6=m.

Yes, not with current implementation, but I still don't think this
is unavoidable.

In case this is urgent I'm fine with the patch that adds the dependency,
otherwise I'd like to try and disentangle nf_conntrack_reasm and ipv6.
