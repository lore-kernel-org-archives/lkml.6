Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEA4C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191B0214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbfAJN0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:26:54 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:59550 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbfAJN0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:26:53 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ghaLt-0001Tw-Eh; Thu, 10 Jan 2019 21:26:29 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ghaLm-0000Vs-MB; Thu, 10 Jan 2019 21:26:22 +0800
Date:   Thu, 10 Jan 2019 21:26:22 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Matt Mackall <mpm@selenic.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, Michael Buesch <m@bues.ch>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] hwrng: core: Fix missing check during driver release
Message-ID: <20190110132622.ni5lshjmhmsydaal@gondor.apana.org.au>
References: <20190106172613.10913-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190106172613.10913-1-pakki001@umn.edu>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 06, 2019 at 11:26:12AM -0600, Aditya Pakki wrote:
> devres_release can return -ENOENT if the device is not freed. The fix
> throws a warning consistent with other invocations.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/char/hw_random/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
> index 95be7228f327..1b05da40626a 100644
> --- a/drivers/char/hw_random/core.c
> +++ b/drivers/char/hw_random/core.c
> @@ -578,7 +578,8 @@ EXPORT_SYMBOL_GPL(devm_hwrng_register);
>  
>  void devm_hwrng_unregister(struct device *dev, struct hwrng *rng)
>  {
> -	devres_release(dev, devm_hwrng_release, devm_hwrng_match, rng);
> +	WARN_ON(devres_release(dev, devm_hwrng_release,
> +				devm_hwrng_match, rng));

Hmm please don't perform real operations within a WARN_ON.  This
is potentially confusing to the reader.  If you had to do this, do
it like

	err = devres_release(...);
	WARN_ON(err);

I'd also like to know under what circumstances can you get an
-ENOENT?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
