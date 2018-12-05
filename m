Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03544C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0A720878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9bpSjXq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0A720878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbeLEOrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:47:42 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46729 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbeLEOrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:47:42 -0500
Received: by mail-lj1-f196.google.com with SMTP id v15-v6so18547438ljh.13;
        Wed, 05 Dec 2018 06:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mxVwoIMwpFomTJ8PWao4eAF2MERZp30vta5Iv5s786E=;
        b=O9bpSjXqmpeX6W8+/4TQD8NB0EwhODkWAwtaqQ+/TCQ/OGi/x1opXa3SLQhMMsANjN
         OuoHsr0eykZ+Nf2JdKnkxwL8TEPwTeeNnrVfMwfYJeRLzAwM2wJFy303WRzSBUcqFOkg
         3o+oqdAj7y10mnZWuUFAcmcF8NVd2Sh3KpaBijMFxYej1CckTo3WvWQRF070/HyKjy5U
         5GYELUZ3DNj0SfaosFtT7TJkL1RrA41t4p0fTkFoHb787ManEw2OHSS/6+tg8wSdffP6
         RbNzsZSGFj+hcis6+rjOSByhlUILlln6K3i4CtVP6yiXO72a3nGB7YNY+02344lwLyy8
         r7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mxVwoIMwpFomTJ8PWao4eAF2MERZp30vta5Iv5s786E=;
        b=lMqfzPyAWeDs7JzWAfSgSFN0yfDubj6LGOww+wDJ0L/jU1V8eR7Zr+1cU5S05pp+K8
         YmvHTt/8yLMgfINhNwI4q8Qo+RCtQiyMz5VFoUT+TqxnzrKndpOuIOeizrHbkBN6BS1f
         8DsXoRa1qr0EN65yuIooRSv+FGbi2hJzDBHhmOgmy001CKhvM8wg/ZypbtCokIRAqgRJ
         oVY6MOr+Z2spdvVU1BkR5bo4Uwo5zuxkV88C5Vmv01XfsZLNlQ5xEUCKBxy/LIlC2zrD
         g86b+C6D/ZpCdxw35gvZPkSx32M7FIUQ4zYZ8UvLCHpSU0SZ8ONtonOQdOTM0M9T2JTj
         AB2Q==
X-Gm-Message-State: AA+aEWalZHCSlN4y1ofSnGZNI/L7BQPlvBwIX+4D/ZU0cWQf3Bpn6QkU
        3VvfDvAO8jhAKBUl1mdJnTs=
X-Google-Smtp-Source: AFSGD/W3GDR/qmpnfwTfJi0FXy/0mnRSulTOBspICZdFKMWK62eSWihTG6PMbShTi5HXLOSXGVh9Wg==
X-Received: by 2002:a2e:2b85:: with SMTP id r5-v6mr15376802ljr.91.1544021259003;
        Wed, 05 Dec 2018 06:47:39 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id e13-v6sm3796559ljk.53.2018.12.05.06.47.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 06:47:37 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gUYSh-0003vJ-PH; Wed, 05 Dec 2018 15:47:40 +0100
Date:   Wed, 5 Dec 2018 15:47:39 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     johan@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH 1/5] gnss: sirf: write data to gnss only when the gnss
 device is open
Message-ID: <20181205144739.GE15689@localhost>
References: <20181118215801.12280-1-andreas@kemnade.info>
 <20181118215801.12280-2-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181118215801.12280-2-andreas@kemnade.info>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 10:57:57PM +0100, Andreas Kemnade wrote:
> The api forbids writing data there otherwise. Prepare for the
> serdev_open()/close() being a part of runtime pm.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/gnss/sirf.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
 
> @@ -73,6 +76,7 @@ static void sirf_close(struct gnss_device *gdev)
>  	serdev_device_close(serdev);
>  
>  	pm_runtime_put(&serdev->dev);
> +	data->opened = false;
>  }
>  
>  static int sirf_write_raw(struct gnss_device *gdev, const unsigned char *buf,
> @@ -105,7 +109,17 @@ static int sirf_receive_buf(struct serdev_device *serdev,
>  	struct sirf_data *data = serdev_device_get_drvdata(serdev);
>  	struct gnss_device *gdev = data->gdev;
>  
> -	return gnss_insert_raw(gdev, buf, count);
> +	/*
> +	 * we might come here everytime when runtime is resumed
> +	 * and data is received. Two cases are possible
> +	 * 1. device is opened during initialisation
> +	 * 2. kernel is compiled without runtime pm
> +	 *    and device is opened all the time
> +	 */
> +	if (data->opened)
> +		return gnss_insert_raw(gdev, buf, count);

This can race with sirf_close() when you move serdev handling out of
sirf_open()/close(). Not sure how best to handle that yet.

Johan
