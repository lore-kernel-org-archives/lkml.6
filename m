Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A57DC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B2423C30
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IVEmFKif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B2423C30
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934262AbeFVCGy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 22:06:54 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32849 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934132AbeFVCGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 22:06:51 -0400
Received: by mail-pf0-f193.google.com with SMTP id b17-v6so2433997pfi.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 19:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=clj++TUZwbU/E/HLENQlGkckumGGwaTdPxQYbhbkHkk=;
        b=IVEmFKifSRzY3GYR307n8/uErxSJKenUUS9ok7QhV7Pn4o5g2LeQ4QRxLJ9tWG9am5
         PpoTzf3vhmEGmHtIEdxkvJ5EkycCvis7gY1ctSpq+drjaslQFPAHgvH9AkKK8SZPXtyN
         r56QXDfh3dPPv4SSrD6VPBt0EXyamJ9S8De0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=clj++TUZwbU/E/HLENQlGkckumGGwaTdPxQYbhbkHkk=;
        b=rKWGtSRBM/W8xr6QOVFR5nniP/Rq6wPbNlB6v0WUx3fI9L1w4sPVfePdJTYR+K1Yjl
         WepvdBhTwEHR3YRFde/CObrFInRWxAmsODkjbK2au6T9kpJPlBL/ijLhUBW6ELdeqwBq
         VYYEuWGJa04tMXxJaW2dwjY9082I4/Z7dQhIR2DMutMN5Gu80bBRL6vKEigjt7tqzjIl
         5rgGD6Mh8pYpM1CMgQ2ZPEl0dxEbOX2SSs+xRHgLlr99e4IYgCu6dqCJZOVgiBu4owhj
         e4UXNH/kBCRjwKF3Kd7wXXnHkV15qMTBzeiJAYfOaxEym0fASgWDowX54Q7ly5yzHsz+
         OGBg==
X-Gm-Message-State: APt69E0BvAF9b5QibylITsGOkeaOx3J9FjpUYVThCX5DeGF6A1gUj3xI
        kX/myq+khLfrxeo2vDbRprn/Qg==
X-Google-Smtp-Source: ADUXVKI2HVX46OLjPalErLi7JL+IoebBKMSDxsaPt60uNSgFtgeMHD4B+ieqqWGHL/F9nUJqWaSAEw==
X-Received: by 2002:a62:b02:: with SMTP id t2-v6mr29860028pfi.36.1529633210697;
        Thu, 21 Jun 2018 19:06:50 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:0:1000:1501:bc2f:3082:9938:5d41])
        by smtp.gmail.com with ESMTPSA id m1-v6sm8986995pfh.155.2018.06.21.19.06.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 19:06:49 -0700 (PDT)
Date:   Thu, 21 Jun 2018 19:06:47 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v4 12/12] mfd: cros_ec: Add throttler sub-device
Message-ID: <20180622020646.GB180395@ban.mtv.corp.google.com>
References: <20180621015237.100100-1-mka@chromium.org>
 <20180621015237.100100-13-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621015237.100100-13-mka@chromium.org>
User-Agent: Mutt/1.10+32 (bdae56f54f92) (2018-06-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 06:52:37PM -0700, Matthias Kaehlcke wrote:
> Instantiate the CrOS EC throttler if it is enabled in the kernel
> configuration.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Reviewed-by: Brian Norris <briannorris@chromium.org>

> ---
> Changes in v4:
> - register throttler in cros_ec_dev.c instead of cros_ec.c
> 
> Changes in v3:
> - patch added to series
> ---
>  drivers/mfd/cros_ec_dev.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index eafd06f62a3a..9e56c2793075 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -383,6 +383,22 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
>  	kfree(msg);
>  }
>  
> +static const struct mfd_cell ec_throttler_cells[] = {
> +	{ .name = "cros-ec-throttler" }
> +};
> +
> +static void cros_ec_throttler_register(struct cros_ec_dev *ec)
> +{
> +	int ret;
> +
> +	ret = mfd_add_devices(ec->dev, 0, ec_throttler_cells,
> +			      ARRAY_SIZE(ec_throttler_cells),
> +			      NULL, 0, NULL);
> +	if (ret)
> +		dev_err(ec->dev,
> +			"failed to add cros-ec-throttler device: %d\n", ret);
> +}
> +
>  static int ec_device_probe(struct platform_device *pdev)
>  {
>  	int retval = -ENOMEM;
> @@ -422,6 +438,9 @@ static int ec_device_probe(struct platform_device *pdev)
>  	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
>  		cros_ec_sensors_register(ec);
>  
> +	if (IS_ENABLED(CONFIG_CROS_EC_THROTTLER))
> +		cros_ec_throttler_register(ec);
> +
>  	/* Take control of the lightbar from the EC. */
>  	lb_manual_suspend_ctrl(ec, 1);
>  
> -- 
> 2.18.0.rc2.346.g013aa6912e-goog
> 
