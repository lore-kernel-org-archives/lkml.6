Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912C8C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 16:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F9B520862
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 16:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpsTamu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F9B520862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbeHSUCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 16:02:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbeHSUCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 16:02:05 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42C4D2084E;
        Sun, 19 Aug 2018 16:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534697400;
        bh=C17x5Fd3M8O+NocEBBvsIra2UYcqTeWE1vY1O+wY0nc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BpsTamu0vKj1fZzJsJGdIHs/SgVrXlXh8ySfMGXiwe7jdrRBoK5tZmfdLY7jGswuZ
         6ZFKiCEjHn5H3B1EWDwiQJdWJDsJNsh5tF/l7s2a+fwJrHu/vBHoFWTvdUSTb0soft
         EPQZbDckVOk0zZ43FyhWDZIh++W0ACCKgHrCCWcI=
Date:   Sun, 19 Aug 2018 17:49:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Agner <stefan@agner.ch>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: max9611: explicitly cast gain_selectors
Message-ID: <20180819174956.73ae1d90@archlinux>
In-Reply-To: <20180811091219.5048-1-stefan@agner.ch>
References: <20180811091219.5048-1-stefan@agner.ch>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Aug 2018 11:12:19 +0200
Stefan Agner <stefan@agner.ch> wrote:

> After finding a reasonable gain, the function converts the configured
> gain to a gain configuration option selector enum max9611_csa_gain.
> Make the conversion clearly visible by using an explicit cast. This
> also avoids a warning seen with clang:
>   drivers/iio/adc/max9611.c:292:16: warning: implicit conversion from
>       enumeration type 'enum max9611_conf_ids' to different enumeration
>       type 'enum max9611_csa_gain' [-Wenum-conversion]
>                         *csa_gain = gain_selectors[i];
>                                   ~ ^~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
Hmm. This is a somewhat odd code construct, but it kind of makes sense
as it enforces that we are using a subset of one enum for the other.

Not terribly pretty but not awful I guess.

This patch is fine given that.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/max9611.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> index 0538ff8c4ac1..643a4e66eb80 100644
> --- a/drivers/iio/adc/max9611.c
> +++ b/drivers/iio/adc/max9611.c
> @@ -289,7 +289,7 @@ static int max9611_read_csa_voltage(struct max9611_dev *max9611,
>  			return ret;
>  
>  		if (*adc_raw > 0) {
> -			*csa_gain = gain_selectors[i];
> +			*csa_gain = (enum max9611_csa_gain)gain_selectors[i];
>  			return 0;
>  		}
>  	}

