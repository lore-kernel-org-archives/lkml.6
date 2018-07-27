Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C11C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 06:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B0320673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 06:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K1P6JJ1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B0320673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbeG0HYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 03:24:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41434 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbeG0HYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 03:24:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id j5-v6so3837556wrr.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 23:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2QBp0gumFG3GnpvUJ2wSEz1AklSSPCMtMUSefGdk3xs=;
        b=K1P6JJ1smjf/TVKBouohOVH5k5amJmT8oanA8KP9vzV8TsHZUK0XraZsdBBElWSOMR
         vs1LG36vtNz1Q1XWnVgjBSs2H5LbQZpzx1cbEGgcilcwBkGVrKWbMGS2/7Z5QvRCZwxK
         2fdQBwYTqhFMBG1wmJJlerE7Qcsl0GCukknc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2QBp0gumFG3GnpvUJ2wSEz1AklSSPCMtMUSefGdk3xs=;
        b=ftKkb/gyPA4qLlFQQEgdeFQ1yhyXUxkH2zGq29hgca68zydthRDUkYoA+VLZzwhCC9
         ZvfuX6nmG9ZiA4tEnUF6pvZ4Y+16fYn61nbr9mXSK/9Moy7ijpjaImSC/ImVEFW+E4sl
         XObBovn/OWkaADQMPuHBJm7SZ06lM/ovluRIuo17U1kgd059x3/biXjjzJdxoj8e6tsT
         pA+Y4WHB5toSCWqhk3Aun30lxFzQiG/G299RDjv+BMXQBmqOsHk3yi6ZiM02OzQc86AU
         KLnkQrF6GJjNQh65HlBNrVy8BhcRGJRqaQOuriC+g7lAmcauD2M1oNbgE+ATmD6vIjpT
         OfcA==
X-Gm-Message-State: AOUpUlHRhDMhGYWEDNASVDAFKHWL+nBujkvE8YKFW3PjtVRIH5d//t7L
        gmPmWaKT53k96Jy8gDmj50FlyA==
X-Google-Smtp-Source: AAOMgpdGyDEXIZqpp400uZ4pDwlwvNhxyH8XmP2zMjdmVZv15yDEqa8EseCmQSezTZYLjj1EtUtSxQ==
X-Received: by 2002:adf:959a:: with SMTP id p26-v6mr3575027wrp.202.1532671437416;
        Thu, 26 Jul 2018 23:03:57 -0700 (PDT)
Received: from dell (host109-153-79-7.range109-153.btcentralplus.com. [109.153.79.7])
        by smtp.gmail.com with ESMTPSA id 133-v6sm5055928wmh.27.2018.07.26.23.03.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 23:03:56 -0700 (PDT)
Date:   Fri, 27 Jul 2018 07:03:54 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson: Switch simple-mfd and syscon order
Message-ID: <20180727060354.GA4628@dell>
References: <1532614438-7207-1-git-send-email-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1532614438-7207-1-git-send-email-narmstrong@baylibre.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jul 2018, Neil Armstrong wrote:

> The order between "syscon" and "simple-mfd" is important because in these
> particular cases, the node needs to be first a "simple-mfd" to expose
> it's sub-nodes, and later on a "syscon" to permit other nodes to access
> this register space through the "syscon" mechanism.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
> This also has a consequence for U-Boot since the U-Boot DM is much simpler
> and can only associate a single device to a node, thus here we want these
> nodes to be an mfd bus to be able to probe the sub-nodes.
> 
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 4 ++--
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi  | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index 6adc8d3..3f0de9d 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -342,7 +342,7 @@
>  			ranges = <0x0 0x0 0x0 0xff63c000 0x0 0x1c00>;
>  
>  			sysctrl: system-controller@0 {
> -				compatible = "amlogic,meson-axg-hhi-sysctrl", "syscon", "simple-mfd";
> +				compatible = "amlogic,meson-axg-hhi-sysctrl", "simple-mfd", "syscon";

I must profess, I haven't looked at the code recently so can't really
comment on the semantics - I'll leave that to Rob et. al.

However, if the ordering is important, you should add a comment to
prevent anyone re-jigging it or reverting the patch for some reason.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
