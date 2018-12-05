Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAA9C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9A02081C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRiwA93z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF9A02081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbeLEPGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:06:25 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38687 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbeLEPGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:06:25 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so18648567lja.5;
        Wed, 05 Dec 2018 07:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z+43scOvjQymplkXmGk9hI1a477LYVA40yOkLt1y+Rk=;
        b=LRiwA93zV8yiahlchOQfAh1z8Tj99kSZo6OYPqiY51WhFAZaCQOAqH0ngp5uCoro1v
         eBPHxWJrsUqF6AoFb62qlKpJcwfDTqaHQDgUU5/EgJMUTc5E8bovG2raJy8Vg81ok9jQ
         8C0cEVKt1rmEvJ+TWiZMVbvR+CUDJeLK0+uboLdLh83lkVVgoYNRxn8vbtBlPATkXFWs
         XjGWngrHHYGVL5IcC/xCDw9rmWWONyXvKlRokBgYRJlUBEcLMzVu6jH7LQ7r0sGiYi8l
         hNa9mAvFN1SC9HIvwatkEKa/Q1V3xBzzleZLpL4afvW8SFECqHvGmMuUQDB9rdaNAIhH
         3ebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=z+43scOvjQymplkXmGk9hI1a477LYVA40yOkLt1y+Rk=;
        b=EvbShNS88w174lXaKU6cFftls7wn5fbqrcgitI7peWGw2l2jGKCffUWYexyhMqskDo
         c8fcb0oz+63/vo/2mRUGKIFucxeqmX5l1sHkDNOO4aspGpdDFfzMz+vIxDp0gfzwtjIK
         OGr9Ljy55jdVGCEG6gaeRPeg77d6oNTSYbVNpncXa0EXZMTfZ+sXyU7qzOlMEEiGBw5u
         tKfcJUIW0XZvELZRJT8HQNYwYFMzEiGWdJGvnqNnx7aWTI+6Rm8JhmWlMSp2T6roB7vQ
         ETjGDzSTFZpW4/0y4CpmcxLV6vcX+UQQFZBs9FKUiv+tbMkZBenZ8s2D0SU+anHb+FtG
         vQMw==
X-Gm-Message-State: AA+aEWZ4k9plTxVo48ttq4nzqVISaxwyn3bA/TxC2BX9WGAvp1K3HdBy
        sQtWnYrlr8NazbPj58vfZXkUw/O0
X-Google-Smtp-Source: AFSGD/VjC5yrNu0AXNNXGp36inheYZEVjC9pgQuTLEaOUxdNwoq/pk3481jDP1JsFOTUj4alGl/j2Q==
X-Received: by 2002:a2e:4503:: with SMTP id s3-v6mr16175313lja.44.1544022383046;
        Wed, 05 Dec 2018 07:06:23 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id m77sm3666440lfg.3.2018.12.05.07.06.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 07:06:22 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gUYkq-00041d-Uz; Wed, 05 Dec 2018 16:06:25 +0100
Date:   Wed, 5 Dec 2018 16:06:24 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     johan@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH RFC 4/5] gnss: sirf: add a separate supply for a lna
Message-ID: <20181205150624.GH15689@localhost>
References: <20181118215801.12280-1-andreas@kemnade.info>
 <20181118215801.12280-5-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181118215801.12280-5-andreas@kemnade.info>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 10:58:00PM +0100, Andreas Kemnade wrote:
> Devices might have a separate lna between antenna output of the gps
> chip and the antenna which might have a separate supply
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/gnss/sirf.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
> index 6a0e5c0a2d62..f7573ca2dacd 100644
> --- a/drivers/gnss/sirf.c
> +++ b/drivers/gnss/sirf.c
> @@ -30,6 +30,7 @@ struct sirf_data {
>  	struct serdev_device *serdev;
>  	speed_t	speed;
>  	struct regulator *vcc;
> +	struct regulator *lna;
>  	struct gpio_desc *on_off;
>  	struct gpio_desc *wakeup;
>  	int irq;
> @@ -217,6 +218,7 @@ static int sirf_runtime_suspend(struct device *dev)
>  
>  	if (!data->on_off)
>  		return regulator_disable(data->vcc);
> +	regulator_disable(data->lna);

I don't think you want to disable it until the device has entered
hibernate mode.

>  	ret = sirf_set_active(data, false);
>  
>  	if (ret)
> @@ -245,13 +247,20 @@ static int sirf_runtime_resume(struct device *dev)
>  		if (ret)
>  			goto err_close_serdev;
>  	}
> +
> +	ret = regulator_enable(data->lna);
> +	if (ret)
> +		goto err_disable_vcc;

This one needs to be managed as vcc in the case where we have no
onoff-signal connected, right? Similar for suspend of course.

> +
>  	ret = sirf_set_active(data, true);
>  
>  	if (!ret)
>  		return 0;
>  
> +err_disable_vcc:
>  	if (!data->on_off)
>  		regulator_disable(data->vcc);
> +

Superfluous newline.

>  err_close_serdev:
>  	serdev_device_close(data->serdev);
>  	return ret;

Johan
