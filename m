Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D55C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 16:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7046520779
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 16:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMy6d6Qo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7046520779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbeHSThS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 15:37:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbeHSThS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 15:37:18 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42F0B20779;
        Sun, 19 Aug 2018 16:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534695918;
        bh=DZ/3L7AmLPBaTaCXAlKBD5TYNAX6eJZYWnnXpKEwwSw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eMy6d6QoNIcsmgOKDQVmeLmPaqIzXszsI9yHIfgoEcea/Weug9it/oDrCMfotPtZW
         krjbkiOLLQcdt1UtzXwMeS7+QNQRMbtPue3aHAvijZ2ncRB2kMnLpcI7wjOghGMf4v
         ckJ8k8076zvSM5AWjmflL1HDc6Vmy3b2Imq+YDCc=
Date:   Sun, 19 Aug 2018 17:25:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Himanshu Jha <himanshujha199640@gmail.com>
Cc:     dpfrey@gmail.com, daniel.baluta@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: bme680: Add check for val2 in the
 write_raw function
Message-ID: <20180819172514.370d34fb@archlinux>
In-Reply-To: <20180811102636.6171-1-himanshujha199640@gmail.com>
References: <20180811102636.6171-1-himanshujha199640@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Aug 2018 15:56:36 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> val2 is responsible for the floating part of the number to be
> written to the device. We don't need the floating part
> while writing the oversampling ratio for BME680 since the
> available oversampling ratios are pure natural numbers.
> 
> So, add a sanity check to make sure val2 is 0.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>

As discussed in David's patch series v3, I think this is still relevant
but now needs an update to cover the new code.

Thanks,

Jonathan

> ---
>  drivers/iio/chemical/bme680_core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> index 7d9bb62baa3f..9d5a05e054d1 100644
> --- a/drivers/iio/chemical/bme680_core.c
> +++ b/drivers/iio/chemical/bme680_core.c
> @@ -852,6 +852,9 @@ static int bme680_write_raw(struct iio_dev *indio_dev,
>  {
>  	struct bme680_data *data = iio_priv(indio_dev);
>  
> +	if (val2 != 0)
> +		return -EINVAL;
> +
>  	switch (mask) {
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>  		switch (chan->type) {

