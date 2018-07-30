Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DA3C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5928C20894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0ig1BV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5928C20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731986AbeG3Upm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 16:45:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730400AbeG3Upm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 16:45:42 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C97820857;
        Mon, 30 Jul 2018 19:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532977759;
        bh=iEir1ujIilHpJcTMGIDR6n0a6IxEnLJen5859mfMX6k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h0ig1BV22TlruLzrIIxl55qWKaNNqLFNY3XVDnTdaGzG5y07u1CfFdpEUsiLMKKIS
         S1Wf2slJP3HnTycIYO0srpb9N4B7ob1MuffA+76E29QKq7Ymd0k7A+GTLnXUUXFjcs
         wYaSOtswiWnRRgQm5A5lRaQ/EAx8Y/YS/vRlM6T4=
Date:   Mon, 30 Jul 2018 20:09:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: fix test for val being not zero or not one.
Message-ID: <20180730200914.7becfa32@archlinux>
In-Reply-To: <20180730125918.7100-1-colin.king@canonical.com>
References: <20180730125918.7100-1-colin.king@canonical.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jul 2018 13:59:18 +0100
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> The current check on val always results in true and so the
> call to sii1133_update_adcsens never gets called. Fix this check
> so it returns with -EINVAL only when val is not zero and not one.
> 
> Detected by CoverityScan, CID#1472099 ("Logically dead code")
> 
> Fixes: e01e7eaf37d8 ("iio: light: introduce si1133")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks!,

Applied to the fixes-togreg branch of iio.git. Will send upstream after
the merge window closes now.

Jonathan

> ---
>  drivers/iio/light/si1133.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
> index d3fbeb3bc463..5ac22c46da1f 100644
> --- a/drivers/iio/light/si1133.c
> +++ b/drivers/iio/light/si1133.c
> @@ -838,7 +838,7 @@ static int si1133_write_raw(struct iio_dev *iio_dev,
>  		switch (chan->type) {
>  		case IIO_INTENSITY:
>  		case IIO_UVINDEX:
> -			if (val != 0 || val != 1)
> +			if (val != 0 && val != 1)
>  				return -EINVAL;
>  
>  			return si1133_update_adcsens(data,

