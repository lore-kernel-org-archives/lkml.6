Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F5EECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48410208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HN1xtNk4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48410208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbeIPGEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 02:04:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34845 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbeIPGEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 02:04:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id p12-v6so5938277pfh.2;
        Sat, 15 Sep 2018 17:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=I32c3IMA3Gf6l1MDq8YJ3TJ1oDF3cJShcf4FyJmXZ8g=;
        b=HN1xtNk4pM9aKjwm1+qdCLjZ9ISqmPJpQRr2EGOXyS8+FRMrgAEQjImBeQb4u+Y1Oz
         JO5Qgk8n0r5VspGPZYpjcV+ep5rjypMUQfxFJvVI71JnfmbnC9IAlanaU7NG+uCS/ALw
         187Ym+BqNHzVdHgcBlQDkM4Y2vxkLoVgl86CpS9p3m5yUymVZI7Zxr2e//anuLNTiRQy
         ZftNEsM7U3/XMvuVAgJmoJjyUAYfCRYdJrNz1JcDiHDHmiqQJLISQIdD1K2jHvheLAiv
         EXO8HRBeao5mmLZx+VAS3oMVZlbCugGLazjzZVArsxDyi48+TmHpvUwRwi+QOSUPhfdw
         tswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=I32c3IMA3Gf6l1MDq8YJ3TJ1oDF3cJShcf4FyJmXZ8g=;
        b=tp9XHVAR5wbRU1qlO2fJjLTBnH1ZOM+0zOy7HUj9Ko9ujxHneeTLoOyqx2Ww0dfKWX
         0NlMmHl5riF3tuEmdhbTaoV8lJar3hgVeZqtnNFLp1oNrs/RfJQV+aleRrsAjD8MIjAn
         9gk94AecGH+lXCcisuiOZ6otdyK2uTxvgO7Gx4GNrCLNRPFqSJSom3lpH4YMWD3qAKRX
         l0ccfvM1PYGL8Ws635emkiVp9iTnWJwiqVFOzmshxlfHTAE2LbTZKbci25QWoeeVFtlH
         Qm5bNCYEbJhvDjme8grJzlHjtWXZcEtZUMWGybd9hWO8tj6DWOlIcF+HtPiiy92hjE5u
         Q+8Q==
X-Gm-Message-State: APzg51BQGG4RJ9pHaTlzhFUV9dyhNyzwkbkRreSn5OMLErVuITgR8TCc
        G/PJu7FoFfyVvj1eN7F2d30=
X-Google-Smtp-Source: ANB0VdYi/mK9ktfYrWuvEzRVkxul3OlqMOueNosdmZyreBPNA2g/D5VQfC7NHAbdJ8x+imZRtCBrHQ==
X-Received: by 2002:a63:da04:: with SMTP id c4-v6mr17992281pgh.398.1537058601187;
        Sat, 15 Sep 2018 17:43:21 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id t9-v6sm14367336pgi.87.2018.09.15.17.43.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 17:43:20 -0700 (PDT)
Date:   Sat, 15 Sep 2018 17:43:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     kronos.it@gmail.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: Use PTR_ERR_OR_ZERO instead of reimplementing its
 function
Message-ID: <20180916004318.GA30797@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 08:03:37PM +0800, zhong jiang wrote:
> PTR_ERR_OR_ZERO has implemented the same function. We prefer to use
> inlined function rather than code-opened implementation.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Applied to hwmon-next. For future patches, please also refer to the
affected driver in the Subject line, unless the change is in the
subsystem core code.

Thanks,
Guenter

> ---
>  drivers/hwmon/asus_atk0110.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
> index a6636fe..a7cf008 100644
> --- a/drivers/hwmon/asus_atk0110.c
> +++ b/drivers/hwmon/asus_atk0110.c
> @@ -1210,10 +1210,8 @@ static int atk_register_hwmon(struct atk_data *data)
>  	data->hwmon_dev = hwmon_device_register_with_groups(dev, "atk0110",
>  							    data,
>  							    data->attr_groups);
> -	if (IS_ERR(data->hwmon_dev))
> -		return PTR_ERR(data->hwmon_dev);
>  
> -	return 0;
> +	return PTR_ERR_OR_ZERO(data->hwmon_dev);
>  }
>  
>  static int atk_probe_if(struct atk_data *data)
> -- 
> 1.7.12.4
> 
