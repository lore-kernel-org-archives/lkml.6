Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5015BC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 17:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3C620841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 17:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESrhnnP4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA3C620841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbeIBWJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 18:09:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbeIBWJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 18:09:12 -0400
Received: from archlinux (unknown [176.12.107.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CF7B20841;
        Sun,  2 Sep 2018 17:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535910759;
        bh=Tpw0Bh5g2MGbEK9tMelk2AYAN2jxNmx7+Rn5Kh0WJxc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ESrhnnP4mjAyP2OIJSo9j5TK77o4SOqa+jWK6uBLEBaq7x3moyMDyhFzAvr7FtOk4
         sCnZbwHGkHoSbD2IyrHfQEAHqM2kXfSD6r7HAyu5mK3sJ/2Z2t9YkJz2oXUVlCdu8g
         7MgODeqiQTeqtywHr2bl32f0JrUHp29U67GMaA+o=
Date:   Sun, 2 Sep 2018 18:52:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] iio: adc: qcom-spmi-adc5: Verify channel numbers from
 DT
Message-ID: <20180902185228.2eadbce6@archlinux>
In-Reply-To: <20180827211453.213061-1-mka@chromium.org>
References: <20180827211453.213061-1-mka@chromium.org>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2018 14:14:53 -0700
Matthias Kaehlcke <mka@chromium.org> wrote:

> The driver only defines a subset of all possible ADC channels. Channel
> numbers read from the device tree are accepted as long as they don't
> exceed a max value, even when no channel definition exists. Add a
> check to abort initialization in this case.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks for tidying this up.

Jonathan

> ---
>  drivers/iio/adc/qcom-spmi-adc5.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> index 9c8e6f9e8248..ab5bec917c0a 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> @@ -519,7 +519,8 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
>  		return ret;
>  	}
>  
> -	if (chan > ADC5_PARALLEL_ISENSE_VBAT_IDATA) {
> +	if (chan > ADC5_PARALLEL_ISENSE_VBAT_IDATA ||
> +	    !data->adc_chans[chan].datasheet_name) {
>  		dev_err(dev, "%s invalid channel number %d\n", name, chan);
>  		return -EINVAL;
>  	}

