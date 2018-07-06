Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FD4C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C847223E08
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:55:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C847223E08
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932898AbeGFNzb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:55:31 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:52802 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753075AbeGFNz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:55:29 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1fbRCe-0007Fh-Mf; Fri, 06 Jul 2018 15:55:16 +0200
Date:   Fri, 6 Jul 2018 15:55:16 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        =?iso-8859-15?Q?M=E1t=E9?= Eckl <ecklm94@gmail.com>,
        Fernando Fernandez Mancera <ffmancera@riseup.net>,
        "Pablo M. Bermudo Garay" <pablombg@gmail.com>,
        Felix Fietkau <nbd@nbd.name>, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfilter: conntrack: add weak IPV6 dependency
Message-ID: <20180706135516.viz6pjtkdmcoqq2l@breakpoint.cc>
References: <20180706130005.3640993-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706130005.3640993-1-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> wrote:
> Now that the conntrack module contains code for ipv6, we can no longer
> have it built-in while IPv6 itself is a loadable module:
> 
> net/netfilter/nf_conntrack_proto.o: In function `nf_ct_netns_do_get':
> nf_conntrack_proto.c:(.text+0x88c): undefined reference to `nf_defrag_ipv6_enable'

AFAICS this is caused by

CONFIG_NF_CONNTRACK=y
CONFIG_IPV6=m
CONFIG_NF_DEFRAG_IPV6=m

This is exported via nf_defrag_ipv6.ko.

nf_defrag_ipv6 has an ipv6 dependency, but i think it might be avoidable
so this would work:

CONFIG_NF_CONNTRACK=y
CONFIG_NF_DEFRAG_IPV6=y
CONFIG_IPV6=m
