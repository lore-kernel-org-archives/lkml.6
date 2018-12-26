Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C344DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 17:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92EFC21900
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 17:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbeLZRoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 12:44:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57402 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727285AbeLZRoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 12:44:19 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E08FF8B101;
        Wed, 26 Dec 2018 17:44:18 +0000 (UTC)
Received: from redhat.com (ovpn-120-80.rdu2.redhat.com [10.10.120.80])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3A60D604CC;
        Wed, 26 Dec 2018 17:44:17 +0000 (UTC)
Date:   Wed, 26 Dec 2018 12:44:16 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Buesch <m@bues.ch>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: hw_random: Fix missing check during driver release
Message-ID: <20181226124405-mutt-send-email-mst@kernel.org>
References: <20181226172332.6365-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181226172332.6365-1-pakki001@umn.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 26 Dec 2018 17:44:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 11:23:31AM -0600, Aditya Pakki wrote:
> devres_release can return -ENOENT if the device is not freed. The fix
> throws a warning consistent with other invocations.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

Well why not

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> ---
>  drivers/char/hw_random/core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
> index 95be7228f327..582d983fa93f 100644
> --- a/drivers/char/hw_random/core.c
> +++ b/drivers/char/hw_random/core.c
> @@ -578,7 +578,11 @@ EXPORT_SYMBOL_GPL(devm_hwrng_register);
>  
>  void devm_hwrng_unregister(struct device *dev, struct hwrng *rng)
>  {
> -	devres_release(dev, devm_hwrng_release, devm_hwrng_match, rng);
> +	int rc;
> +
> +	rc = devres_release(dev, devm_hwrng_release, devm_hwrng_match, rng);
> +	if (rc)
> +		WARN_ON(rc);
>  }
>  EXPORT_SYMBOL_GPL(devm_hwrng_unregister);
>  
> -- 
> 2.17.1
