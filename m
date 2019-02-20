Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B88BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 019012146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfBTKXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:23:51 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:41702 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfBTKXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:23:50 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gwP2R-0005kS-Qr; Wed, 20 Feb 2019 18:23:39 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gwP2F-00022M-7l; Wed, 20 Feb 2019 18:23:27 +0800
Date:   Wed, 20 Feb 2019 18:23:27 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Thomas Graf <tgraf@suug.ch>,
        syzbot <syzbot+bc5ab0af2dbf3b0ae897@syzkaller.appspotmail.com>,
        bridge@lists.linux-foundation.org,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: use-after-free Read in br_mdb_ip_get
Message-ID: <20190220102327.lq2zyqups2fso75z@gondor.apana.org.au>
References: <000000000000862b160580765e94@google.com>
 <3c44c1ff-2790-ec06-35c6-3572b92170c7@cumulusnetworks.com>
 <CACT4Y+ZA8gBURbeZaDtrt5NoqFy8a8W3jyaWbs34Qjic4Bu+DA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZA8gBURbeZaDtrt5NoqFy8a8W3jyaWbs34Qjic4Bu+DA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 09:28:36AM +0100, Dmitry Vyukov wrote:
>
> > Weird, this is the kfree() on the error path of br_multicast_new_group()
> > when rhashtable_lookup_insert_fast() fails, which means the entry should
> > not be linked in the rhashtable or the hlist.
> > All other frees are via kfree_rcu. I'll keep looking..
> 
> Humm.... +rhashtable.c maintianers
> 
> The code in br_multicast_new_group is effectively:
> 
> mp = kzalloc(sizeof(*mp), GFP_ATOMIC);
> err = rhashtable_lookup_insert_fast(&br->mdb_hash_tbl, &mp->rhnode,
> br_mdb_rht_params);
> if (err)
>     kfree(mp);
> 
> So it looks like rhashtable_lookup_insert_fast both returned an error
> and left the new object linked in the table. Since it happened only
> once, it may have something to do with concurrent resizing/shrinking.

I've looked through the rhashtable code in question and everything
looks OK.  So I suspect some earlier corruption has occured to cause
this anomalous result.  Is it possible to collect earlier alloc/free
stack traces on the object in question?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
