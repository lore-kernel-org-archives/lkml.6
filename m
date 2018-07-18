Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29865ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE9320854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE9320854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbeGRUyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 16:54:11 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:42752 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730123AbeGRUyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 16:54:10 -0400
Received: from localhost (179-64-212-66.spl.org [66.212.64.179])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B51191473D1B4;
        Wed, 18 Jul 2018 13:14:40 -0700 (PDT)
Date:   Thu, 19 Jul 2018 05:14:40 +0900 (KST)
Message-Id: <20180719.051440.931407144963903326.davem@davemloft.net>
To:     neilb@suse.com
Cc:     herbert@gondor.apana.org.au, tgraf@suug.ch, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH - revised] rhashtable: detect when object movement
 might have invalidated a lookup
From:   David Miller <davem@davemloft.net>
In-Reply-To: <87fu0kt5m0.fsf@notabene.neil.brown.name>
References: <20180711.224658.2077863065492745521.davem@davemloft.net>
        <20180711.224801.1129067473269289703.davem@davemloft.net>
        <87fu0kt5m0.fsf@notabene.neil.brown.name>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 18 Jul 2018 13:14:40 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: NeilBrown <neilb@suse.com>
Date: Mon, 16 Jul 2018 09:57:11 +1000

> Some users of rhashtable might need to change the key
> of an object and move it to a different location in the table.
> Other users might want to allocate objects using
> SLAB_TYPESAFE_BY_RCU which can result in the same memory allocation
> being used for a different (type-compatible) purpose and similarly
> end up in a different hash-chain.
> 
> To support these, we store a unique NULLS_MARKER at the end of
> each chain, and when a search fails to find a match, we check
> if the NULLS marker found was the expected one.  If not,
> the search is repeated.
> 
> The unique NULLS_MARKER is derived from the address of the
> head of the chain.
> 
> If an object is removed and re-added to the same hash chain, we won't
> notice by looking that the NULLS marker.  In this case we must be sure
> that it was not re-added *after* its original location, or a lookup may
> incorrectly fail.  The easiest solution is to ensure it is inserted at
> the start of the chain.  insert_slow() already does that,
> insert_fast() does not.  So this patch changes insert_fast to always
> insert at the head of the chain.
> 
> Note that such a user must do their own double-checking of
> the object found by rhashtable_lookup_fast() after ensuring
> mutual exclusion which anything that might change the key, such as
> successfully taking a new reference.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>

Neil I have to be honest with you.

During this whole ordeal I was under the impression that this was all
going to be used for something in-tree.  But now I see that you want
to use all of this stuff for lustre which is out of tree.

It would be extremely hard for me to accept adding this kind of
complexity and weird semantics to an already extremely complicated
and delicate piece of infrastructure if something in-tree would use
it.

But for something out-of-tree?  I'm sorry, no way.
