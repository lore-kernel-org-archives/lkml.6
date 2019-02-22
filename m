Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692E7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381C92070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZTSI7Li+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfBVSFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:05:49 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46665 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727718AbfBVSFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:05:48 -0500
Received: by mail-pf1-f194.google.com with SMTP id g6so1430004pfh.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 10:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KubzSsGIl0mpzxhYHGlSJ+rcugeREyH930Tvr54KTUk=;
        b=ZTSI7Li+97fF6ojDRVb9B/lg0Qqr+c71bQNlQweT83JeDv7/VjHdSuTXFTmV/d4zaB
         j0DKp8/TBUG1amAfiE28634QqwogOleCrfRtvSTksqoeofxc31DxIREWk3ZyD7SPV/tN
         o7C98Cj/dUfxZQnRutIYg7LAANIpIrpN0bJKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KubzSsGIl0mpzxhYHGlSJ+rcugeREyH930Tvr54KTUk=;
        b=a1Og5xWnnJoo8ScnCB2+4pC/cF/smH602txO8LW/A2uRihDTI4rypWe8ko6EadU8ru
         x5fRxk+M+CYuguTT3oK1ZvEV+ZxHBCSga2YzBPgjGHdxW1r3mawzVue/sQzxUdgzonfa
         Afi+DSR6X2ijH/Do/wNyfwjO5zazqoN3hJQarAbm+hHuVqr1tx5mldCa7xm0diWDMZE/
         5hoSufY3Ut8xi1NtEwqpz/y50R3OupKOpcG+BNhPgiALMAkQj+2gv9H7mklT0aBO4LDk
         JKtNO5cTqrUkdwMfcEIqbCqYrIMCttI494fUM9rCI9Qz79Uk/jfXUmGceLW9XfwHq47e
         2CWA==
X-Gm-Message-State: AHQUAua8gMs+srAuyTLpnitMdsxj2v86mnT3Zp+vVBs264DslA7d//v9
        krOw1/NB//ACucIOLVqgxUFY0Q==
X-Google-Smtp-Source: AHgI3IavGDOBO0lLpGTAhsMakepsHGlvesjtlBjhOwE6wUKvv96jHsyNE7tCT7EfBYyQ9bu2xqrjBg==
X-Received: by 2002:a65:6091:: with SMTP id t17mr5213979pgu.416.1550858747224;
        Fri, 22 Feb 2019 10:05:47 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id s1sm2706322pgv.30.2019.02.22.10.05.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 10:05:46 -0800 (PST)
Date:   Fri, 22 Feb 2019 10:05:46 -0800
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
Subject: Re: [PATCH 2/3] dt-bindings: net: btusb: add QCA6174A IDs
Message-ID: <20190222180546.GB223791@google.com>
References: <20190222003403.128243-1-briannorris@chromium.org>
 <20190222003403.128243-2-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190222003403.128243-2-briannorris@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 04:34:02PM -0800, Brian Norris wrote:
> There are two USB PID/VID variations I've seen for this chip, and I want
> to utilize the 'interrupts' property defined here already.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>  Documentation/devicetree/bindings/net/btusb.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/btusb.txt b/Documentation/devicetree/bindings/net/btusb.txt
> index 37d67926dd6d..43c96c3380a6 100644
> --- a/Documentation/devicetree/bindings/net/btusb.txt
> +++ b/Documentation/devicetree/bindings/net/btusb.txt
> @@ -9,6 +9,9 @@ Required properties:
>  		 (more may be added later) are:
>  
>  		  "usb1286,204e" (Marvell 8997)
> +		  "usb0cf3,e300" (Qualcomm QCA6174A)
> +		  "usb04ca,301a" (Qualcomm QCA6174A (Lite-On))
> +
>  
>  Also, vendors that use btusb may have device additional properties, e.g:
>  Documentation/devicetree/bindings/net/marvell-bt-8xxx.txt

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
