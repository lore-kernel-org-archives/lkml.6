Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBE1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B29752075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gN98Qmmx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfBVSEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:04:09 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35182 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfBVSEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:04:08 -0500
Received: by mail-pg1-f196.google.com with SMTP id s198so1474448pgs.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 10:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NBDYynHnmf+PRB+3zm8U/Thb/lB25m9nA1UHHlQDuNI=;
        b=gN98QmmxC+80Hu4YvrI+l3Hfk1gs5wZNu1e4tkZEzLWreZtkoR4+s+lplguLhGMadW
         8Iw5FbnNo//NOsKNMu8tqa5plZa92xNAu5v2ZspLY2mNgA8MMsSmYBfnIU9V+qiySEzP
         nbinkTI3qQInivoWhVx2fUrdIFYG3EotOlxIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NBDYynHnmf+PRB+3zm8U/Thb/lB25m9nA1UHHlQDuNI=;
        b=Onb0ccfAs4kPqpGLqJRayli29utmK8J3Bu9voi0tvF3YDtP38nkmPBMrJNwgH0VlhQ
         t+Lt84sqFZHpX6ikmu6KtGATRzKh+eLjn4VdufGRF0+qnOOjs/GF6wWvoyddeMqzb/Ad
         +KbzpTWsJErLLcBSa/RTygyAcRDq9gNS/1g/g1IjsNklYDbk8IOfzfnWtxN7Max4JdLO
         mUAdFQw67jQ4cYTuebVwBthLSQJzgCUDiFZV11d1n1xqqa0Zs8PbrbSs3kmTZSgI0Xsg
         222kF2YmMC628PXhS3J3IyYQ9whh0LPrIADP/rEVDiTn7H8dtKGPl4Szd4fjistB5ihp
         kLGg==
X-Gm-Message-State: AHQUAubADi6d2Pd2Zn18zJHqgD5k1wzaHo555CJQMSI1P9U832ip0P8m
        HzUbynejFgv+BEk/yOwPpg/okw==
X-Google-Smtp-Source: AHgI3IYJGUQh4RRG119Jd6S5+H3oe5J3JtSpbOhsBeGSquz0ecMAsn4NE6EKS1OKUgutuP6fEYvfiQ==
X-Received: by 2002:a62:ea08:: with SMTP id t8mr5437076pfh.60.1550858648347;
        Fri, 22 Feb 2019 10:04:08 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id g67sm6423447pfg.13.2019.02.22.10.04.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 10:04:07 -0800 (PST)
Date:   Fri, 22 Feb 2019 10:04:06 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH 1/3] Bluetooth: btusb: add QCA6174A compatible properties
Message-ID: <20190222180406.GA223791@google.com>
References: <20190222003403.128243-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190222003403.128243-1-briannorris@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 04:34:01PM -0800, Brian Norris wrote:
> We may need to specify a GPIO wake pin for this device, so add a
> compatible property for it.
> 
> There are at least to USB PID/VID variations of this chip: one with a
> Lite-On ID and one with an Atheros ID.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>  drivers/bluetooth/btusb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 470ee68555d9..380e6f38c607 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2862,6 +2862,8 @@ static irqreturn_t btusb_oob_wake_handler(int irq, void *priv)
>  
>  static const struct of_device_id btusb_match_table[] = {
>  	{ .compatible = "usb1286,204e" },
> +	{ .compatible = "usb0cf3,e300" }, /* QCA6174A */
> +	{ .compatible = "usb04ca,301a" }, /* QCA6174A (Lite-On) */
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, btusb_match_table);

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
