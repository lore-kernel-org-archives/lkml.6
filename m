Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7888CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 02:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD7C206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 02:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD7C206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439500AbeKWNSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 08:18:46 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:43264 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbeKWNSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 08:18:45 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gQ1KV-0007mW-Ha; Fri, 23 Nov 2018 10:36:27 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gQ1KT-0003Z6-It; Fri, 23 Nov 2018 10:36:25 +0800
Date:   Fri, 23 Nov 2018 10:36:25 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     PanBian <bianpan2016@163.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: do not free algorithm before using
Message-ID: <20181123023625.oguwfmhhi2su6etr@gondor.apana.org.au>
References: <1542880816-63838-1-git-send-email-bianpan2016@163.com>
 <20181122144441.tkfmrq3lzibq2g3y@gondor.apana.org.au>
 <20181123010555.GA83154@bp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123010555.GA83154@bp>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 09:05:55AM +0800, PanBian wrote:
>
> Thanks for your explanation! But I find that the function
> crypto_init_spawn just lets spawn->alg point to the algorithm without 
> increasing the reference count, i.e., alg->cra_refcnt. So I am confused
> about how this can protect the algorithm from being freed. Maybe I
> missed some key points. Could you please explain it in more details?

Oh you're right! This bug was introduced during the skcipher
conversion.  The spawns are not meant to carry a reference count
with them because they are not supposed to stop the underlying
algorithm from being removed.  So yes we do need to hold a reference
count on alg until the instance is registered.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
