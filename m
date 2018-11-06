Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B3FC46464
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 01:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF22D20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 01:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yVBZN4Nd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF22D20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbeKFLEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 06:04:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:54568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbeKFLEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 06:04:08 -0500
Received: from gmail.com (unknown [104.132.51.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA85C2085B;
        Tue,  6 Nov 2018 01:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541468488;
        bh=QZKteHFaC0ERPCbARleGQvXPWi/L775b2m7wGNnyBEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yVBZN4NdAn8dIElL4YMQNv4OcwJlW56m1rOnHNDZ5JSCVgdDnpwhte6NA0z+PuTLO
         jJMMwB84bz9F8soG4pReiw/3CiPPelAigybf8XJLN6gir8Vgoc80H9t0tMLXswYibU
         x1y9Z6LHeeBcnBXdi4NN7FgK+rQY9DTLHzdJOG5w=
Date:   Mon, 5 Nov 2018 17:41:27 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] crypto: crypto_user_stat: made crypto_user_stat
 optional
Message-ID: <20181106014126.GC28490@gmail.com>
References: <1541422274-40060-1-git-send-email-clabbe@baylibre.com>
 <1541422274-40060-2-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541422274-40060-2-git-send-email-clabbe@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corentin,

On Mon, Nov 05, 2018 at 12:51:10PM +0000, Corentin Labbe wrote:
> Even if CRYPTO_STATS is set to n, some part of CRYPTO_STATS are
> compiled.
> This patch made all part of crypto_user_stat uncompiled in that case.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  crypto/Makefile                      |  3 ++-
>  crypto/algapi.c                      |  2 ++
>  include/crypto/internal/cryptouser.h | 17 +++++++++++++++++
>  include/linux/crypto.h               |  2 ++
>  4 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/crypto/Makefile b/crypto/Makefile
> index 5c207c76abf7..1e9e5960946a 100644
> --- a/crypto/Makefile
> +++ b/crypto/Makefile
> @@ -54,7 +54,8 @@ cryptomgr-y := algboss.o testmgr.o
>  
>  obj-$(CONFIG_CRYPTO_MANAGER2) += cryptomgr.o
>  obj-$(CONFIG_CRYPTO_USER) += crypto_user.o
> -crypto_user-y := crypto_user_base.o crypto_user_stat.o
> +crypto_user-y := crypto_user_base.o
> +crypto_user-$(CONFIG_CRYPTO_STATS) += crypto_user_stat.o
>  obj-$(CONFIG_CRYPTO_CMAC) += cmac.o
>  obj-$(CONFIG_CRYPTO_HMAC) += hmac.o
>  obj-$(CONFIG_CRYPTO_VMAC) += vmac.o

Doesn't CONFIG_CRYPTO_STATS also need to depend on CONFIG_CRYPTO_USER?
Currently you can enable it but without CRYPTO_USER the API won't be available.

config CRYPTO_STATS
	bool "Crypto usage statistics for User-space"

should be:

config CRYPTO_STATS
	bool "Crypto usage statistics for User-space"
	depends on CRYPTO_USER

> diff --git a/include/linux/crypto.h b/include/linux/crypto.h
> index 3634ad6fe202..35de61d99cd5 100644
> --- a/include/linux/crypto.h
> +++ b/include/linux/crypto.h
> @@ -515,6 +515,7 @@ struct crypto_alg {
>  	
>  	struct module *cra_module;
>  
> +#ifdef CONFIG_CRYPTO_STATS
>  	union {
>  		atomic_t encrypt_cnt;
>  		atomic_t compress_cnt;
> @@ -552,6 +553,7 @@ struct crypto_alg {
>  		atomic_t compute_shared_secret_cnt;
>  	};
>  	atomic_t sign_cnt;
> +#endif

This is a long ifdef, so use:

#endif /* CONFIG_CRYPTO_STATS */

- Eric
