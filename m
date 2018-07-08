Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F79C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 11:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43AF4208AF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 11:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wEnWgVCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43AF4208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932893AbeGHLFh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 07:05:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932776AbeGHLFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 07:05:35 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36406208A1;
        Sun,  8 Jul 2018 11:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531047934;
        bh=uVsNvPxUyafXlJGflqCWrHP5zCNlrd0KFuAdrLXAVcM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wEnWgVCkpRrbqAXE2I/0eBGyua7BYDqCPp+hYfCrtWj2Jj1te438qtUjWPBl6bjZg
         QPFt9GOrmgBkKxmQESvgl4Tyzsmc0cgPEtvPuO8/UwY92LAtZtKT0+CflzMVRghBDk
         NvETLmHc4syj/v1gSvKfcMZ1UIIxMDn/3rx0H+d4=
Date:   Sun, 8 Jul 2018 12:05:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: sca3000: Fix missing return in switch
Message-ID: <20180708120530.0de30fcc@archlinux>
In-Reply-To: <20180707174401.GA11730@embeddedor.com>
References: <20180707174401.GA11730@embeddedor.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Jul 2018 12:44:01 -0500
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> The IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY case is missing a
> return and will fall through to the default case and errorenously
> return -EINVAL.
> 
> Fix this by adding in missing *return ret*.
> 
> Fixes: 626f971b5b07 ("staging:iio:accel:sca3000 Add write support to the low pass filter control")
> Reported-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Thanks, Applied to the fixes-togreg branch of iio.git, marked for stable.

Jonathan
> ---
>  drivers/iio/accel/sca3000.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index 4dceb75..4964561 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -797,6 +797,7 @@ static int sca3000_write_raw(struct iio_dev *indio_dev,
>  		mutex_lock(&st->lock);
>  		ret = sca3000_write_3db_freq(st, val);
>  		mutex_unlock(&st->lock);
> +		return ret;
>  	default:
>  		return -EINVAL;
>  	}

