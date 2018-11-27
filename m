Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F80C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E94208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CqtMKBtY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E94208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730965AbeK0VyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:54:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41557 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730948AbeK0VyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:54:18 -0500
Received: by mail-wr1-f66.google.com with SMTP id x10so22184477wrs.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 02:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lgN5iq/QCKYXZG2ugqx/LbDXFr7vzoH2nxJHO0iQbZ0=;
        b=CqtMKBtY92lrMKDtVpqyH/inDmT9PkF99pfI6KeDkXwfFbgS6ZnpuXOa0t27qBWyVG
         TXzQWwOOXVurGIRIpybAbwUwxfg4cH2GEtXqy/FRtGNiBV673BigNMI4D83+n3HucyLQ
         UYXljPQ70dPiS+74BHXDKDaKi6pkhrSSietfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lgN5iq/QCKYXZG2ugqx/LbDXFr7vzoH2nxJHO0iQbZ0=;
        b=GFvNXmjna4S/scEAgr3O/CxQkHeiOxaBiJIijTedKDJg5TaY8EjjQ0vEqtPnvKTEOj
         R2IHbJV6ItsXKnIKBDx3inuScctbHLqZ77aAeDP9PT9ygFRiaE9Nrc2JCl/020sSVZtz
         gHlVYxNS//dnh3ZYJ7OUlBxoJCcgZ786OaHhV+HwwwzNZKXQwneuqIbU3eHUsFv6hjsx
         yglLcZQiVjmR63XHA7U3mb61s64+mPgWEn200LJuYjW67+f0grK6bzkEo6w1hU9VmxXU
         7tPdXepcim5h8skPFsc/vW3aJxy8Y9tYIZccTJGwi5w7wdwvb2OsZYdeeXA8dfGe0jAV
         0OLw==
X-Gm-Message-State: AA+aEWY62nRGzuX3sQPC3EAKZueVMMdjJX5NWhqv3nUN+xRCQdMGmCnL
        ynHlnUn8Jj6Ah9jOQ0tiJYU3jA==
X-Google-Smtp-Source: AFSGD/UYl1LAqiFF4eFBuaUUMHcn0RKAAQdBAk+By4SEp/R4YYiVQysnlg1qBl5CE8r8eXxMAyb24A==
X-Received: by 2002:a05:6000:108d:: with SMTP id y13mr24675922wrw.135.1543316206175;
        Tue, 27 Nov 2018 02:56:46 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id y13sm2621103wrw.85.2018.11.27.02.56.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 02:56:45 -0800 (PST)
Date:   Tue, 27 Nov 2018 10:56:42 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     lee.jones@linaro.org, jingoohan1@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jonathan@marek.ca, ctatlor97@gmail.com
Subject: Re: [PATCH 1/2] dt-bindings: trivial: add ti,lm3630a binding
Message-ID: <20181127105642.uu56phxjfl7bjl2p@holly.lan>
References: <20181124141703.29232-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181124141703.29232-1-masneyb@onstation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 09:17:02AM -0500, Brian Masney wrote:
> Add a trivial binding for the Texas Instruments LM3630A Backlight Chip.

It's quite unusual for a backlight device to have a trivial binding.

The driver supports fairly extensive parametrization via struct
lm3530a_platform_data. It is really the case that none of these
properties should ever be set via DT?


Daniel.


> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  Documentation/devicetree/bindings/trivial-devices.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
> index 6ab001fa1ed4..86486368dc35 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/trivial-devices.txt
> @@ -182,6 +182,7 @@ taos,tsl2550		Ambient Light Sensor with SMBUS/Two Wire Serial Interface
>  ti,ads7828		8-Channels, 12-bit ADC
>  ti,ads7830		8-Channels, 8-bit ADC
>  ti,amc6821		Temperature Monitoring and Fan Control
> +ti,lm3630a		Texas Instruments LM3630A Backlight Chip
>  ti,tsc2003		I2C Touch-Screen Controller
>  ti,tmp102		Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
>  ti,tmp103		Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
> -- 
> 2.17.2
> 
