Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D328AC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8693220851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:32:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8693220851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbeLCXcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:32:11 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:49838 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeLCXcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:32:11 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3C330133E98E5;
        Mon,  3 Dec 2018 15:32:10 -0800 (PST)
Date:   Mon, 03 Dec 2018 15:32:09 -0800 (PST)
Message-Id: <20181203.153209.2147928207639502351.davem@davemloft.net>
To:     neilb@suse.com
Cc:     herbert@gondor.apana.org.au, tgraf@suug.ch, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v3] rhashtable: detect when object movement between
 tables might have invalidated a lookup
From:   David Miller <davem@davemloft.net>
In-Reply-To: <87pnuno479.fsf@notabene.neil.brown.name>
References: <20181116055551.zxfydbpoicslsfkg@gondor.apana.org.au>
        <878t1tece0.fsf@notabene.neil.brown.name>
        <87pnuno479.fsf@notabene.neil.brown.name>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 03 Dec 2018 15:32:10 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: NeilBrown <neilb@suse.com>
Date: Fri, 30 Nov 2018 10:26:50 +1100

> 
> Some users of rhashtables might need to move an object from one table
> to another -  this appears to be the reason for the incomplete usage
> of NULLS markers.
> 
> To support these, we store a unique NULLS_MARKER at the end of
> each chain, and when a search fails to find a match, we check
> if the NULLS marker found was the expected one.  If not, the search
> may not have examined all objects in the target bucket, so it is
> repeated.
> 
> The unique NULLS_MARKER is derived from the address of the
> head of the chain.  As this cannot be derived at load-time the
> static rhnull in rht_bucket_nested() needs to be initialised
> at run time.
> 
> Any caller of a lookup function must still be prepared for the
> possibility that the object returned is in a different table - it
> might have been there for some time.
> 
> Note that this does NOT provide support for other uses of
> NULLS_MARKERs such as allocating with SLAB_TYPESAFE_BY_RCU or changing
> the key of an object and re-inserting it in the same table.
> These could only be done safely if new objects were inserted
> at the *start* of a hash chain, and that is not currently the case.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>

Applied to net-next.
