Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A290C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6B0204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="oE+Zp9ge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfADRQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:16:20 -0500
Received: from smtpcmd13146.aruba.it ([62.149.156.146]:43806 "EHLO
        smtpcmd13146.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfADRQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 12:16:20 -0500
Received: from [192.168.188.46] ([93.34.66.13])
        by smtpcmd13.ad.aruba.it with bizsmtp
        id LHGJ1z0070H9oKh01HGJss; Fri, 04 Jan 2019 18:16:19 +0100
Subject: Re: [PATCH v14 3/3] pps: pps-gpio pps-echo implementation
To:     Tom Burkart <tom@aussec.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc:     Ricardo Martins <rasm@fe.up.pt>,
        James Nuss <jamesnuss@nanometrics.ca>,
        Lukas Senger <lukas@fridolin.com>
References: <20181230083333.27210-1-tom@aussec.com>
 <20181230083333.27210-2-tom@aussec.com>
 <20181230083333.27210-3-tom@aussec.com>
 <20181230083333.27210-4-tom@aussec.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
Message-ID: <5eba2cc4-75fa-e1dc-8a86-68f1221d5e78@enneenne.com>
Date:   Fri, 4 Jan 2019 18:16:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181230083333.27210-4-tom@aussec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
        t=1546622179; bh=rhbkH+KM6NmIyK8ETyvSe3Yd/5IuQZ9ljNzqukES93w=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=oE+Zp9ge74xyZEQ7tnPK5tZkgqszuD7ZE8ryr7Gy6JrfpmZUYejC7eA+s/6516jOn
         pacwLnCc2fIhCn1ceEniNGtK6f0YJTTu1VA/kHA2kV38gRO3xoEyZUg48YFZBA2yzR
         mwr1IRW2UqKgB7jrLwD591BZ1gJgy8nooxz8FvHLdVGn6wGx3nOksrorrFGV1t2LlN
         1E2kCaFRbDO2AszgGuEmb0xBP3C2F2GL2+ECYAfzoZBcvJLcyC5TmBEAXmhcNUs64d
         9OaTLkKw9IEmmI67m2J/EIU7FTo+rCFAJ2ZK9J8QS72YOYPTYvRlDpvTFgJvSzijEB
         st4EeWvQZKC4g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/12/2018 09:33, Tom Burkart wrote:
> This patch implements the pps echo functionality for pps-gpio, that
> sysfs claims is available already.
> 
> Configuration is done via device tree bindings.
> 
> This patch was originally written by Lukas Senger as part of a masters
> thesis project and modified for inclusion into the linux kernel by Tom
> Burkart.

[snip]

> +static void pps_gpio_echo(struct pps_device *pps, int event, void *data)
> +{
> +	/* add_timer() needs to write into info->echo_timer */
> +	struct pps_gpio_device_data *info;
> +
> +	info = data;

Maybe you can write as below and saving two lines and having better readability:

struct pps_gpio_device_data *info = data;

> +	switch (event) {
> +	case PPS_CAPTUREASSERT:
> +		if (pps->params.mode & PPS_ECHOASSERT)
> +			gpiod_set_value(info->echo_pin, 1);
> +		break;
> +
> +	case PPS_CAPTURECLEAR:
> +		if (pps->params.mode & PPS_ECHOCLEAR)
> +			gpiod_set_value(info->echo_pin, 1);
> +		break;
> +	}
> +
> +	/* fire the timer */
> +	if (info->pps->params.mode & (PPS_ECHOASSERT | PPS_ECHOCLEAR)) {
> +		info->echo_timer.expires = jiffies + info->echo_timeout;
> +		add_timer(&info->echo_timer);
> +	}
> +}

I think is better firing the timer if and only if we set the echo GPIO otherwise 
it's useless...

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
