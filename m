Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008BFC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA00021A0E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA00021A0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933042AbeGFOzy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:55:54 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38232 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753450AbeGFOzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:55:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9B55ED1;
        Fri,  6 Jul 2018 07:55:52 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 962143F2EA;
        Fri,  6 Jul 2018 07:55:51 -0700 (PDT)
Date:   Fri, 6 Jul 2018 15:55:49 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     David Ahern <dsahern@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        "David S . Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org
Subject: Re: [PATCH] ipv4: fib: avoid NULL dereference
Message-ID: <20180706145548.kirmwesxx5nviwyj@lakrids.cambridge.arm.com>
References: <20180706142836.1822-1-mark.rutland@arm.com>
 <92672813-153a-eccb-dbee-4b59bbf657f1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92672813-153a-eccb-dbee-4b59bbf657f1@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 08:49:14AM -0600, David Ahern wrote:
> On 7/6/18 8:28 AM, Mark Rutland wrote:
> > diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
> > index 5bc0c89e81e4..8d98c8162554 100644
> > --- a/net/ipv4/fib_trie.c
> > +++ b/net/ipv4/fib_trie.c
> > @@ -497,11 +497,11 @@ static void tnode_free(struct key_vector *tn)
> >  	struct callback_head *head = &tn_info(tn)->rcu;
> >  
> >  	while (head) {
> > +		tn = container_of(head, struct tnode, rcu)->kv;
> > +
> >  		head = head->next;
> >  		tnode_free_size += TNODE_SIZE(1ul << tn->bits);
> >  		node_free(tn);
> 
> you are changing tn before the above 2 calls are made on the tn passed in

As tn_info(tn) is container_of(kv, struct tnode, tn), the end result is
the same tn value, so this is not a problem.

Thanks,
Mark.
