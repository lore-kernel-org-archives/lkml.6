Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CEAC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84F1214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84F1214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeJQOQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 10:16:54 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:37464 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbeJQOQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 10:16:54 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gCfDa-0001xF-Ig; Wed, 17 Oct 2018 14:22:06 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gCfDW-000488-EV; Wed, 17 Oct 2018 14:22:02 +0800
Date:   Wed, 17 Oct 2018 14:22:02 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Gilad Ben-Yossef <gilad@benyossef.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] crypto: ccree - avoid implicit enum conversion
Message-ID: <20181017062202.yrwriuzsmbvgnapl@gondor.apana.org.au>
References: <20181010214006.21304-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010214006.21304-1-natechancellor@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 02:40:07PM -0700, Nathan Chancellor wrote:
> Clang warns when one enumerated type is implicitly converted to another
> and this happens in several locations in this driver, ultimately related
> to the set_cipher_{mode,config0} functions. set_cipher_mode expects a mode
> of type drv_cipher_mode and set_cipher_config0 expects a mode of type
> drv_crypto_direction.
> 
> drivers/crypto/ccree/cc_ivgen.c:58:35: warning: implicit conversion from
> enumeration type 'enum cc_desc_direction' to different enumeration type
> 'enum drv_crypto_direction' [-Wenum-conversion]
>         set_cipher_config0(&iv_seq[idx], DESC_DIRECTION_ENCRYPT_ENCRYPT);
> 
> drivers/crypto/ccree/cc_hash.c:99:28: warning: implicit conversion from
> enumeration type 'enum cc_hash_conf_pad' to different enumeration type
> 'enum drv_crypto_direction' [-Wenum-conversion]
>                 set_cipher_config0(desc, HASH_DIGEST_RESULT_LITTLE_ENDIAN);
> 
> drivers/crypto/ccree/cc_aead.c:1643:30: warning: implicit conversion
> from enumeration type 'enum drv_hash_hw_mode' to different enumeration
> type 'enum drv_cipher_mode' [-Wenum-conversion]
>         set_cipher_mode(&desc[idx], DRV_HASH_HW_GHASH);
> 
> Since this fundamentally isn't a problem because these values just
> represent simple integers for a shift operation, make it clear to Clang
> that this is okay by making the mode parameter in both functions an int.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/46
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> 
> Alternatively:
> 
> 1. The uses of DESC_DIRECTION_ENCRYPT_ENCRYPT could be replaced with
>    DRV_CRYPTO_DIRECTION_ENCRYPT since they are the same value.
> 
> 2. An enum of value 2 could be added to drv_crypto_direction which is
>    what HASH_DIGEST_RESULT_LITTLE_ENDIAN is equal to (not sure what that
>    should be named).
> 
> 3. DRV_HASH_HW_GHASH could be removed and replaced with DRV_CIPHER_OFB
>    since they are the same value.
> 
> This patch seems to make the most sense to me given that the enums are
> just functioning as integers but I'm willing to fix this however the
> maintainers want.
> 
>  drivers/crypto/ccree/cc_hw_queue_defs.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
