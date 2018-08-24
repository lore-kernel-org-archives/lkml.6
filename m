Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1501DC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 02:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E2AF2083B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 02:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E2AF2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbeHXFml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 01:42:41 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:45258 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725735AbeHXFml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 01:42:41 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ft1YD-0006Jr-0H; Fri, 24 Aug 2018 10:10:13 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ft1YA-0000nA-E6; Fri, 24 Aug 2018 10:10:10 +0800
Date:   Fri, 24 Aug 2018 10:10:10 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, Mike Snitzer <msnitzer@redhat.com>,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Deadlock when using crypto API for block devices
Message-ID: <20180824021010.hfar7gasp34ddrib@gondor.apana.org.au>
References: <alpine.LRH.2.02.1808231621220.8560@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1808231621220.8560@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 04:39:23PM -0400, Mikulas Patocka wrote:
>
> 1. don't set CRYPTO_TFM_REQ_MAY_SLEEP in dm-crypt
> =================================================
> If we don't set it, dm-crypt will use GFP_ATOMIC and GFP_ATOMIC may fail. 
> The function init_crypt in xts.c handles the failure gracefully - but the 
> question is - does the whole crypto code handle allocation failures 
> gracefully? If not and if it returns -ENOMEM somewhere, it would result in 
> I/O errors and data corruption.

It is safe to use GFP_ATOMIC.  First of the allocation is really
small (less than a page) so it will only fail when the system is
almost completely out of memory.  Even when it does fail the crypto
operation will still succeed, albeit it will process things at a
smaller granularity so the performance will degrade.

The sleeping part of that flag is also not an issue because it
only kicks in once per page.  As this is going to be less than
or equal to a page it shouldn't matter.
 
> 3. introduce new flag CRYPTO_TFM_REQ_MAY_SLEEP_NOIO
> ===================================================
> Would you like to introduce it?

For now I don't think this is necessary given that this allocation
and similar ones in lrw and other places in the crypto API are just
performance enhancements and unlikely to fail except in very dire
situations.

But if new problems arise I'm certainly not opposed to this.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
