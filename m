Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0029CC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0AD2159D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE0AD2159D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbeI1La0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 07:30:26 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:42528 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbeI1LaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 07:30:25 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1g5l0q-0008VY-Ri; Fri, 28 Sep 2018 13:08:24 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1g5l0p-0005wW-4h; Fri, 28 Sep 2018 13:08:23 +0800
Date:   Fri, 28 Sep 2018 13:08:23 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH crypto-next 00/23] crypto: skcipher - Remove VLA usage
Message-ID: <20180928050823.pggznhgv47wu4pd4@gondor.apana.org.au>
References: <20180919021100.3380-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919021100.3380-1-keescook@chromium.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 07:10:37PM -0700, Kees Cook wrote:
> This is the full follow-up to earlier discussions[1] that suggested
> adding a new struct crypto_sync_skcipher to handle the VLA removal from
> SKCIPHER_REQUEST_ON_STACK.
> 
> This series is effectively a no-op change: everything is a wrapper
> around struct crypto_skcipher, but provides compile-time enforcement
> for not putting an ASYNC skcipher on the stack, which allows us to
> declare the on-stack requests with a fixed stack size.
> 
> [1] https://lkml.kernel.org/r/CAGXu5j+bpLK=EQ9LHkO8V=sdaQwt==6fbGhgn2Vi1E9_WxSGRQ@mail.gmail.com
> 
> -Kees
> 
> Kees Cook (23):
>   crypto: skcipher - Introduce crypto_sync_skcipher
>   gss_krb5: Remove VLA usage of skcipher
>   lib80211: Remove VLA usage of skcipher
>   mac802154: Remove VLA usage of skcipher
>   s390/crypto: Remove VLA usage of skcipher
>   x86/fpu: Remove VLA usage of skcipher
>   block: cryptoloop: Remove VLA usage of skcipher
>   libceph: Remove VLA usage of skcipher
>   ppp: mppe: Remove VLA usage of skcipher
>   rxrpc: Remove VLA usage of skcipher
>   wusb: Remove VLA usage of skcipher
>   crypto: ccp - Remove VLA usage of skcipher
>   crypto: vmx - Remove VLA usage of skcipher
>   crypto: null - Remove VLA usage of skcipher
>   crypto: cryptd - Remove VLA usage of skcipher
>   crypto: sahara - Remove VLA usage of skcipher
>   crypto: qce - Remove VLA usage of skcipher
>   crypto: artpec6 - Remove VLA usage of skcipher
>   crypto: chelsio - Remove VLA usage of skcipher
>   crypto: mxs-dcp - Remove VLA usage of skcipher
>   crypto: omap-aes - Remove VLA usage of skcipher
>   crypto: picoxcell - Remove VLA usage of skcipher
>   crypto: skcipher - Remove SKCIPHER_REQUEST_ON_STACK()
> 
>  arch/s390/crypto/aes_s390.c                   | 48 +++++-----
>  arch/x86/crypto/fpu.c                         | 30 ++++---
>  crypto/algif_aead.c                           | 12 +--
>  crypto/authenc.c                              |  8 +-
>  crypto/authencesn.c                           |  8 +-
>  crypto/cryptd.c                               | 32 +++----
>  crypto/crypto_null.c                          | 11 ++-
>  crypto/echainiv.c                             |  4 +-
>  crypto/gcm.c                                  |  8 +-
>  crypto/seqiv.c                                |  4 +-
>  crypto/skcipher.c                             | 24 +++++
>  drivers/block/cryptoloop.c                    | 22 ++---
>  drivers/crypto/axis/artpec6_crypto.c          | 19 ++--
>  drivers/crypto/ccp/ccp-crypto-aes-xts.c       | 13 +--
>  drivers/crypto/ccp/ccp-crypto.h               |  2 +-
>  drivers/crypto/chelsio/chcr_algo.c            | 27 +++---
>  drivers/crypto/chelsio/chcr_crypto.h          |  2 +-
>  drivers/crypto/mxs-dcp.c                      | 21 +++--
>  drivers/crypto/omap-aes.c                     | 17 ++--
>  drivers/crypto/omap-aes.h                     |  2 +-
>  drivers/crypto/picoxcell_crypto.c             | 21 +++--
>  drivers/crypto/qce/ablkcipher.c               | 13 ++-
>  drivers/crypto/qce/cipher.h                   |  2 +-
>  drivers/crypto/sahara.c                       | 31 ++++---
>  drivers/crypto/vmx/aes_cbc.c                  | 22 ++---
>  drivers/crypto/vmx/aes_ctr.c                  | 18 ++--
>  drivers/crypto/vmx/aes_xts.c                  | 18 ++--
>  drivers/net/ppp/ppp_mppe.c                    | 27 +++---
>  drivers/staging/rtl8192e/rtllib_crypt_tkip.c  | 34 ++++----
>  drivers/staging/rtl8192e/rtllib_crypt_wep.c   | 28 +++---
>  .../rtl8192u/ieee80211/ieee80211_crypt_tkip.c | 34 ++++----
>  .../rtl8192u/ieee80211/ieee80211_crypt_wep.c  | 26 +++---
>  drivers/usb/wusbcore/crypto.c                 | 16 ++--
>  include/crypto/internal/geniv.h               |  2 +-
>  include/crypto/null.h                         |  2 +-
>  include/crypto/skcipher.h                     | 74 +++++++++++++++-
>  include/linux/sunrpc/gss_krb5.h               | 30 +++----
>  net/ceph/crypto.c                             | 12 +--
>  net/ceph/crypto.h                             |  2 +-
>  net/mac802154/llsec.c                         | 16 ++--
>  net/mac802154/llsec.h                         |  2 +-
>  net/rxrpc/ar-internal.h                       |  2 +-
>  net/rxrpc/rxkad.c                             | 44 +++++-----
>  net/sunrpc/auth_gss/gss_krb5_crypto.c         | 87 ++++++++++---------
>  net/sunrpc/auth_gss/gss_krb5_keys.c           |  9 +-
>  net/sunrpc/auth_gss/gss_krb5_mech.c           | 53 ++++++-----
>  net/sunrpc/auth_gss/gss_krb5_seqnum.c         | 18 ++--
>  net/sunrpc/auth_gss/gss_krb5_wrap.c           | 20 ++---
>  net/wireless/lib80211_crypt_tkip.c            | 34 ++++----
>  net/wireless/lib80211_crypt_wep.c             | 28 +++---
>  50 files changed, 563 insertions(+), 476 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
