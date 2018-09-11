Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28745C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 05:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4A320854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 05:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4A320854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbeIKKug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 06:50:36 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:48696 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbeIKKug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 06:50:36 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fzbbM-0003xh-Py; Tue, 11 Sep 2018 13:52:40 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fzbbC-00062p-8P; Tue, 11 Sep 2018 13:52:30 +0800
Date:   Tue, 11 Sep 2018 13:52:30 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Alexander Stein <alexander.stein@systec-electronic.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Arnaud Ebalard <arno@natisbad.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Christian Lamparter <chunkeey@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/4] crypto: skcipher - Enforce non-ASYNC for on-stack
 requests
Message-ID: <20180911055230.iiiq2uu5gczlwjon@gondor.apana.org.au>
References: <20180906225854.40989-1-keescook@chromium.org>
 <20180906225854.40989-3-keescook@chromium.org>
 <20180907034242.zhm4dglzkldhvh3x@gondor.apana.org.au>
 <CAKv+Gu9kHpBTKjQKA3W4Q424FeY+Zq4srq2-r0MxjfCNKHT_5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9kHpBTKjQKA3W4Q424FeY+Zq4srq2-r0MxjfCNKHT_5A@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 08:56:23AM +0200, Ard Biesheuvel wrote:
>
> OK, so given that all SKCIPHER_REQUEST_ON_STACK occurrences are
> updated in this series anyway, perhaps we should add
> skcipher_[en|de]crypt_onstack() flavors that encapsulate the
> additional check? Only question is how to enforce at compile time that
> those are used instead of the ordinary ones when using a stack
> allocated request. Would you mind using some macro foo here involving
> __builtin_types_compatible_p() ?

Something like a completely new type which in reality is just a
wrapper around skcipher:

	struct crypto_sync_skcipher {
		struct crypto_skcipher base;
	} tfm;

	tfm = crypto_alloc_sync_skcipher(...);

	crypto_sync_skcipher_encrypt(...)
	crypto_sync_skcipher_decrypt(...)

These functions would just be trivial inline functions around their
crypto_skcipher counterparts.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
