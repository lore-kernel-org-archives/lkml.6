Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3EAECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58BDF2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muxAUwCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58BDF2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbeGSLQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:16:58 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:42059 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbeGSLQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:16:58 -0400
Received: by mail-lf0-f66.google.com with SMTP id u202-v6so5638123lff.9;
        Thu, 19 Jul 2018 03:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cXvAc5QzEHTTQ9hob7b4mmuInTGcMVt1RNqy7tPvjk0=;
        b=muxAUwCXHHMuZhI2ZD79TJ5vab6f0OfcGQL8it8I5Qci1zkDGTxTiOAYFIcRs5M+Ag
         zMmCSWrD9l+5v+47MuM/ahRyyPpFGRjAc2SdqY97JSTM+O+WBMKctB1REKb2IPQmlore
         z0iLp/wWRaZeyCUyhv4ee5eE4cCKaxSbd+Vry9JwNuNHA/5I4awj4qhZm9Ku9jLBjcHI
         e3EbY+U29UPt862BnXSeI2IWGUtF1+xpmrVluUpVl0u5VFqrp4PN2zdrLXPohaYSUHES
         seBGlMWLuRiHcM/LgJbHzNFjN7jyrBolXWzlcBTSR1Cw53gneYUV3xoawSajUb3qCvPR
         Li/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cXvAc5QzEHTTQ9hob7b4mmuInTGcMVt1RNqy7tPvjk0=;
        b=lCm6geiR6ch3u73+C+O0+PKFaQLTIbfiASDgYDwwGBg7d7LQbBvREhRCak/KFiFGjT
         ffLcmTF54oFKdaqPM2OXUyzg7DC2DSarc48sSNNO40+f8UdMseG7RNP6rnqQHsCH8RGa
         FVkF2k/V7lduIpxdl+LctCsYG/4kjXQD8xOuN4TxDgEPWnV2+IoGAlus1XGnw+4ss1I1
         o5ZGtovXDzu1uJamSTcOQu3/qTX1PPL71kUAyt7UOTq6QACKax2MW6BDidMiveCzUPSj
         HsDi8tX664ghWjus2/ABXZZT4Z47X43yk5GGEpQCYR/1ZLWc7IPF1NNXPOZFKtTEAdzC
         NPtA==
X-Gm-Message-State: AOUpUlEy/1l9uT3Sg4RGhopYgGFBeHzQsD6Rzqqe9L/H373jWaUcMOVm
        dcb7DJxlEc1UBTP/HmJ6vQc=
X-Google-Smtp-Source: AAOMgpemJl6WYYy1ldjcDAn5WhF+dEOAOs5YjUrlXCB9TSEbSC6K8viV98qnBGpkGlnSqe9wuyj4/Q==
X-Received: by 2002:a19:ce51:: with SMTP id e78-v6mr6594152lfg.99.1531996465689;
        Thu, 19 Jul 2018 03:34:25 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id a4-v6sm905150lfe.54.2018.07.19.03.34.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 03:34:24 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fg6GD-00062J-EF; Thu, 19 Jul 2018 12:34:13 +0200
Date:   Thu, 19 Jul 2018 12:34:13 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Keerthy <j-keerthy@ti.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        t-kristo@ti.com, linux-rtc@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan@kernel.org
Subject: Re: [PATCH v4 3/4] rtc: omap: use
 of_device_is_system_power_controller function
Message-ID: <20180719103413.GS10204@localhost>
References: <1531372060-10532-1-git-send-email-j-keerthy@ti.com>
 <1531372060-10532-4-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531372060-10532-4-git-send-email-j-keerthy@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 10:37:39AM +0530, Keerthy wrote:
> Use of_device_is_system_power_controller instead of manually reading
> the system-power-controller property from the device tree node.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/rtc/rtc-omap.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index cb19ece..3610efd 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -753,8 +753,7 @@ static int omap_rtc_probe(struct platform_device *pdev)
>  	if (of_id) {
>  		rtc->type = of_id->data;
>  		rtc->is_pmic_controller = rtc->type->has_pmic_mode &&
> -				of_property_read_bool(pdev->dev.of_node,
> -						"system-power-controller");
> +			of_device_is_system_power_controller(pdev->dev.of_node);

Nit: Continuation lines should be indented at least two tabs further,
but in this case an exception seems warranted to keep the line within 80
cols.

>  	} else {
>  		id_entry = platform_get_device_id(pdev);
>  		rtc->type = (void *)id_entry->driver_data;

Reviewed-by: Johan Hovold <johan@kernel.org>
