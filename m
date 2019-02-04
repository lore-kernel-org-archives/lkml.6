Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB43FC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BFD120815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JzQUQC41"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbfBDTXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 14:23:23 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46911 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbfBDTXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 14:23:23 -0500
Received: by mail-ed1-f65.google.com with SMTP id o10so855023edt.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 11:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=IzF9/4Xl2N8Sb5ydsn20DtyqNkvjP2B1jIT0CPs5H8U=;
        b=JzQUQC410YHieMVM/+idr1XcPFl0zQNa3eqi/VI3ni9x2hqMOcR6vgQg3SUwI8YaX0
         ORXufpYCGTqHXpb5NPdFhVQZp3C268AJaWoWSwjYEN5VWCvuqVElkdOv9Bilcp/HvEoh
         Vlc8cLRuxho9gqwSmHV2CPmZDA9fP7NQ2PuuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=IzF9/4Xl2N8Sb5ydsn20DtyqNkvjP2B1jIT0CPs5H8U=;
        b=ca750ArCvY2rAu39I5fIJl9HNx6eoybASH6D1SDunn25x/7cq6JsGdu6HlrmO7WJKc
         3Npqio/aUda/RF0grPKg/A4++IP2zSt1cgpZUnDFPyEZzGpu3CNrZF9RuS0AOI1VScow
         ADCaQCJLtsGnMIFsEB80shxolTwuYmedAVL8pSupwB+ZQEafn6EkQIvfg+JaKWSy+bCZ
         mPuvdGdRtsXIwBPct0r0WejOqNWFXOOfnNco1d0+iEVthSu588J2KzxFEoOwwp8Sfl4E
         FPqOnpE72yeaCR5zK3N+nxLCwAkhbyQXxjF/kKUoOdKnrIgYfijhDhwUQrCDy6dpaTi6
         rhXA==
X-Gm-Message-State: AHQUAubp6LbNB8gNrn2m4k7vTWHjOMbTQxiPu8zCXeRhKHv/hztU3H5/
        RctMSCSN3eeOYCS3YuiFCJSWB0r2sv8YXw==
X-Google-Smtp-Source: AHgI3IaTaS6AV7RCls2Dp1tDfsOaRrxX8v13ow3ILF/ohjRRBuvw5X814q14ErbB9txKkRoHV9GCuw==
X-Received: by 2002:a17:906:f146:: with SMTP id gw6mr719005ejb.176.1549308201467;
        Mon, 04 Feb 2019 11:23:21 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id w10-v6sm2692886ejn.67.2019.02.04.11.23.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 11:23:20 -0800 (PST)
Subject: Re: [PATCH] mailbox: bcm-flexrm-mailbox: Fix FlexRM ring flush
 timeout issue
To:     Ray Jui <ray.jui@broadcom.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
References: <20190204192129.93533-1-ray.jui@broadcom.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <dc8e7d9b-51fb-d216-d85c-915dda7d18ae@broadcom.com>
Date:   Mon, 4 Feb 2019 11:22:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204192129.93533-1-ray.jui@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix looks good.

On 2019-02-04 11:21 a.m., Ray Jui wrote:
> From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>
> RING_CONTROL reg was not written due to wrong address, hence all
> the subsequent ring flush was timing out.
>
> Fixes: a371c10ea4b3 ("mailbox: bcm-flexrm-mailbox: Fix FlexRM ring flush sequence")
>
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> ---
>   drivers/mailbox/bcm-flexrm-mailbox.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
> index d713271ebf7c..a64116586b4c 100644
> --- a/drivers/mailbox/bcm-flexrm-mailbox.c
> +++ b/drivers/mailbox/bcm-flexrm-mailbox.c
> @@ -1396,9 +1396,9 @@ static void flexrm_shutdown(struct mbox_chan *chan)
>   
>   	/* Clear ring flush state */
>   	timeout = 1000; /* timeout of 1s */
> -	writel_relaxed(0x0, ring + RING_CONTROL);
> +	writel_relaxed(0x0, ring->regs + RING_CONTROL);
>   	do {
> -		if (!(readl_relaxed(ring + RING_FLUSH_DONE) &
> +		if (!(readl_relaxed(ring->regs + RING_FLUSH_DONE) &
>   		      FLUSH_DONE_MASK))
>   			break;
>   		mdelay(1);
