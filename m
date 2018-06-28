Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FCCC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4590E2712B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4590E2712B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934816AbeF1JFk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:05:40 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37418 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932274AbeF1JFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:05:30 -0400
Received: by mail-wm0-f65.google.com with SMTP id n17-v6so7655794wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 02:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RPeyRfRZjIHU/MocvTGC3SUvxohCz8S73TPu7gqtVDk=;
        b=BEqcEjPb/56oMvZS7wEDoyLt8QSFLzdxaVWY8+daTylmzwh/VLyCK1YahefeWO9NEa
         GhW9WsxaNcA6SN4Nuw4d9rXXIuEwa49I59TuJV0Yi02OK85WTQwBLC2UhcPnUN1c8K4A
         mjgZ0OTfai95uTIqaNwEm3lTN1gu5hh8eTGYlJkbdK9Qk6ytoqR2UU3Rvn33eHBptrYf
         PWFaBnECC4zq7i8DuRYhvqQCX5sQTbtuwwjkYfu7SSGMhofy91qDWO74e4O6yBViiUVp
         CaY3Y1N6dF0Yneob4HROgbpsazARx1tS/YW8YvUXIUJeqF6khk3ZUHkXaqkJeWQbydoy
         1KXA==
X-Gm-Message-State: APt69E3Gf4rYTqX4mOtuUanVww7xTrDsQEySR0LcbN/FAGrPC5O+OpQu
        H2sTlo/4AlalqSbFn4k1RzLm7Q==
X-Google-Smtp-Source: AAOMgpfSxMRtzMOfBemzgCHzsWyh55ZHHQN1pFvLKY5G8BE5PODn7lxl8PlmT4OFSMNEh7wtbGW66A==
X-Received: by 2002:a1c:cc08:: with SMTP id h8-v6mr7131527wmb.82.1530176729502;
        Thu, 28 Jun 2018 02:05:29 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id d10-v6sm10417618wrj.38.2018.06.28.02.05.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 02:05:29 -0700 (PDT)
Date:   Thu, 28 Jun 2018 11:05:26 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Shrirang Bagul <shrirang.bagul@canonical.com>
Cc:     jic23@kernel.org, lorenzo.bianconi83@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mario.tesi@st.com, marco.bianco@st.com, armando.visconti@st.com
Subject: Re: [PATCH v2] iio: humidity: hts221: Fix sensor reads after resume
Message-ID: <20180628090525.GA2540@localhost.localdomain>
References: <20180628082215.12023-1-shrirang.bagul@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628082215.12023-1-shrirang.bagul@canonical.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> AV_CONF register (RH & TEMP. oversampling ratio's) and CTRL1 register
> (ODR & BDU settings) values are lost after suspend.
> 
> While the change in AV_CONF updates the sensor resolution modes
> (overriding the user configuration before the device went to suspend);
> loss of the contents of the CTRL1 register leads to failure in reading
> sensor output.
> 
> This patch restores the AV_CONF & CTRL1 registers after resume.
> 

Hi Shrirang,

I still suspect we have some hw issue (IoT Gateway) here (cc ST folks
to get more info) and anyway I guess the proposed patch will fix the issue
completely since OD and HL configuration is not restored properly.
Could you please double check HL/OD regs are properly preserved after resume
phase?

Regards,
Lorenzo

> Changes from v1:
> - Don't drop enabling the sensor during resume
> - Restore AV_CONF register along with CTRL1
>   (As demonstrated with i2c register dumps of hts221 captured on Dell
>   IoT Gateways 300x before suspend & after resume [1])
> 
> Fixes: ffebe74b7c95 (iio: humidity: hts221: avoid useless ODR reconfiguration)
> Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
> 
> [v1] https://marc.info/?l=linux-iio&m=152506543000442&w=2
> [1] https://marc.info/?l=linux-iio&m=152534455701742&w=2
> 
> This patch is based on:
> git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git -b testing
> ---
>  drivers/iio/humidity/hts221_core.c | 31 +++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
> index 166946d4978d..fc5599497f55 100644
> --- a/drivers/iio/humidity/hts221_core.c
> +++ b/drivers/iio/humidity/hts221_core.c
> @@ -656,14 +656,43 @@ static int __maybe_unused hts221_resume(struct device *dev)
>  {
>  	struct iio_dev *iio_dev = dev_get_drvdata(dev);
>  	struct hts221_hw *hw = iio_priv(iio_dev);
> +	const struct hts221_avg *avg;
> +	u8 data, idx;
>  	int err = 0;
>  
> +	/* Restore contents of AV_CONF (RH & TEMP. oversampling ratio's) */
> +	avg = &hts221_avg_list[HTS221_SENSOR_H];
> +	idx = hw->sensors[HTS221_SENSOR_H].cur_avg_idx;
> +	data = avg->avg_avl[idx];
> +	err = hts221_update_avg(hw, HTS221_SENSOR_H, data);
> +	if (err < 0)
> +		goto fail_err;
> +
> +	avg = &hts221_avg_list[HTS221_SENSOR_T];
> +	idx = hw->sensors[HTS221_SENSOR_T].cur_avg_idx;
> +	data = avg->avg_avl[idx];
> +	err = hts221_update_avg(hw, HTS221_SENSOR_T, data);
> +	if (err < 0)
> +		goto fail_err;

just return err, no need for goto statement

> +
> +	/* Restore contents of CTRL1 (BDU & ODR) */
> +	err = regmap_update_bits(hw->regmap, HTS221_REG_CNTRL1_ADDR,
> +				 HTS221_BDU_MASK,
> +				 FIELD_PREP(HTS221_BDU_MASK, 1));
> +	if (err < 0)
> +		goto fail_err;
> +
> +	err = hts221_update_odr(hw, hw->odr);
> +	if (err < 0)
> +		goto fail_err;
> +

just return err, no need for goto statement

>  	if (hw->enabled)
>  		err = regmap_update_bits(hw->regmap, HTS221_REG_CNTRL1_ADDR,
>  					 HTS221_ENABLE_MASK,
>  					 FIELD_PREP(HTS221_ENABLE_MASK,
>  						    true));
> -	return err;
> +fail_err:
> +	return err < 0 ? err : 0;
>  }
>  
>  const struct dev_pm_ops hts221_pm_ops = {
> -- 
> 2.17.1
> 
